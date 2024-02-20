Return-Path: <linux-kernel+bounces-73569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE685C451
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3C2B22C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745B13958F;
	Tue, 20 Feb 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xH4Vlx+I"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0F78688;
	Tue, 20 Feb 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456180; cv=none; b=AjT/Qls9TKKOJyoDODlpmO3Rm+Qz+GwXN9ZgjDN98PYF1qHxdTO3POrK088EEhGq9jprBJxbERAQ70D7LRgMpEggX7YifhKczp6QQbVxKwIDbLLeKlCldizMB58J0z0AXHIcrz/FK6NgupUSyRcBU+wl2+C++IwKRyh3Q9jkyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456180; c=relaxed/simple;
	bh=dmi97ihsQHR136LdoSFWmyMDV0XkN33gpSpTyXrBFj4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=L2yg/8F80C8NUAzx0BNkXCmQV13ZkMqd5EeEJi1n2X1Erc2jpehfT70bn6k1wfqKrNGLrHt99NOgdv5CleXeUYrGHpPSpi8RN24LDxq/l3O9MJWJYTWhw4tQfGKVu4qUD4MYieeCv/xpeAf2F+D/PqUkCiuFi1KaIasoVxGdObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xH4Vlx+I; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708455872; bh=pFI8FnzNKc7+k3g3nC6wduGRD05uGcNCchPjmG7qSZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xH4Vlx+Iw1qBWB6+s8znzfa+isssUZmB+StD6rZKsVelT6ZDRVtSJ19bj65HuqGpx
	 Usq7bhzKhMOLO2Du9Ed3b15Btq8xMF10SuSytGaQL3harArxxQrGm+atQPw5N185Wt
	 7bt8rDXMOHFCdLB5pgUgfoXh8ugEkNovzBppR7eQ=
Received: from cyy-pc.lan ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 11B84C23; Wed, 21 Feb 2024 03:04:27 +0800
X-QQ-mid: xmsmtpt1708455867tqokz8oa2
Message-ID: <tencent_C9E0DAC75884B0346EF2250A5E68673BA20A@qq.com>
X-QQ-XMAILINFO: NiDupExshEc70XaZcuHgb8zjvf3CU1GVRuohbIeat/MxFt3rjbDuW0+/qs/vNI
	 brFaK+gI/D/pbti3ER5TG6xRXTKOUWNd9FPRoxKGvovkb30i0zGP6AjYCtkTefdNvZwOBEOM6wYu
	 ZcoxioPhd7iwsUHf/g/WhPgrQZc1nTjSNwHW1UCeQo6zXWO3v5mmX5TEpbByeSawtIYkfWCHzrWx
	 ApKUmp36gVV+dR5Tu5gqOZdhVtn7y8ei3V+DxRoQ9tiAtYWq6LGsKJ8iCOqOQt/VIlSqb6zbYaRt
	 ClzLW/bkWzJYC7juZOP3zHWUjDj0SpCKnx7sJgLzJ3rRK3v7d51WW+6YNiBzw2rY7XOk6gXhaAqp
	 U92TOemu2sPUobqYSutBxT7vc2IGO5uDIV7gSLmm3cJdNwP5XbngCGxZxvzBrWe7d9/rh417HpGV
	 /7DiTJK+VH/Rf9lpx2xgo0PP3N736whsCCja4B8f7KIb339SNLesD4et4+9yRY+ZK47Ivcmmrfct
	 qNjHDKOjg5n3XC+Hbvy6LRkd6QtOf3lFDEadGDY+Jydg0lqMS9IYwxBclw+Pw6E8SSRJHAGwADBt
	 +klC+wtdaqHn089ymz6GyY824nSTJWIxW/uK83mTYrCmbxujPIkjU81Qmvk9ruNBYNYE06S9O5rT
	 0eqCXfb9f3BHhg1GZQ71bFPYJEBBl7UmSIa+qz435Hh9QAdkB4FsE4iO9JQnhraigg1q9nm7NMb7
	 ZHcGPYIJ6HAEZqw1T3RADbj1An7bqZ/k5ogRNouk9f1oKKkJulKeckLpfxSQ/qFgkT7VHwF1I8oE
	 XGfoKXAO0Y6TBytuSsNhSBaDVE6GdDp7nelwB+MnywgPQeTz56gkh9plZgTD4sBcVhTxo0PoUJmz
	 cD/1AQwMANrzY4LbAE32IKPm3luCliRZSc1H2CrckUXb/5yZcPGkWOUjo8tnT7XcK7615nfTFPgQ
	 8uncXOXFsPjydH3WWWFpIttl3xFTtcWLxuWhWPNaRVYtAejZVLHtNYjxlvQh+PeRXhu3t9V6TKry
	 e6rZ4yNz+lnStBmh+PbBdo2R02HGQ=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [RFC PATCH 1/1] riscv: dts: Allow BUILTIN_DTB for all socs
