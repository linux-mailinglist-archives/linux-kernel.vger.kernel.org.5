Return-Path: <linux-kernel+bounces-140259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854A8A1078
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88C91C22CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81A14B083;
	Thu, 11 Apr 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DARjq2BI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFcAkVur"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A91487D6;
	Thu, 11 Apr 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831619; cv=none; b=t9IrmPfKjkoOxRxiQukWyB0TGkWYwlN0TkRflMrxWVk3nWODogFT/gwSbRWV5249fW/piCE3kZFxSkm/RE92OWV14KzInKgohY3402c4bHfRZ8CCxhKmu/HKzmRnFT2AqVj4MKsImykqqzkwah00o1FT027CIFe7hKhCQDaSZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831619; c=relaxed/simple;
	bh=vxBjKQkKFtCESvvYKo//6HECl3o26t9wpch2vn2xAbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sBnxvnerDa3LCgtQ+7hWgUUpgRJ2IvziZgt9jBFP2RIR/SjHMR+4NVVJK9ZsK0uLlN2g1xQp1wgFZ3s+VLhE/NPOZbDIcxYs7m5j1Od7FtXL89We0r+4kzKlkqk26Ts8YLVO3tB3GRRcWNNxlL2KjBcsHxOveJ0YqL1vCtNsT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DARjq2BI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFcAkVur; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 10:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712831616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWU0q1Ku6aBcu10UIXpekb9yN+TtHumYZszpbm+2CfE=;
	b=DARjq2BIqHLU9/5uBB40HYiWhEtYn/gyH8VHV9osNQWCheCpcELyTxyGU/EfUrORj3lP3H
	8zmf1ZUnfTSv6XUUkKMS+T5qJbX2+A0Jr2Up/cjVkFbIp9dxgDeM3xyWfZMe/4UFG1IsQ/
	bldttaDAk1MetyXK8stNFFEYUEIFLhsD1ZSRsQ/j9+Ir6DU+H5851BzqvSXEJp9STCCYUC
	+BdMpv9jooRXeX1/xqW08EsC967o0jOS0AZsztawfL3TCHh6k0OykV7GCBLb2AqcAbDL/4
	nbToY0umqktURlz73P2Rcx4iG5R23H/6TubkE6/G9OpEYB1pd+Dm/Hb4YsBfHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712831616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWU0q1Ku6aBcu10UIXpekb9yN+TtHumYZszpbm+2CfE=;
	b=MFcAkVurT+VyFp1iddgf5oyXBxUjc6hxh7Sqr6NPN324K8A9px/STilu0sKzyhu0LAPMkK
	lf8eC0KNVdfi8lBQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix trivial typo in the comment CPY ==> COPY
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240405185726.3931703-3-andriy.shevchenko@linux.intel.com>
References: <20240405185726.3931703-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171283161594.10875.6791785093097722117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     63752ad191f93144c99e848b7dbda050bda16fa6
Gitweb:        https://git.kernel.org/tip/63752ad191f93144c99e848b7dbda050bda16fa6
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 05 Apr 2024 21:56:46 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Apr 2024 12:29:40 +02:00

genirq: Fix trivial typo in the comment CPY ==> COPY

IRQ_SET_MASK_NOCOPY is defined with 'O' letter. Fix the comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240405185726.3931703-3-andriy.shevchenko@linux.intel.com

---
 include/linux/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 97baa93..a217e10 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -115,7 +115,7 @@ enum {
  * Return value for chip->irq_set_affinity()
  *
  * IRQ_SET_MASK_OK	- OK, core updates irq_common_data.affinity
- * IRQ_SET_MASK_NOCPY	- OK, chip did update irq_common_data.affinity
+ * IRQ_SET_MASK_NOCOPY	- OK, chip did update irq_common_data.affinity
  * IRQ_SET_MASK_OK_DONE	- Same as IRQ_SET_MASK_OK for core. Special code to
  *			  support stacked irqchips, which indicates skipping
  *			  all descendant irqchips.

