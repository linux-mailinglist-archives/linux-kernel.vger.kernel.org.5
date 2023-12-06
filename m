Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447F0807B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377546AbjLFWQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377494AbjLFWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:16:27 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8E10C0;
        Wed,  6 Dec 2023 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701900967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7Gat5xEw2YkABlBCPURNwKi3WZsiT+3bFDUKj6PsyA=;
        b=iSkBdKepSayqda5WA4rmrRSNcXfR8Toke+qdFKqwV62t8Go/PtqoAp+8OyDTKnBYR7XpzQ
        5eV3kNYrB5Aom1TNE4mz/Ss4He4KhcBV9qyTNAUb2wdVT55LNCp1KruxKW7Q3LWuQRcWZ/
        YIg/OQYmGUU3xcz+9aOj9L5woebj0n4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ARM: dts: samsung: exynos4210-i9100: Add accelerometer node
Date:   Wed,  6 Dec 2023 23:15:56 +0100
Message-ID: <20231206221556.15348-4-paul@crapouillou.net>
In-Reply-To: <20231206221556.15348-1-paul@crapouillou.net>
References: <20231206221556.15348-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree node for the ST Microelectronics "K3D" accelerometer
chip found in the Galaxy S2.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index f03b03dbe9f2..7e57fe033e2b 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -421,6 +421,23 @@ touchscreen@4a {
 	};
 };
 
+&i2c_1 {
+	status = "okay";
+
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+
+	lis3dh: accelerometer@19 {
+		compatible = "st,lis3dh-accel";
+		reg = <0x19>;
+
+		mount-matrix = "0", "-1", "0",
+			       "1", "0", "0",
+			       "0", "0", "1";
+	};
+};
+
 &i2c_5 {
 	status = "okay";
 
-- 
2.42.0

