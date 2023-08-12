Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37B6779EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjHLK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjHLK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:26:09 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F22133;
        Sat, 12 Aug 2023 03:26:12 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 000CB82AE5;
        Sat, 12 Aug 2023 12:26:10 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 12 Aug 2023 12:25:09 +0200
Subject: [PATCH v5 5/8] dt-bindings: marvell: Document PXA1908 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230812-pxa1908-lkml-v5-5-a5d51937ee34@skole.hr>
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
In-Reply-To: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk114E7HTfT9tN/rAL215HciXtCc+q399A0tT/Z
 hs46NNU/HGJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZNdeBAAKCRCaEZ6wQi2W
 4XGVEACJOjDghy+FVW9JMrbajmBAgiz7GitrR3uJhGoYZy3y2jRPeGHBpnfeycKpHvNm35rfyat
 +YLiSXkSBkSOApvOldPjqGf/7eHgEAGRZxHB1D+icGpYxn8rodNms3IrDdl8poFpMF2B/DyKrPg
 iJmn9fi3PGa4ycJMRWh1gvuh5e8baReAk+hQRR30W0UN2DBBSmxgy4u+Of/lZZ0XXEh+5F1tQBX
 /wT+rCs7LMfWzHBXqmic1wQRbFED91CGwJoaAtN36/yzgKXSB/MWGrPWwr2UD1iTOrMPixM+0q/
 9psV+2mCTcBVRzHS34jBUlW6K2sSkk2Yy5iL4HVJ2DZ9Ql42RKt3h4s18gTl+KrLEWWn6TgEY7p
 llj4HistUTUyMEpVUGtJvmtP5ZTWcGkMdC+eW/NkZ2zV56JSVXVKwyqbzDd1R/6vGvEifFt+vBo
 cci4PupBDFMPofbldcJoeN7kYOGnXsFpkRUy/2ZmthJFDN9pWNVFj+Wu9cAWWtDpJFmtGiTeJ6k
 v6LU6leUJ5JG9rjYEGUdmnMeAmOXmEVi6Chl95D4KTqWPN+xq4LKBmPyXygxhSgRaf5jgjnM+Wu
 /zHOh9V24fec6XBeN/Yjy9SOTU+TkyVNm7SZ3riFltyTlJuwebab+en8zP24HiybxGZyEk+JluR
 V8bHCp6Y0Lu293Q==
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


