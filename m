Return-Path: <linux-kernel+bounces-30316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31016831D00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647071C22CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B92DF9A;
	Thu, 18 Jan 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ICObkfrh"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3E2D051;
	Thu, 18 Jan 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593201; cv=none; b=R5A2yihTYJ2eupR9Z5WlsqlHqCrQJuGBD4uWkUxnc9z7aefX7ijjVwoYchsmhb9rwxsYBNX0KhcWT/Pvdo/frDXdYmar7D62/lqglaXXV9jc7a1rRT1Yyq5h8ogIz1lIbBuVP6OHa0/R9SnaczZLhLI0ylDGKldtByawB5jKw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593201; c=relaxed/simple;
	bh=9HL/x4Nj/uz8p4t8CXOhsS0Z/OjK0DF1R3RA4ctG+tM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=aWY+A7BJBrZMXmAMGQ48vjSlPvgcj9bFXA9cAXxWU+XPQs10C1kvmxwFJGsMHoTJtJ+iVsdlh1d5MlVqsMrRsVouZlelON2JyfHpRsFR9gINGH08K5DxEY+WspUB5lv3LUsRupdOqTBOVmMtElMl3EoSyiow9v253yEu/HILwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ICObkfrh; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 802DA24000D;
	Thu, 18 Jan 2024 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Wk0pf2LEOjDnkraDRWIDqQ91OCoFBDydZfp83yb0pk=;
	b=ICObkfrhVIHgn2/dVXNwYAHoxENoGLbIjx1QIIjPcwCxfvaRJ4hqwiBaPg7p1x17ZfYuUM
	NoWoMfxgCXKdGIYm+4SZNXHFIZL72qhvdMreTvAKzVxJpLH4INcduxhD2oE0Mbp0+HrXfu
	SNRbirW29ieyLLTnsemvcCl7WmWMrUO8kak3vogQfyBlVghBPH51DDMJI95Cege7xNMi3V
	rf4+7c3xCBE67NzwIr0OQ+cjOx+Srda5BZprKyyInRu+MoVKTZjaAjtlk9GbK1rJutIzJl
	X6cCnFuPB+aTAyySklrY9Qa4S2FYzBa7AF8kveXgNeQD23v+9fk33vj7FVphJQ==
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
Subject: [PATCH v6 13/15] MIPS: Share generic kernel code with other architecture
Date: Thu, 18 Jan 2024 16:52:42 +0100
Message-ID: <20240118155252.397947-14-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
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


