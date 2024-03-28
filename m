Return-Path: <linux-kernel+bounces-123340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16088906DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052F8B24B99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60F136E29;
	Thu, 28 Mar 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Tf1fsyl8"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E8136999;
	Thu, 28 Mar 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645605; cv=none; b=Y4Sl8ECgayAM+WAGetXr18mP67NyXwor+VkFi5GFbBVVv6Y3iI1wx75+7t9LeFaTDRkuVTMEiz1gXRgyLOOX2FjKt7q9Tyybx18iX4oHGfN1E38Cqh4G0B1WlivT13bRLRNkGOsJBePGcazWW/9Sf6h1BJvFdVHVI+aJdLTUoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645605; c=relaxed/simple;
	bh=RQOmtF5sz09oiQaWbhcOCj1k5EViSvGFbXXELiSXa8g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RkE8cuKs1EiZX5Rn7Fkx4jHkP4Siphnb+h8cvfkpZu4jFnJ6dlDJMyTSFAjOHdEcF66ilNyoaZUUvigjhIHC3stX9tKowmg9oTyGeUsn56FuaB93/o3RV7/VzAlhXPwjER6ERvW/i6arQsBn6kNpwvdKQ/3BDPX3+mvbVD/Vss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Tf1fsyl8; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645592; bh=9HQK85GTqyqUxDvyqLPaskdxNbsUGUyRwHgyJUjL2q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tf1fsyl8jYWupyzVjyTsIQMlG1ILod2YLUSri6+mF0MBSVbVR4bEHVwbZ5LcIkLzh
	 LVANQz2q/tlWUxqI89aYcUgBuJEkf4yuogLjqyPmM9RMiGw7M+d4CBTX0d1Apoidhs
	 Ww90uH8mzqt3BeHV2Ks/LLX+hudpeJKxHBF1XJAU=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 199B7A03; Fri, 29 Mar 2024 01:06:25 +0800
X-QQ-mid: xmsmtpt1711645585thg74j62o
Message-ID: <tencent_93716D45C75B5CA098DC1090C6573E1FC107@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UE0tx3s9TEPQZ3LzMmrtmWbqb/Lhc+IOUQQqDu3uvKp3dR89jRsN
	 myUQDAD6CeOGTR0bTkNryCd36IcgbJPsVzyhUaNGhsHhv32ie30wRNei3bEmehsqDQ1GwuJS1F3i
	 qoDk9EMhkpkgump4v6L2GqHy3924zAEU2voHfinlHerU76GsoYYIRscYtdOPrsQ7b/qbPuyMUAyu
	 NBLS9VBxF6DhIW0Aid1EgY9PUsTytHHVFEsGegYDEU42Dx5v2CEcHVIknG9sX33k3MexcETuMfFO
	 efNy/mFnX3E1xNLlNeyPECRnu7lhqOYr/jD9pp+EPBoD0ufCvAn1BhnZJzPLICbSWlIwV4fFeAxl
	 2VMc+iY4Gji0WzG5vjqgX219i7nUZMxecsCn9ozj3ZynXF9uyA+fdeOIkSzROes+MxV4ayOpGCdZ
	 4Vjvv9SLPsawZrv0TWhDcxrrudsGVJEzjYOUAZyYxVRxx/hNw6BGof6K/UAghK2echd/wxFhZ53V
	 WjO2XslWhbeL12vsWDex6ydgREB1fvnwE/xLQ5DsUO5RvxnzDEp8sm5w0pbH6U1vpym2vBixVf0i
	 95V33EBs4vN77vnRJfpLqfa8x/mCJn4lO13plORhSlUT+OjoUjG8IRB8vMuwup1b82Zeiyh61Qm0
	 V4xnREXtEvnxdxsrLxxqBgoto0S2J2stoT7gRBZlpYrGB/p0wxZA5VVWvnHkhijAzMMFzILdNOFF
	 F1g5XLEW1Fgsc3E+HgpckQNqbfdeelXtAd22zNrEfNg6Avwoj3cEyggj0NOZp1GFmdmGRd7FHYA3
	 UIX/PVwHKp/vcspsm+CL4Pn0v6wm2CRsxkb/8YIF/7Uj7VONx181co64sdkL9tEC4Wo5B957TPBA
	 xbKsz8tLwPAyDi/uFDqR44uRkz8WKCjuKVb6XfR+vD/OzjaChfPwQaXPM8608SPt+VO6+nmPErrD
	 aPgFjVSWDVxtjrYZAyCUAeugq3398W9pt5t2BaQiicWXeeDoOte7mmyKxXBLSiqFjXUdDzKSiXxg
	 MP4Cdc+q9WBnMS10raVA1m8wrSZnqXhTE5AGW+bX1VKAjLzoaaTZOQfy47Blc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH v1 1/5] riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
