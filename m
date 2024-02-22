Return-Path: <linux-kernel+bounces-76912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB885FE86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D51F282BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42A153BFA;
	Thu, 22 Feb 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SC44U0yB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSdHSt0Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BD14F9FF;
	Thu, 22 Feb 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620937; cv=none; b=SuhxUYRRZmB1ZYTlznlsvfpucrzcK1uAlD0sa6761dO9yc+K0FWWyn8KX0JRx8UbKblDjOS7O+poe3oETg/7MJmEq+xvDMgY7TX3YPR4IhagKQGwc2TAUpf2HFlMcC70OD8gaV7lFLVNNEv2Jp2+iQ4oSEsuKwXF3cdDaWEDMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620937; c=relaxed/simple;
	bh=npytPVw5M3sUKok7yybHeugon47SNE8jW3hGSR/Wa0c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ecD2aZmW3rEQ2cgvDkR8FgKh/jRoJ/9tQtTrI3pIBfhMzrloc+j+wRHDIi+ICgruCuS2FzRyhiChpK1VcRV2YBQ/As457ajiHtWoo1mSK6HuDp9oRvxGpntdBpMs+UZzJyI2mbNFMxWkIbtnetleAedSovOfkekwMD4K4vekFYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SC44U0yB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSdHSt0Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 16:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708620933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nqywM3EaFuT0LLG5+8nJBAP5oaXlvRtzzWjT/BqrDU=;
	b=SC44U0yB2I/+7YxiPAE02ZqznBBXruIoQ4+jG9Emt12zslkCEBJdDT/duLku72pBo/GgD9
	JNrAwSozVgGKic/us5J1wYQvxG24+lYxa3WHcHh5ZJrTYya+qC2sPyalNLdNXT+DK5p2E8
	rARD3pF8BNFt5pwWpq4rqI9lJQcx9v1LnoksJNmB9BeX2pCuyN8R4FpJToimBdjLb6zAlN
	Zob69ISlNj+EbjdN7rcjN+KmDK3y9cWUbsGbLSjumTqskRAK+HB9FiwkIbg2hGjZuA9gkm
	/RHSVfh83XeZ1GVc+Z84Kyp/1bL9+2hkIhvZrQHiTuFZYnxnmXnt7A3Tb5xs1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708620933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nqywM3EaFuT0LLG5+8nJBAP5oaXlvRtzzWjT/BqrDU=;
	b=pSdHSt0Yd/wY08rP6vqSmB8iHrBW1OiO7mpx3HivMMaRByFiyJQrdFVFiE5zaG0XTpBi5p
	Ka6Z5IU4w+N8e6Dw==
From: "tip-bot2 for Max Kellermann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu: Remove stray semicolon
Cc: Max Kellermann <max.kellermann@ionos.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222114727.1144588-1-max.kellermann@ionos.com>
References: <20240222114727.1144588-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862093279.398.1951043939056036811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     266e95786452d97f42dcb9a881bba223584b9648
Gitweb:        https://git.kernel.org/tip/266e95786452d97f42dcb9a881bba223584b9648
Author:        Max Kellermann <max.kellermann@ionos.com>
AuthorDate:    Thu, 22 Feb 2024 12:47:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:51:14 +01:00

cpu: Remove stray semicolon

This syntax error was introduced by commit da92df490eea ("cpu: Mark
cpu_possible_mask as __ro_after_init").

Fixes: da92df490eea ("cpu: Mark cpu_possible_mask as __ro_after_init")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222114727.1144588-1-max.kellermann@ionos.com

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7b36b3a..cc4a806 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3106,7 +3106,7 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __ro_after_init;
+struct cpumask __cpu_possible_mask __ro_after_init
 	= {CPU_BITS_ALL};
 #else
 struct cpumask __cpu_possible_mask __ro_after_init;

