Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B11E7B3725
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjI2PnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjI2Pm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:42:57 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAAB4;
        Fri, 29 Sep 2023 08:42:54 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id A0C55834CD;
        Fri, 29 Sep 2023 17:42:52 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 17:42:01 +0200
Subject: [PATCH RESEND v5 5/8] dt-bindings: marvell: Document PXA1908 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa1908-lkml-v5-5-5aa5a1109c5f@skole.hr>
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
In-Reply-To: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=68SP0psZM8Sot29iAM52aLi+c+3JVnNIUMMY8bC0VIc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFvBykbMfnls1yGf4fnlrBhT+2giyUpNMrmngY
 NrnBlnuSCWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbwcgAKCRCaEZ6wQi2W
 4Q1UD/0a2+plywFrZfoPOUGfUG21u20/lq32w+NkuuOqs0DPmluvGJ5lXnub50JGVHmZDhS/mW6
 Ln47gQ/55U0zv6SOIqHXJiR7tw8yZ/fZeny9n5orx7vRUa2GlER2xH9X8Ml8eRjU8mfR1ynopjW
 PXRSyNCqQeGaBChiK8V0bvZ2pKoLjuJV5iZUaRPGUnHvuy1R68ogDAtiwgPrPs8OS4hmCJVZSdS
 9rUuN9TeXaNhIHr5ZRaShmFR1fv4vCgBthvyedVJCrOBJF3ebbvpFCwWdGf72TA5hYnwur2QMZv
 dKCyFntK5EmICsXlS3L/X8rN154ze0TcbuWZI98hLw9R1GExT1RsbkcNa3Wy6r2wx7KApqGHzRX
 bB1uGp8haqSOhURcbeAZ8WTszBaJIExB1Jms6SkeDBo1nq4zNPgDGgnKF4E8SH5tLB4DZXy/sf7
 zjmqXpvZ0ZoFQh5XbRQG0SL3sIzO2SNNprqd6TkbdE7lJiDmB/3TJ4U++EeVzPZ+31WJFPTTT9D
 ExNtFFTVNBRtHNkIBhxKU5yxFy2s2yvPr+9bWFFV/LEM+Q5XVoVEGPahC7Bxd0FwCTdaTGdKOKi
 XZw0n8lHbSbB8bQ8Q0ODp36k2nUc3k8oUkk7IztLMv2pAxjEJb+vU8o7nQ26EDnKh55BYtUepuS
 AewQLy2gKT+t58A==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding for the Marvell PXA1908 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 4c43eaf3632e..f73bb8ec3a1a 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -35,6 +35,11 @@ properties:
           - enum:
               - dell,wyse-ariel
           - const: marvell,mmp3
+      - description: PXA1908 based boards
+        items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
 
 additionalProperties: true
 

-- 
2.42.0


