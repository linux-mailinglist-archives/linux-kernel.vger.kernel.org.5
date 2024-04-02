Return-Path: <linux-kernel+bounces-128697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E7895E56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6D282CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528115E5DA;
	Tue,  2 Apr 2024 21:03:14 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851115E1F6;
	Tue,  2 Apr 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091793; cv=none; b=F+TCmPMBU8EWgLvEB2GQQUNtjnun5ibRLUduBl0cdBP3uyEmvyncpMznzSgdKIt86uxZbNVY0RBb5ReXBQdaW5r56heuP4V4y+w16g8fo1A1bsLB/lvLdEighe2wZH+DBzCYM5iJrc97HlMdzMUvQD6Q7afy16pwUZC495qkRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091793; c=relaxed/simple;
	bh=9Fh0rtfqOUxLvMXy/ZdHE5t311Pfv0e+glL7VyPYAcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6pRrVNQu9RoKjriNA3Ov4Z1PYhMqNoGekz21P0QJ0Ndbf3gpzgCwK2WgYCTBlkh8MijTR7AMXdo/I3dEd4HZvGPRuEibV0ttGmQFsidxu7eGnNujktwsarAkIJnidYz40hsgAryNL1RZCizP1sJV7p1BJYo7j3Y3u/aUdy0Nqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 189DE87FF6;
	Tue,  2 Apr 2024 22:55:49 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 02 Apr 2024 22:55:39 +0200
Subject: [PATCH v9 3/9] pinctrl: single: add marvell,pxa1908-padconf
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-pxa1908-lkml-v9-3-25a003e83c6f@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=938;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=9Fh0rtfqOUxLvMXy/ZdHE5t311Pfv0e+glL7VyPYAcw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNcuKDBOPaLJ7sPtBStqoCNKsX4WA4i04YF
 ucgGUtzAlWJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4bmSD/9yB4805XYSm5SRbpCRI/zKWTsBQcRO7NHUvg7zKaNIB4Q9+Kmr4ymUrNPZ4bDt5i0TYSL
 s4ndQ160AtewJ47irDR6JGFz1ORwUiHDHP5dRBnkfZjzqm0S1q49q7lxXpQXdECxrVsNpIYDJy/
 YdGaC+vSaEKj1gmsiUefnjxbP3eUfPo7mARkdxcji8cNGa+kaBHLOZ/GCbG/sSqBsGMoKv9FjGH
 CMlJuHKcdeFOsfUa0JREsMETCksqCcReyr7hnyAzhHeHIHJppQPPs2ybeIREOPo3vMYyEiFUakm
 59kJCACmRZCbUbFW2EHz3lLoKLmUsPhzftboZSa0DXTrRut0ejHWY8qoiCX1YlJcdaso4FJ5i2Y
 e1SOQ5/6RQZL+NOPKz7+gFyaEyGVnNMcJJFLfCgZGPlLN4f9ZKDOCnuKjrOfcQcdJh7Y8SR8Lh0
 R881nVV8Jah30l+eBOj1/W3iAETccDm/AJdm5PxAcbilGU0T0IENGnKjOaK4/UHhC/Sh87EHNuw
 fK/07oObq+3qwJsWtk3uX/I9beW+WFbliyDkRt1V9bXBb+b9HYrDymPph7z2cIHj5EE8QoU0Fvu
 CMugfUAQBaAU5jtfoSmbLv45MQ3+KFE/jbR+JKtm0Ea6bkANauQHHNjxxL7tHvY6z9gNRojp58m
 0UTfuXZ76Zvn5rg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/pinctrl/pinctrl-single.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 19cc0db771a5..c15bf3cbabd7 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1967,6 +1967,7 @@ static const struct pcs_soc_data pinconf_single = {
 };
 
 static const struct of_device_id pcs_of_match[] = {
+	{ .compatible = "marvell,pxa1908-padconf", .data = &pinconf_single },
 	{ .compatible = "ti,am437-padconf", .data = &pinctrl_single_am437x },
 	{ .compatible = "ti,am654-padconf", .data = &pinctrl_single_am654 },
 	{ .compatible = "ti,dra7-padconf", .data = &pinctrl_single_dra7 },

-- 
2.44.0



