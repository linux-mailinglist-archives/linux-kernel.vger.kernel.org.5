Return-Path: <linux-kernel+bounces-42569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D7840335
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8B2B22B49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F55821B;
	Mon, 29 Jan 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dia79f7t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpOamZLE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B935810D;
	Mon, 29 Jan 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525450; cv=none; b=GavFuotwvrAG9wUIvhXWM9DH6nRmSswT7dQ1pW6nVjOZtNrajJzQEm8tzuq1ZhVcHPm7QmT+lUJ6gZxmS+EDwqUGit9c0vf01vxTaiOanuNJtPn1+ZIdrkUlmrnWMgepD0rDU65CmrXyHDXt51CYC28uhr1ABS6WDXz41h9MMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525450; c=relaxed/simple;
	bh=W/bFJTnHsEGR4cCFLWzVQay1Nw506nMdbBNrQzZUyTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z/F0ghZOcpO/Gs5h8oGJaZ8hMmmTcpOYLsozxGBYVhDNIPWgRVofD7/TagyR4bLIs7T/StM50PMk1rLB3r1DU5aMuBJxbrXwNhqqq/uzoU5veGawzRYkbl9bX5aW2dmHGpkJHGU2AlFaVWK/FpjhqrPTRUC/m74y6MW2yKLvthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dia79f7t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpOamZLE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jan 2024 10:50:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706525446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffkKSYcj75lGpOSBioIHErCcbl/NbswiwLRlbhSqyfc=;
	b=Dia79f7t4/Z6EPDPrbBNr5G9SfMDcyLIhXzBaDNi6EC5uiZpcji4myoa1QhOKUbN6546IE
	OVLI4upQKbVJh6c3G7v7MquelV1h7dRsdmQmpOSI9sYC6d0DDGoELWpPYEhULhQJ7CQkgL
	qarTjoqfqxQ5f2PRmW1PFwnnJzvZwGT0Bm9Of3H/8RTmRbfWWRKRk5cu4tHxeI7hVyxGXG
	IB456gcWORRZWuP8uFExGAyJxQD79ZDP3QI64J8mkQLvdKaBjNfDmgj0g2bnSwW3li9/Ec
	I47X7T0h074vaz2NvFyUdztSFAFvj3ZQcpuqP1U9vKIvwoSgRslasw2Uvkk5LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706525446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffkKSYcj75lGpOSBioIHErCcbl/NbswiwLRlbhSqyfc=;
	b=IpOamZLE0qkraJnxLbYt+k3PwFyLjj91kiUzREuk4+y38t/EvPXP6zwBBF+vSLKDpTXq9e
	3/3OUHcefx/oCzBQ==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/lib: Revert to _ASM_EXTABLE_UA() for
 {get,put}_user() fixups
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240129063842.61584-1-qiuxu.zhuo@intel.com>
References: <20240129063842.61584-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170652544552.398.565528579108985833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8eed4e00a370b37b4e5985ed983dccedd555ea9d
Gitweb:        https://git.kernel.org/tip/8eed4e00a370b37b4e5985ed983dccedd555ea9d
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Mon, 29 Jan 2024 14:38:42 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 11:40:41 +01:00

x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

During memory error injection test on kernels >= v6.4, the kernel panics
like below. However, this issue couldn't be reproduced on kernels <= v6.3.

  mce: [Hardware Error]: CPU 296: Machine Check Exception: f Bank 1: bd80000000100134
  mce: [Hardware Error]: RIP 10:<ffffffff821b9776> {__get_user_nocheck_4+0x6/0x20}
  mce: [Hardware Error]: TSC 411a93533ed ADDR 346a8730040 MISC 86
  mce: [Hardware Error]: PROCESSOR 0:a06d0 TIME 1706000767 SOCKET 1 APIC 211 microcode 80001490
  mce: [Hardware Error]: Run the above through 'mcelog --ascii'
  mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
  Kernel panic - not syncing: Fatal local machine check

The MCA code can recover from an in-kernel #MC if the fixup type is
EX_TYPE_UACCESS, explicitly indicating that the kernel is attempting to
access userspace memory. However, if the fixup type is EX_TYPE_DEFAULT
the only thing that is raised for an in-kernel #MC is a panic.

ex_handler_uaccess() would warn if users gave a non-canonical addresses
(with bit 63 clear) to {get, put}_user(), which was unexpected.

Therefore, commit

  b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")

replaced _ASM_EXTABLE_UA() with _ASM_EXTABLE() for {get, put}_user()
fixups. However, the new fixup type EX_TYPE_DEFAULT results in a panic.

Commit

  6014bc27561f ("x86-64: make access_ok() independent of LAM")

added the check gp_fault_address_ok() right before the WARN_ONCE() in
ex_handler_uaccess() to not warn about non-canonical user addresses due
to LAM.

With that in place, revert back to _ASM_EXTABLE_UA() for {get,put}_user()
exception fixups in order to be able to handle in-kernel MCEs correctly
again.

  [ bp: Massage commit message. ]

Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240129063842.61584-1-qiuxu.zhuo@intel.com
---
 arch/x86/lib/getuser.S | 24 ++++++++++++------------
 arch/x86/lib/putuser.S | 20 ++++++++++----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 20ef350..10d5ed8 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -163,23 +163,23 @@ SYM_CODE_END(__get_user_8_handle_exception)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE(1b, __get_user_handle_exception)
-	_ASM_EXTABLE(2b, __get_user_handle_exception)
-	_ASM_EXTABLE(3b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(4b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(5b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(5b, __get_user_8_handle_exception)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE(6b, __get_user_handle_exception)
-	_ASM_EXTABLE(7b, __get_user_handle_exception)
-	_ASM_EXTABLE(8b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(9b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(9b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(10b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(10b, __get_user_8_handle_exception)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 2877f59..975c9c1 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -133,15 +133,15 @@ SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	RET
 SYM_CODE_END(__put_user_handle_exception)
 
-	_ASM_EXTABLE(1b, __put_user_handle_exception)
-	_ASM_EXTABLE(2b, __put_user_handle_exception)
-	_ASM_EXTABLE(3b, __put_user_handle_exception)
-	_ASM_EXTABLE(4b, __put_user_handle_exception)
-	_ASM_EXTABLE(5b, __put_user_handle_exception)
-	_ASM_EXTABLE(6b, __put_user_handle_exception)
-	_ASM_EXTABLE(7b, __put_user_handle_exception)
-	_ASM_EXTABLE(9b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(5b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(8b, __put_user_handle_exception)
-	_ASM_EXTABLE(10b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(10b, __put_user_handle_exception)
 #endif

