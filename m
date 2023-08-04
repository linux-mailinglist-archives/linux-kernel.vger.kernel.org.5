Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8C7701E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjHDNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjHDNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:34:53 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608C19A4;
        Fri,  4 Aug 2023 06:34:46 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 7290083C06;
        Fri,  4 Aug 2023 15:34:44 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 15:32:35 +0200
Subject: [PATCH v3 5/8] dt-bindings: marvell: Document PXA1908 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-pxa1908-lkml-v3-5-8e48fca37099@skole.hr>
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
In-Reply-To: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
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
        afaerber@suse.de
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=823;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=Z9HNmB4PXP/SAOgptPUsAenlM6qAQfEwkO/84V1Bzz4=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzP48K5iI+sW1xUfkJNUlKBYnI/NXOW1uthFWQ
 xeGpTz84mWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZMz+PAAKCRCaEZ6wQi2W
 4S4OEACOy98QSnXz19HxHR6aBRGTYPO6VowO3hNN8P1iQ9tPYkyGO/bjAdmmIEyEcDIluhLa9F7
 h9G3pg7d+WSLT1m5QDYBEFzAEA00oNIdC+GYuuNEc8v3vqoa3oZpOFhe5fjKTYUNHfcdT/EIO9X
 1+Gzv3iP/EkTabJCFwHrwqaco9inuckqkJy78+RhzxtTwegqAeiW/rFEYNkHZlURFSFTwaXK//C
 zdJkvx5TJNbxk908nku2wyZuVyjnFfjtDmqYZmBClZC09qX/IJt6ATKDqcQSYzS9U1EFtmgVLUN
 60HbTECIQRL2FfYkfr63LSRXp+HvLo5E3bbScy+fHvIDqqCswg6vAVxqrIk6r5X2JLWpAK6JZJP
 QoaUmSFRiNXKaqWBnOA9mrI4AHccpka38Oc2D8aJZghmDazaQTS/h60yFvVpvCozdhQn2QHXMyc
 ++81XzsohvF/qoKGcgThLmsp7IEHsEh9AWopAXq8OqjFhQ9xVu/8KdcbA8uoOVArwnKFzF/1QnH
 wfVFL9ax7B92nuFIL9/Z0zqPCNVEINKbwUYWMVV8ogmXmp91rGqMFRWtuky/1eKFlIGVwLAkyCV
 NP2r28ocPpZ29AIdfiA3wwVyDhdpO/QM2hb9sVBaTvZmRqDqI8n80A4ehAao9Yq5Zy3Z+3O0EqI
 4sP+zt0U6NmxTjA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding for the Marvell PXA1908 SoC.

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


