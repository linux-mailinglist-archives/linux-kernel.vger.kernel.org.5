Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8380B172
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjLIBaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:30:07 -0500
Received: from mail-m25471.xmail.ntesmail.com (mail-m25471.xmail.ntesmail.com [103.129.254.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC5010F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:30:12 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=e6kBuiHhF1GSlWML17rFKSqfGmnDq09ZaTAXaNvDKGygV9wCypiD0zyU2rZ19qnZEESh1ECRd0f9rEmwc4eA7S82D25mjAh9PaECbir6pix8wv8WZVufu31Gs6s85KgVI5ZBeDO6MDB14RXomdIy7nOV4/mPnz1eMjvC/uDMYHA=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=Ksw/7IywGMYWf1AJ9p0S1CUhJTrJL9FdKIXVss4Vfu8=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 5AAFB780194;
        Sat,  9 Dec 2023 09:21:54 +0800 (CST)
Message-ID: <3b35ebad-c951-49a1-bfff-da79b3492ce1@rock-chips.com>
Date:   Sat, 9 Dec 2023 09:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] Add VOP2 support on rk3588
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
References: <20231207075906.651771-1-andyshrk@163.com>
 <8765245.NyiUUSuA9g@diego>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <8765245.NyiUUSuA9g@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMdSVZDTh9IGhhMQk1JQxpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8c4c2aade8b24fkuuu5aafb780194
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Fjo6DTw3PE4fSx0WSz4h
        HygaCwxVSlVKTEtJS0NPQkpOSUlNVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSE1NSTcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko:

On 12/9/23 00:07, Heiko Stübner wrote:
> Hi Andy,
> 
> Am Donnerstag, 7. Dezember 2023, 08:59:06 CET schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> This patch sets aims at enable the VOP2 support on rk3588.
>>
>> Main feature of VOP2 on rk3588:
>> Four video ports:
>> VP0 Max 4096x2160
>> VP1 Max 4096x2160
>> VP2 Max 4096x2160
>> VP3 Max 2048x1080
>>
>> 4 4K Cluster windows with AFBC/line RGB and AFBC-only YUV support
>> 4 4K Esmart windows with line RGB/YUV support
>>
>> The current version support all the 8 windows with all the suppported
>> plane format.
>>
>> And we don't have a upstreamed encoder/connector(HDMI/DP) for rk3588
>> yet, Cristian from collabora is working on adding upstream support for
>> HDMI on rk3588.
>>
>> My current test(1080P/4KP60) is runing with a HDMI driver pick from
>> downstream bsp kernel.
>>
>> A branch based on linux-6.7 rc4 containing all the series and
>> HDMI driver(not compatible with mainline rk3568 hdmi) picked
>> from downstream bsp kernel is available [0].
>>
>> [0]https://github.com/andyshrk/linux/commits/rk3588-vop2-upstream-linux-6.7-rc4-2023-12-07
>>
>> Changes in v4:
>> - fix the POST_BUF_EMPTY irq when set mode
>> - use full stop at all the description's end.
>> - address Krzysztof's review about dt-binding in v3
>> - keep all VOP2_FEATURE_HAS_xxx macros increase in order.
>> - address Sascha's review about debugfs
>> - Add const for rockchip,rk3588-iommu compatible
> 
> very nice, the error messages on "mode changes" are gone now.
> Display and even combination with panthor still work of my rk3588-board
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks for your honorable work on this platform, and thanks for you test and review.

So can I add your Tested-by for all this series form PATCH 1~16 in next version?
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
