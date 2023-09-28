Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7172A7B1CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjI1Mhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjI1Mhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:37:37 -0400
X-Greylist: delayed 284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 05:37:35 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA84191;
        Thu, 28 Sep 2023 05:37:35 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 5A9F1211DA;
        Thu, 28 Sep 2023 14:37:33 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 3/4] dt-bindings: power: reset: gpio-poweroff: Add priority property
Date:   Thu, 28 Sep 2023 14:37:27 +0200
Message-Id: <20230928123728.21901-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928123728.21901-1-francesco@dolcini.it>
References: <20230928123204.20345-1-francesco@dolcini.it>
 <20230928123728.21901-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 .../devicetree/bindings/power/reset/gpio-poweroff.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
index b54ec003a1e0..c6404841bcd7 100644
--- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
@@ -40,6 +40,10 @@ properties:
     default: 100
     description: Delay to wait after driving gpio inactive
 
+  priority:
+    default: 0
+    description: Priority of the power off handler
+
   timeout-ms:
     default: 3000
     description: Time to wait before assuming the power off sequence failed.
-- 
2.25.1

