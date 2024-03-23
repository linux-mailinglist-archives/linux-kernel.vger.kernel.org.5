Return-Path: <linux-kernel+bounces-112324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F1887861
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854981C20FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C918EB4;
	Sat, 23 Mar 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oe4YdMEb"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76558DF53;
	Sat, 23 Mar 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195980; cv=none; b=WFdkJJmSwg3htmv0YDmWtOa7MuZi4IiH/ysiJ3TIsibA6Er7BCDqZuRDMue9KPes143BHCHIdF13RpunMueoKPqthIRg0I5nr10NOeUfLb/5E8L1RJxllSoFPTMlskfdFWmtt2X7cVnUZIPag4mMvjNuXUl3757oW/Cj1q3lRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195980; c=relaxed/simple;
	bh=Y1c/TKrZBe7md/0bMLeqRF8QhF8uFJReg5l0Llwn/wE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qvZrO3LO+Cvm0WDhJAJoKpPdydi0V2/orkmENP9L843OBxOYh3aD/F9q9F9vYCvNzIKtA7vn0aHIM08tWx1lS7+J2i2QwjY+HAOZtzD0FPUzqYfuuD0AVex2h+3UMThH7jLqFEufH+esi2QT8tgY2Z72JwOp1WyjDUfKuBJQsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oe4YdMEb; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195974; bh=gxGEA1zI0RM+I3kpAeG2Tfht93lBnbsfTrZDhfruV3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oe4YdMEbiQc5uV1LuUQYsbJVkr5lPskAeflh8ityfnCtIngSgyiEaKLj5Kqt+Talt
	 lXPKXc02rRHlbeD42KK4JUcBBSIOVjm4EbKVkdwgYQ4fIM8ngLK8sMmoaS9zsMDR/4
	 jLvgI3P98KYVK7Ix8a6/DRehhEl+gpmnnnKgZNVI=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195971tonyfvaik
Message-ID: <tencent_C07CF3823CDA708E47B879312E213C8DB908@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAj61jTOe54p85UExhdidaDwwLUsRR7zkr0fCV9v9nd4Trhy5U/Eq
	 1eGcetKRrVcRFO3+d6O2nKFy0N+YEo+zNX6QYJ9ZnWgZssmh5u3xAzfOpfnwl5RlmroYW/yhSJQF
	 60LUYBoW8b1fsDq42tXjLPaPVF3KU733xftgU82ZlqdK/QNHwp46Q/cUoF631vOe4FALQHsuJxOj
	 Kd1q/A7swXqYqLzBNXSFYlqHEwHkBqF+0ynNFjt0tA78iN2l6c5bw/5p0SMQVBTKlDJ5XJSp4zdd
	 i6MME9fypgZoQSnjtt9ArlyqC0/c+Ke+rdEyX95i/Q0m6Dbx1hJsmufb/4NbOzCdPH8kjj5OQIo0
	 KDihCCiVpuhO7G0PHq1W/LaODrU286x8Q42G0aUSZ/tscaeJDOXpthYPQ6Ju8+kQaNSxHXQr/Xbd
	 swEIP1S7J8Cy9cVGrW0Vx34ggJZU+5w6sJwFChIKmu5A2yNySFrBVYMKPMFmVytPKOYIlsYuEbTP
	 BkgJPEWvBnquRl2rhj+whKTWlFhApb1wAl2g6AlN9U4BalBUrLG6AV0r01mHxSGdFPuTmx3/WAc+
	 CAq2HW+hHmvDRZgspEjF2nftibfTjBFrzVgIbKaZckhv79V+fyqW/r3qjHHpNywIcl7WQbOjB5PJ
	 kJlopcwYbeHjoD1Iwe3ejXaG9gSJQ+SmH7iFrV0xdV7TcewDi7TVaRtROP4HRsRyPyvaUVKfi3VA
	 jXjqpDEzfHu5J8RCUEap75d8GL98b+tc9PWaIZrbEeP4TfCzDL+otr85+ZL4ZDW9NLvT+3QVT0I8
	 Uhl2/ctTuQx2Sbpa8iFNo1XRhF+qVYJ/l/TTH0YsDq3rrvayLu9mIrvGoJahhQEm8aW/whfM5Z7w
	 JK8hRtfdweSf1DRhyYdiOUEVeOP1T+nOJCebiWLRaJCW301V9TOVa+fLf//rZ+j7PdJ7nHpkmklD
	 JXGBfoM7Rc816OezvwWbabQUKZ4GTKd+zu9J4Sb9u6BAGRipM3Rx6pkgIoQwJe0FY2kcxA2B3LK9
	 otE2bCORE/acVXNzm4Bf1QM6wX2MXg82fHmFKZSA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v6 06/11] soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
Date: Sat, 23 Mar 2024 20:12:18 +0800
X-OQ-MSGID: <20240323121223.1729328-6-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SOC_FOO should be deprecated from patch [1], and cleanup for other
SoCs is already on the mailing list [2,3,4], we remove the use of
SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from now
on. Thus, we should also change the Makefile here to use ARCH_CANAAN.

Then, since we have introduced SOC_CANAAN_K210 for K210-specific drivers,
we should replace its drivers depends on SOC_CANAAN_K210 and default select
when it has the symbol SOC_CANAAN_K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/soc/Makefile       | 2 +-
 drivers/soc/canaan/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index ba8f5b5460e1..fb2bd31387d0 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -7,7 +7,7 @@ obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
-obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_ARCH_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 43ced2bf8444..3121d351fea6 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -2,9 +2,9 @@
 
 config SOC_K210_SYSCTL
 	bool "Canaan Kendryte K210 SoC system controller"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF
 	depends on COMMON_CLK_K210
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	select PM
 	select MFD_SYSCON
 	help
-- 
2.43.0


