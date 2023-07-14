Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C1753634
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjGNJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjGNJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:13:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADE2D47;
        Fri, 14 Jul 2023 02:13:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36E9DdBm028503;
        Fri, 14 Jul 2023 04:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689326019;
        bh=mKtCUPgaud8pjCzNSvAn4kZizjOxNjiafARqukJWj+8=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=wU8Iqipd8rz5A6Oh2r/fpzTsUZhuw6/l9SXit/XsUAyw+B3CmKzj32OHZuP6GGwZQ
         1NXKAFjgsWI8GaOiAQrHTF1bz/JEK3QiFsCJS55C4ebbrQorB8SluVnvcd2YQafTFW
         OGU8we2N+yKHQAGB0Wf7vlLWXPTIejKNUqWCAwbI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36E9DdKP097414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jul 2023 04:13:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jul 2023 04:13:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jul 2023 04:13:38 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36E9DcdL015114;
        Fri, 14 Jul 2023 04:13:38 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
Date:   Fri, 14 Jul 2023 14:42:42 +0530
Subject: [PATCH v5 2/2] arm64: dts: ti: k3-am62-main: Remove power-domains
 from crypto node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230614-sa3ul-v5-2-29dd2366fba3@ti.com>
References: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
In-Reply-To: <20230614-sa3ul-v5-0-29dd2366fba3@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Tero Kristo" <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326014; l=1080;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=twkydDeRPS5AYQfyYZRmDOCh79DoQ65SqFyXWQK4qeQ=;
 b=AJ+VVQIeJ4KLEgtk9OggCVRkJHfne+ozX+EGKZP58f9RMR7lSGudpeCVhbp6M52B+CA0hqKDl
 kBA1p40Gac7AmpUAewZ8Ge9HYWANvn+FDOYtlz26ZCQXkdTb2N9cPbx
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only SYSFW has control of SA3UL power.
From SYSFW 08.04.00.002, for security reasons, device ID for power
management of SA3UL has been removed.

"power-domains" property in crypto node tries to access
the SA3UL, for which it gets NACK and hence, SA3UL driver doesn't
probe properly.

Fixes: 8af893654c02 ("arm64: dts: ti: k3-am62-main: Enable crypto accelerator")

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index b3e4857bbbe4..18a6e9ffaf58 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -174,7 +174,6 @@ k3_reset: reset-controller {
 	crypto: crypto@40900000 {
 		compatible = "ti,am62-sa3ul";
 		reg = <0x00 0x40900000 0x00 0x1200>;
-		power-domains = <&k3_pds 70 TI_SCI_PD_SHARED>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;

-- 
2.34.1

