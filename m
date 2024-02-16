Return-Path: <linux-kernel+bounces-69090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65D858458
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67C91F2222A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D687134756;
	Fri, 16 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gu4Ezaqp"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADB132C1F;
	Fri, 16 Feb 2024 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105359; cv=none; b=IEhJhDDzUqsK0Hbd32O84YdDCTDUqDEEmVewZeGI1n9t2tspBvn9UrfefXxLqSlkzLKn1wDr1ChAcDV3u6RV0UdoUemsQnyhQVkeIfBM0eNtCq9j4SlriO2CLcrWZ8/QLIYw3AGbiT13HmzPsfKPHfjNTj9ow4+HNal3IkbeXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105359; c=relaxed/simple;
	bh=E/90gBwLmpJXeK232Brlce3fowXySmiFqEe90Bkb9Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofdOeZP9aqOGb2QVJkmgB+Se1LqProsfSeGWOjJ6gAGzWGFb9jVD02SaQeivBoR1i4affv5zq0/FEHf09H+1gCDqjdotkQJL7XTdeEaEOkUqTeQcIfC34li7EYMeB+syNVIkAA5vz/aMBziG164SJOWUVCn2OdDdpOnEUf8APag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gu4Ezaqp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C097040009;
	Fri, 16 Feb 2024 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfmqPXyNaR+Aomf8hQQJpTdW18Oyoy4DRDDUy1YAmW8=;
	b=Gu4EzaqpGe9p3mjEHXSwL8mlGL+/R90ivM05jzPQB67qyT2+xZv05L2imaQPvJO+DyamZ4
	6bHYkXfoHa/vzpFl0AzsLKaOjWpOCxhSEdBXrhJlyNac08V0+O6cOX99jw+hys6A7/YZsV
	FavGJGTrWGrO+z1u5waTBrNX1enHOoGn7rFs5w/ni8sMeSZA/8KZU/a58FGTniiUsrWZIY
	I381Iv8//t+bFr7qEvPEkTm8lmooE+KPAVzT1F2RMUUtF4PkmxIchItpgjG0czrPE8/jBd
	Z1QHNnrAqBQ2dzfc2aQUGn1WRwVUg38mf0qS45fsO7bhM5ttb7FiGKodR5gvHA==
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
Subject: [PATCH v8 05/14] MIPS: cps-vec: Use macros for 64bits access
Date: Fri, 16 Feb 2024 18:42:14 +0100
Message-ID: <20240216174227.409400-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Some access are 32 bits only while they seems better to be done in
64bis for 64 bit kernel.

This was extract from an initial patch from Jiaxun

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/cps-vec.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index df610c006b443..f876309130ad1 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -396,7 +396,7 @@ LEAF(mips_cps_boot_vpes)
 	/* Calculate a pointer to the VPEs struct vpe_boot_config */
 	li	t0, VPEBOOTCFG_SIZE
 	mul	t0, t0, ta1
-	addu	t0, t0, ta3
+	PTR_ADDU t0, t0, ta3
 
 	/* Set the TC restart PC */
 	lw	t1, VPEBOOTCFG_PC(t0)
@@ -571,10 +571,10 @@ dcache_done:
 	lw	$1, TI_CPU(gp)
 	sll	$1, $1, LONGLOG
 	PTR_LA	\dest, __per_cpu_offset
-	addu	$1, $1, \dest
+	PTR_ADDU $1, $1, \dest
 	lw	$1, 0($1)
 	PTR_LA	\dest, cps_cpu_state
-	addu	\dest, \dest, $1
+	PTR_ADDU \dest, \dest, $1
 	.set	pop
 	.endm
 
-- 
2.43.0


