Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60C758240
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGRQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGRQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:37:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3210C;
        Tue, 18 Jul 2023 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689698245; x=1721234245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4NUpTJzBo4VjuMeFqhZjHQR0CDQrSitP9tTknt3O5eA=;
  b=AKuRbBQ7ennWt3mKQEaPOKDeqrzyJV2wQPYcYODRO7Jav9QXOYu0nYpr
   XaDJMOQ0YoNAPYVTIKnZNnbkRTQhHt3lXYnJ06RLhAwOabcr5weVILPhr
   G5+AZek+t0146K9tybBgcsSOa0h0uXIJYCEOboMGC7N84zUdvbrcT1hL4
   F8g3VQbgHLNYGh8bzWnTw1d4iFq+myZxvHAsSCJvbb7992Sr7nKA8OZXY
   Y5rLLCK8nvY69SRunn2nG8ZblgfM63L+0IHtWTDHiF8A+m3lTzCBlsF2i
   Bm8MgL+DsPCW/K7umfqaoxGmgJBdtahNoxD50guDWRy5wotsOjwMIcrWn
   w==;
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="236269369"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2023 09:37:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Jul 2023 09:37:25 -0700
Received: from [10.159.245.205] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 18 Jul 2023 09:37:23 -0700
Message-ID: <31e4da6a-44ab-5c0a-ae32-c0fcf09d7cb8@microchip.com>
Date:   Tue, 18 Jul 2023 18:37:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91-vinco: Fix "status" values
Content-Language: en-US, fr-FR
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230626221010.3946263-1-robh@kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230626221010.3946263-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 at 00:10, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The defined value for "status" is "disabled", not "disable".
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
We'll queue the patch in our tree (and linux-next) soon (tm).
Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/microchip/at91-vinco.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-vinco.dts b/arch/arm/boot/dts/microchip/at91-vinco.dts
> index ebeaa6ab500e..ecbdacf48708 100644
> --- a/arch/arm/boot/dts/microchip/at91-vinco.dts
> +++ b/arch/arm/boot/dts/microchip/at91-vinco.dts
> @@ -159,7 +159,7 @@ usb0: gadget@400000 {
>                          atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
>                          pinctrl-names = "default";
>                          pinctrl-0 = <&pinctrl_usba_vbus>;
> -                       status = "disable";
> +                       status = "disabled";
>                  };
> 
>                  usb1: ohci@500000 {
> @@ -168,7 +168,7 @@ usb1: ohci@500000 {
>                                             &pioE 11 GPIO_ACTIVE_LOW
>                                             &pioE 12 GPIO_ACTIVE_LOW
>                                            >;
> -                       status = "disable";
> +                       status = "disabled";
>                  };
> 
>                  usb2: ehci@600000 {
> --
> 2.40.1
> 

