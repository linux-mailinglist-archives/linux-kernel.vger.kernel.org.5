Return-Path: <linux-kernel+bounces-147792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7298A79BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A881F23245
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EC46A4;
	Wed, 17 Apr 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFmPEmy9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA6184D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312916; cv=none; b=jgvt5OKkvhFZMTYMiXKp64rTUvk7/0Xv7vWYni8AE71DjToexE+p+0DSlMvhi4diiARyRyDlM59qydjzvkcQJyE7rorTJe0/cWfQLIj0WSmXTLbqfBzfKj28DXfJIi1yLgg5rEhJdtCbVdCeDkQ/k6v73DfwDLkFbJ2+rTsjMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312916; c=relaxed/simple;
	bh=0UVGRaaY/AaWE2yiYwE1iCIDluyE17+bs6H2PNq1AC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tepJV6wrfiKYyNi43sMBZE93UqZ++AwXxNLEpTxd6cSliAwTG3eotvyrLar8CNZSfdIzmGjusLvT+17n6RV2nphtd7SW4h7ty6e34TomJ5+j9txo+mLo5hV0Ouk1uoRG2zfhErmuMpqZ1u3xOd5kGhKPO0LGATdVH6FGAvM6q/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WFmPEmy9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a4fc4cf54dso5098997a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713312914; x=1713917714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5ofQ3KH15PkqJ9IroccuDO0HaegnEECNOZCgmKj3yJg=;
        b=WFmPEmy9VC08Mr25XlxHqie6e1vIwxqgWC2JZy8a1HKzRHV12FPLSq5+kU1b8SvE+r
         HnBRbGsEq6k10t6olld2vfD2/EhaKY5F+I6cqVxsI9GienONj+iO+w1jzsy0JqoJq81V
         UT0cDrIrPtaWrjj9GTpnzcCGMFHcLC+/HbcXeWhsrCnNEwAAIfOL7a/GD1Lxkj++jurS
         A+Tzb5AslvTCmxvHLZfQcQ9P1t3jLBeEH0gedC7oTIoF6fkWw1SSnDyQWLgtEv19F4s4
         2niVgkhkan+qLpjwdHPox9XoqVczMVf45kvAbBLu5Iq7uRm7ChXUyanWtNPBU7iLMRK2
         IlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713312914; x=1713917714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ofQ3KH15PkqJ9IroccuDO0HaegnEECNOZCgmKj3yJg=;
        b=xRaTUGpcwAnaB0bVmhcDrucYwm868Uc1mIGWu/DYGgPTXbal8Q/YGgWNyCAz1ag7Ip
         hvdkaDLfq9RhfNJOLhjOi74uMkXPEy8pmedLTXMnKu6BWl7yk0ozay+Qp94ap5oVAQGD
         4UjjaY7SE9vAhZFo5cQI4/ciugoG4nG7JaPr4rkRbWURE9Iqoaga+guBW/lrvk6zsOu7
         WCpon+SfyH6HeiBs+LuUGztEdnjroP/70+9X5ntT+B9RYnhTgHtoMZiYVQrFmWNDSJQ4
         zDDpe2nbHFFhazil+oSe6d1SDsOCd1zsLcX/mBvaHsQJiNUgLnTlTlN9O4gfl11dJogt
         LwJw==
X-Forwarded-Encrypted: i=1; AJvYcCXSgQ6+PSdXapV6oPvknQrZxT/y4ALwzxsJykFHQzkiUZhxaTq5ShGRlunU5eHs/m4/Op1U95wPLc8BLLeNzB1BFUQustabb5dhmbU3
X-Gm-Message-State: AOJu0YxsZkckmOk7kD3u3KgGAi/pJNVNQ/4B5RSuJy2m+OTrjXw7lMRA
	qQ1Zuc7P6w9aDizw/Oe3OBvQJK5wPZigSWw9VBiS1dKnvMHvZAevzqxvQyamd+ZWw5GU36QDeA2
	icg==
X-Google-Smtp-Source: AGHT+IF2DFS2VtgAyUhW0lsQ8B2jlSVOSsnmicyBH5IXA35vfEPayetT8/ucpiCo2V7UyBChWtpcbZH0q30=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3108:b0:2a5:c859:f94f with SMTP id
 gc8-20020a17090b310800b002a5c859f94fmr58452pjb.3.1713312913929; Tue, 16 Apr
 2024 17:15:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 16 Apr 2024 17:15:07 -0700
In-Reply-To: <20240417001507.2264512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417001507.2264512-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417001507.2264512-3-seanjc@google.com>
Subject: [PATCH 2/2] cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly disallow enabling mitigations at runtime for kernels that were
built with CONFIG_CPU_MITIGATIONS=n, which currently is possible only on
x86 (via x86's SPECULATION_MITIGATIONS menuconfig).

On x86, a large pile of Kconfigs are buried behind SPECULATION_MITIGATIONS,
and trying to provide sane behavior for retroactively enabling mitigations
is extremely difficult, bordering on impossible.  E.g. page table isolation
and call depth tracking requrie build-time support, BHI mitigations will
still be off without additional kernel parameters, etc.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                | 10 +++++++---
 kernel/cpu.c                                    |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..73cc672de9c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3423,6 +3423,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported on x86 if and only if
+			the kernel was built with SPECULATION_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a0eca6313276..3021976e34cf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2494,10 +2494,14 @@ menuconfig SPECULATION_MITIGATIONS
 	default y
 	help
 	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  speculative execution hardware vulnerabilities.  Mitigations can
+	  be disabled or restricted to SMT systems at runtime via the
+	  "mitigations" kernel parameter.
 
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 
 if SPECULATION_MITIGATIONS
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bb0ff275fb46..e3f2b34bb378 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3214,6 +3214,8 @@ static int __init mitigations_parse_cmdline(char *arg)
 {
 	if (!strcmp(arg, "off"))
 		cpu_mitigations = CPU_MITIGATIONS_OFF;
+	else if (!IS_ENABLED(CONFIG_CPU_MITIGATIONS))
+		pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
 	else if (!strcmp(arg, "auto"))
 		cpu_mitigations = CPU_MITIGATIONS_AUTO;
 	else if (!strcmp(arg, "auto,nosmt"))
-- 
2.44.0.683.g7961c838ac-goog


