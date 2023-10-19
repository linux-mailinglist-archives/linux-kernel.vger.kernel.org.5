Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33387CF663
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjJSLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJSLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:14:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5145E112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:14:30 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxXOqUDzFl3i0zAA--.6397S3;
        Thu, 19 Oct 2023 19:14:28 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbS+GDzFlXL4qAA--.24527S3;
        Thu, 19 Oct 2023 19:14:27 +0800 (CST)
Message-ID: <a23cfd62-af09-4aa3-902e-bb34756275c6@loongson.cn>
Date:   Thu, 19 Oct 2023 19:14:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/loongson: Add support for the DC in LS2K1000 SoC
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231011162638.819080-1-suijingfeng@loongson.cn>
 <26565c5e13e72c64214a7f67ab6f2d9d876fa4bd.camel@icenowy.me>
 <037ec619-c170-4ca6-897e-04fccd58c62a@loongson.cn>
 <76nxdwa6m7qyqvala4akc2rptuylhrqyoz2x5rjua4hppoxk7x@wwn37gwuvrms>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <76nxdwa6m7qyqvala4akc2rptuylhrqyoz2x5rjua4hppoxk7x@wwn37gwuvrms>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbS+GDzFlXL4qAA--.24527S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Jr1kWr18AFy8KF4xKF43XFc_yoW8JF18pa
        y5CanxKFs7tF1fAFy8twn5uF4Svr4ftr1Uu3yxCr1UW3ZrGw10va13Krn0kFy5Grn29a42
        gw4YkFWFywnrAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
        JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWU
        AwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU8fsqJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/19 16:11, Maxime Ripard wrote:
> On Fri, Oct 13, 2023 at 06:28:01PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>>
>> On 2023/10/13 16:22, Icenowy Zheng wrote:
>>> 在 2023-10-12星期四的 00:26 +0800，Sui Jingfeng写道：
>>>> LS2K1000 is a low end SoC (two core 1.0gHz), it don't has dedicated
>>>> VRAM.
>>>> It requires the framebuffer to be phisically continguous to scanout.
>>>> The
>>>> display controller in LS2K1000 don't has built-in GPIO hardware, the
>>>> structure (register bit field) of its pixel, DC, GPU, DDR PLL are
>>>> also
>>>> defferent from other model. But for the display controller itself,
>>>> Most of
>>>> hardware features of it are same with ls7a1000.
>>>>
>>>> Below is a simple dts for it.
>>> Why don't you write a proper, YAML-formatted binding?
>>>
>> This patch use only one DT property, that is the "memory-region = <&display_reserved>;".
>> But the memory-region property is a common property, I means that everyone know how to
>> use this property. I'm not sure the if YAML documentation is strictly required now.
> AFAIK it is, and even if it's not, please do it.

OK, thanks a lot for the feedback.
I will try to solve this problem at the next version.
I'm preparing the next version.


> Maxime

