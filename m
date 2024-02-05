Return-Path: <linux-kernel+bounces-52924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB29849E69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2923B28E22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4D33CF9;
	Mon,  5 Feb 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PbRjKJGe"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2F2E634;
	Mon,  5 Feb 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147313; cv=none; b=In7HNgu9BS84Ct5AgkRoRaOhBPr245rlZz/rRtGDXoWYmICvBKqe6JJBPnFe3PiR4HTNTXC4SucjcAbBWCw2/GB90Le9qfqLabOjRceP3p6Rws/pEoy+nhNIuPxYyrQRB/efTsTgylL2w57CIDtfbj77zKwVPXshQMVyWRbCN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147313; c=relaxed/simple;
	bh=oa5sejmaTh9U90I2mSDvC4U+biGVOnXDlP5i08xONzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUVhpcumZkndubKJB/fMQtCA78wenLDdeEGNw7OIDdGD3y1agq9184wjZwt+gnlV/6I25pM1KqRz1E+liak4GKgbrMotZjqLuIWMPiSf6n7F3x1f1Xzcdjp/KEGRAGk+dKPV05GWqLtmUOUqHjFQ90MuIYcAqB51W4GuIpx1214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PbRjKJGe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 064CA1BF208;
	Mon,  5 Feb 2024 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707147308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCu7pbyVCXYyBTkd+j43VhZPPnMfAyc4JbkgYZulLro=;
	b=PbRjKJGe20Wre3g36e4elqWGh2SQLjS5H0anTaXoffAmMjTX/ucQLd32l6/nqucNABPa5O
	sEl7D56VJ2307krtD3AwN99Q1Zpicqt6z4WewCW2FGt1jBZpEHJsLcLuMpFhLTZA3eAGDX
	RKw29VHd8oAQMuHKeguplFrUpm+y4igmqgaMXM/yS3HBZqOZIdtQVYdRGj3YW454exU5sf
	vQN27JDxsiY82Cmb9OCg+RyrHXFhWlUT9iYRcLX++UzYwoMEhe5LTwFl0wZ/bXRXTcRSUV
	S/OVcUjS+ik2QEBpbacoZBlMpP5Sh77jFv97a+AJIc5J7LQsbC1LhuNwHKZDiw==
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
Subject: [PATCH v7 02/14] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Date: Mon,  5 Feb 2024 16:34:48 +0100
Message-ID: <20240205153503.574468-3-gregory.clement@bootlin.com>
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
index 0e3f2f2fa732b..355d0f0709de8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2295,7 +2295,7 @@ static const char panic_null_cerr[] =
 void set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
+	unsigned long uncached_ebase = CKSEG1ADDR_OR_64BIT(__pa(ebase));
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
2.43.0


