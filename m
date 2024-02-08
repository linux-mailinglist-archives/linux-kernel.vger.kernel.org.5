Return-Path: <linux-kernel+bounces-58109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E384E160
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0077288AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF179956;
	Thu,  8 Feb 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hijtnYGI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqNpBAEo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4178675;
	Thu,  8 Feb 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397486; cv=none; b=nNfoabvtIGOh9c9h/D7Jezj0Z+2inVGrDKJHW3GYtGPvxKkzqmSo7sWFb6uZtto4y0U6RQjTZ553rY4wE3mT669TmcxiHFHoeq11DY2Iq/PoPnHqIG6aCVQEef5djKal8O42M4xys4khZNTjUXcMo/XTUJHm6kbG1cqndDVz1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397486; c=relaxed/simple;
	bh=zD2hAS9rFCsvLHQ7O5g+Y8FQqGWZOYZTZSVmQS3E41k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RDbcn8kqy5puEp8NKC2/n/MkUai7Ct/78nOM610r7a4W8ZJJM1drCFfddpccoH2UB//6HbBB3/zf+6nCLg+r1xk921S7dCh4v3ASX+qcu7BU2RvE9bqZI3CZGD08GCUcQZbgrd1FITiVjBsaqqMUsp5jGkH7qhVJdZ/1BfreIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hijtnYGI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqNpBAEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Feb 2024 13:04:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707397482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU8Czi4uoNaAF5ZiLqTmJVk8S6mrBMl8Jdh0PpJc20k=;
	b=hijtnYGI9XkBEhO01UElvN4KSZ/0pY4usSGwTcs+d5vuhy2nwAAg9cH535fH7vSqgcnYPs
	4QhMw01tJ3ljn4Ut0+l1UQtW35gdRmsFgUgkQdpTzFkkaAfoeuLHNV4eQD+e8SbPL7XOoz
	6GtHzAg2BuJNNAOvqIB9FXtoFe/I5sKX8oK6IHe0a6vVexScO1ueT1qBULVh95TpV95IK3
	lFST4bC7r/f4pSANthr6Dt/NiFPU0+rJ2ne48Pl6KQhSpT5/2VPlcuQOymCVladcLQxp8W
	GsXOyJ7t2CFV3T4rxl3DomRxBRBqk1f1V8EuBAsbOClE7h+LUgF6gZ/MU/ygiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707397482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EU8Czi4uoNaAF5ZiLqTmJVk8S6mrBMl8Jdh0PpJc20k=;
	b=PqNpBAEoumW8Qj1LII2KBJRN+UGxjSBWpt8CWYHsHXnEgCiSQ05U8ziiQxi0PZRKQ7cDJK
	ahwKXx+pupkRdCDg==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Consolidate targets and clean-files
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121235701.239606-2-masahiroy@kernel.org>
References: <20231121235701.239606-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170739748154.398.15079300167705030498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     31a4ebee0d16a141b18730977963d0e7290b9bd2
Gitweb:        https://git.kernel.org/tip/31a4ebee0d16a141b18730977963d0e7290b9bd2
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 22 Nov 2023 08:56:58 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 08 Feb 2024 13:15:41 +01:00

x86/vdso: Consolidate targets and clean-files

'targets' and 'clean-files' do not need to list the same files because
the files listed in 'targets' are cleaned up.

Refactor the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231121235701.239606-2-masahiroy@kernel.org
---
 arch/x86/entry/vdso/Makefile | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1..2038d9c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -55,11 +55,8 @@ targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
-vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
 obj-y += $(vdso_img_objs)
-targets += $(vdso_img_cfiles)
-targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
+targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
 
@@ -190,5 +187,3 @@ GCOV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
-
-clean-files := vdso32.so vdso32.so.dbg vdso64* vdso-image-*.c vdsox32.so*