Date: Fri, 29 Mar 2024 01:06:09 +0800
X-OQ-MSGID: <20240328170613.120131-1-cyy@cyyself.name>
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
SoCs is already in the mailing list [2,3,4], we remove the use of
SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from now
on. And allows ARCH_CANAAN to be selected for other Canaan SoCs. However,
we should keep the config SOC_CANAAN and use def_bool to redirect the
symbol temporarily to avoid potential conflict.

Since we now have Canaan Kendryte K230 with MMU, ARCH_CANAAN is no longer
referred to as K210. There are some special features for K210, like M-Mode
No MMU and loader.bin in arch/riscv/Makefile. If we keep ARCH_CANAAN for
other Canaan SoCs and remove the K210, the depends on !MMU in Kconfig may
confuse some users who try to boot Kernel with MMU on K210, as Damien
mentioned in the list [5]. Thus, we introduce a new symbol SOC_CANAAN_K210
for any conditional code or driver selection specific to the K210, so users
will not try to build some K210-specific things when MMU is enabled and see
it fails to boot on K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/
[5] https://lore.kernel.org/linux-riscv/2b0511af-1b5b-4c90-a673-c9113bb58142@kernel.org/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/Kconfig.socs                        | 10 ++++++++--
 arch/riscv/Makefile                            |  2 +-
 arch/riscv/configs/nommu_k210_defconfig        |  3 ++-
 arch/riscv/configs/nommu_k210_sdcard_defconfig |  3 ++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 623de5f8a208..17340aa4dcfc 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -72,11 +72,17 @@ config SOC_VIRT
 	  This enables support for QEMU Virt Machine.
 
 config ARCH_CANAAN
-	def_bool SOC_CANAAN
+	bool "Canaan Kendryte SoC"
+	help
+	  This enables support for Canaan Kendryte series SoC platform hardware.
 
 config SOC_CANAAN
+	def_bool SOC_CANAAN_K210
+	depends on ARCH_CANAAN
+
+config SOC_CANAAN_K210
 	bool "Canaan Kendryte K210 SoC"
-	depends on !MMU
+	depends on !MMU && ARCH_CANAAN
 	select CLINT_TIMER if RISCV_M_MODE
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..fa6c389c3986 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -154,7 +154,7 @@ vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
 
 ifneq ($(CONFIG_XIP_KERNEL),y)
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
+ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
 else
 ifeq ($(CONFIG_EFI_ZBOOT),)
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 7e75200543f4..2552e78074a3 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -27,7 +27,8 @@ CONFIG_EXPERT=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 # CONFIG_MMU is not set
-CONFIG_SOC_CANAAN=y
+CONFIG_ARCH_CANAAN=y
+CONFIG_SOC_CANAAN_K210=y
 CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 0ba353e9ca71..8f67fb830585 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -19,7 +19,8 @@ CONFIG_EXPERT=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 # CONFIG_MMU is not set
-CONFIG_SOC_CANAAN=y
+CONFIG_ARCH_CANAAN=y
+CONFIG_SOC_CANAAN_K210=y
 CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-- 
2.43.0


