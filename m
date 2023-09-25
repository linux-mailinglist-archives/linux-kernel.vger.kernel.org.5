Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317A7AE0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjIYV06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjIYV0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:26:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7D13A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:26:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B5AC433C8;
        Mon, 25 Sep 2023 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695677208;
        bh=g4nGXG8QAWMfBKVUemLO0mep12ZxcujBfi4nVu4PncA=;
        h=From:To:Cc:Subject:Date:From;
        b=NJRuA+EEHUomrwKIPyWxWiecsUNPIA7UZp+Dc70FnVEvRRPI6J5beVsVUgMlHb/uR
         84UQePlVvDRrKEbEe1imREsdBWAm9GD0PjQ88z1SKu5OmZQtKRi3C62dgQMmqU5Aof
         U1wtLAGuY9TH+Jb/vJ360DPQKFVeT91GZFOlI4T6L+nHBmDrZaRBPVetbNWp8RMPIq
         wKfeGjuP9O5eVDcgo0xd+pZUnCDA/4Rk+HF0VAYF/JQ02721RVljREx5rQqH6d6J2Z
         G5EYnXTzxHxPUbbKCe9P0QfP0bK4K4iDPfzMdSMCKiX2lM+Si2b9jWciTPXPy5oZOa
         2OHxlEVpZjzDw==
Received: (nullmailer pid 1975277 invoked by uid 1000);
        Mon, 25 Sep 2023 21:26:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop child 'reg' property
Date:   Mon, 25 Sep 2023 16:26:34 -0500
Message-Id: <20230925212639.1975002-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus schema based on simple-pm-bus shouldn't define how may 'reg' entries
a child device has. That is a property of the device. Drop the 'reg' entry.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml           | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
index b568d0ce438d..7e1ffc551046 100644
--- a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -73,9 +73,6 @@ patternProperties:
   "^.*@[0-9a-f]+$":
     description: Devices attached to the bus
     type: object
-    properties:
-      reg:
-        maxItems: 1
 
     required:
       - reg
-- 
2.40.1

