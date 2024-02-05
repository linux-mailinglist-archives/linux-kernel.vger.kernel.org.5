Return-Path: <linux-kernel+bounces-52934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0F849E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5992A28CD4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D96482D7;
	Mon,  5 Feb 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jyaDsTDt"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B140BEB;
	Mon,  5 Feb 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147321; cv=none; b=QzmbKYA9Urz9tC4zIoOmW3YUI5eAunojmHeyRz0scNt6z4gtHOYsG9qMwh/KJutzocoBAt/Cn+V+O2vQMrKg4IXYTkTM5EGmyd5q3/s3IZ2FrQ9EtzsZNNSJEvemvWmclKSowTwjAFlNhKY6JctbYqBAiZ6pzq4hDPDtBndUzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147321; c=relaxed/simple;
	bh=9HL/x4Nj/uz8p4t8CXOhsS0Z/OjK0DF1R3RA4ctG+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQido/O6T9i7j9mMnqjiFR+1n4slz6QwvEUoC4oIAnpaantDKsKCOg9CnvRik/3v5IeARbqcv9JpIUXKrxSh6f5vXalDRYeWZkWq4at28oEmvSGukcEyYbQYEo8ZvN5s7dUY2U3cC5P2ukMwN5zuqM+nEl3pjr180hPUqw19QiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jyaDsTDt; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C9E8FF805;
	Mon,  5 Feb 2024 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Wk0pf2LEOjDnkraDRWIDqQ91OCoFBDydZfp83yb0pk=;
	b=jyaDsTDtaEcCfxi8hPZQTaUQj22/lvuqXaHaORad3+otn6iFysGdjUN3h+2TXaM3CzKtNs
	o3VIoFe5rEow+xgo5hvVBfyBpuz8zg1VjGp43FCFNSh+f8xB0E90PzNA8+YOH5A+24WsDN
	Dbuz5BptEGagbm10fvmNt46qEqtPiiqX1uYwY1fnvLk2Fm5S36jxqg4AFRGN6K6CR9uRMV
	Ju1+lYFkDZub/DFKDyCxw12j8BW16y8/lVztTBgNNsWGp60/a2TjzjVALY/2FWycyF9tLc
	DphsiySOxPYQ2Rv6eqqdxYaSsA22yA9rdOgW5Pk/lA9+N9kmpiHwAfcWxyDQ0A==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v7 12/14] MIPS: Share generic kernel code with other architecture
Date: Mon,  5 Feb 2024 16:34:58 +0100
Message-ID: <20240205153503.574468-13-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205153503.574468-1-gregory.clement@bootlin.com>
References: <20240205153503.574468-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Some architectures might seek to utilize a significant portion of the
generic kernel code while maintaining independence from the generic
kernel due to specific peculiarities.

This patch allows for the reuse of core code, preventing unnecessary
duplication.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/Kbuild           | 1 +
 arch/mips/Kconfig          | 3 +++
 arch/mips/generic/Makefile | 6 +++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index af2967bffb73d..d683993ed331c 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,6 +17,7 @@ obj- := $(platform-y)
 # mips object files
 # The object files are linked as core-y files would be linked
 
+obj-y += generic/
 obj-y += kernel/
 obj-y += mm/
 obj-y += net/
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdba..5549d26448941 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -109,6 +109,9 @@ config MIPS_FIXUP_BIGPHYS_ADDR
 config MIPS_GENERIC
 	bool
 
+config MACH_GENERIC_CORE
+	bool
+
 config MACH_INGENIC
 	bool
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index e37a59bae0a62..56011d738441f 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -4,9 +4,9 @@
 # Author: Paul Burton <paul.burton@mips.com>
 #
 
-obj-y += init.o
-obj-y += irq.o
-obj-y += proc.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += init.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += irq.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)		+= yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)	+= board-sead3.o
-- 
2.43.0


