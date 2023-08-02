Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D876CA2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjHBJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjHBJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:58:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5B0D2D71;
        Wed,  2 Aug 2023 02:58:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8CxtPC6KMpkr+AOAA--.35442S3;
        Wed, 02 Aug 2023 17:58:18 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM66KMpkJn1FAA--.49251S3;
        Wed, 02 Aug 2023 17:58:18 +0800 (CST)
Subject: Re: [PATCH] usb: xhci-plat: fix usb disconnect issue after s4
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230802090642.1642-1-zhuyinbo@loongson.cn>
 <2023080243-matted-abnormal-0fb0@gregkh>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <4ee866a1-39a4-3b88-20f6-108e605ab00e@loongson.cn>
Date:   Wed, 2 Aug 2023 17:58:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2023080243-matted-abnormal-0fb0@gregkh>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvM66KMpkJn1FAA--.49251S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2023/8/2 ÏÂÎç5:39, Greg Kroah-Hartman Ð´µÀ:
> On Wed, Aug 02, 2023 at 05:06:42PM +0800, Yinbo Zhu wrote:
>> The xhci retaining bogus hardware states cause usb disconnect devices
>> connected before hibernation(s4) and refer to the commit '547d55fa83
>> ("usb: ohci-platform: fix usb disconnect issue after s4")' which set
>> flag "hibernated" as true when resume-from-hibernation and that the
>> drivers will reset the hardware to get rid of any existing state and
>> make sure resume from hibernation re-enumerates everything for xhci.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   drivers/usb/host/xhci-plat.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> What commit id does this fix?
> 
> Should it go to stable kernels?


Sorry, perhaps it has been rebased, that tree was mainline tree next
branch, you can find this commit id "f3d478858bec4"

Thanks,
Yinbo

