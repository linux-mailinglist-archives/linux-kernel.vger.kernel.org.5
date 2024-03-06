Return-Path: <linux-kernel+bounces-93620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E12873270
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B35F292767
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7F5DF0C;
	Wed,  6 Mar 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mr6q31YU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpZybAFY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AD5D91F;
	Wed,  6 Mar 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716981; cv=none; b=BpQdLwV3lTqhqPNtJRZofbQmX+FwTRzgby/EfyLsFyfGNNnpD/e4gjbeFVIItK05GmWW2u0ewUbuaypVHeQk7rOaeVR1dgpsZKimuIFLeg22k9NhwMuLVZ+UIsB1npR/pkDAGXKpP0U+WxDMtWr3hTDlrcruuViFg2ZA4jzSxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716981; c=relaxed/simple;
	bh=ZoZAFpnXAIJuXfD4zTp2dyuISQoKk0qGZNiwVZw73xE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s0vE3rjPc/7RHanFfolduu/ZqR4jYy2LQVUKLmp9Jp+GTezFGgDGysxThv2FUMzR+XmycngLaFysyvWHye6wxCoVXC3qnoyrh7fO+Vbhq1zgcTFb+aocjTcRzawoRlcEBrcSdflil6qxiVKr5wYBmFBrk1aQxxkPiq2HqAfbLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mr6q31YU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpZybAFY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Mar 2024 09:22:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709716974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCbaMdXFmHvzM3rg9VFcTTzEusauzL0ySMi6yjcgNhQ=;
	b=Mr6q31YUxAlWI1xfEA8qHGjraDb77P2KCjJOmq8QyqrOWGCAJD9X1ONfP813NbA/uEmyfN
	XIaxgKdJCxa68DtaBqgf5pEBXTOjke5eg4rIJztEd8JpY5gfBRSBVF7mPlS6PcxW2y6rqh
	4lzBo2eJr+7Q6Zgzxx2WbIwjJoMfi1N1gj8vio5TRMWraolyOsPG4AixK2HkkH0bRf0No0
	tShNDJteXFU1liJCiNPzD8C4przWc+tpoiI1yjDtZc2aW35m8B6hcpeB3FjFXR8UOczaYi
	7kz/bEI/vF2FE88pE9p106PwGjApJb5F95fM5VQwZ3bp+Vvw9iBSIHTS1ueruw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709716974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCbaMdXFmHvzM3rg9VFcTTzEusauzL0ySMi6yjcgNhQ=;
	b=SpZybAFYk7aRKDh/5FSvT/APR7fGyl8+aiEake9f8gbylwNYUmzbCTWWfa3qXw2GWx2W3N
	xLewN1lhLdHZqEDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/nmi: Drop unused declaration of proc_nmi_enabled()
Cc: linux@weissschuh.net, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240306-const-sysctl-prep-x86-v1-1-f9d1fa38dd2b@weissschuh.net>
References: <20240306-const-sysctl-prep-x86-v1-1-f9d1fa38dd2b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170971697378.398.205017146158091581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     774a86f1c885460ade4334b901919fa1d8ae6ec6
Gitweb:        https://git.kernel.org/tip/774a86f1c885460ade4334b901919fa1d8a=
e6ec6
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Wed, 06 Mar 2024 07:50:29 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 06 Mar 2024 10:13:33 +01:00

x86/nmi: Drop unused declaration of proc_nmi_enabled()

The declaration is unused as the definition got deleted.

Fixes: 5f2b0ba4d94b ("x86, nmi_watchdog: Remove the old nmi_watchdog").
Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240306-const-sysctl-prep-x86-v1-1-f9d1fa38d=
d2b@weissschuh.net
---
 arch/x86/include/asm/nmi.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 5c5f1e5..41a0ebb 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -14,9 +14,6 @@ extern void release_perfctr_nmi(unsigned int);
 extern int reserve_evntsel_nmi(unsigned int);
 extern void release_evntsel_nmi(unsigned int);
=20
-struct ctl_table;
-extern int proc_nmi_enabled(struct ctl_table *, int ,
-			void __user *, size_t *, loff_t *);
 extern int unknown_nmi_panic;
=20
 #endif /* CONFIG_X86_LOCAL_APIC */

