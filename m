Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C57729A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHGPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHGPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:44:48 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005BAA;
        Mon,  7 Aug 2023 08:44:46 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 47E8483B63;
        Mon,  7 Aug 2023 17:44:45 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Mon, 07 Aug 2023 17:42:39 +0200
Subject: [PATCH v4 5/8] dt-bindings: marvell: Document PXA1908 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230807-pxa1908-lkml-v4-5-cb387d73b452@skole.hr>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
In-Reply-To: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
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
        afaerber@suse.de,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=2ainjaUkEO8QAJQ9TFJg6BT5HCGIXfSI5apzikQRiN8=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk0REy0fUass7BnYtFTsJSV7hxAfBiGNLFgULTg
 aGh2+48thCJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNERMgAKCRCaEZ6wQi2W
 4SAsD/4wNjJK6c5woLjmZ085TuoR/9kzH7lrqAXW0DvU0NeoEPCCvF6RTSSUvg8MzatyXRdBq7a
 7yfAw15DafxedjKhRkSwT29ZaTZst+WUkqaKPof8jtbjFO2RawqbXRyMMGAd0CHKeyxAnuQpELe
 wC8lsbxyrs27rGzbdp0qbSQ34/UNkpXv7b99vpKpduH4KwEekEK8hpBJi48KI4K8rr4PItYfYOx
 LFIk62nuqk5jtY907RD0filO7nSw9hYJEHXXjtqubN4ibGXgBo7T94H9mjB6YyKjP9vUb40DQ2l
 fvF2D/d1AoKwdu3+Z1SHjJxfBHtARW1P6nXOi7KGvYOz0ylgkKLa4HLD+fOja8RLt3y5lEz6tw+
 XOdYlalLizx3fvXoTUsiWaj8QYevBToRXaDu+oNve+8Frzl6xVs6QxXiM9o1g3x0GDs+Pr6nU6Y
 2lloiodY6w25z+vBPOj1cz2IcazaoK8qe05dengvlz1qDLqMQDlaIqNSW5DTLwcYVakV/3+WPIW
 DV2lM215KYgNEsZUIwPNDm8mRKYc5z9D+e2mYtxyHeEjZVgq63NiWQaW9rqfdpI/lGaHJDVY+92
 faVhWPYpIBHTjbph+cINGbdcpX+fpdTWok0/FTgWhrD4zhEaXB7lEtZo9z5+YX8hUqIuzkNQJF0
 663I8/Csgsz7m9Q==
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
2.41.0


