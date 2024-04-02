Return-Path: <linux-kernel+bounces-128693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A492E895E42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E67D2877E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4615E5B9;
	Tue,  2 Apr 2024 21:02:33 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8115DBB5;
	Tue,  2 Apr 2024 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091753; cv=none; b=Xz/Jp1txTTJTgT5hBy8gQF2mBVCXGHMJF/ETn1B5G8IhvBxq3UnQfRT/z3+fMRFnjMY/i7E5GBqquvAxWA7J9B9Z+UjkKv07L2wUIZqbD1PXm0KlOQNhLOeZzZCeb8+VMS1PElbuOAXbLnEGymePVuDP1szX7cxESiRfyH2ApuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091753; c=relaxed/simple;
	bh=+wdJL/Vtg+IC9uzo2i9e96b+dkkyPr63PvOur5KT8gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9RWj3i2/a4pXV7LWT2MOxtiuPLXtEv/dGaqEbkKH1STU3SLzCvUquhgVitHW2/G21DtaE86q7Coi3QBj2oq4VBjbeYJY5x6/hklJKOvYcSaj3VbeCdD/kAW+fYkv+LQ1Vaom08JxYiR/mGI7k1xoqf8x0M9ombPG6dujtTX4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 258CE86C4D;
	Tue,  2 Apr 2024 22:55:52 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 02 Apr 2024 22:55:42 +0200
Subject: [PATCH v9 6/9] dt-bindings: marvell: Document PXA1908 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-pxa1908-lkml-v9-6-25a003e83c6f@skole.hr>
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
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=+wdJL/Vtg+IC9uzo2i9e96b+dkkyPr63PvOur5KT8gc=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNCvt6+pWUUzIr9dSwV1EElWR7tDmhzqHsG
 K/k1c/LoqiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4aUQD/0UNtjqNmsE6GaRjKoCaRTMmajVHcWzqnban2JRVaqzS5jyKhbZK8LtOUiGiGMcT8i2r8B
 UZlTkkf0PRZAUNEKF7iExDlvAi/0vESWGefZ7tC2LUqX6xkGhuMK4jMuHaD7ioGtM0gwpy+d/Iq
 zKzEqs6eXZa6tJ5kgja1JwRPeDkSkgCAkWTp66L/bnKSoHRS+Vv0G4zD48Q/8dk3tnPBTd/hkpX
 TvXTJFiI/cKkj/RrOhcLj85TrXSEjdKyiPn/W5lc7YS3+5PiDolOrtSFep+d8qdY0XWN0sQU4Us
 KhvWHM6ZwLqByQEwxAyUb8SyV0eL41Q0pynXNje5Bjpt2JF4W07RtXoBszMcq/0E/7PaD9qSAr8
 h4QQss+dmFTCLQUtvXqvLmtxJij95OcfCh220QENf5YNVzBgE5GaxH+id5NL7608FluPLaNkzTD
 tk36QcvFVlqFjuSxfnzNZQRpeHg+xeT5ypyytb1no6c4nxR4Bbiq3zBFCNe9N2hOsfGpz/1a1nu
 tBwstIAVCNhMpjd6Cow+J82LgbAw7zpa2YHBYnwstTKjb2FjiLPQIfGKhsf9JYvsUhYTK4orhsi
 9dEWdgV2piJ8c2vtRK9I1Z21z0ZhW72CyHIGkTlVslH8ZBeZMKaUWCwlia2VOguwvTpZ+hqO77i
 i5tlWe9WuAyKI/w==
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
2.44.0



