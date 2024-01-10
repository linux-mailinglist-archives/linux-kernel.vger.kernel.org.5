Return-Path: <linux-kernel+bounces-22635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6B82A0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510C41C22E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCB4F1E3;
	Wed, 10 Jan 2024 19:04:13 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20E4E1C3;
	Wed, 10 Jan 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 935D485C06;
	Wed, 10 Jan 2024 20:04:02 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Wed, 10 Jan 2024 20:03:29 +0100
Subject: [PATCH v8 3/9] pinctrl: single: add marvell,pxa1908-padconf
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240110-pxa1908-lkml-v8-3-fea768a59474@skole.hr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=aPDfX56f175HrpaS8j1qNna/7A6tRjoQ5g2xcEelOeo=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlnuoDKse9zFhRTeOKwT2NAKG/go4lWc/KuDzv0
 iQzQcFPyBqJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZ7qAwAKCRCaEZ6wQi2W
 4XyID/wJ0KH/U87OMMY/hWKpf4lBjER+VpOcCZ0JCZdGD0saW0pIpYoEc1cdJg4r5Sw1lJgLOHL
 KAJVuIZfCt9Fcl1PdvgHeDLkn60U6BIZRXgF3JlOyVfyG+uzF9UhoOiJqvqM7VRjjwZDZuyiDut
 5oPVADtArVJILTMvbyHo4rKO86N32Lx41ak9AjyBjt3XdzJLiF5chBP5nHWiuODWlg4kLQILb4g
 Fz6aLaVQPr2ZWezoYRXQloxpusu8SsuYNsYYw4/FGt/sGTGqXwDZAN7DqmswG+YMWUPXa+ZHpTm
 6DHT3xWyyolxpMN6XdE9Cp4e0vIv0/Qt9iyXwBhTng2CXvCmld3uH+X7LStCENA4jPKPVOYkib1
 R75sFE+HhQDHsB2xNAbJ4vhuGN/ZJXCIQy4SGdwPYxN43C/E4L4iQBeENjY++ds5uGaMAUYpvzv
 jW8SRw17EIqJ1EdFQN77QlK5BcJna2cPTijbyhfY4rvzGKJeabQoZlPJn4s9LEgTWnZCd8vpb3p
 GNNQ33fWabJe4RwvxjS3DhLVazUtrdU4YdpFxBiJt0XYGbG6VyKpHWAx4G46UgbZ/xep2jvVxph
 nEIb+Nrv42PqqBeylMs/VAya8tqJ9CgiKb9/zLoZPQ0CGlEH0l+gXaqD/oz5v3e6/rzci4xYtz/
 J1s1L2Cb/7gseQQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
separate pinctrl driver later.

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
2.43.0



