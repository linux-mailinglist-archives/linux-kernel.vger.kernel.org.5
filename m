Return-Path: <linux-kernel+bounces-58107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4B84E15C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61100B281DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BC78B42;
	Thu,  8 Feb 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uF4iIl+N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="665aNmhI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAB76C65;
	Thu,  8 Feb 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397483; cv=none; b=bxVIFyESqAMmKFjzvui3jBK0zb4KUd9/cm/MRGyGJsnKW/hIHZb8DmbGmbpfGdLwh/GMldKT3ESN8Crpbmqd1XheKxtamB0AUWBIp6Da6ws6HO0do2zAvIK/Z9Nftr3TJrvX0+ImlhK6RPukFX0bLlLT6b0RGPgquDTN75ncPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397483; c=relaxed/simple;
	bh=9C+h3t0wM818FscYQmrwPqmLL19g9wTuM7dgIM9JHDw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tzVXbKRdYAPjU96kAr0uqpB5txE/XziAAhamwYhnNnV4ZAq+ZCGJXb+IT7FodIL3FkWthe1Boq24LwrsnbSftciTcN2fMJTmDOBCYe9bLc1VUqwxawH8XZwgy6DlZBrh8BMJDW/CmVzkubVXiln3SPpec+ULIihMiMTVuIkWRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uF4iIl+N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=665aNmhI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Feb 2024 13:04:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707397480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItrhzjXgrU37HoKwRFwkN3cl4RKFDsKe3ioFh/KQiRs=;
	b=uF4iIl+NKsHpumQ3DS5O91pPm6O9FM4DEoncYqm7F5v+BblAAQz4cWtNcdQjKJU9cdS7ue
	AhasJmHE3dLKs8WJAZ345YZsnKsbXyJFJUoybO2+Fil9WgLt2zIDyIaHmk/8M5ERA7j+ZV
	0hf0NjvzhpSH7yBhBKEb2mPIDtdged6JyOMrOKzFZbm4ckxUEjY3+u0cAsqFvVd92GjZ6V
	6vJOzIBMpcKylz+UPBI9ZZTiTR/SVuxDdqS9Bv/ql/PQqGQl7tNnivZvNpUAOPdoxgwQYF
	5TWwZbsTj//C7NpJeZ8iSfPbfmGXcSAJOnEM1MHws1T4oK+9zjCCoAwrUrizEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707397480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItrhzjXgrU37HoKwRFwkN3cl4RKFDsKe3ioFh/KQiRs=;
	b=665aNmhIgB6uPCjY5YGxPO/r63U4wQwpoK1UWmS1gc1NBkMUsgRpRaBUr0U1GTLgCPN33n
	cRAoMRcA8YyeqcCA==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Use $(addprefix ) instead of $(foreach )
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121235701.239606-4-masahiroy@kernel.org>
References: <20231121235701.239606-4-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170739747989.398.8335577123809642415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     ac9275b3b4dd11a1c825071b9dbaf7614a399c89
Gitweb:        https://git.kernel.org/tip/ac9275b3b4dd11a1c825071b9dbaf7614a399c89
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 22 Nov 2023 08:57:00 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 08 Feb 2024 13:23:01 +01:00

x86/vdso: Use $(addprefix ) instead of $(foreach )

$(addprefix ) is slightly shorter and more intuitive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231121235701.239606-4-masahiroy@kernel.org
---
 arch/x86/entry/vdso/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index cbfb5aa..439b527 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -40,8 +40,8 @@ obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
 
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
-vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
-vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
+vobjs := $(addprefix $(obj)/, $(vobjs-y))
+vobjs32 := $(addprefix $(obj)/, $(vobjs32-y))
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
@@ -112,7 +112,7 @@ VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
 
 # same thing, but in the output directory
-vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
+vobjx32s := $(addprefix $(obj)/, $(vobjx32s-y))
 
 # Convert 64bit object file to x32 for x32 vDSO.
 quiet_cmd_x32 = X32     $@

