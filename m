Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8277BB88C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJFNFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjJFNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:04:56 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19007EB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:04:53 -0700 (PDT)
Received: from francesco-nb.corp.toradex.com (unknown [201.82.41.210])
        by mail11.truemail.it (Postfix) with ESMTPA id CC59C2115B;
        Fri,  6 Oct 2023 15:04:46 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 3/4] dt-bindings: power: reset: gpio-poweroff: Add priority property
Date:   Fri,  6 Oct 2023 10:04:27 -0300
Message-Id: <20231006130428.11259-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006130428.11259-1-francesco@dolcini.it>
References: <20231006130428.11259-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add the priority property to the gpio-poweroff bindings description.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v1->v2:
 - Add $ref to restart-handler.yaml in gpio-poweroff.yaml
---
 .../devicetree/bindings/power/reset/gpio-poweroff.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
index b54ec003a1e0..a4b437fce37c 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
@@ -18,6 +18,9 @@ description: >
   Finally the operating system assumes the power off failed if
   the system is still running after waiting some time (timeout-ms).
 
+allOf:
+  - $ref: restart-handler.yaml#
+
 properties:
   compatible:
     const: gpio-poweroff
@@ -40,6 +43,9 @@ properties:
     default: 100
     description: Delay to wait after driving gpio inactive
 
+  priority:
+    default: 0
+
   timeout-ms:
     default: 3000
     description: Time to wait before assuming the power off sequence failed.
-- 
2.25.1

