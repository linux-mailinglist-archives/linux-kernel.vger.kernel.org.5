Return-Path: <linux-kernel+bounces-69087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1E858450
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF921C21627
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A181332A8;
	Fri, 16 Feb 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nU9Hnxx8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D4132472;
	Fri, 16 Feb 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105357; cv=none; b=HXXg1h7bXq4lGW4XoGCOZtJxVL+4AiTB9X6VmNcmVCnKuBbyloIjPSYZVPP8kUgjLn1hh0cjQLkLxtp7vYpTCUmgy53miiWC+QvqFsmThXMcTn9zU4vjBZ01BmQfTTQxS8AJScqKNplTNzvTeBZYNeWkrRFBcKKsq1RXLPaZ+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105357; c=relaxed/simple;
	bh=rp7klZcscRHI7H80OaeJy1/tHR2TlRZAKcODnRytUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFjEt+zKRG3jW9FtYv9336F9r7KKCwlowXz7eYB+AtAebduQ9gP9q21sDeka6RDd7Ej/PVTdgvFbBt0TS+IJgAzBwP26XU3iivgsCpxLookA7Hi/bHtd2hX72R8ICpw1/7uOS+0nEWPBE8uywWo/0xLvyOgerP/cdKRy6+OJIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nU9Hnxx8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED049240007;
	Fri, 16 Feb 2024 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sm6ABzVaGE03VL5KhWQvFUqXceq6K/iThPKbCcwB5eM=;
	b=nU9Hnxx8KUt9MdyahkBYJb3afEs7DpmoJIOG4xlpTVe//fjhU/bT4rGsG2EtOf6bznCNOu
	GwDCNKzu67xKUdJbxJrZl67E3ZNu7JpMuw72b0bpGoylIRg5mtTgCQmRgHBbs6ZHadaO8A
	KaKJWMDKyL/W3+PCSsL6dbRPatUO9MzHXR63uz/m/SM3VDT6LTOLtBEmStyc3AOKpM0w4G
	wzIjVcyWOsdtWjndC9/9DHYg61Z55MPf7EZKcAMKl9Kvka0DQjsKzumPRQjSdfTcGsHYVE
	d1lOAAW51Bn0LNmCd4LBBdSzEVFtifhOy2AkdjaQMkFODEEew6tCJqHd/Pt+fg==
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
	Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v8 02/14] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Date: Fri, 16 Feb 2024 18:42:11 +0100
Message-ID: <20240216174227.409400-3-gregory.clement@bootlin.com>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

ebase might reside in XKPHYS if memblock is unable to allocate memory
within the KSEG0 physical range.

To map EBASE into uncached space, we convert it back to its physical
address and utilize the new CKSEG1ADDR_OR_64BIT helper for mapping.

Co-developed-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Co-developed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c3cc6fff9d80a..075bb08543eca 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2293,7 +2293,7 @@ static const char panic_null_cerr[] =
 void set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
+	unsigned long uncached_ebase = CKSEG1ADDR_OR_64BIT(__pa(ebase));
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
2.43.0