Date: Wed, 21 Feb 2024 03:03:57 +0800
X-OQ-MSGID: <20240220190357.3391307-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
References: <tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
patch moved this configuration to entire riscv.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/Kconfig                  | 16 ++++++++++++++-
 arch/riscv/Kconfig.socs             | 32 -----------------------------
 arch/riscv/boot/dts/Makefile        |  2 +-
 arch/riscv/boot/dts/canaan/Makefile |  2 --
 4 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b49016bb5077..23d501561e64 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -996,7 +996,21 @@ config RISCV_ISA_FALLBACK
 config BUILTIN_DTB
 	bool "Built-in device tree"
 	depends on OF && NONPORTABLE
-	default y if XIP_KERNEL
+	default y if XIP_KERNEL || SOC_CANAAN
+	help
+	  Build a device tree into the Linux image.
+	  This option should be selected if no bootloader is being used.
+	  If unsure, say Y.
+
+
+config BUILTIN_DTB_SOURCE
+	string "Built-in device tree source"
+	depends on BUILTIN_DTB
+	default "canaan/k210_generic" if SOC_CANAAN
+	help
+	  DTS file path (without suffix, relative to arch/riscv/boot/dts)
+	  for the DTS file that will be used to produce the DTB linked into the
+	  kernel.
 
 endmenu # "Boot options"
 
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e08e91c49abe..623de5f8a208 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -84,36 +84,4 @@ config SOC_CANAAN
 	help
 	  This enables support for Canaan Kendryte K210 SoC platform hardware.
 
-if ARCH_CANAAN
-
-config ARCH_CANAAN_K210_DTB_BUILTIN
-	def_bool SOC_CANAAN_K210_DTB_BUILTIN
-
-config SOC_CANAAN_K210_DTB_BUILTIN
-	bool "Builtin device tree for the Canaan Kendryte K210"
-	depends on ARCH_CANAAN
-	default y
-	select OF
-	select BUILTIN_DTB
-	help
-	  Build a device tree for the Kendryte K210 into the Linux image.
-	  This option should be selected if no bootloader is being used.
-	  If unsure, say Y.
-
-config ARCH_CANAAN_K210_DTB_SOURCE
-	string
-	default SOC_CANAAN_K210_DTB_SOURCE
-
-config SOC_CANAAN_K210_DTB_SOURCE
-	string "Source file for the Canaan Kendryte K210 builtin DTB"
-	depends on ARCH_CANAAN
-	depends on ARCH_CANAAN_K210_DTB_BUILTIN
-	default "k210_generic"
-	help
-	  Base name (without suffix, relative to arch/riscv/boot/dts/canaan)
-	  for the DTS file that will be used to produce the DTB linked into the
-	  kernel.
-
-endif # ARCH_CANAAN
-
 endmenu # "SoC selection"
diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 72030fd727af..318239d9423b 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -8,4 +8,4 @@ subdir-y += sophgo
 subdir-y += starfive
 subdir-y += thead
 
-obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
+obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
\ No newline at end of file
diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 520623264c87..987d1f0c41f0 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
-
-obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb.o, $(CONFIG_ARCH_CANAAN_K210_DTB_SOURCE))
-- 
2.43.0


