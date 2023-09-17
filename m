Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7627A359A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjIQMsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjIQMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 08:48:07 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7CFD9;
        Sun, 17 Sep 2023 05:48:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E7C3C0004;
        Sun, 17 Sep 2023 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694954879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aq+pwsYFiwStYxtjQVnBxBzcUNTCMXjBxquvlKd5ZhI=;
        b=dU+jbPVzpXt3H6VtNT2P6FcrQlOnsf4Df+ssXytXV5pjq0RstMNPtNcn+RQlbMT2Lxp7Gj
        fmDzLM73gjnxTvIlafkC2FAIen6ClA4zYbIXRFXCNQIuVNOqbv7WpQKYt6vLZY6cqd5u9B
        rv8vWvHVRhfzWhQ11K9XFOWmH4Hk0COyGvL7V/PYohpp0q/HbzoyD4JlI1r9eRpGje8O+k
        TMxcTeTe1i+2knSZEEZw+JipkIkP2Cle/TB3lBp4nzJ7kNIV0u2NuABQ7pVgic/GYOF5qX
        l5DEMpOqjXCFaQWXWTfuRTn0/uqnsjLT5za0jh8ZMoQ3kgMLkaIkSmy0nEWIEQ==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 1/2] dt-bindings: net: mediatek,net: remove reference on top level schema
Date:   Sun, 17 Sep 2023 15:47:22 +0300
Message-Id: <20230917124723.143202-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level schema does not represent an ethernet controller, the
subschema defining the MAC nodes does. Remove the reference to
ethernet-controller.yaml on the top level schema.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index e74502a0afe8..0b2cb1897310 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -105,7 +105,6 @@ properties:
     const: 0
 
 allOf:
-  - $ref: ethernet-controller.yaml#
   - if:
       properties:
         compatible:
-- 
2.39.2

