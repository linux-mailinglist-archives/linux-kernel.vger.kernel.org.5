Return-Path: <linux-kernel+bounces-110583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805FD8860EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E99E1F23C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99E134402;
	Thu, 21 Mar 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f/thp/5F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1iv8jqh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B7613341A;
	Thu, 21 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048861; cv=none; b=KrlpuB/dV5Pp9CkSQZa4Ct9F7UpY9QX/A3nwxUX4nRcOZ8jp81cdAEO83kdGVjmFIVCIaebM367o4Pib5KO/cFLkoDhBcIRrEOhhjmar+kvFFPTECnvb04IpV/NEd/PkPykz0mcnsEOMwzeZKxUMsZKetSPjWcQULh9PcGV0IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048861; c=relaxed/simple;
	bh=atXL0Gjof7O2+DckvspFpzkt0LG8lU6zn8MpAKBl8hI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mu6+PDjQcbs+XBFM0RRv9MjZwmayB7gtFmO6L4USwsev4+LFvqURq1fSzhsF2I/U+gcWumHg8gEUCmwUVMg3eMZixX5+Qm+LzRKlJcoS+jRizOGvMam1qJbgwrMq1tYakvjTO/pTF4dtcr8G3ORGfrp7kPy/i4GS2YYxira0Cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f/thp/5F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1iv8jqh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 19:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711048857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewl+E6trDEwiIkwR4RjKfDmS2foWpVfS4m+Kh4nbms0=;
	b=f/thp/5Fw6NuwC6VJS1psi1LPUgl2V3rTvi5UCXJUG29/jhfsmHXEtEDK1BTiZ9b9Ct5X/
	hCHb+e11hR2ViOKIogDQKs+b8I/A4gmU4hZkmJrBg4v/ke7YgAc+E6Ar3k4WMuYq4SI+dG
	3h3pFe8ruiqSdch1Pzk8k0Jm5zTAaUPnud95n2ggxRwzpax9egTM10nGYYk+rXtBupNvWo
	qP8T5+80w+OlDKyB+qMpbPfcTqvaKUAOiX5Xh8iX1nr2ay5T7kKoa8JSQpmvPKtGUMBP8c
	nMKfd/s/osWPkFrOZrpEAJ31kK1fgX72Yqs1Ez8NrnOC1FOEg841nkVweGpwpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711048857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewl+E6trDEwiIkwR4RjKfDmS2foWpVfS4m+Kh4nbms0=;
	b=c1iv8jqhe2CnbBH6iKh4tprScOMggH2LG1oyozYS/4kj4bgQ8qUF0uhnfT+qvptnLgWWVd
	oeiM17wvG6OVjbBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/percpu] x86/percpu: Enable named address spaces for GCC 9.1+
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240321164647.289879-1-ubizjak@gmail.com>
References: <20240321164647.289879-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171104885594.10875.6089335444765928119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     b429eafe0d9f765d8626e53221ce3108b783da5e
Gitweb:        https://git.kernel.org/tip/b429eafe0d9f765d8626e53221ce3108b783da5e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 21 Mar 2024 17:46:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:16:20 +01:00

x86/percpu: Enable named address spaces for GCC 9.1+

Enable named address spaces also for GCC 9, GCC 10 and GCC 11
releases. These compilers all produce kernel images that boot
without problems.

GCC_VERSION cutoff is arbitrary. It is primary a risk-reduction
cutoff, older compilers will be tested and enabled in linux 6.10
release.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240321164647.289879-1-ubizjak@gmail.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 09455d9..03c9d11 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,7 +2433,7 @@ source "kernel/livepatch/Kconfig"
 endmenu
 
 config CC_HAS_NAMED_AS
-	def_bool CC_IS_GCC && GCC_VERSION >= 120100
+	def_bool CC_IS_GCC && GCC_VERSION >= 90100
 
 config CC_HAS_NAMED_AS_FIXED_ASAN
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300

