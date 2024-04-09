Return-Path: <linux-kernel+bounces-136520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4589D517
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6CD1C21493
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7F7F474;
	Tue,  9 Apr 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lmng51cH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvqG/Akf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2137E79F;
	Tue,  9 Apr 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653687; cv=none; b=c00Mh42F0mdjoNO+63Hn/vvgOBi1cANK728GyLUydH9yyljmLXwIlpHDXpF6UV9/kbdoTSr9F5xgeSjumnDrD/1GwaEZD3GrFw0pvpsR/VrBdFJ60hF6+Q3paKOldMU8DYM3BlVd0tUz5aoFiodUB2UmjVXBbF811BKIfRyr3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653687; c=relaxed/simple;
	bh=HE/saxvtD2kKAocFwGdmH88/5rJIaZDcipwBqyNXHCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D99xE1KsREe2dwTTvzBcZLphdy9J94OgTHV6ciLLcDdcVVHlxPbu2DAzRaJoVBZQX4X61aBLq3TEF/uNBgHfRNKle31WxlWYwawR208u4W/Tz/VKffH6+fuVPH5XvQOOIkRmjQtfaz4G01l3UBBt5wjfoIETpqafpOv0ozQ8DRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lmng51cH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvqG/Akf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 09:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712653682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKxTYC+kI3eBBkVcnpV9xchAkzkdtl8rdRudI0WUrLE=;
	b=Lmng51cHQhcmk0fPIGIlNxGGgjWagc27b3N+fwkjmTQF3tyStFIrscWyEJ3ms8xG0U5mtj
	Et4vvjwS9ITyUE//74rznbBJSae3bcN9Xlf1G3V25YFucIWE6U7rcWWtduSsz1B/cFkfEB
	U6QIVSjVreiQMdtjr1Sqktx+SzVwxz+Wj1e4N4zygIUMNt1u+bIxdkK7SM6Kb2bnv1CRVn
	FHcnX0z+T+bRJ6jM+NcbDUTZdu/5536Mfucy8eTa10zfZeEokvNBb+fmk8M4nNg9qwISQs
	3lY2700tGBDojvX5JZNzCUx29FP56iXy3zbEiJf+yzXtyQQxE9eBQHdR3EW+kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712653682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKxTYC+kI3eBBkVcnpV9xchAkzkdtl8rdRudI0WUrLE=;
	b=LvqG/AkfiDn8NIns1zisKU8r2t+x71Ef9QDOd1Pum0EZBUWsf96wog9fcVHPpm1OaINH1x
	5eNMA2XZBQQrsyCg==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson: Select
 GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP for IRQ_LOONGARCH_CPU
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240326121130.16622-3-yangtiezhu@loongson.cn>
References: <20240326121130.16622-3-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265368105.10875.1763282728546644251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     42a7d887664b02a747ef5d479f6fd01081564af8
Gitweb:        https://git.kernel.org/tip/42a7d887664b02a747ef5d479f6fd01081564af8
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 26 Mar 2024 20:11:29 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 11:03:16 +02:00

irqchip/loongson: Select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP for IRQ_LOONGARCH_CPU

An interrupt's effective affinity can only be different from its configured
affinity if there are multiple CPUs. Make it clear that this option is only
meaningful when SMP is enabled. Otherwise, there exists "WARNING: unmet
direct dependencies detected for GENERIC_IRQ_EFFECTIVE_AFF_MASK" when make
menuconfig if CONFIG_SMP is not set on LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240326121130.16622-3-yangtiezhu@loongson.cn

---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 687d17e..1446471 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -593,7 +593,7 @@ config IRQ_LOONGARCH_CPU
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select LOONGSON_HTVEC
 	select LOONGSON_LIOINTC
 	select LOONGSON_EIOINTC

