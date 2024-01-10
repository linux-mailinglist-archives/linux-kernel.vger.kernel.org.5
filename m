Return-Path: <linux-kernel+bounces-22634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5B82A0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E873B1C22B13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DA4E1D7;
	Wed, 10 Jan 2024 19:04:11 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BA4D5A4;
	Wed, 10 Jan 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7FC9E86FA6;
	Wed, 10 Jan 2024 20:04:01 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 10 Jan 2024 20:03:28 +0100
Subject: [PATCH v8 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240110-pxa1908-lkml-v8-2-fea768a59474@skole.hr>
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
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=nPqksz+qvcn9/ddd+JmVyGr2SKNiP/jDRCNtDE3N8yA=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlnuoDxX0XASidDqWMsvBIwlM6VYVz8sDcYKHic
 juD0rOaSnmJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZ7qAwAKCRCaEZ6wQi2W
 4Xd5D/9yB2P0X3VPttxoigsQc6keHJYVms2XTxL8qugyjtPUAr9oRBGJ2P/Rhl3LcMgJT1sAJJ8
 Pf2q2e8JWPbkqT6g556Lczc548WhuYH0E/OY8PRA3dS6yoTZABrN0QQZ8ZbhREf6DWqYtYriTXo
 zNycz54dUqaBsPJW9Yb/PEluKj8yiDhr+6rkVGlvu2Kn3snwXa0C+T+nHe0QYQwLO+2sYe1EmTs
 t+CwtAY1TCO9pa/LUaN5uYWL83niWmEsVenIZ65/eqnWyknrgCK+wUh+QhV681OVlSojM4TGoi/
 w2TjRg6Rto7zS8nki8LppUmngHxmHH2tXq+3BGRU7502w0ckCqAkNErjn9IqalIo4d7D+UfV8Xc
 X6GvU/t31bbgHJkzNyIBoPxW+eRJLyYCSYrWWUzG/V0dhX+M35rBx5OXeeWNdjYr0Ponat73dEo
 HqKw83vSgzTDu/b5a/Y7Pjst5Rz3NlIbdQmK7vwmpPWzC4v73FwUUQ6gXEHOkM8WMHtjfjUwV9y
 f3NOAcAJH76AyQasyqQy6HG/9hPsPPZZvn/6Yn9+eEQ2qvxwVrZ0zcrP2oYY3QK6Lv8ycEMOEqJ
 0nNY5E8vXzdRXUKAMJPGdCeaUOD0dKRHv61gk5zF0xNw6Fhubkr5qOod/oVx86pC+KLXSzArmX0
 B1r/dhUKR0LNIZA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
index c11495524dd2..1ce24ad8bc73 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.yaml
@@ -33,6 +33,10 @@ properties:
               - ti,omap5-padconf
               - ti,j7200-padconf
           - const: pinctrl-single
+      - items:
+          - enum:
+              - marvell,pxa1908-padconf
+          - const: pinconf-single
 
   reg:
     maxItems: 1

-- 
2.43.0



