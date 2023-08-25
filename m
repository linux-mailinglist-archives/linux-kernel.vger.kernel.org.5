Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F978835D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjHYJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjHYJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:17:48 -0400
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5BB1FC3;
        Fri, 25 Aug 2023 02:17:45 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 1755920328;
        Fri, 25 Aug 2023 17:17:34 +0800 (CST)
Message-ID: <769a67cb-1b32-fd4f-b37e-e3ec4dab5eb9@rock-chips.com>
Date:   Fri, 25 Aug 2023 17:17:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     shawn.lin@rock-chips.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        matthias.bgg@gmail.com, ulf.hansson@linaro.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Content-Language: en-GB
To:     Sharp.Xia@mediatek.com
References: <c8c059ce-53a9-3627-8984-dff771dff1de@rock-chips.com>
 <20230825083918.24334-1-Sharp.Xia@mediatek.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20230825083918.24334-1-Sharp.Xia@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlLTlYfSk4dSB9CH0lMHkxVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8a2bfc111e2eb6kusn1755920328
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PVE6Mzo*TD1CMz8rGj8PCx5P
        CktPCwpVSlVKTUJJQk5OS05PQk1PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlPT003Bg++
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/25 16:39, Sharp.Xia@mediatek.com wrote:
> On Fri, 2023-08-25 at 16:11 +0800, Shawn Lin wrote:
>>   	
>>   Hi Sharp,

...

>>> 1024
>>>
> Hi Shawn,
> 
> What is your readahead value before and after applying this patch?
> 

The original readahead is 128, and after applying the patch is 1024


cat /d/mmc0/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            18 (3.0 ~ 3.1 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400 enhanced strobe)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

The driver I used is sdhci-of-dwcmshc.c with a KLMBG2JETDB041 eMMC chip.
