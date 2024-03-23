Return-Path: <linux-kernel+bounces-112325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC74887865
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD901F22096
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B7339FF5;
	Sat, 23 Mar 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ekilKsN1"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D049C1759D;
	Sat, 23 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195982; cv=none; b=ZG6bgjAKXDHctplL4kttgfkoEFUBhk4PaI2KmSyAvFxrVT+KDFImqPRCBkloY4YDOROuiNxK4Ol0vuhiVISSTVxr5t9ebDsjq9YD318a0c92GMUeEz7rnAJgMGvn+883A5U2FAu5ENL6iJqKpmQDxNTCY7lTAABCfBe7E+n5MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195982; c=relaxed/simple;
	bh=zLRe0rs7rrOcg1pnUIlyS0xL50RZTV31X8+yyh8qXE0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NgGsIB8cfrfM0SsLSaHvdbBPRiOQFYfB+ZdPwD9Cn25QlnbUyI0zfrbpvvlxfu9urBLD8Qct+RS0T0YzbmL/TZ2g9yVV48cdcqq5VFgvbN9ITHr/lrrymtuFBiYCB1negovfObrjM77exvB9NWY8qZrtjF79WCZ8kqDhXUQ4YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ekilKsN1; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195972; bh=5MpYpfT0eNaGtEdlbvizvrZCBY0mWQjBXe0Ac37Um0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ekilKsN1Kmwni40C5x3g5mWmfqzTx2z/QyJ8cCGowm4lj+5cXXD6I8iyJsBdGC/XH
	 UMYlWZSgDvaTSfSJm6rmbJ95PV1l1sOnSNfFbaiack0hixbM9qwc3lWat3F7fAoN30
	 RBUFbxZUoRWj9G+dOp/6kDGL1f/EVTUhUP4842WY=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195969tpfdvk5ux
Message-ID: <tencent_F208A26B5338C6E14AC6648730368AF0FD0A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtun29cR78Yys0AwmqeM/v0G+9hjwKHKZ+XZCcWoA7laQgQFc7Hy
	 BA1slHKuzjwLNC3wTl3ktEYZYOb3H762Ci8JDR63DKdGBqKcH0IbYfGT4ihZdl4ETu2UdqFpEjYR
	 wS++nVOK/7CRT2O8Y89nQ3MiPCUjp0ZU9Eqa4MERanDXWCFAyhzMZ820RMD5eWio5w9baVeJMRwS
	 yUN3ItLKXkeWXpdANmBoTySpZTVPAaUuAnekb9P2HQLKLzcjIJ68n6RBVnIJcsawmwPzGsBl7FIh
	 3SC1nhsacLPq+UUAquvjTJUzX+JhHDde5h0VmFFf9CrdgiNt+XpoiFkx1JOFy7HQigl1VSwl/JXE
	 DpHsQx9oCddbAqLoEsUme5d1nMMwwj1oRkApwQBuKB/4INOlANAyjK1KU/iKllTUaGSG1rqxqRjf
	 azpgMzWS9eGckijsNwMwPfmA8C1vSjSld7muix5V20ww/ptnBGqt0jAfmBaZv6ACTqMNOk8r79L4
	 KkP73aqCSNKsvDXV4VEtbEUYnyHciHRhFgYJzqdgDvcaGPNYwVX5esaAlLG/9MPYEMdvEktCYCWj
	 lL48cmSqcYGicA24LHSSV5Q+YWfPOxNiOYGWdtfVzMB9kUskeJgPg5ZJuklcmMcvuKvhgfZ1KzNr
	 WnhDu5SRUMrqw5MWQhkFba02RHDI4G9u3u41XxBwLyHvARJos/WLU2x6lPwVWNFe1ee4q9RfngJr
	 p/nbZkCaIV/p3NAHS8qO5b8IM+zFqrQ7+p59pMNmAquUPc8RIiEYq2UZTop5F58cX7X/ZQH25ZSw
	 hmHjFxk9tFIuEOyvMxpDFdIGgLHk1XTK8i9Gslqmi10LsIIj+S8p1H338lFOpXPK+Pk7aG3SqOMx
	 HxYaHbjWTcWmJ78iUlsShJ/QHYKbBnLP7GkwJxdpFCQcJOGsf+YepPP39DbmWsLYf3SARzRQbL8Q
	 z27u7NB6ipGnDYK7xqb2rVDjRLUQ6KCJyO8peSaiuBzodVpzORnPkFMnLWu9LZDfnRmkbB9PcWWe
	 5Z4VvfjgMM6vxv2YcpJw8gAY1XuC8pF1lBRL2nIA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH v6 05/11] riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
Date: Sat, 23 Mar 2024 20:12:17 +0800
X-OQ-MSGID: <20240323121223.1729328-5-cyy@cyyself.name>
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
SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from
now on. And allows ARCH_CANAAN to be selected for other Canaan SoCs.

Then, since we have Canaan Kendryte K230 with MMU now, the use of
SOC_CANAAN is no longer only referred to K210. Thus, we introduce a new
symbol SOC_CANAAN_K210 for any conditional code or driver selection
specific to the K210, so users will not try to build some K210-specific
things when MMU is enabled and see it fails to boot on K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/Kconfig.socs                        | 8 +++++---
 arch/riscv/Makefile                            | 2 +-
 arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 623de5f8a208..5710aee456ac 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -72,11 +72,13 @@ config SOC_VIRT
 	  This enables support for QEMU Virt Machine.
 
 config ARCH_CANAAN
-	def_bool SOC_CANAAN
+	bool "Canaan Kendryte SoC"
+	help
+	  This enables support for Canaan Kendryte SoC platform hardware.
 
-config SOC_CANAAN
+config SOC_CANAAN_K210
 	bool "Canaan Kendryte K210 SoC"
-	depends on !MMU
+	depends on !MMU && ARCH_CANAAN
 	select CLINT_TIMER if RISCV_M_MODE
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0b7d109258e7..294b2b3e8e6a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -149,7 +149,7 @@ vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
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


