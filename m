Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36C375BCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGUDjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUDjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:39:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718041BFC;
        Thu, 20 Jul 2023 20:39:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36L3d7Kc073061;
        Thu, 20 Jul 2023 22:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689910747;
        bh=6ncmgsCGXWN2h5jurCHYvdbyIoLK75ANn08yn2dph6g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=DjctBhQ9gEifJT4KqmZjpjALnpx5Jfc3tqdyIpnM8iL5qptd2qNrFeUqyVUJt/por
         aNGSeHV+vQHzMyhBDfYNZJVoyiNtJB15lS41F/r/sH4rhShLnwICLOKBkgg3Aba9+P
         9VeI9ao+x7g5CfnHTprJuq6S5AWWvz2/9nT933bA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36L3d7j7095425
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jul 2023 22:39:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jul 2023 22:39:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jul 2023 22:39:07 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36L3d4kH002829;
        Thu, 20 Jul 2023 22:39:05 -0500
Message-ID: <ec6b8d6d-6191-d760-10b2-29518010f4b4@ti.com>
Date:   Fri, 21 Jul 2023 09:09:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2] arm64: dts: ti: k3-pinctrl: Introduce debounce select
 mux macros
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>
References: <20230619131620.3286650-1-nm@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230619131620.3286650-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/23 18:46, Nishanth Menon wrote:
> Introduce the debounce select mux macros to allow folks to setup
> debounce configuration for pins. Each configuration selected maps
> to a specific timing register as documented in appropriate Technical
> Reference Manual (example:[1]).
> 
> [1] AM625x TRM (section 6.1.2.2): https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> - I have'nt picked up Krystoff's ack since the file modified is now different.
> - Changes now applied to k3-pinctrl.h instead of the ABI header that is
>   now set up to be deleted in v6.5-rc1.
> 
> V1: https://lore.kernel.org/linux-devicetree/20230308084309.396192-1-nm@ti.com/
> 
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index c97548a3f42d..6004e0967ec5 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -11,6 +11,7 @@
>  #define PULLUDEN_SHIFT		(16)
>  #define PULLTYPESEL_SHIFT	(17)
>  #define RXACTIVE_SHIFT		(18)
> +#define DEBOUNCE_SHIFT		(11)
>  
>  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> @@ -29,6 +30,14 @@
>  #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>  #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
>  
> +#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> +
>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  

-- 
Regards
Vignesh
