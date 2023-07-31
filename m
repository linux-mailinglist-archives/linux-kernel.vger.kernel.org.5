Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FF7696AC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGaMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjGaMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624210EA;
        Mon, 31 Jul 2023 05:45:27 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjHEa110648;
        Mon, 31 Jul 2023 07:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690807517;
        bh=Pcz6ABCUyvN0ow/G7gff5cRXMYJaFfXpriXkrpONG2M=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=NIOdeyNEsts3asU+1/mlG5a6xs+imJ7L7O3otboOUm7GDplJnWDpKDp7yIgvRYcQ9
         RSC12DM6/qxZR5UQf1LFXHp2TuZPpVjHQVJ4Ql5y7+o3ztluyFiti/BYKBAESPWzpL
         53NNkErVWjzNeAiFqJZw3A55nDLH64ySQ7ywSEPI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VCjHjA021188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 07:45:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 07:45:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 07:45:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjGbk053803;
        Mon, 31 Jul 2023 07:45:16 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Mon, 31 Jul 2023 18:14:40 +0530
Subject: [PATCH 3/5] arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230731-mcasp_am62a-v1-3-8bd137ffa8f1@ti.com>
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
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=aTOqwZxXdBJogA2nRpSO8Kb+qxM8xYZ25pTWUKPJOR8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx6zYYMwzfaFYgA8QP+a3aNyGfWTL8VdXfwv36
 gqCD/+RKQiJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMes2AAKCRBD3pH5JJpx
 RQDrEAC5pvCzWw3YO1K2zS5NfpF9tyEZNvtbKZBhfCyr8Ji/FUXPd1qLvKuj3LTjjse2a/AEgjc
 7fJA0/0nWOXNih/f8fJXHadwgtmDdpxijwBssBiXJJ61gQ+lsn0aWfRzTIy8RwxMr35MSm9YLPF
 PO7iukHXWx+lVj2UKHzUURRVDFIIkufGjGGi9LQrvT1Kr8Zaw3BKNpzNhte4gOaKI2R3IBdc4hr
 /lkdCq4MWO8Dc6u0x2tnfHyEjxJYWCccEfCw3Ns/Sn+MQA+bAgSbtk0jB7vuTO4Dvvu+A1seQwq
 Qu5hB5I8VUMtLnw2Nfz0J0zZD/2gCwwRr/z1mMixKJtYpXVRtd+QNcSsC60SY4v2SFSv2mgy71T
 MSWk1lC90H8tPdI9RgpZ2ihMOf7F2Akr6M6vFNERSTO/MKrGw2VKdSKDjvSpRaFX2knWYUmcYr9
 m/B64bmDmbxxAI+PID0rBTAI7Fy/Y6Q9uK4aFJtzO8Yj6SpSX2Z4MdcuRf/rRzpQ2Pb5LexhM/X
 oRaDMhWb/wuBNkbhOa+apP+21qoWNDD1V6hMwQJ8Tz/oS30hKt21tAzN5uUC1ODnZxM/QLSRae6
 WRGJRZU4X8DoRinNiHNEtlOaL8Kl/1u9vyqLtRsqkGlbw2+bHrcKKXkPenVCZ/PBDAqwrK8k2XK
 NsLFpw10vqMq9SA==
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

The TLV320AIC3106 audio codec is interfaced on the i2c-1 bus. With the
default rate of 400Khz the i2c register writes fail to sync:

[   36.026387] tlv320aic3x 1-001b: Unable to sync registers 0x16-0x16. -110
[   38.101130] omap_i2c 20010000.i2c: controller timed out

Dropping the rate to 100Khz fixes the issue.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 9d34b8fe4ecb..752c2f640f63 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -338,7 +338,7 @@ &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	exp1: gpio@22 {
 		compatible = "ti,tca6424";

-- 
2.41.0

