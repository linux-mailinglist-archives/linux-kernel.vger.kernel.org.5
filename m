Return-Path: <linux-kernel+bounces-68826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9158580BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E92D1C21B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52F1482E9;
	Fri, 16 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ncVgyyRB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qY/YY+eU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82B1468E0;
	Fri, 16 Feb 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096638; cv=none; b=qIUc7mbxBvVSLxaMmoWzm/MLyQbyLkw1wZfmkeFbkFiI4rqsgB80GUaU+VEtU7OrAAQpfjPdquXpR+jjhM1fttcbCUsayBAKgjv/ShvBc2ShltVNNEY44LGHvNDY98tKXzFDarKQKrk+JZIiRLwpkEEV4CvJe1nf5JPBZLH0QnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096638; c=relaxed/simple;
	bh=LgmqsFVYDLPKU2mGo+sXS/WNK228bWXA5+BAO+nbEcQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y+YvWWcujitq1LWXSm9kENnfDAei2wn+0HAFfz8/hJ3y5LmJf7P6trQwUi+fBfFNXgFr9cyFyTLXi6kpnLMPzQXaF32PE7VtaFWIRVFqj5tk6Woid9dPi+XpkDpbJ2Y9POaL2KmgWzScTv6CRSWCQ8wqN9GE6pFvPkbfeoxl4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ncVgyyRB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qY/YY+eU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwCoe0KOv631+89TBjbCyYTq51enKo1mEUrZUtr7kmw=;
	b=ncVgyyRBW2TlW7RQD7TMM72iC81WC7S9VIm2Wxqa/XroqOG4ilQ650laeI6IDINdz2YTq1
	KTf7eXwwM8mbZMkQJjt+pIFYsdZoJDbLbmVVq7uO0indz32eEYTpaecamP4CWk17adQylS
	TUjELkoKCoWwpa1NnVcTrIgWFZGakSK2caR3UuSdTBOeRUlLtIEfXgx7fhk81uORU7VGem
	pJ9uGgr9qb71e/ykgZWHKqlNEYoAr1KoORabMGUl2TOd+O8WB/+Ae3WamZbfChjkSpw2t4
	KtDz1wqbP/7v/EF3T9067cDxVHl0MU6vdpSI+Z2ajtvD4irPlFCrZTAqCJyIqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TwCoe0KOv631+89TBjbCyYTq51enKo1mEUrZUtr7kmw=;
	b=qY/YY+eUsxp+FMWZ45EvS5ht/mXFleaSgaXkSHYjmPerF8Zum2O8lNam9lj9G3OxOLh62q
	g13sZUurxAvS2cCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/hyperv/vtl: Prepare for separate mpparse callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.808238769@linutronix.de>
References: <20240212154639.808238769@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663415.398.9214649384592672164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c22e19cd2c8a8f8ef8cfc0a0aaaa95d8cc064309
Gitweb:        https://git.kernel.org/tip/c22e19cd2c8a8f8ef8cfc0a0aaaa95d8cc064309
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/hyperv/vtl: Prepare for separate mpparse callbacks

Initialize the new callbacks in preparation for switching the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.808238769@linutronix.de


---
 arch/x86/hyperv/hv_vtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 96e6c51..f573cac 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -26,7 +26,9 @@ void __init hv_vtl_init_platform(void)
 	x86_init.timers.timer_init = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 
 	x86_platform.get_wallclock = get_rtc_noop;

