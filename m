Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE47BEFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379280AbjJJAvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379282AbjJJAvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F25B6;
        Mon,  9 Oct 2023 17:51:35 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 559F5512;
        Tue, 10 Oct 2023 02:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696899092;
        bh=1H4cFl+GfvAjihnYXGrLxSTEhemF5I7Tx+xJzhwuvnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4X1s3ouPNFTmH1mOBAb3rdgqwUSGamaha1GaZdMotyM2hlKOku3Xlavyfmqc3vMn
         4A4g2eia6zy0LLVYfUWA8niy8712ObZeZCiMpkVatPCYac5du/2aW2JOH05RAyTXdX
         tPuEX0s+xMnNEu+PbZ+2quT75WK1SqWwikfPA+Ls=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] media: dt-bindings: media: imx335: Add supply bindings
Date:   Tue, 10 Oct 2023 01:51:22 +0100
Message-Id: <20231010005126.3425444-2-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for the supply references used on the IMX335.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../bindings/media/i2c/sony,imx335.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
index a167dcdb3a32..1863b5608a5c 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx335.yaml
@@ -32,6 +32,15 @@ properties:
     description: Clock frequency from 6 to 27 MHz, 37.125MHz, 74.25MHz
     maxItems: 1
 
+  avdd-supply:
+    description: Analog power supply (2.9V)
+
+  ovdd-supply:
+    description: Interface power supply (1.8V)
+
+  dvdd-supply:
+    description: Digital power supply (1.2V)
+
   reset-gpios:
     description: Reference to the GPIO connected to the XCLR pin, if any.
     maxItems: 1
@@ -60,6 +69,9 @@ required:
   - compatible
   - reg
   - clocks
+  - avdd-supply
+  - ovdd-supply
+  - dvdd-supply
   - port
 
 additionalProperties: false
@@ -79,6 +91,10 @@ examples:
             assigned-clock-parents = <&imx335_clk_parent>;
             assigned-clock-rates = <24000000>;
 
+            avdd-supply = <&camera_vdda_2v9>;
+            ovdd-supply = <&camera_vddo_1v8>;
+            dvdd-supply = <&camera_vddd_1v2>;
+
             port {
                 imx335: endpoint {
                     remote-endpoint = <&cam>;
-- 
2.34.1

