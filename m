Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4746792698
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjIEQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354169AbjIEKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:02:52 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85E1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:02:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bd0d19a304so37580741fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693908167; x=1694512967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYGR7uuW7UPI/w9fw3s9+lxIPdVOpDrXZDwG9etXioU=;
        b=Haxyrdl6Ja8pSyKeaU7BzL/UQu1328QkRXuse0icojx1BQ/sDNKsN2cM/jJRIvZ0SO
         xuR6MFk36R/2kxr+iUEKqUtPyZJhZxR7d+JhW657+MtNWbhAzglLkOUMIG505gv5hseP
         O+6kL/ru+Z8fblrDPIDoyeFkox3n2UX/tYNBVbdhRgIJB5PhWcRFTyYXoOMynF03ljSK
         G8sJW+fLwgLGCLt0Sdc7rnNJqrtedk7jnQ1oASKUBYvM8iRGkxzXJsBzDc2/174ga8Dr
         0INyPBvBbBzNXqCByYJUv0EOq8gh3jO6WHP/NtQ5WduBfeuKzssQlf0W6CFIz7+jyGVv
         gLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908167; x=1694512967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYGR7uuW7UPI/w9fw3s9+lxIPdVOpDrXZDwG9etXioU=;
        b=ESnvSgQKBVN+rHpZxPDXLzKV6KibvS+Cr1VG3zR9EuyefvXO4os/OvzEPEcnj+lq/i
         51H/gzZf2aYWWF88nk4Nu28cb2dVzBd6upX+u2GZ0quyxpynF1N7ns7TR/G41GSicQqW
         F5v4Ly5dulDp3eJJngCesdcSANCl/i50wTZ5Cw8fRuQIRmWd2aUWbLc/2SD+uEVBBOTw
         +7J40uPzA+YLOfgdiH1BSs8sCUNrrcLWtMfxGj2qK8JBOO1cL/akgZs29ff0yBgP5RSC
         pMI7RqAnlSwzjAuDcjSagtkd0hRCg4GSp3qzSZifedSWoIg6P06e/tqmdQlwB56eTxcf
         H1Lw==
X-Gm-Message-State: AOJu0Yw1hpfzxNUC+Hik1v2dASDI0MMeR3N9XM3j9gzeCU2qDca1h4hX
        PIZV/DyBSAq4vU45M/1tESQ=
X-Google-Smtp-Source: AGHT+IH+P+hWUsphZuKUjHUJDujAPScoPnEWatQST0MiWhn9PBSSf3QaOBbgHUHZ5qfM8xPNsIvIxA==
X-Received: by 2002:a05:651c:236:b0:2bd:16e6:e34a with SMTP id z22-20020a05651c023600b002bd16e6e34amr8805725ljn.19.1693908166895;
        Tue, 05 Sep 2023 03:02:46 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00317df42e91dsm17159880wrr.4.2023.09.05.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 03:02:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 5 Sep 2023 12:02:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 00/20] SRSO fixes/cleanups
Message-ID: <ZPb8we3RAespXmXI@gmail.com>
References: <cover.1693889988.git.jpoimboe@kernel.org>
 <20230905063550.GAZPbMRuLizPxmRuHF@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905063550.GAZPbMRuLizPxmRuHF@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Sep 04, 2023 at 10:04:44PM -0700, Josh Poimboeuf wrote:
> > v3:
> > - drop kvm patches (to be picked up by Sean)
> > - fix "no microcode, no microcode" printk
> > - fix "Safe Ret" capitalization in documentation
> > - fix chopped line in commit log
> > - drop "x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check" patch
> > 
> > Josh Poimboeuf (20):
> >   x86/srso: Fix srso_show_state() side effect
> >   x86/srso: Set CPUID feature bits independently of bug or mitigation
> >     status
> >   x86/srso: Don't probe microcode in a guest
> >   x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
> >   x86/srso: Fix SBPB enablement for (possible) future fixed HW
> >   x86/srso: Print actual mitigation if requested mitigation isn't
> >     possible
> >   x86/srso: Print mitigation for retbleed IBPB case
> >   x86/srso: Fix vulnerability reporting for missing microcode
> >   x86/srso: Fix unret validation dependencies
> >   x86/alternatives: Remove faulty optimization
> >   x86/srso: Improve i-cache locality for alias mitigation
> >   x86/srso: Unexport untraining functions
> >   x86/srso: Remove 'pred_cmd' label
> >   x86/bugs: Remove default case for fully switched enums
> >   x86/srso: Move retbleed IBPB check into existing 'has_microcode' code
> >     block
> >   x86/srso: Disentangle rethunk-dependent options
> >   x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
> >   x86/retpoline: Remove .text..__x86.return_thunk section
> >   x86/nospec: Refactor UNTRAIN_RET[_*]
> >   x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()
> > 
> >  Documentation/admin-guide/hw-vuln/srso.rst |  24 ++-
> >  arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
> >  arch/x86/include/asm/processor.h           |   2 -
> >  arch/x86/kernel/alternative.c              |   8 -
> >  arch/x86/kernel/cpu/amd.c                  |  28 ++--
> >  arch/x86/kernel/cpu/bugs.c                 | 102 ++++++------
> >  arch/x86/kernel/vmlinux.lds.S              |  10 +-
> >  arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
> >  include/linux/objtool.h                    |   3 +-
> >  scripts/Makefile.vmlinux_o                 |   3 +-
> >  10 files changed, 201 insertions(+), 219 deletions(-)
> 
> They all look good to me, thanks!
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

I've applied them to tip:x86/bugs, thanks guys!

Below is the delta diff from v2 to v3.

Thanks,

	Ingo

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 4516719e00b5..e715bfc09879 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -57,7 +57,7 @@ The possible values in this file are:
 
  * 'Vulnerable: Safe RET, no microcode':
 
-   The "Safe Ret" mitigation (see below) has been applied to protect the
+   The "Safe RET" mitigation (see below) has been applied to protect the
    kernel, but the IBPB-extending microcode has not been applied.  User
    space tasks may still be vulnerable.
 
@@ -139,7 +139,7 @@ an indrect branch prediction barrier after having applied the required
 microcode patch for one's system. This mitigation comes also at
 a performance cost.
 
-Mitigation: safe RET
+Mitigation: Safe RET
 --------------------
 
 The mitigation works by ensuring all RET instructions speculate to
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d538043c776d..016a32613259 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2494,7 +2494,7 @@ static void __init srso_select_mitigation(void)
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
 		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (has_microcode) {
+			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			}
@@ -2505,7 +2505,7 @@ static void __init srso_select_mitigation(void)
 	}
 
 out:
-	pr_info("%s%s\n", srso_strings[srso_mitigation], has_microcode ? "" : ", no microcode");
+	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 #undef pr_fmt
