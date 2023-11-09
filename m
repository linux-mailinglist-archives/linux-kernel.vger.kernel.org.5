Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602457E62C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjKID5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 22:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjKID5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 22:57:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6936726AE;
        Wed,  8 Nov 2023 19:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Pm2B7TFo3IgkBnh209fKUpEVKVfGAUrFV9wEqmNS3hQ=; b=YSv8R4mHt9ulQDgw02xn97t8pm
        onvw6KWGRPNr3EyPcZIcr43jePYu1juDejlpBslEIluFbkeJVzsaJlDgPMep3a2+SByKBJCwT/xXV
        1urmlTC6Sn2kvHMQj2Mtn3RFUJ21gu5Ki3IukzJSBKfZZ613jjEucLG7THDbIQX6VLyE+rsTmIwkd
        ovvPTljc8HejXNXq+fPIoaQH2izdebgWDsFQKGH4z0mc3nQxblBAfQTluvFtwSJ71R95oe6Vv/8H9
        mH3uFdhiY3rX2e11rmxZvf9lH5FxZ31qyUOhPqItz2cs5cqbf2oX5ZyiCzpuN4+0ZMhJaj5Gljbqt
        unpq8Sqg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0wAH-005DJT-0s;
        Thu, 09 Nov 2023 03:57:09 +0000
Message-ID: <24aed6e1-4c93-4161-87ec-c59ee2786e6a@infradead.org>
Date:   Wed, 8 Nov 2023 19:57:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: eliminate abnormal characters displayed under
 menuconfig
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     bhelgaas@google.com, horms@verge.net.au, pablo@netfilter.org,
        davem@davemloft.net, nathan@kernel.org, apw@canonical.com,
        joe@perches.com, linux-kernel@vger.kernel.org
References: <20231006202942.GA865945@bhelgaas>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231006202942.GA865945@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/6/23 13:29, Bjorn Helgaas wrote:
> On Tue, Aug 02, 2022 at 06:12:33PM +0800, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> Use "find ./linux/* | grep Kconfig | xargs file | grep UTF", can find
>> files with utf-8 encoded characters, these files will display garbled
>> characters in menuconfig, except for characters with special meanings
>> that cannot be modified, modify the characters with obvious errors to
>> eliminate the wrong display under meunconfig.

Same problems exist in 'nconfig'.

(more below)

