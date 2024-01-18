Return-Path: <linux-kernel+bounces-30306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBB831CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D7E1F235D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1029437;
	Thu, 18 Jan 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fx6NAWUc"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC325764;
	Thu, 18 Jan 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593193; cv=none; b=evmxX9jN72BbKZAMdw6RonmknrBR1dh/Us2LgXc2SEKO4bZZ9OH/6I4gPjUTUFZ5S2rmnOGjYEmfyUpQy7uy+EbLWuI0Nj1E+zwh1A3MtuL5X55K+cYLWOSyYIJrTUo9zI/vLGgR97QUfvdu2LHMyCMEJjPMc60nK0KdXxGHarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593193; c=relaxed/simple;
	bh=91KuGhdZRQ3yX+KBd4TI2ZS1Tfz4GmFXyhttE3bzAFM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=Lu4UlwbHdgsKJMJO4Kn31U4zadjxf6CZh4Yhf13S1svpfqHy4UfI/42p3eSxw3LkaPgWKQi+HEbjBgl8X0NCcv7EQsf9Gb9JRTEHtKHBUxYCgpiSC1T+dLcgms/sl9a/zj6E9ABDQH8suDy7IzxfT2OhJxWnuMeVDP1I3Gz5+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fx6NAWUc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59D35C0010;
	Thu, 18 Jan 2024 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uEXIbyuTE8+uGbb2wp9Vlt8m5ypasCyIw0FxaqtHUs=;
	b=fx6NAWUcxFTXEV431gpxyAKclV58QEtRu2YyBExSkwS/4wCp9bcQdFXl7sdJVj6c7qKSJl
	SeZ/+0Tuv5mCMKs8O/9ZdvwAUpeALdn36z+R71NbMziDCp8ETcnCH9e2IIGPtnoyGvuShA
	3tDApIRYTrnVh0qZ/AJ8rrpn8BMzF79E/DyY96T03izZJaGnW/wmr9P8+jaYqYykIqs4Od
	Pcuy6h2Qfhxt06JrJB523mz5ZbR+3GuAzsIKSEt4ujcPhoL1B3haBrW3H13wZqNMqASQXD
	oRYHUCZWQzn9YgNiiA0BikY+7yuI4aKAVnczlDBfo7ZDPKvB/1DbG2tek96peQ==
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
Subject: [PATCH v6 05/15] MIPS: cps-vec: Use macros for 64bits access
Date: Thu, 18 Jan 2024 16:52:34 +0100
Message-ID: <20240118155252.397947-6-gregory.clement@bootlin.com>
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


