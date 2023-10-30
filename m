Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1587DB645
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjJ3JmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:42:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B40FC5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:42:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxuOh5ej9lRbY1AA--.3639S3;
        Mon, 30 Oct 2023 17:42:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxkN12ej9lD+o2AA--.54880S3;
        Mon, 30 Oct 2023 17:42:17 +0800 (CST)
Message-ID: <3ccb9600-6990-4ec7-81de-0d7b4e1294eb@loongson.cn>
Date:   Mon, 30 Oct 2023 17:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/loongson: Introduce a drm bridge driver for
 it66121 HDMI transmitter
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-3-suijingfeng@loongson.cn>
 <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <CAA8EJprjQXcTgxnC1POaBjVBzyVBvKpmKyJcCR5ExRUhVxtYoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxkN12ej9lD+o2AA--.54880S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4xAry7tF17Cr4xGw4DAwc_yoW8AFyfpa
        nFkw1YkrWUXrW2y39xGF1UJFy5Za93GFWfWFsrJ3s3Wr9xAa40yrn8JFW5Jry7Xa43Ar42
        qrZ7GFWUW3WYkrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjxU7PrcDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/30 06:53, Dmitry Baryshkov wrote:
> On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> The IT66121 is a DVO to HDMI converter, LS3A5000+LS7A1000 ML5A_MB use this
>> chip to support HDMI output. Thus add a drm bridge based driver for it.
>> This patch is developed with drivers/gpu/drm/bridge/ite-it66121.c as base.
> Please use the original bridge driver instead of adding a new one.

I'm agree with the spirit of code sharing, but this is nearly impossible for non-DT system.

Because the original bridge driver(say it66121.ko) is fully dependent on the DT.
UEFI+ACPI based system can not use with it.

Our I2C adapter is created by the drm/loongson.ko on the runtime.
The potential problem is that *cyclic dependency* !

I2C adapter driver is depend on drm/loongson
drm/loongson depend on drm bridge driver (say it66121.ko)
drm bridge driver (say it66121.ko) depend on I2C adapter to setup.

This plus the defer probe mechanism is totally a trap,
incurring troubles and don't work.


>   If
> it needs to be changed in any way, please help everyone else by
> improving it instead of introducing new driver.
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/loongson/Kconfig            |   1 +
>>   drivers/gpu/drm/loongson/Makefile           |   2 +
>>   drivers/gpu/drm/loongson/ite_it66121.c      | 749 ++++++++++++++++++++
>>   drivers/gpu/drm/loongson/ite_it66121.h      |  19 +
>>   drivers/gpu/drm/loongson/ite_it66121_regs.h | 268 +++++++
>>   5 files changed, 1039 insertions(+)
>>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121.c
>>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121.h
>>   create mode 100644 drivers/gpu/drm/loongson/ite_it66121_regs.h
>