>>
>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  arch/Kconfig               | 2 +-
>>  drivers/pci/Kconfig        | 2 +-
>>  net/netfilter/ipvs/Kconfig | 8 ++++----
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 5ea3e38..2462337 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -745,7 +745,7 @@ config CFI_CLANG
>>  	depends on CLANG_VERSION >= 140000
>>  	select KALLSYMS
>>  	help
>> -	  This option enables Clang’s forward-edge Control Flow Integrity
>> +	  This option enables Clang's forward-edge Control Flow Integrity
> 
> Menuconfig renders as "Clang ~@~Ys forward-edge", so this really
> should be fixed.
> 
>>  	  (CFI) checking, where the compiler injects a runtime check to each
>>  	  indirect function call to ensure the target is a valid function with
>>  	  the correct static type. This restricts possible call targets and
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 133c732..8102b78 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -166,7 +166,7 @@ config PCI_P2PDMA
>>  	depends on ZONE_DEVICE
>>  	select GENERIC_ALLOCATOR
>>  	help
>> -	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
>> +	  Enables drivers to do PCI peer-to-peer transactions to and from
> 
> I applied this one by itself to the PCI tree.
> 
>> diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
>> index 271da84..06b9066 100644
>> --- a/net/netfilter/ipvs/Kconfig
>> +++ b/net/netfilter/ipvs/Kconfig
>> @@ -308,10 +308,10 @@ config IP_VS_MH_TAB_INDEX
>>  	  stored in a hash table. This table is assigned by a preference
>>  	  list of the positions to each destination until all slots in
>>  	  the table are filled. The index determines the prime for size of
>> -	  the table as 251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
>> -	  65521 or 131071. When using weights to allow destinations to
>> -	  receive more connections, the table is assigned an amount
>> -	  proportional to the weights specified. The table needs to be large
>> +	  the table as 251, 509, 1021, 2039, 4093, 8191, 16381, 32749,
>> +	  65521 or 131071. When using weights to allow destinations to
>> +	  receive more connections, the table is assigned an amount
>> +	  proportional to the weights specified. The table needs to be large
> 
> Menuconfig renders this one fine either way, as far as I can tell.
> It contains several "c2a0" (UTF-8 non-breaking space) characters:
> 
>   00000180: 660a 0920 2074 6865 2074 6162 6c65 2061  f..  the table a
>   00000190: 73c2 a032 3531 2c20 3530 392c 2031 3032  s..251, 509, 102
>               ^^ ^^
>   000001a0: 312c 2032 3033 392c 2034 3039 332c 2038  1, 2039, 4093, 8
>   000001b0: 3139 312c 2031 3633 3831 2c20 3332 3734  191, 16381, 3274
>   000001c0: 392c 0a09 2020 3635 3532 3120 6f72 2031  9,..  65521 or 1
>   000001d0: 3331 3037 312e c2a0 5768 656e 2075 7369  31071...When usi
>                            ^^^^
>   000001e0: 6e67 2077 6569 6768 7473 2074 6f20 616c  ng weights to al
>   000001f0: 6c6f 7720 6465 7374 696e 6174 696f 6e73  low destinations
>   00000200: 2074 6f0a 0920 2072 6563 6569 7665 206d   to..  receive m
>   00000210: 6f72 6520 636f 6e6e 6563 7469 6f6e 732c  ore connections,
>   00000220: c2a0 7468 6520 7461 626c 6520 6973 2061  ..the table is a
>             ^^^^
>   00000230: 7373 6967 6e65 6420 616e 2061 6d6f 756e  ssigned an amoun
>   00000240: 740a 0920 2070 726f 706f 7274 696f 6e61  t..  proportiona
>   00000250: 6c20 746f 2074 6865 2077 6569 6768 7473  l to the weights
>   00000260: 2073 7065 6369 6669 6564 2ec2 a054 6865   specified...The
>                                        ^^ ^^
> 
> 
> There are a few more ugly ones:
> 
>   $ find * -name Kconfig\* | xargs grep --color -rIP "[^[:ascii:]]"
>   crypto/Kconfig: an ε-almost-∆-universal hash function, and an invocation of
> 
> CRYPTO_ADIANTUM
> Renders as "an   -almost- ~H~F-universal hash function"
> 
>   drivers/mtd/nand/raw/Kconfig:	tristate "OLPC CAFÉ NAND controller"
>   drivers/mtd/nand/raw/Kconfig:	Use NAND flash attached to the CAFÉ chip designed for the OLPC
> 
> MTD_NAND_CAFE
> Renders as "OLPC CAF ~I NAND controller".
> 
>   drivers/mtd/spi-nor/Kconfig: 64 KiB block instead of 16 × 4 KiB sectors.
> 
> Renders as "64 KiB block instead of 16  ~W 4 KiB sectors."
> 
>   drivers/net/can/usb/Kconfig:from Theobroma Systems like the A31-µQ7 and the RK3399-Q7
> 
> CAN_UCAN
> Renders as "from Theobroma Systems like the A31-  Q7 and the RK3399-Q7"
> 
>   drivers/net/can/peak_canfd/Kconfig: operated with ambient temperatures in a range of -40 to +85 °C.
> 
> CAN_PEAK_PCIEFD
> Renders as "operated with ambient temperatures in a range of -40 to
> +85   C."
> 
>   drivers/gpu/drm/panel/Kconfig: The panel has a 1200(RGB)×1920 (WUXGA) resolution and uses
> 
> DRM_PANEL_JDI_LT070ME05000
> Renders as "The panel has a 1200(RGB) ~W1920 (WUXGA) resolution"
> 
>   drivers/gpu/drm/panel/Kconfig: panel module. The panel has a 1024×600 resolution and uses
> 
> DRM_PANEL_TDO_TL070WSH30
> Renders as "panel module. The panel has a 1024 ~W600 resolution"
> 
>   drivers/platform/mellanox/Kconfig: The processor used on SN2201 is Intel Atom®Processor C Series,
> 
> CONFIG_NVSW_SN2201
> Renders as "The processor used on SN2201 is Intel Atom  Processor C Series,"
> (Not terrible, just an extra space, but lost the (R))
> 
>   drivers/platform/mellanox/Kconfig: System equipped with Nvidia®Spectrum-1 32x100GbE Ethernet switch.
> 
> Also CONFIG_NVSW_SN2201
> Renders as "System equipped with Nvidia  Spectrum-1 32x100GbE Ethernet switch."
> (Again, just an extra space but lost the (R))
> 
>   kernel/time/Kconfig:	int "Clocksource watchdog maximum allowable skew (in μs)"
> 
> CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> Renders as "Clocksource watchdog maximum allowable skew (in   s)"
> Clearly wrong.

I have verified all of these comments that Bjorn made (just checking :).

Is there some world where these characters display correctly?

(other than in gconfig & xconfig -- they have no problems with these characters)

thanks.
-- 
~Randy
