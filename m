Return-Path: <linux-kernel+bounces-128695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36D895E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEF61C2276A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8710C15E809;
	Tue,  2 Apr 2024 21:02:34 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE979DD4;
	Tue,  2 Apr 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091754; cv=none; b=RrORv2d883/B7SjNxDyCCQRmfHCpCX6X3ixuCY0gtabr0UEKMbFAqOqaT2UH4hZTYxrxeSVGbLXltDtO6UrYQKdWiO/HUKhOX8S5/eWmP5GyMQh5vA0jiWi9GeUKOyzD1JSpTEvQLloYEF3Kgeb2AhPJOZ2FgZB/th0O2ebzopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091754; c=relaxed/simple;
	bh=KkKUaK2SeDyP20scuUXm7oVk+QfHUL3F87v8Iwvt8qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlSsxZfnV8RtyvnAGjmWjRleYZMx4tqtNpHllt0yLT+1WDoc1Mthsuq6+CKSwwwAQkuQ+jf/AtXos18NoPUkXzsrA+KsNuJsckaquxq7F0xWq/9O2ztVm4ERM2PA1JuZGYZEFuETafKNFCj+DsauQyD1/vsOmKfmooNfmbpapLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 0B68886AFD;
	Tue,  2 Apr 2024 22:55:48 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 02 Apr 2024 22:55:38 +0200
Subject: [PATCH v9 2/9] dt-bindings: pinctrl: pinctrl-single: add
 marvell,pxa1908-padconf compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-pxa1908-lkml-v9-2-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
In-Reply-To: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr>
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
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Rob Herring <robh@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=KkKUaK2SeDyP20scuUXm7oVk+QfHUL3F87v8Iwvt8qk=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNa/nqQ1UT/Ixqv8AglmTEwTsijNUNfGKBU
 iJ4TYgwPkeJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4fgYD/4nd8vxZVbYhlynUp5Kb/Oin6wSAX5NVE/7Gl28cwJSDVtyzc6PGXMMpqIDGkvAqd7cDfG
 nuGmuAFQM+zHc430FSAL20wpR96Jerr7MH0FhsBMxfoq/z+3u9KKZyl8n6XRJy/A290efH6tbrg
 c3fBGDuVO+QlzutcH9bJMaABkN6PJHQWvZY2N77nr1BMPD8vOJtaWPJu9MKmuFObiRjVhwfqWf0
 mU0mgd0TfGdpzL52C6WyPIm2D8QFEs+BrB5AS2ZkBSghz180kXPGxAbAwPOjXaI0BM8aQmzse46
 6FPeUJrm2s9YKfZ2jVwE+YjI/qo8uPOAnLsGzXFn6Mp6CJuDyOOoFpEU6iu0v7dpXc3zC1V6iPX
 OLzsaQBb5txWhQFmcj/1D00P5sWVx/4lAMnEHa3lcZIYD8SW9n4eSbxDcvvBpRep7wVAdi7JP/1
 z0XM5Qa78gtYD2ZR3vW5tCOI8GtCpVctApYcqjr0rQuVK0iLzz6EsxSZT4wERChiqRXmWtWUHIW
 iUUqtXZzRgzSqdk0EekSG8Iup4udjG5l45ZY2Z3XudBxaLUONm5l63Tur+Oo6rHElBCkOQ1sDH2
 qRncgLwc2yW8nc3nFl+m8SIKMDitn9pfRlvhsr2/xzGXIn6SlgzY2OLnm1nDAOOSxn/EgUJeaOc
 aLRRxGAI/J5x5sw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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
2.44.0



