Return-Path: <linux-kernel+bounces-22631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E1E82A0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA01C22B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90F4D5B2;
	Wed, 10 Jan 2024 19:04:10 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F64D594;
	Wed, 10 Jan 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7A2A786FA1;
	Wed, 10 Jan 2024 20:04:05 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 10 Jan 2024 20:03:32 +0100
Subject: [PATCH v8 6/9] dt-bindings: marvell: Document PXA1908 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240110-pxa1908-lkml-v8-6-fea768a59474@skole.hr>
References: <20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr>
In-Reply-To: <20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=hQNDE8d2VNITaszqocq6Wcxo7kVXmCkyyXgEBB+XhoM=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlnuoDBhEmGm5+abaeyPMpgub9FLBfmr8K+0dTz
 iZIfkvZ2c2JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZ7qAwAKCRCaEZ6wQi2W
 4fXzD/402VdzW/ljzZzpwPhSy0A8Xw3gevYw8HTA0PHBQUeUqOxMCkxI0m5gpAVAV5JEc6N0kDK
 E6xe0aoYs3UEgTsgA83nK2BFxAeBzTBRGXwY48qtP+n4aTkdigsTdlQFWErZrRgw6G63aWQJ7Qd
 DJxe+mveFJmdu/DQ4gMSsm7eVJhPtPJFu8xBdVKFGM5QxgMU+7GmnJFp5yfKTptljadkSrl3KBd
 fLo+MnLv+7TUeVVaZet45/Iyd/DqSoYCDyyujf1yc8cr8dFLMcUV25XgMbxOHzvgDav1GM119xa
 UMhAtNrBxb4/U3E1+XnO46kqeBHQDhi6QdoFTYgBx9bDJdfcaBdcNMdzPPVzqAp64ICvl8w4uim
 ut0uwDx3+tmaOhCUFHaVGKY6ggliYBtjzJfPGW4dvMNZ8y4L/Rm3IUjkwTmpo3T4iqY9sRmyV4u
 8/9urqL97B5bsQ7nU77BGDAsj6OgRdOs2ixDi4ges7kUp8xUYZonk83dyA3wXaDemnHTBIjqdIy
 gS8JVvyX5ix+RyqW9+DtxULOdIqRrYCeGVIyULBBnmvNZyngCT85hC34e9JrPZ55QhorKiA7mNm
 Dz5U0xNpksEJtIX87DXSgJcR9ztXqfreUvYkEtScQ0Cahas0VV6ZEne5Sg6i2krNb3L/KozXt89
 Q0YNjv6I6zxXe9Q==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

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
2.43.0



