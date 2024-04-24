Return-Path: <linux-kernel+bounces-157541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E128B12AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F98EB25627
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056EC2B9CF;
	Wed, 24 Apr 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arCjjtuO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AF1B7FD;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=IRZRmW21YNVNTgni+LMJISFOQ8lq7y5595xevjlMjf3r7RH/kF78CGhCjuT5FUzZ1qPxwAug6LcJ4o8C09bmPJPuGRRy+h8BkL0BwhFqyBwY4/pJ3kxTTbsJA4fVmOwEvl4Ek3MpXF7NhOsc1NdwTavbfalI66+RdOI3tbYQcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=EV3GxaGEdzZvY8jizNgN4gUpDiN90/bE/LtdAfajnQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xk6Zoz+D2JjMqw4Y7jbFBKdBK+ur6qK58lIYoO2478ap5Bc8APV0sBRrvCKx72UOSZStZp9w0L4boSLpxobRzoPg1GaW1qZaj0iz8z1OMrI/tTo8ytE2uiMt7Un1jiQ/g2cI1RMXmkRaGj4smWtJNQiDZF3F+UszPl1+g/ri+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arCjjtuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5225C3277B;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984156;
	bh=EV3GxaGEdzZvY8jizNgN4gUpDiN90/bE/LtdAfajnQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=arCjjtuOKPIl5476a2iJ6hwikppafVLm2L8+mlPQZsmP7PgUd51+r2FglCx0nISn0
	 DCOOKqwxk4ReI4peBGwLQ5R2IUxe0btmwdUxSBR0e3V0h9DVmiHVNN7hdfue9EH84f
	 HRkfB/R11rBJKvNUFSLLHkrl6UI4b23eGU2VU0iuDSaNxnaIpaERM1b4wa0zEfZKVK
	 5FlsmU+c9yizQsAS+RLG4WD7fb8LrvZ0E+r+CZIgh5a42hoXG1aw0sm4NObcg5zSiE
	 MMjRq1MRbs7LNqTULqjDFRWYwS2LYlbCZc6khyHHW/kFoaynWc9YO28jTyR4cHVRli
	 SBGY4lVkJELUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF0C4345F;
	Wed, 24 Apr 2024 18:42:36 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:30 +0200
Subject: [PATCH v10 03/12] pinctrl: single: add marvell,pxa1908-padconf
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-3-36cdfb5841f9@skole.hr>
References: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
In-Reply-To: <20240424-pxa1908-lkml-v10-0-36cdfb5841f9@skole.hr>
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
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKUuQkICKDgKUkYwrMmJLozzbWPsslKjmU7+
 tHQpLftmBqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlAAKCRCaEZ6wQi2W
 4brMD/9p/aVMBKQWkLSOSYJEGOJVXyQxkUMgSo0y6GQo1A9Rn/6uvPbzV9mEi9261XyKZLxpku2
 ie88dKpir2K5bFKzZfQxFPt2LGc+MvsTch6HIM+KbkFLjGuyBMkxazGdKBCpdr1fe0QwjZy243W
 Tk7VZ9FEJF+Hhi2qHNkeOyUtrKMjwd7HgXdrT/ONpIRKVtlf8clBJ9jRVFSM8mijXV6/rkfTYFC
 nnUd8z4sJcKOQdecakaxunH1Fe4BbAXSu8z2d6/zHB5/3yaPwffoQR7x+l+Qusu8PsvXpvNRuuy
 FB54O4ccAx6peyddh/vDCjLIaBQMpw3e1rfIcWvExwZvSV45if/0iodRrU3FrAeq0xsMyZImels
 N1Ri0ntdHBugRTIdiwEJlGC81gAIqIQMfGVSxz0l/4XMiBViccNZ+/tM2KQc1dAqxkYRqFDu3zo
 8h2Pbw4uoRncG3zsFy6xNOaTck7lXlIL2yWFTQcrKCFi1fDkCrDEwRBaUi0w5Fi1pDzvuEVGtqs
 MhyIuFYecmqBqMl5DvRpg3kwy4qDjeKykM9zux+uFxyTSpseTcMRxgcr/s8xx+pWQ1hSMpdXhWn
 E8dwU2axOEfAVGmmoo9Yf/LJwYI5SC4O360rXNActmBdtS1dS1ayU5Z6M/X4zRHP5jjVYuLjBKe
 ITTloEI4QuDp9TA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

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



