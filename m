Return-Path: <linux-kernel+bounces-123345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59178906EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB21F28CED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F053368;
	Thu, 28 Mar 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fS0IOZXu"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259511DDE9;
	Thu, 28 Mar 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645685; cv=none; b=lVR6cCsHAh8G/zfUiOpMZZi0UhIBXhWS7T08ok3+hiq/cjetg5YSvNdQq+wsMYhXE+cPhgWlJTYeCveBOAjCD7V9+mjxQz4BprDrE4Zpt7daaB8994qgqPBR1wD++kk0kCcFmK+5t9VVqDyIGpSBLqh97xt+2jWXrTux00CeyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645685; c=relaxed/simple;
	bh=yLAh4vZn/20dsAUd14dpiSYz1AbSjAqcMfIEUPSGvrI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aGVXwPECgLLYTKXH3mlq9dHmG60wq0FUq/sc7VE5bHhwIqoi9J8aXS4FmqzetfaZaiKTCG4CmnbK0Vp8mkNp31TR540sLdwASUUxHCvsPFC+L0NXkf5SSdyhzJ62gvS6TFwm9peNj5zK5LgZE8P67ZDF1rgTqNlmzcdSHPBPsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fS0IOZXu; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645674; bh=ShRfnoFe4/QTY7IWset6XRPKvmziMcmsdCdl78vdWsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fS0IOZXucYBTfGB1hues66fVGmAihtHHcRDrvZCX3VcS55xF4V7d26kY++iJGbpzn
	 7VhmlqhwigwqvlvffhAaFZAbGbqGOMIcDtqlRGqcCh9YWrSN19exC3pu4wAk/VpHsi
	 QA7yokCpNXl5bOIhll8MGJAJ0IE+NkfcUOLzaKWI=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 199B7A03; Fri, 29 Mar 2024 01:06:25 +0800
X-QQ-mid: xmsmtpt1711645598tgdi2glgr
Message-ID: <tencent_8A35663124AED1894F53905E1BC0F1091705@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57uqGksiE1sIyx981IWc6h3ZDq8dDiTnV4PmY1QRaC0DZckQyVix
	 jnKTFyYAwhabDVHbsVwwpsAlIUrjx1YTYJCgc2U+Qxj0yzYT8EBk0tDy0Tdl6vxP5dyEaXXTIjzB
	 oboFs30cYRKhFPhnwElS9zw41vSyXwE7J+tfkTxUdXE0jE1jNJT1Nt2VfNIc5qjP6KSSm8xeLAFg
	 uRkDSzEyaXZEP5UMcJxj2CE08GYlHRkbl/w3GxAw4yBjdbqVK6uFCsv4797BNUpOKv1WbyoTddVV
	 LEx1Mmr/8B4IdPWQDpB3dMjJk+/If1/n1XZYJaQCi9a8+J8hLT1WVRVDqlEDw6Ye2pSfIhhH+AZv
	 f4K+HGC+O2HA0EWsZa5RqcmlAjpn2mcvboI6986EWL6d26B2NvYQ7UPy9c0C37FclxmUmSAOH2Wc
	 WWfhdbd7kI6busyDg84DosRAXL85gzrgYHT1VGD5FOJNXeLci88xzsw/lfsQxngRK1SFtCgAKgva
	 rx827kcfRT5aRgzmj/rxaS6rXP9BewMSe0tvGztMFfhWkBTyEgKXe5ch+fjy5N+3fp6ECaDwqw4K
	 4GP0JqMLsP75xEBZAhW/+NojX6an4gLutGmhadcIZCAkIh9zykrcXAxGpiSKvAIcIqXMh6pFZm6H
	 46MXMCkrmzaRS37nf1quZaQwSxW7P+En7uLsGEx5sMjLKGsbfqPn/yf1e3QJ7BLxMu20rWE9gkIR
	 0p+HgWvrq3ITKGgIFMgCvZmoFAnYwV6mju3J3gmuto1q4USuRs7XSQMamZcDAeQMMiaZNCebMP58
	 FqU29XWXQXTXh2a5PUBcI18NzuaEEW1gAumK1NAjuIsEukulpX2l1uQ/2AcNtUPVikt75dzgCmHS
	 DSurfMRVEEpY+RTc25KFkbmJbJckdlenNYNSg7iI/GYMuep/Yx7L0xKUvNuiPNSBp1S1+br2WkKg
	 nNdatZYR7v2Cbb2HqUx28HUr/Ah2B56gcGPHOE7NgYOsV8ZPOQU+j2bsli4WGWg8S1mEtQkEi9cS
	 Ae8jx/d+H8OZVm/2QIOTqcr7C4Yke2e7rzDN/E8qjvEtAEYQf2gJYHlTytD1el3u9yMMSD4MpC3w
	 LnD2Wd0gEC9cSDvcE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 5/5] reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Fri, 29 Mar 2024 01:06:13 +0800
X-OQ-MSGID: <20240328170613.120131-5-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SOC_FOO should be deprecated from patch [1], and cleanup for other
SoCs is already in the mailing list [2,3,4,5], we remove the use of
SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,

Thus, we replace its drivers depends on SOC_CANAAN_K210 and default select
when it has the symbol SOC_CANAAN_K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/
[5] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/reset/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 85b27c42cf65..7112f5932609 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -103,9 +103,9 @@ config RESET_INTEL_GW
 
 config RESET_K210
 	bool "Reset controller driver for Canaan Kendryte K210 SoC"
-	depends on (SOC_CANAAN || COMPILE_TEST) && OF
+	depends on (SOC_CANAAN_K210 || COMPILE_TEST) && OF
 	select MFD_SYSCON
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC reset controller.
 	  Say Y if you want to control reset signals provided by this
-- 
2.43.0


