Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661477174F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 01:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjHFXdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 19:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFXdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:33:43 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7819A1711;
        Sun,  6 Aug 2023 16:33:42 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bb5dda9fb7so547336fac.0;
        Sun, 06 Aug 2023 16:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691364822; x=1691969622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAy0iP4nu33R1zoenEmgl0oLRqLADzX1A+hGNqe/StA=;
        b=kF1cQIfB55viQ9BWXImgv9RJZ4PfoVJKbzNBkrQLHbYmH4dbJjkV4x7L9JsoydYP1X
         9yN3xsSY/T+BlIRKqdhJs5uMFga1KLKhjeYBXXfSvB+ItXGLdoFvJU1sLnZb8xHM6QqG
         9MMCVsdSQRnuaUClC3ozg3jpFQ6gdmToN0wIqigkoPL3Cs1CowYBL5X66RalPWp5RkJM
         Vp6Hd2CfXD6JieVvH5t8u91N6I3/cOG+NTDdNJE4EQK8/ohi7b0rGQQ0oZUZBVziy5Zd
         QO2eRaAnpDNKMhUEbj36aeC4MCOdGZ+eHUw4js6FQibjDND7RJvVvdhAuh0gfabbRF7D
         xb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691364822; x=1691969622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAy0iP4nu33R1zoenEmgl0oLRqLADzX1A+hGNqe/StA=;
        b=IVFyAOqWX1uUGX3TaNsO1Y2NBOyjnlglt/g1HVK/1N0O64C0Kvuq7VfOVnDFbnUMg4
         0r9LyR1zekz722OrXGVUpDg6WmMbSXcteZvnfYDreYPYcAt+BGjtVGyZRo7RPVO1YTJ2
         yCpGdLqt+DNM3VzJEAbFpp8I82d6yhhQDHimtRu7w4sv1sqbSaaaTJzxdcVjimv1ONZn
         D8EF5InWvbzmaqTHKUFBgfTwBw5KYvbIX7iq4rFf7KEdLRmHEuhcvRuBZ8rqW3e8rBeu
         U6c0fPvndnjNl7vKiSClX2FwbY38RSO1QuTHoS09C7VtRDIo3eq+Y0isrANau8rsQjUA
         0tNA==
X-Gm-Message-State: ABy/qLZLhbSCio0fPodDDKGtZWL88fzccq932KDL7nxAb3Efm7TX0OEc
        n0Iss/+okPY90mDYozFt5yo=
X-Google-Smtp-Source: APBJJlHTJAnnYkJsfGdiTpc2zm3Mzbfa6JkIf8rAyFnPVs0lZKRu3t77VP1edvFhaDOO5u+zZ7gbOw==
X-Received: by 2002:a05:6830:4602:b0:6b9:db20:4d25 with SMTP id ba2-20020a056830460200b006b9db204d25mr17732325otb.1.1691364821665;
        Sun, 06 Aug 2023 16:33:41 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:7349:328b:525c:ab7e])
        by smtp.gmail.com with ESMTPSA id c12-20020a9d6c8c000000b006b96aee5195sm4261334otr.11.2023.08.06.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 16:33:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] arm64: dts: imx8m-venice: Pass "brcm,bcm4329-fmac"
Date:   Sun,  6 Aug 2023 20:33:33 -0300
Message-Id: <20230806233333.815702-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Pass "brcm,bcm4329-fmac" to fix the following schema warnings:

imx8mp-venice-gw74xx.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
	['cypress,cyw4373-fmac'] is too short
	'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#

imx8mn-venice-gw7902.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
	['brcm,bcm43455-fmac'] is too short
	'brcm,bcm43455-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 21d7b16d6f84..cde29aa1a0a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -801,7 +801,7 @@ &usdhc1 {
 	status = "okay";
 
 	wifi@0 {
-		compatible = "brcm,bcm43455-fmac";
+		compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 964cc4fc2ddf..0bff7a6fdca6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -726,7 +726,7 @@ &usdhc2 {
 	status = "okay";
 
 	wifi@0 {
-		compatible = "brcm,bcm43455-fmac";
+		compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 3ac011bbc025..9a36edc60394 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -679,7 +679,7 @@ &usdhc2 {
 	status = "okay";
 
 	wifi@0 {
-		compatible = "brcm,bcm43455-fmac";
+		compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
 		reg = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 3473423ac939..faa370a5885f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -737,7 +737,7 @@ &usdhc1 {
 	status = "okay";
 
 	wifi@0 {
-		compatible = "cypress,cyw4373-fmac";
+		compatible = "cypress,cyw4373-fmac", "brcm,bcm4329-fmac";
 		reg = <0>;
 	};
 };
-- 
2.34.1

