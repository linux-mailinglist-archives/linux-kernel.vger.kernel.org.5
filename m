Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22C580E848
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbjLLJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:55:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244C95;
        Tue, 12 Dec 2023 01:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702374913; x=1733910913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X8CUL9LClm8ET/lWAC5xyw23OUAQtwlECRNjbkZl/IU=;
  b=2g4YBe9hlsznv7GrysqftNIsrbDQ2ny1qvDmn197aE+bgu5Tzb/zsyXT
   YCOMdyup/U61SJk9iFTN4VKKj77pHkMIXlqDJU4cnG7ZqSRK4JF7LUg3c
   Qsc73f/m2cTHozdNWDGGfvoxjKUp/wiplIYKVAlcJNj6cxDWGXBc5Lsdt
   +mBi8jkuACNz63QSvFBiQfShwX0FCfM3h3imA/W/s6iD53mSSsaeEdU1T
   IxPVPH/aWf/vhEx3FDXCq4364qBTUA3yn2vD1ZVK0wHTOPbFMBqc8QFhB
   LsGmLBF0Fas58vlU2TkwiS+0Cc9cTexK5w5VT1vlsMRcqKj0asTL+Njow
   Q==;
X-CSE-ConnectionGUID: iJVzHzojREmPBAOFIETSrQ==
X-CSE-MsgGUID: ygS8AKm2Sh2dSf9Ddb7OAw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="13131478"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 02:55:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 02:55:06 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Dec 2023 02:55:04 -0700
Message-ID: <521ee68c-f204-4d56-a8ef-46f391bd1e1e@microchip.com>
Date:   Tue, 12 Dec 2023 10:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama5d27_som1_ek: Remove
 mmc-ddr-3_3v property from sdmmc0 node
Content-Language: en-US, fr-FR
To:     Mihai Sain <mihai.sain@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>
References: <20231211070345.2792-1-mihai.sain@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231211070345.2792-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 at 08:03, Mihai Sain wrote:
> On board the sdmmc0 interface is wired to a SD Card socket.
> According with mmc-controller bindings, the mmc-ddr-3_3v property
> is used for eMMC devices to enable high-speed DDR mode (3.3V I/O).
> Remove the mmc-ddr-3_3v property from sdmmc0 node.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Fine with me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> index d0a6dbd377df..f3ffb8f01d8a 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> @@ -54,7 +54,6 @@ usb2: ehci@500000 {
>   
>   		sdmmc0: sdio-host@a0000000 {
>   			bus-width = <8>;
> -			mmc-ddr-3_3v;
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&pinctrl_sdmmc0_default>;
>   			status = "okay";

