Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF0776912
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjHITrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjHITrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:47:11 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEED2106;
        Wed,  9 Aug 2023 12:47:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl1fT086082;
        Wed, 9 Aug 2023 14:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691610421;
        bh=BYl4jJDg+IGtJlaRNFfsbCRVFe+QoB6JeXudogyJCag=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=SgjUWYfeZ++YAzDEcTRzeC+Wqb3G3B7I8C+fieLXUSz3u4Jr/fQb4rJ22kpSK7cll
         ZEIZPvPaVJn9pvltvttNxUAjwLO3XVeCn+Fuw13qcK5ttlD6AYsiQErjOZdbdbPegR
         147S42aXDYGR6C+4vG36UkwqDBwXe34JUG0N8gWw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379Jl1mu032236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 14:47:01 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 14:47:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 14:47:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379Jl0Uk065166;
        Wed, 9 Aug 2023 14:47:00 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 10 Aug 2023 01:16:22 +0530
Subject: [PATCH v6 4/7] arm64: dts: ti: k3-j784s4: Fix interrupt ranges for
 wkup & main gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230810-tps6594-v6-4-2b2e2399e2ef@ti.com>
References: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
In-Reply-To: <20230810-tps6594-v6-0-2b2e2399e2ef@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Hari Nagalla <hnagalla@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=pmr8txSe1Pu1GvCkSBqddn+aqWc9cRutSnhOiL2s9iw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk0+0weAntwJxXUXg42ifMuN5WYbCqgiJkj0SzQ
 OmI5lKfXl+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNPtMAAKCRBD3pH5JJpx
 RRFQD/wMaIfpOdrXHlhQjBqNBdY8rCYcxRaaCOUb1hrQWXLh1Qbm0J2lT1eH6dak6F6KyH94Cj7
 0YLfHHV4Dx6TDZrL/mkGDiEE4WthEvUggj2pFcihjU+semYUskCdRq6XXkCKprw9b607p4LLRnd
 smcUGAqdFLH0969LLPBvRs3IJwmXsoLFbm0n5K+d01YC6UqFQBC1ivLi0TvhHOlu6NBeCAabiFG
 uduf9J9AZgh9/1Z72eGMs7Ae0hvmoB0MO8Ye1EArhpKSoIqbRifI8qThrwPAwhzG9WUW60tzlNC
 4MuxWtUXYSs4xWXFJYzezRg1TpOzrRy3VEvpfmt5PmvOMdzrwgNBb9/PVFDX6XUECofDhjZVEKa
 ZUvP5ws0g/tUWCx6tj66+NJynbgqLdXQu9weAcBogv2J3jnuRZhMF2Mh7ARZTAe5FKtFjKTQSZ7
 mxhk94UYNSZBkmutq88Ku247CSMijhpcKNn3ByHfSu+7u0hv2eo2WTglr5DzcbfDnenmF/Gs6df
 y4tyOgvc8RZScZLOM/6Zu/qIYqo2yBH7eWTlbegNKdmPjWB+4uaBpRv7KgmYZDUF97tWJxKP2i9
 bxxfa1NlDg6fw0okBJ2eJnOajzqBUXqpAEigieY8Ka2k5PQh7+uguMQ8puDCHG4OTg8/srdeqWK
 WpVDrDLnZQwyK1Q==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Apelete Seketeli <aseketeli@baylibre.com>

This patch fixes the interrupt range for wakeup and main domain gpio
interrupt routers. They were wrongly subtracted by 32 instead of
following what is defined in the interrupt map in the TRM (Table 9-35).

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Link: https://www.ti.com/lit/ug/spruj52c/spruj52c.pdf
Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a04c44708a09..013cf4ed98d8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -60,7 +60,7 @@ main_gpio_intr: interrupt-controller@a00000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <10>;
-		ti,interrupt-ranges = <8 360 56>;
+		ti,interrupt-ranges = <8 392 56>;
 	};
 
 	main_pmx0: pinctrl@11c000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 740ee794d7b9..77a45f97e28b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -107,7 +107,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <177>;
-		ti,interrupt-ranges = <16 928 16>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */

-- 
2.41.0

