Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C62801F18
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjLBWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLBWgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:36:02 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA99129;
        Sat,  2 Dec 2023 14:36:06 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id D8A531612A1;
        Sat,  2 Dec 2023 23:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701556203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zc39xsL707XCoXIplAh3ga88kJDua1ThzVS+PxcXYc=;
        b=Sz67HQgt6Qhbdi642JEJmyb3q41j2bBfbd6mieLNqnLVFy6bkC+45ppm5792hV5LXoArUC
        3Va+uaAyibn8dM5IKDmuzb/l1dCXgfbXWRulSI1AE9+0Een5pDdS2hy2LXX7/pKVK8S4xY
        zVmQxIZkOVKe9+IZ9TW22xvO48x98d0=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] arm64: dts: imx8mq-phanbell: make dts use gpio-fan matrix instead of array
Date:   Sat,  2 Dec 2023 23:29:01 +0100
Message-ID: <20231202222934.137191-2-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231202222934.137191-1-david@ixit.cz>
References: <20231202222934.137191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Adjust to comply with dt-schema requirements
and make possible to validate values.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
index a3b9d615a3b4..e34045d10a12 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
@@ -39,7 +39,7 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 
 	fan: gpio-fan {
 		compatible = "gpio-fan";
-		gpio-fan,speed-map = <0 0 8600 1>;
+		gpio-fan,speed-map = <0 0>, <8600 1>;
 		gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
 		#cooling-cells = <2>;
 		pinctrl-names = "default";
-- 
2.42.0

