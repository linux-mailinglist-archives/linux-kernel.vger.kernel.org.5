Return-Path: <linux-kernel+bounces-30304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED21F831CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA11F21883
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7F28DDC;
	Thu, 18 Jan 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NW50GUni"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130732575C;
	Thu, 18 Jan 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593193; cv=none; b=qL/3Uc5MEuCXly1xplK7l+ORfsiANNhh+Ljcrf9y9FEehozOzIlmJY/parWZlrPI6hFcvJiTQIEFllDD5fIBsl40Tf1lPttb2KWGZkxVp1Zi+12L7qWFprw6cJrTPgsL4bz9nkDPVn+TII3gJaGFbJIXVxm5aF7ob2pT3ILRPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593193; c=relaxed/simple;
	bh=ybEa4dcyEPEWICOPd9fwlUWO52POhOtdC7gkpwjOtmw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-GND-Sasl; b=iREeOlH68TqAjshTde72azHOZViLvYPx43Nd5rsZHkA5PpF+vuLarAiFWUwDQ3hiNwMQpILQbNNQgT2jHGBZiX8CDR/AKFWEpdjHsJ1+4WkaqBjTZZWgzbahq/aq5D4/w6/Dx3tjkJv6vJ2D19Ghj6oXBWv7Tio4l5X+rkLE+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NW50GUni; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B849BC000F;
	Thu, 18 Jan 2024 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jfDXwpJOlckaLV3N+26lV5tYsCgTGsva2UsQmLLTiU=;
	b=NW50GUniLxpYy7F7gyqZvtWUE0t/7SA7A99hg27xv53frQUToOFOAl/L1QN5zz/AYIArXg
	nZpOTj9cKGn4Tm1nL0v2TatZnrWkhjwWX8iQGmrAkux27R2Wp5t0JanOh82dH1H0jTzWxW
	JR0elOSDORFEwuhLJnatxd68CKCU/jZLbBydRrsNTHtCp5V+DFig+M1xZlFpQXWU7NDiFM
	W9mKJ4rzzh8iLi4wtoAnaEccBnT0tJJPaMcI8HQD2yszz1Z7PsS1yD4HA9k8W0bPm9sHFI
	8QUhuGU2zDwNBh68Mg4utWkyh62u3c9Qy1d8JDI70vcuEseHUt4h1RHxBWL08Q==
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
Subject: [PATCH v6 04/15] MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
Date: Thu, 18 Jan 2024 16:52:33 +0100
Message-ID: <20240118155252.397947-5-gregory.clement@bootlin.com>
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

With the expanded support for placing the kernel in XPHYS rather than
just KSEG0, scenarios where ebase doesn't belong to KSEG0 are more
likely to occur. In such cases, we currently experience a substantial
and perplexing stack dump without any accompanying explanation. To
rectify this, we aim to replace the uninformative stack dump with a
warning that offers a clear explanation of the issue.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 355d0f0709de8..911d2233d6d0b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2347,10 +2347,13 @@ void __init trap_init(void)
 		 * EVA is special though as it allows segments to be rearranged
 		 * and to become uncached during cache error handling.
 		 */
-		if (!IS_ENABLED(CONFIG_EVA) && !WARN_ON(ebase_pa >= 0x20000000))
+		if (!IS_ENABLED(CONFIG_EVA) && ebase_pa < 0x20000000)
 			ebase = CKSEG0ADDR(ebase_pa);
 		else
 			ebase = (unsigned long)phys_to_virt(ebase_pa);
+		if (ebase_pa >= 0x20000000)
+			pr_warn("ebase(%pa) should better be in KSeg0",
+				&ebase_pa);
 	}
 
 	if (cpu_has_mmips) {
-- 
2.43.0


