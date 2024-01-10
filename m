Return-Path: <linux-kernel+bounces-22638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C1B82A0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C370B266B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9024F616;
	Wed, 10 Jan 2024 19:04:15 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CC4F1E4;
	Wed, 10 Jan 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7A90D85C07;
	Wed, 10 Jan 2024 20:04:06 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 10 Jan 2024 20:03:33 +0100
Subject: [PATCH v8 7/9] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240110-pxa1908-lkml-v8-7-fea768a59474@skole.hr>
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
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=nzCagw7FOqMrQlO9+vXuSahZpxuYCujLjSnk9dhtGTk=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlnuoDRTKrtpKQfsrTs1ouA4M/p0A2idFYLpoKz
 XFDUBu6Q9CJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZ7qAwAKCRCaEZ6wQi2W
 4ewgD/9MLxFG6IZcn5UvqBEQ6K4EyzYPh0C75RBaFH1886ZTO/3bdKmXffQ4u3u/dbayuo2N7LH
 2Q2/noPvcWrnZ8jarRvZwTGsj7uTEHH3MJw5UKez5YwIfs5zY/vDi6TmH/TzrBnxBEkJGJPJAHc
 +SToQ4ggJ2mzDI0F2wbuXdoqgHhRq4EH6DkCCEO0n4pyJdMP3pPPZGPdTiFmWWT4/HZFXglxLCN
 d6o0P/j0oMPeLS1+FfSwObFgtkp6cr5+VI+u26siNUuZ7pN0naN3SJq9ZEO6+Ubm2YzaJtTz0nV
 DeZLJ1+Ol6pAXLSBY38Bkx9m5FNskLv2WQm6UpE6f44Rh21a0xGoic9b0jQxk637axzC7hDrnKJ
 JzqZ93S4kSvEn1tnu28Tbwd3LbQPjGjLJrGPc/n/MftZVdFIzrTnV9RjTE1PowIi5aaDnharPMJ
 xj5viZk+VD4uplBr/EGtMOtpLdl99ZT7PB++1GKhTFdAOgatzJyWWRjp+eSJk425JBkQi68EXX0
 BET6i+K+F4l+2vkJuwhhoGAusGCdoENM1FAIN/zL7sSveqJa5Xl8Xrq86/mpIJKBxe30NIFIYFj
 tRzRpGrtGShbMge6hCHrE/2hys43EmVQPwDIyXp2k29394MTd8fhk3N5IAznptuYimeP0iMBRyh
 KZj/CPBnQ/VZAaA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

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
2.43.0



