Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4797762F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjHIOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjHIOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:48:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3431FCC;
        Wed,  9 Aug 2023 07:48:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 379EluQO075453;
        Wed, 9 Aug 2023 09:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691592476;
        bh=YJ6CAHBWMpjQ9JZLQq2WZQGFtlDCZBggbxrJy0wkvys=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=omabc2859s6MgX9SKnbNI7kH533sB1NuREXoXVHdY5ok2ZHX88mdRZYS8w2Bm52M/
         jaJy6MosAQ8D2r3c1YX0I50thl6bLMYJ//PAzLm9B2elukKPBUJrcnKtg9G6Qhrx99
         pji0VMvq+9qa5Q/1FFc9/Nhq6BPT55Ka4YFrDafg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 379EluWa022956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 09:47:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 09:47:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 09:47:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 379EltaX036909;
        Wed, 9 Aug 2023 09:47:55 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 9 Aug 2023 20:17:05 +0530
Subject: [PATCH v5 4/6] arm64: dts: ti: k3-j784s4-evm: Fix interrupt ranges
 for TPS6594 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230809-tps6594-v5-4-485fd3d63670@ti.com>
References: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
In-Reply-To: <20230809-tps6594-v5-0-485fd3d63670@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Esteban Blanc <eblanc@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <jpanis@baylibre.com>, <u-kumar1@ti.com>,
        <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=lVTkp0occe1u5PjXOpY9HPUxvXrGy5ifWyibV8zxXk0=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk06cY4XC70qYfbRwNR4eHpXUnSJHrpmS8nEGMu
 y1qA11CS8eJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNOnGAAKCRBD3pH5JJpx
 RWP9EAC9yUT6J+PLRBb4OzmzWLK6km+veF1wCFf967a+WIhskBlYpyIAWsbTxeOfHQmKpZ/yoGF
 bl1Gi525VSapO9AveF1Qq67mJkEuvUvtFBVojbI7Y0ZorgF1SV6qqMHAeSiorcnE475f+UgTbEZ
 aFuKXBaMatm9FRn+TPUxdPNslam9c0ACFsDXDji6sLNwuN98CbOmdISC0++NTxag4qwHl1Re208
 WcZ42uFTBcycxJN5bcJlTau09BYjVxMJLuSb1D7rxUujv+KSmTwi9Jdsni+pnpIyZ479WA+Tmb3
 7Ys91gQDrkGx0Qp8ur8xPyAx15yieg3k9LV6+Cfkogvj7g2Xv0tJ8EG0/tgrNzMgzeoo/+Xt6Hf
 gvYkOuMiKeVAxL3Ox78+sDvuAbdXHqIY62LQITkLPFk2C3sdZUm8G/hFGOVDMGl1JrPOs5WURS7
 ZEtG+4eJpQ5F2sPHUax+2baMZDihuuIkGV1bbRY6S76m6LAp7OGbr7P4LFI8wK5trscYeHXwZju
 MlMiGP7OoBY++WqX6sVDUUxIuTgqukJJbS2C7Yi15dtaLsaxOmdKeiErMrepqOa1ck63tMkUgS2
 Gvlnf03BLRBYYML/rhoQk92sJ0LsJ61Y4kYT211cg/98qkFPAozUkZ+4DtdOYX2UFIvYSd+94i9
 abMPQijo3FeUcBw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Apelete Seketeli <aseketeli@baylibre.com>

This patch fixes the interrupt range for TPS6594 PMIC on MCU/WAKEUP
domain for RTC peripheral.

Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

