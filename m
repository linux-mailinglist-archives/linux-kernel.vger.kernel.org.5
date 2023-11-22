Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2887F4108
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343755AbjKVJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbjKVJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C91D49
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5719C32777;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700643675;
        bh=/phMRAdLatcIBpxBkpvU88xEshVqV20kxEDwUF2WMsM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=cON6WIuQa49uBYEB+oR3Kqjq5IG3n5SOObu05+KmIGMZPyZUitLAWlbBEiYJCPVVX
         jMeSnY5F95LHUz8xI7UEP880DsRjiuP1bARO+NcP6GsKw/NtktHwIg3kYKo+RCLwO8
         t6PtECjtgc8J1aEkNEhQQq0QCAQSecFHqMBcX6NQnq8ur0hCeqbfH72T3tezonV+bi
         PGy/HL+/64O5YKsF7Dhm93f7pNsyQg8u2LZRAB3ajL/iAxC519LFWuolfw/hPFjeu4
         ZmhNJcCFVr2YSFDhzqK3RVl05rsgQK98/LMVJxQuH/kKCaimkpv7uBi6+nStR34sYJ
         iWNZI0zlzOW+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B3DB9C61D9B;
        Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Date:   Wed, 22 Nov 2023 12:00:05 +0300
Subject: [PATCH v5 27/39] ASoC: dt-bindings: ep93xx: Document DMA support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-27-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=1111;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=33ZOBSi7tKmUms2Z5bn+h/5Rtal4W/59/ftopAoDmGE=; =?utf-8?q?b=3DPDGP304YjveJ?=
 =?utf-8?q?dGqVG0yROoVEvjhioop0aEsk2Y2fbUX9RX1cDfdeDk6xJh+ZnuXTbh6djfTUbL3i?=
 afnCj/O9AJ5ijcCU4kuHcWYBLzY5O37yEQFkWI9UJwRzLM4eiQKx
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <nikita.shubin@maquefel.me>

Document DMA support in binding document.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/sound/cirrus,ep9301-i2s.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
index 453d493c941f..36a320ddf534 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -40,6 +40,16 @@ properties:
       - const: sclk
       - const: lrclk
 
+  dmas:
+    items:
+      - description: out DMA channel
+      - description: in DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - '#sound-dai-cells'
@@ -61,6 +71,8 @@ examples:
                  <&syscon 30>,
                  <&syscon 31>;
         clock-names = "mclk", "sclk", "lrclk";
+        dmas = <&dma0 0 1>, <&dma0 0 2>;
+        dma-names = "tx", "rx";
     };
 
 ...

-- 
2.41.0

