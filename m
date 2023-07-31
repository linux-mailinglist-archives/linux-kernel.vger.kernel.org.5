Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9325C7696A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGaMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbjGaMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7619E10E3;
        Mon, 31 Jul 2023 05:45:27 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjGf3110639;
        Mon, 31 Jul 2023 07:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690807516;
        bh=eh6G0ASCqjw7aVLsjaZTovSD6uYBCw0N2aZ2dEim4zw=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=F00qhFfTEc73ofkgO1DkfIeS5RJT++MewzL3OVSl5PBf9buyy829+GEMty+79iuxD
         Yyvl7WrZ5xKtSRI8iOSpE4aZJUJ/7YmsTLObywDXjpLBz4UTzli5yU0d1IocSNzIAJ
         uN20QG3/zTAMSIuaJlv+lhuNNdlPTbqsrXzmnGaM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VCjF2l031482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 07:45:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 07:45:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 07:45:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjESe025081;
        Mon, 31 Jul 2023 07:45:15 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Mon, 31 Jul 2023 18:14:39 +0530
Subject: [PATCH 2/5] arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230731-mcasp_am62a-v1-2-8bd137ffa8f1@ti.com>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>, Devarsh Thakkar <devarsht@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=qEugwhrLwpSo3Rg2CZ+bSuPr12FfFiZlbT7SkiRKxmA=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx6zX2f6kb9auEhv1S6L2PMBqEVSXDYRVSmfZc
 uQFv0I8WHmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMes1wAKCRBD3pH5JJpx
 RRlhD/92OgSCvH1L21dBLLFxyxkRFl7J+DJTPXCdAvnEmDOZVv7BVfKdwCcHcle9mUFQMugZV72
 NtfxFkv4WpoSjAnSOQwOO4jH41uwHD7dSHsg3NLVu0WrCeYrOmdtHQ+wIeEjRp8R1qmktemau0t
 FvhjUFvxXtboo20qJoGV5C76r+RShdDOaF11LzeKs4b63sOakiWnNduFRefwql1x1sNh0MI7DZI
 wEQrZlh+chhjeGND0Iuvc7cRfjdTGI8lgdPD+3u06hXPj1Vf7aqORVFSIpwHDuq7Ph2KO47KU2I
 H/CJa8+zHewz+hfFewuMQSiBdpImri9tVEr+Qh/7jNwxTGTeAmJ+jiAUwS9EjxMPVWNigInCYi7
 W1dbOEmWwCegeQfFHHwuJfJv5AHumUy9vzBLCI6iwk/0hjUOtPZ5uw4G0U+L6tQ4B9gDZnmhW+B
 Q+AxQfvfcXQmS0fL9D+XXWbrBLO/uKM+DH/J7OPC3Q8xLJelwxYqij8hp3GVA9TkOtp6HymnBae
 YqG5WI8i0aI8qJzASASMzoxp6Fosg4AcV0wAbyLuvInd+WMaryI07QEtdvOQ95Kup/MNGaTda+8
 NytNbOu5IQbnEuceFtjmnhxE9ZAfW0Piu7dveYRF8C4mZ0snUZxvTi/r4GBGPf1L944s7NYpALq
 m6jVOC1hK0gXpwg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 133e32f7c6cc..9d34b8fe4ecb 100644
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
2.41.0

