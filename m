Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697467B44F2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjJACUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJACUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 22:20:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03151BC;
        Sat, 30 Sep 2023 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=64FZBFm9QXLeaiqRuEoVGaE58ddNALR1GNC50CVRTEA=; b=CVwbcSdZreAZxeCYkfLtCDY8pI
        dUV/ED0NZY/U4uO/LCDVZeeZBAPyeBmZThaQTaoqVJYYYDxtK7k4zr0c8v0DjkxnB/FHQeDcR2Zbd
        hAKXVaLAewCUo+wpwBvikRlHdTLnIH5jtiAbBP8YnAGq/bAfaU6vRE7i3mpfTSfCTenX7OH5M45Bv
        lQj+I8psGj8qDu0nYvd3IG86sVl2Lkm6oLdovy00DvjD90Q9xou4c1/QmDGuxO0m27Pf+wrkYq1rQ
        rIhlRm71YSCJK86DyB+eeEYKQbXN/lhD2nQjEhLxKPzV8AXYZmW1NOR6//oXyMvp6ZjQO5VacdQUL
        PiVhqZIg==;
Received: from [2603:3004:644:9100::a64a]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qmm4K-000iXd-6D; Sun, 01 Oct 2023 02:20:28 +0000
Message-ID: <b66c04cb-9576-4b8b-9e5e-4e5b37c2c092@infradead.org>
Date:   Sat, 30 Sep 2023 19:20:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: sunxi: a83-mips-csi2: also select GENERIC_PHY
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
References: <20230927040438.5589-1-rdunlap@infradead.org>
 <ZRQIfC67fDmOUBNY@kekkonen.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZRQIfC67fDmOUBNY@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 03:48, Sakari Ailus wrote:
> Hi Randy,
> 
> Thanks for the patch.
> 
> On Tue, Sep 26, 2023 at 09:04:38PM -0700, Randy Dunlap wrote:
>> When selecting GENERIC_PHY_MIPI_DPHY, also select GENERIC_PHY to
>> prevent kconfig warnings:
>>
>> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>>   Depends on [n]: GENERIC_PHY [=n]
>>   Selected by [y]:
>>   - VIDEO_SUN8I_A83T_MIPI_CSI2 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && VIDEO_DEV [=y] && (ARCH_SUNXI || COMPILE_TEST [=y]) && PM [=y] && COMMON_CLK [=y] && RESET_CONTROLLER [=y]
>>
>> Fixes: 94d7fd9692b5 ("media: sunxi: Depend on GENERIC_PHY_MIPI_DPHY")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: lore.kernel.org/r/ZQ/WS8HC1A3F0Qn8@rli9-mobl
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: linux-media@vger.kernel.org
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
>> Cc: Samuel Holland <samuel@sholland.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-sunxi@lists.linux.dev
>> ---
>>  drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
>> --- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
>> +++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
>> @@ -8,6 +8,7 @@ config VIDEO_SUN8I_A83T_MIPI_CSI2
>>  	select VIDEO_V4L2_SUBDEV_API
>>  	select V4L2_FWNODE
>>  	select REGMAP_MMIO
>> +	select GENERIC_PHY
> 
> Could GENERIC_PHY_MIPI_DPHY select GENERIC_PHY instead of depending it?

Yes, I don't see why not.  Let's see what the PHY framework people have to say about it.

Vinod, Kishon, do you see any reason that GENERIC_PHY_MIPI_DPHY could not select
GENERIC_PHY instead of depending on it?


> There seem to be a few other drivers that appear to have the same issue.

Yes, I see 4 others that have the same issue.

>>  	select GENERIC_PHY_MIPI_DPHY
>>  	help
>>  	   Support for the Allwinner A83T MIPI CSI-2 controller and D-PHY.
> 

~Randy

