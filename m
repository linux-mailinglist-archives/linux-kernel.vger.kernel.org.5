Return-Path: <linux-kernel+bounces-69089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81452858459
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF85284B75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8DB134758;
	Fri, 16 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fndWFhQn"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047E132477;
	Fri, 16 Feb 2024 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105359; cv=none; b=My3Xaqr5ox+FgMUzTgVfxXM4RlhIdf+PrTQ5QAR/XuGT+UTzTSMa9QpCatl0PL7qYrlnxTqPbQiHHric5BTleFooKtjwdXCwqOvklQr/ejODnZJQIQErVeaJa+jwlWp/oGYEF8o0OdteGSTf4AzcqhK0iZLjrbc2paPn343nDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105359; c=relaxed/simple;
	bh=+nDcBiIHyQC/Z9LgJL8sMYQAEOQa2wTWBrZ2ynWLh7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJRAyOLGS+1AIfzIzuJrXME3Pt3I3ezqqUgf+Tk43Bzi7HrPLS/AxYgI9i+Xw8lpiV7+rGyobpk3YscP22F/whmgZawH1jqqaoMG1Bi5RzQpK+nUKObj9POKDc2IymyupZRoBGek/X/DufRHC3slFo5AeO56Sx560hDO3VQAWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fndWFhQn; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3E4940008;
	Fri, 16 Feb 2024 17:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFHP7WMf7cdabuKf8LPE+Tv/tjtS5NR+H70CJoKhySg=;
	b=fndWFhQnrU1dyV5z02OwK+v7yQELtD72FtNXbHj/tQ9Q8ckEc4Y3Q/TdNmGNKs5eR8pPQw
	N2YyCWOuTKrk23qldccCI6XH0cyzFOLOfnSnKkfcG82Ge6wkhK2ZCETF3oyORqVBAsRJKL
	2Pn73urZ5OVriEHkdE8oqVAUTWTnWcCHm/Cufk6OfQGlDZLlX0jm6mKQXgtjR6J6S4A2uG
	X5pgmAh5StE/NkZfC0mmfDWlmCLGXvA/BOPys3ePeNXQqrlORpmo7ZiX2SsOdH+gTYAQZH
	zMxx3vfTQ6Bk4bXXRZ9hoU/qVMhCzmgD9BRg8uaKqJr6gk37ueBVN/QbuxVrIQ==
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
Subject: [PATCH v8 04/14] MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
Date: Fri, 16 Feb 2024 18:42:13 +0100
Message-ID: <20240216174227.409400-5-gregory.clement@bootlin.com>
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

With the expanded support for placing the kernel in XPHYS rather than
just KSEG0, scenarios where ebase doesn't belong to KSEG0 are more
likely to occur. In such cases, we currently experience a substantial
and perplexing stack dump without any accompanying explanation. To
rectify this, we aim to replace the uninformative stack dump with a
warning that offers a clear explanation of the issue.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 075bb08543eca..a9644c5e7ef4d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2345,10 +2345,13 @@ void __init trap_init(void)
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


