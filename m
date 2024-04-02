Return-Path: <linux-kernel+bounces-128696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA483895E53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161301C22097
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6015E5D3;
	Tue,  2 Apr 2024 21:03:13 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A015E202;
	Tue,  2 Apr 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091793; cv=none; b=pfbgCSG45M1E4ekLFCVEkqECzZGgZHwTw1KfHQV699OyrO7rrAWN9rUWYR3aaWkWwIlQQoOaV/3sQjLLClI/xL8VxoZ8h6TVaLMLjxkteq5iRmR3mDtyO0yW6iBK4qvNwNihF1VOX1TY8jUPGQrDcnAm/Wz4IOrB5uxmpWxhYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091793; c=relaxed/simple;
	bh=rBtIaMX/S+mXR29Z1GK6jtLfsrLvd3qrx2yb5nOvyjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXQze6TN7u61KuWyKc1zT3y2L6uQV3R7f17h7dczUhaaSGNm3yFUa/iKayk/6mMhXDBvCPwDtWt7Ln41vDDUMpLdIebEJs+/o/XNckqMKiM+FSo4S1M5ZA+P1uNWvbtBb1N378dd2xZi08PNmsDfCoIDJ5jtN7ZMMrbA9dquLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4263987FF7;
	Tue,  2 Apr 2024 22:55:53 +0200 (CEST)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 02 Apr 2024 22:55:43 +0200
Subject: [PATCH v9 7/9] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240402-pxa1908-lkml-v9-7-25a003e83c6f@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=855;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=rBtIaMX/S+mXR29Z1GK6jtLfsrLvd3qrx2yb5nOvyjo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBmDHDNm1oHT2XD6K2y04mhc9MQhQ/6vScz04Onv
 5N/7wD4ogOJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZgxwzQAKCRCaEZ6wQi2W
 4Q+0D/474noNUcTAKGZd19bfGboXkMgSrpFntqJXDASin/Ue7zb3J6bcWzUrCE39Tuin9On7veA
 03YcuWQ9FsgSt/NM22581Ly+0R4C0V399WyswhAsyWuRzzzoiOkqn7jU7kW8C9Ltz2iFqcSw4xp
 Xl26tTc3+RUyrgtZNZsWwnndjOgAkLKSDsc3oMpA85AB866fvNIRLxeCpR5mIsTUElKvhu/IdbU
 E6u3x0E6aa/FAUSSM+WbWWEhCjRNwdYJdpEeC5h8+bAM+LZ6rAr1v9i2ImRTVH9dczJKKW2YDgD
 dhlo5cjeLJp+sAkkkULWOnjlWYT8ODZZGgDq+XV/Vhh0vy8+OnzCP2yAud8Lo0NB0rNkBkavPhT
 4UQBQz7oxwsGdnmhB7uH1w/kd5G95QvEUAujcQ5Wxn5+6suMXR/9v+XJACC28oLCBHqr3+VptAC
 7rAwE8M8Z4l2D1KLpednKgH08QsHtKACb0fSfyXktgiT9QF8kGCDHGldr6D+cPIlx5e1lG5dvhV
 RmELHnI4FBDKt4xcd61JGY/NWHBI0aCjeSEQGPvS+QzmsToP6DWoPeHJha6QLCwNYbMkPlI78Jl
 gLzo1NV0Lnv14q/20Qi1QpzSZqECwx2gB4d97o9NoCGk8eq9aLhEXjIRo/h6PFDoVjzkt+0Cobs
 K5Z/QFZOfkOct8Q==
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
2.44.0



