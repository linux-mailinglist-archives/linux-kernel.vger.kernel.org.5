Return-Path: <linux-kernel+bounces-52927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6425849E77
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D918B1C21801
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5C446C0;
	Mon,  5 Feb 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lNWXhzeV"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F832C6C;
	Mon,  5 Feb 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147315; cv=none; b=GT3pOWovNqfM9rOg5SEGXv3JVVLtvLkuommwI325LEYYvfqcFwYJw+t2FbqXLKg8aktGqynJIfq95ojstbJk/zd7BNrjqV6fMLuBd1IkqhZLjxcqaKwWXnDRdbo1RuqH0Th8yW0FjT5kkuLeW5JilN95JFOR8aeGvB5i4ZAveGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147315; c=relaxed/simple;
	bh=91KuGhdZRQ3yX+KBd4TI2ZS1Tfz4GmFXyhttE3bzAFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxpFLqrk73iMQP0brSBrEpB7YclhabKoM3Wmkr5CUnNSAL0DTfDyxs/8i8MiGQptOiDzhp8N74Sy2ef0e3zHyKPvSrfdbr9hkMAzcKTISGCV8qocLNvS5lniMGWD0iSzWEgnlV5XwHJs9sQ3jwheduklZEvgQkoElb5cZhXeF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lNWXhzeV; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0091240008;
	Mon,  5 Feb 2024 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6uEXIbyuTE8+uGbb2wp9Vlt8m5ypasCyIw0FxaqtHUs=;
	b=lNWXhzeVilhHUemhu/aQCWI9OQQ0UOQDm8RMJpykgIr9nsFBc/wKLRQ/wqOsw2uuZyUFIs
	kekESBVrvaQ5P6U5EdIFzXyXaMAR4Ppy0tLNzGX2XZIRnU/93W0zuwPF7Dl+xWh2ln4Ay+
	LuCVMYqBteVD3PsEboaHQ1raW8N5VN4rzrnkjZK0QzTWquYw87v9oN0n0lYUYXWVLmvAxh
	EbZQ4YOuHn8xSydcdW/PoAD/N4arRwGjZ5NGk4Ml1JSNl+uOKzn5xNrdGGicakxIT/5XUs
	a1rJx2tTntwnhRobxK3bFS0sAZJuCZsGzYWER+DC3qjiwpITqwSLO1vOhbd5RA==
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
Subject: [PATCH v7 05/14] MIPS: cps-vec: Use macros for 64bits access
Date: Mon,  5 Feb 2024 16:34:51 +0100
Message-ID: <20240205153503.574468-6-gregory.clement@bootlin.com>
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


