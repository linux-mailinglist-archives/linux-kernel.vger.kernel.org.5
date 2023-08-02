Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469376C709
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHBHhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjHBHgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:42 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB7C30EB;
        Wed,  2 Aug 2023 00:36:39 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 9CB3E100020;
        Wed,  2 Aug 2023 10:36:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9CB3E100020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690961797;
        bh=b/D/LJ/JEmhps4l5xrKdBZ4JUoOucTGmiH6sdU6vmSw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=asQkXlnrZwtQb8EjKdJdbn87doPjxw8ZkcF0jXGFDNEUolgpT3dW/UJ9/NaMxNmth
         z+0OtccyG9yCK9ivH1JtmahlrBpXc6LtQLbZbJNMkoq683PhRHPlaFDiR5NfFKn/6S
         IHGBHsPy2W5bNkQKx74WyYde6Iiqge71INBwIr5x9FAd5qdxqQnVM7T9KsT9EMNX52
         68cBxdyEWA+cLb7KqrHodbxxBx4LraFGnzyOpjqCyGKyyOmLAUnb5zH1WCXTWvyqz6
         WbA5XPj8IswtfpSzyOkxHEnyP1bKVUKnB60m6IN3V3Hk9IQcOGT/iForslYKU26KQv
         zkLBgQ8FY03pw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  2 Aug 2023 10:36:37 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 10:36:37 +0300
Date:   Wed, 2 Aug 2023 10:36:37 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: watchdog: Add support for Amlogic-T7
 SoCs
Message-ID: <20230802073637.4dy22fdh5kxukylo@CAB-WSD-L081021>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-2-huqiang.qin@amlogic.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:32:19AM +0800, Huqiang Qin wrote:
> Update dt-binding document for watchdog of Amlogic-T7 SoCs.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
> 
> V1 -> V2: Unchanged.
> 
>  .../devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> index f5cc7aa1b93b..443e2e7ab467 100644
> --- a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,meson-gxbb-wdt
> +      - amlogic,t7-wdt
>  
>    reg:
>      maxItems: 1
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
