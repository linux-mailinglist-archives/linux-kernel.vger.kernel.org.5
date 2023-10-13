Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ED67C87B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjJMOTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjJMOTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:19:34 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F6BE;
        Fri, 13 Oct 2023 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=iQgc8ugoV+cWytBNeAfWc+zsoe0xTQmmxE4CSL1oZV4=; b=LynlOPyJLi2iPH8rD2ayaq6Uww
        Zs778MjaKr+WCdxwgB/rn+BIvJgtLBJP9h6n+GE1Q0JmFSsfTeAfVrnT4kUJ3OgXrG9VZKUX1IP0U
        YiapD9tXhpsP2vf/TI46iWW4JayTBYfWKFANQj/R1VKW88sESy9fRurD9X9JM6jxMn2U=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40430 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qrJ0k-0005Ve-El; Fri, 13 Oct 2023 10:19:31 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Fri, 13 Oct 2023 10:19:25 -0400
Message-Id: <20231013141925.3427158-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013141925.3427158-1-hugo@hugovil.com>
References: <20231013141925.3427158-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 2/2] dt-bindings: serial: sc16is7xx: remove 'clock-frequency' property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The 'clock-frequency' property is supported but mainly in ACPI-based
configurations, for example.

This property has therefore no place in the sc16is7xx YAML binding.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml  | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..5050176e8b80 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -28,13 +28,6 @@ properties:
   clocks:
     maxItems: 1
 
-  clock-frequency:
-    description:
-      When there is no clock provider visible to the platform, this
-      is the source crystal or external clock frequency for the IC in Hz.
-    minimum: 1
-    maximum: 80000000
-
   gpio-controller: true
 
   "#gpio-cells":
@@ -74,18 +67,13 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - $ref: /schemas/serial/serial.yaml#
   - $ref: /schemas/serial/rs485.yaml#
 
-oneOf:
-  - required:
-      - clocks
-  - required:
-      - clock-frequency
-
 unevaluatedProperties: false
 
 examples:
-- 
2.39.2

