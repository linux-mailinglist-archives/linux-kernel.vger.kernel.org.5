Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68B7B1752
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjI1J0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjI1JZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:25:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682621B5;
        Thu, 28 Sep 2023 02:25:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P4wG104284;
        Thu, 28 Sep 2023 04:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695893104;
        bh=VOgmZjppaNHRvb+fq7iB4eyXgEBm+n29yek9u6VmbPM=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=M7WdNJwK1s5Vd7sGKOy2TrfBhWTyz0eO7OuYvtS6Pr79vZcjAlXoKnARNDntseNbs
         tHKM4/4/j6mYwUJRGwIoHlbnQnR3iHVZ0QGRJ5nsIakjquuDn6bx2KBA3HbX29IDMh
         0wM3XFelrN8rg6jsnght5MV9wqtXgQ1OBMypjmjM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9P4ss006600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Sep 2023 04:25:04 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:25:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:25:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9P3tj090367;
        Thu, 28 Sep 2023 04:25:03 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 28 Sep 2023 14:54:27 +0530
Subject: [PATCH v2 2/6] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230928-mcasp_am62a-v2-2-ce9f0e1ba22b@ti.com>
References: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
In-Reply-To: <20230928-mcasp_am62a-v2-0-ce9f0e1ba22b@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=8UdWpyx47NjH2sp2+nFjUjfUOYp2UBEB4/o9/Nf7fxo=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlFUZivrZAvboxWYTPt/uQfEC9X/DYuWAvKBMNa
 D/89vc5DemJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZRVGYgAKCRBD3pH5JJpx
 RXdeD/9Q4KaKvu/CVwubxurKDwYapnMFCs+mLI9ktR0E3ILIn5+gVWEKLhnvx87OZkXmkx7W5qK
 NuLlQ8eHGLLQrebVtjlt2c7IvzSqZgoVNy7Wi6gJUSbi/EnC4Ml7kAtjJuAQDNjnDN3K4eQhHn7
 hdSaLFr1Y6o3CMoPVI3S5TQ2KS/90DogpCwoeHJ6cM2s4Bf9oJHkJzEMvaLsaXRlOIKty7JlcSw
 Hc9xWfduyR8i1KFJvTwLylFapic0e/nOIlWorr5/0Ms12WVPvwW4iDJIQ3/eQn6Cp1Oji6wfkoW
 Dbd8TSVFPynSJy6B08/3dB0u9jq6N6xnXVow37JwfIv+uB+pxkBIWhIcgUdL5Ui+KUSvegpSsv5
 myQ6lwJnovgPwzQCVb/B+pKgzUVEjQQ8fluybgDvFag4KapxncsxxeUuXLCcs6vMHh1mgfCIXcs
 8K1uyo7FWszMcKDgLDCR7l4mA6l29BsZUZwGK5UqonPfokt5usEEvmDewxXMvGzaVJgaenpLomq
 VaqpNZybZtEDYE3JPdQFdptRSj7YKguLGmompAy8VSSw8DsM2RZ0zJkuty3oxn5EbqHg1g5vbRs
 Xpi8alxtd5ikSGkTj8LthvOWw81kzxpJQUV+CQGt9qaUmnCPxGNPC7sIqUyHug2kRaeJnrh89+A
 2HpiSQKzB6yAAKg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VCC_3V3_MAIN is the output of LM5141-Q1, and it serves as an input to
TPS22965DSGT which produces VCC_3V3_SYS. [1]

Link: https://www.ti.com/lit/zip/sprr459 [1]
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index cff283c75f8e..c689d3da2def 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -79,10 +79,10 @@ vcc_5v0: regulator-1 {
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: regulator-2 {
+	vcc_3v3_main: regulator-2 {
 		/* output of LM5141-Q1 */
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_sys";
+		regulator-name = "vcc_3v3_main";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vmain_pd>;
@@ -101,6 +101,17 @@ vdd_mmc1: regulator-3 {
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
 
+	vcc_3v3_sys: regulator-4 {
+		/* output of TPS222965DSGT */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";

-- 
2.42.0

