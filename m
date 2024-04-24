Return-Path: <linux-kernel+bounces-157548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AFB8B12BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30431C23A78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAC41C75;
	Wed, 24 Apr 2024 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaZdRRiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87462137E;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984157; cv=none; b=WOvrND3tK4AVAJRWh6NpifRK5gEkuBFFxxixT2VAZUsdWMPt43ZxmhmSOhu8yJEKalyy1XRGWzxjr6MpZrOdms0TKWl7+wfC+FZd8i/9N49yc0WlfhzA2JDUCLZUPv2mHKM1Yuwjku4LaiTMDIGmsDSSO3uZnePlJ/xj57uyPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984157; c=relaxed/simple;
	bh=7q//FjIlTaQphibVjQq0mNhBSgMMsZcZoDkVGtDZjzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riTJyMxprhVknpwdz9287hF5YbZy3eaPjBq4E+E37W0lecJfWYeAOFG8FSuKwxWZ4OHZKu0HXYIoPOsLRKV2xxhWHA/jhgWZcRf/nMD0kEVlMqZwnRAIPvh3uNPQ43C48kCl9pvx6RollfrCmdVQlqBWSywuWK5dJEQGGz6Vh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaZdRRiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60C9DC4AF0E;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984157;
	bh=7q//FjIlTaQphibVjQq0mNhBSgMMsZcZoDkVGtDZjzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VaZdRRiQY7KM2A1C+K9M836uDtRyQrRQZBUVfjdNwxFmTSyIVKWtu79MxiLMAqoCZ
	 77qOS3NRqqYjA6GWbAEF/Ulj3lJtIjT4EnqWZSoMlpo81olM3Qc9WT7MR8Sbsky9kG
	 Hy+3rPymDWoInsTEMCMJzEzpGAKUHUXRU5VhWCVQZ+6IBBHnSnMWmbZKQSKEytwAKU
	 VwETq60rAd89KRFILvWFrf2cUFJkDAH7gaHODzD4ITvwiK7Kt3a1k8NStrj+7l1mqi
	 ZVkKq4MUO5VMsp4grkh20xi9VaCe7piIKVT0OB62EQZPgNoeto0M6POMlnkMZUExH2
	 fkfLSYN4PWMCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB15C4345F;
	Wed, 24 Apr 2024 18:42:37 +0000 (UTC)
From: =?utf-8?q?Duje_Mihanovi=C4=87_via_B4_Relay?= <devnull+duje.mihanovic.skole.hr@kernel.org>
Date: Wed, 24 Apr 2024 20:42:37 +0200
Subject: [PATCH v10 10/12] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-pxa1908-lkml-v10-10-36cdfb5841f9@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=rBtIaMX/S+mXR29Z1GK6jtLfsrLvd3qrx2yb5nOvyjo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmKVKVNt92SFDaPgTEWzHx72+qUm3NYr8Z9zD8o
 8yQBGJGx6iJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZilSlQAKCRCaEZ6wQi2W
 4ZctD/oDQ5OlhApU7EoZW19q2bjbafF+P/NCUzFD+2S2yom+WEQK1WpfZ1dj0KG7cbuhxc3hE+2
 lYY439xTg9snFnmDEQZ09IeEJh+uJpMO1xWRSWHeFK5w2FqGauqewnCTaZZIOkPyA96qf+C2OF5
 3YQl3CAweeeTnoRTzNuF7FnoCc7gedZoN2nEGoC5NF9puhypeLf0Y0rb9HHawO8Lf5X1JIVe8uU
 Hi2xSp3rjCQN+VCP4fAwXT61+NQ0H86MFEJVThhNw0qq2u/Gs8OkSKNh+KK0vNvAKtJo98q6G4I
 Oo8dfrs7wiIRD0PXUUgGXnMdeN1JKN9ko4lLfNJksHJBTDP6vlQRIAI4laggQylOKff0nhZMDVq
 CTpDWg8FBlcmSOk+BobS1BeD3tg6U52xMl+hWFruwm/VMYps7ELVCFK63Luln6ilCXt5Eip28at
 QFwpEUro9CuBP8ZjSXGIXUlOK9mSM3D5tUtB3oQp2W60rBxnPlTaZWD1utNRfOHQq8RE0TEblBO
 u6VkNNmKyj636CcLXzZz1r0XM4cRMUP7giLxMdHQkaQPOWU8M486z/nc7lASivLSk0Z8kLQjjdl
 qU7+sjWZzRuoWPWL9W5cAf5zjJ27wBypYREME8k3XnlpfuPXXG0p2IP9r4AVkzFOD9PrSb3cqhp
 flToYKOCMTXfUmA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Endpoint-Received: by B4 Relay for duje.mihanovic@skole.hr/default with
 auth_id=112
X-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Reply-To: duje.mihanovic@skole.hr

From: Duje Mihanović <duje.mihanovic@skole.hr>

Add ARCH_MMP configuration option for Marvell PXA1908 SoC.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..d71b0b6e75aa 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -168,6 +168,14 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+config ARCH_MMP
+	bool "Marvell MMP SoC Family"
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  This enables support for Marvell MMP SoC family, currently
+	  supporting PXA1908 aka IAP140.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON

-- 
2.44.0



