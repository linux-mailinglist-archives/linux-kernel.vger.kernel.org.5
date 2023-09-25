Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5F7AE18B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjIYWKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjIYWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:10:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7EC107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:09:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C8AC433C7;
        Mon, 25 Sep 2023 22:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695679798;
        bh=wrZGhwKs0rxrVrvNQeQFjjkktFc24Ckyd2CV5SBPQrA=;
        h=From:To:Cc:Subject:Date:From;
        b=HKJjdNu7I9LITZhQdye8D0M0nnFZYNtbr48LOBgybs4ESmzZ1jinSTTG0X5I3ipM2
         amIUnjlHqMhCLW2TaN7r84iAgQKrw2MLIkSyYAj7WOTwnMPsFzSV9ga2tWRAR4/+/i
         svBCPoG48zk80LZfpx3zR9nCSFCnk850xTx2sor61/oeNn0IDUFHmI6n6kffFX91cO
         fuADG8CXuh/85ckjurBU2qnIrSLr8eZUh2zyH+c1H01fe+/QrMfHKGuyQWqc9jtQ5z
         wmOccTN4V+AkEuxjeRsOel1AM5GLLTRoKaaAHXpkT3wnhU1vIqFX2/RV91W9WoIzq0
         XdRGDIkjlYfhg==
Received: (nullmailer pid 2032130 invoked by uid 1000);
        Mon, 25 Sep 2023 22:09:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        David Rau <David.Rau.opensource@dm.renesas.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: dt-bindings: Add missing (unevaluated|additional)Properties on child node schemas
Date:   Mon, 25 Sep 2023 17:09:28 -0500
Message-Id: <20230925220947.2031536-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Add unevaluatedProperties or additionalProperties as appropriate.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/dialog,da7219.yaml | 1 +
 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml | 1 +
 Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
index eb7d219e2c86..19137abdba3e 100644
--- a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -89,6 +89,7 @@ properties:
 
   da7219_aad:
     type: object
+    additionalProperties: false
     description:
       Configuration of advanced accessory detection.
     properties:
diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
index ff5cd9241941..b522ed7dcc51 100644
--- a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -33,6 +33,7 @@ patternProperties:
     description:
       A DAI managed by this controller
     type: object
+    additionalProperties: false
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml b/Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
index b6a4360ab845..0b4f003989a4 100644
--- a/Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
@@ -60,6 +60,7 @@ properties:
 
   ports:
     $ref: audio-graph-port.yaml#/definitions/port-base
+    unevaluatedProperties: false
     properties:
       port@0:
         $ref: audio-graph-port.yaml#
-- 
2.40.1

