Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F23752713
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGMPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjGMP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1832706
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso1039370f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262192; x=1691854192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a92s0ZBpjasngrfkdppw5RA1B//7iWnSeb2Z8OjOQOc=;
        b=AwzbtHX/Hy8teYyGGtfglN1H/KkE+USMpc9vXvkM0GmOr5NPj7RYfxH4Vj5fPxteep
         6x07uaYMcmSXo2GI7aBk4uhuIHTmcak3aZolMGTv+YyBluvi/VVSXnbhC7THfVZoA4x/
         vEOqsybWByv69J2HbONrZrXO5Y/sPukmHqHfXcF5iWS+gpQwVtRJ6CouutPM/uRAnlyL
         8mdtTgccbd3/jDO/UtlhdXv2cn6FytJC00q693BzXQJdihqd6iD8Pdn9tZpTj32NOVs+
         DsdzA3RbUQO1zk8cDZO81p7G+RwHYepte7DpDo36vp0cpidfu6aMCusBBOubrqdK7M6l
         xtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262192; x=1691854192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a92s0ZBpjasngrfkdppw5RA1B//7iWnSeb2Z8OjOQOc=;
        b=AumDWmF2axzbwSBLdRpeZsGP8XWpXDYAnbZS2qUPyvrhR7HHSj3jJI1786QKIHLle3
         dvXpewVRTo8bwOnZgrUwk+kTt1cfNXGWpPPcrvD5V4FTrM+mAYfNY5V/QYWwwmv6vGm8
         sZfBMLD6JGPYSas6SHLkPIa9oqnTofQhYOCRP244Hicx8h3uOwvGmKdhej1tZZQtS20y
         I6495t8j1ctJoWEFwuuqlzoz5IFiVRUqXE2nRzt61e6c+fwzRpy9WgfLqzKWwTCcHw1a
         a7v97HG1OP1sOVrhme48B41o3ZttZwLqqt5hqDexzas53LRn222AzeXtfJxD3Hz35/5p
         w/5g==
X-Gm-Message-State: ABy/qLZ2mvPxp3KQ5aL7cLm5AhL/ZhRaiPlDFmTaD3H7cbrMD2a1bbj9
        j7J+ZgC/jRbYBQGeFexyIR4tgQ==
X-Google-Smtp-Source: APBJJlEZszP7Kjrwu0BtXJ+mxlydmEr7PvbzOrIwYYxYxXIWCWZun4+gNiEx1MV4LEY6YLDbaEzrmw==
X-Received: by 2002:a5d:4443:0:b0:314:358a:64d5 with SMTP id x3-20020a5d4443000000b00314358a64d5mr2193139wrr.13.1689262191880;
        Thu, 13 Jul 2023 08:29:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d608e000000b00314427091a2sm8245246wrt.98.2023.07.13.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:29:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: imx1-apf9328: correct ethernet reg addresses (split)
Date:   Thu, 13 Jul 2023 17:29:46 +0200
Message-Id: <20230713152946.82938-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The davicom,dm9000 Ethernet Controller accepts two reg addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
index 77b21aa7a146..1f11e9542a72 100644
--- a/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts
@@ -58,10 +58,8 @@ eth: eth@4,c00000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_eth>;
 		compatible = "davicom,dm9000";
-		reg = <
-			4 0x00c00000 0x2
-			4 0x00c00002 0x2
-		>;
+		reg = <4 0x00c00000 0x2>,
+		      <4 0x00c00002 0x2>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
 		fsl,weim-cs-timing = <0x0000c700 0x19190d01>;
-- 
2.34.1

