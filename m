Return-Path: <linux-kernel+bounces-108948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BF88125F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14681B242C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53B4120C;
	Wed, 20 Mar 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxXmnk+1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsvWO/0c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632340BE2;
	Wed, 20 Mar 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941631; cv=none; b=jcv8Cmj5cirdumJWzzEdRxxEnZ8yyzFR5V3vIjj7TYKbBGupC8fSZo5AZGaAW+WTNRmVR4GU3709npoJ3p18Kms2OFG8HL04ljCvXwFpFQAxpJ55Ilz7aQQEMLGyWIPdwJgLck2Xd0p/ycN92FMkL9FU8H4pelTATw2qkgyLFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941631; c=relaxed/simple;
	bh=GDiJZ38CTJw7wnpOWIhwLFBfLixZL6WvagrpsS+vtAI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rTiYRxmgKODDjsIXFFmlcDtRsLH71yu1nw2IvOt2Lc4V2Is73fG7EWQAbHzS73AhQnG5OpWb9Citd5Qp2Fw+ka+kSy2v3CZ9wcIr0G16Fxbpjx9hsCoa41nML/0lPbMYxnXJq7KCc0Mg/iHBClT8JRFsEuNXIFtXqBZ6zS315tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxXmnk+1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsvWO/0c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Mar 2024 13:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710941627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex8bou4kB+2rtEdHnDeTFtmRS71UnWOZIqNtXLmn0Go=;
	b=GxXmnk+1VW3z+FpUrBibncFBWi9rlnubpnOlFnuDdW4w8fLnE1q3ZWdgRd4lgCpVjeb1z5
	iNbOQxaq1XGaeBXsVg6XGRPf+L1gsu4Mcg+p6DXaTGfJ0svrXr/xEUeIrb78QeZNxFlxsP
	5x2etzBWQnLV/20frZF4hVC1lpjeIMv1Qdjh0SobFrNKK95THt2K4Xy02o4M/bkFgcH+dx
	E455cSf8QHEvovyQuIPp5Lg1jsOsbsi8UIvv9ebGfDEJpfXChRedSODLMisnEp8fbiaCOR
	Dnk+NwJ77/RoO5jfSEYoBMHZt9QPjh9gxTGbAC5uR7GdMoGo6V/PNABktKEnLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710941627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex8bou4kB+2rtEdHnDeTFtmRS71UnWOZIqNtXLmn0Go=;
	b=vsvWO/0cXamxFoVFVXmw5hRpskPf+D6qzK1iqzRL9m+WPD0rqliWSoKLb6vC5qCXFqVyTq
	D9jJXGMVmBxVs4Aw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Re-enable named address spaces with
 KASAN for GCC 13.3+
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, Jakub Jelinek <jakub@redhat.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240320124603.566923-1-ubizjak@gmail.com>
References: <20240320124603.566923-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171094162686.10875.4624002937424858657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     f61f02d1ff788ae5ad485ef8edd88d9c93557994
Gitweb:        https://git.kernel.org/tip/f61f02d1ff788ae5ad485ef8edd88d9c93557994
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 20 Mar 2024 13:45:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Mar 2024 14:22:56 +01:00

x86/percpu: Re-enable named address spaces with KASAN for GCC 13.3+

Commit:

  68fb3ca0e408 ("x86/percpu: Disable named address spaces for KASAN")

.. disabled support for named address spaces with KASAN due to
the incompatibility issue between named AS and KASAN.

GCC 13.3 has fixed this issue (GCC PR sanitizer/111736) so the
support for named address spaces can be re-enabled with KASAN
for GCC compiler version >= 13.3.

Note that the patch considers GCC 14 to be fixed - if somebody is
using snapshots of the GCC 14 before the fix, they should upgrade.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20240320124603.566923-1-ubizjak@gmail.com
---
 arch/x86/Kconfig |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aed87c..09455d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2435,14 +2435,17 @@ endmenu
 config CC_HAS_NAMED_AS
 	def_bool CC_IS_GCC && GCC_VERSION >= 120100
 
+config CC_HAS_NAMED_AS_FIXED_ASAN
+	def_bool CC_IS_GCC && GCC_VERSION >= 130300
+
 config USE_X86_SEG_SUPPORT
 	def_bool y
 	depends on CC_HAS_NAMED_AS
 	#
-	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
-	# with named address spaces - see GCC PR sanitizer/111736.
+	# -fsanitize=kernel-address (KASAN) is incompatible with named
+	# address spaces with GCC < 13.3 - see GCC PR sanitizer/111736.
 	#
-	depends on !KASAN
+	depends on !KASAN || CC_HAS_NAMED_AS_FIXED_ASAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)

