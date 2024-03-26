Return-Path: <linux-kernel+bounces-118584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329288BCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C8E1F3BB95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFFE433C9;
	Tue, 26 Mar 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+8foGwJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eycbu2vf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B43FB9B;
	Tue, 26 Mar 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443368; cv=none; b=aooom3RSjNfSB6VP0hTQRbOppHz4/GQeF3tkaWRF3tOCJjJa+h04iu4JEsUZlQbpDSJ8ZOb7M5vfjlgt61WDV6yASm8yeHAsTk0KIOHZjkLKIVA/d9+4WOuF/U2Ft1zhkZGnwhbN50uVL+BbzuOMztgv/d4CqTmC7JkHpp8Yx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443368; c=relaxed/simple;
	bh=OOuwkb/GnfWXmUreRzzoRubqTHVJY1oBNP8Lkd5iLO4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c3CmSP2Ot4n71VN7sWWJ5HevHs/Hu3YZF0tnd3hTybu6N4pDEXZrFlOIoX6hW9pAOY/WG1IKHxqb2Ixiyvcy5MhQG8hWAI1xOXwbFNwnvnNlmabPRj1OStJC9oX8vh8BXFqGrmlSMoYE1Mo6hZTHfdBLYbFQ8yaplzXsDzUr8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+8foGwJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eycbu2vf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 08:56:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711443365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/9oO4IBpErftDrrfF8M+qoYDPeSaTc65GGVjFBmBts=;
	b=T+8foGwJV//5eu55WHpnCQpyudW13T/NP9RS+6uSWAgpmFvxwmPAtlKPuQpwo7R4gs8JI8
	6FTj2se8ZRgfO+H1BU9xuO+sZNXHc/uY2tjqYfEtQ5+uh6jmhrm0+paddaC+5nXwtv2oiQ
	23F9Oq+qBhyskwra6QEaoto5ruCsTNUz/mZk6EF1dw8Yde3hbHSMcrz9C9Ol1X4TPfp2uO
	T6YdO5rIJKigjVMVWQHAIij6fQMVF7dO0D/narzP3C2KWIHRUfY0VwT2Dt+f6yRP+X8Vui
	fEIrPk7j/IdaN+CiiqZNRwTaW07IQH42EBd2/zoC7HVYA1UzU4WT24sfd/vDrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711443365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/9oO4IBpErftDrrfF8M+qoYDPeSaTc65GGVjFBmBts=;
	b=eycbu2vfekssjfL43wdz6n6Ehq41m1zyW7Ad4lp1eYzkCc8eeLPSnCtgK8X1GjIvK7KO60
	uTeMWXp+VIZXbgCQ==
From: "tip-bot2 for Bingsong Si" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Clear TME feature flag if TME is not enabled by BIOS
Cc: Bingsong Si <sibs@chinatelecom.cn>, Ingo Molnar <mingo@kernel.org>,
 "Huang, Kai" <kai.huang@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240311071938.13247-1-sibs@chinatelecom.cn>
References: <20240311071938.13247-1-sibs@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171144336418.10875.2002917635921003194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     cd2236c2f49eb46443fd7573d0ddad5373577b11
Gitweb:        https://git.kernel.org/tip/cd2236c2f49eb46443fd7573d0ddad5373577b11
Author:        Bingsong Si <sibs@chinatelecom.cn>
AuthorDate:    Mon, 11 Mar 2024 15:19:37 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 09:49:32 +01:00

x86/cpu: Clear TME feature flag if TME is not enabled by BIOS

When TME is disabled by BIOS, the dmesg output is:

  x86/tme: not enabled by BIOS

.. and TME functionality is not enabled by the kernel, but the TME feature
is still shown in /proc/cpuinfo.

Clear it.

[ mingo: Clarified changelog ]

Signed-off-by: Bingsong Si <sibs@chinatelecom.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Huang, Kai" <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20240311071938.13247-1-sibs@chinatelecom.cn
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be30d7f..3c3e7e5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -228,6 +228,7 @@ static void detect_tme_early(struct cpuinfo_x86 *c)
 	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
+		clear_cpu_cap(c, X86_FEATURE_TME);
 		return;
 	}
 

