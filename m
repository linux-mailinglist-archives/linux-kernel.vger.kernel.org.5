Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22076651A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjG1HRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjG1HR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:17:26 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04053ABE;
        Fri, 28 Jul 2023 00:17:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8423910000B;
        Fri, 28 Jul 2023 10:17:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8423910000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690528642;
        bh=THLBRWDsl5iTK9u472zi5OUc76M58zPFkwRfjKmJhec=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=kqdd3nJVJhpGdhuCZrTZfWzI2s2RabtHQlb8otG6RJY97QX5bdQ2Q+jKgjiVNlFP1
         48JhFTI6TwMXPZ6sBnB1AuXHASXmYNkDtAdVpru68MxcIFVz6KRqZ3g4yLdbmQe24J
         86Ss7J4oQEgMTRaXQE99fEbVSDM6vnpADX4hgrL4SFFvIK0LeOIhoE74jA4zHXNvY0
         eHalq5fueMzU7c2UVgOKYPFgmrApiQUFlBPqoagNbg7qXH8oZVi/DYuvwYjIQegOLS
         4oH0yV9fSdyuqZAz8dS1HSU0tf4fcYj+DzHEgNEzdmfRAsdnUJpgUh8GY6lI5AUZoP
         46ZQU3FHOBkTw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 10:17:22 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 10:16:59 +0300
Date:   Fri, 28 Jul 2023 10:17:22 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: Add watchdog node for Amlogic-T7 SoCs
Message-ID: <20230728071722.dpytlujrzosb7owa@CAB-WSD-L081021>
References: <20230726112146.1127145-1-huqiang.qin@amlogic.com>
 <20230726112146.1127145-5-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726112146.1127145-5-huqiang.qin@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/23 10:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/23 10:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:21:46PM +0800, Huqiang Qin wrote:
> Add watchdog device.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 1423d4a79156..6e34d11214b7 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -143,6 +143,12 @@ apb4: bus@fe000000 {
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>  
> +			watchdog@2100 {
> +				compatible = "amlogic,t7-wdt";
> +				reg = <0x0 0x2100 0x0 0x10>;
> +				clocks = <&xtal>;
> +			};
> +
>  			uart_a: serial@78000 {
>  				compatible = "amlogic,t7-uart", "amlogic,meson-s4-uart";
>  				reg = <0x0 0x78000 0x0 0x18>;
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
