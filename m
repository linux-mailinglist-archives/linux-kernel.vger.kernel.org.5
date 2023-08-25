Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FF788512
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbjHYKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjHYKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:39:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE5010F3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:38:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so90899566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959937; x=1693564737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Pr6mOTEETUqosKsJ5fgTHRRR+q1VEncin3/WqSmfRk=;
        b=fCamgT/fodMELjy6D2+2dpkiL7HArK1oFN+maIlgh3KXOh/Ztgw6gazAonDDm4pdxr
         dDkUQIgNQ2vP+w1wz0iGH1crs98HngJIQc1jiAu68yUetZ7i21NYo6b7oWFpmDs2Wxmr
         elbWZALCq+JfWuEosUA1qpv0M+NZAMqkD7oQ1VkUe8gtoSxK4O4IKpeYl+DMWEk0nDmy
         Sik+WRCxsC0CKe84z2skLRGQxMXZfGat4l2F2vyT+np2JY02DwTr1spHt1yYoZ9IGJcv
         S8LSaarau796gJPtAA6/I1Qn0yvjw2QRgYmrrUYCIKfT74K2oiBWLcp7VAkilyEHiOLE
         8u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959937; x=1693564737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pr6mOTEETUqosKsJ5fgTHRRR+q1VEncin3/WqSmfRk=;
        b=NnLb0lAeOM45xBOdo7AIfw1e0LlKlYt+4/NyWLQb6Zvm+fhOYxDgrxDQ6pbmzcC1ko
         9z5Voe2cj6tWP+Frw2cO20FLdm5UfKx3DBkrrdfEJdsKe4RfoqjKBO0sDm6fwbdxcAGY
         JYss7VG99FBhw4cVq+k2U+YSDTFzuH13OEAhkBZvs/Kr3bbobPmDI7rR+WTMscW419G2
         K47h1PfzO8R11pRLo+PMk7poqwZzSDIEwWA7VoBXrhDmsU/8LjThC+h/C0/GW3TRKH47
         AlkD3DTA1oMGXjmCa0of4/DeRqieZ+BYcrZ2crWWCQPrYmk/qwTN6ySq9JBH0PAaMib/
         58JQ==
X-Gm-Message-State: AOJu0Yy3mN9KkIc6y0cIkESLMaGpxzIb98tPj7RRNsrWmv9e/auE7ZeK
        PAMhPLlPOxVt12kKghGqoVQ=
X-Google-Smtp-Source: AGHT+IGUQizktoQDoAMVhntNV5W01XIL2neRaQfS4hw+W2be/+KiYL3Xk68pS/zdfnmPQvwIVvlp7Q==
X-Received: by 2002:a17:907:b13:b0:9a1:ab86:5f22 with SMTP id h19-20020a1709070b1300b009a1ab865f22mr7882885ejl.56.1692959936548;
        Fri, 25 Aug 2023 03:38:56 -0700 (PDT)
Received: from gmail.com (195-38-113-90.pool.digikabel.hu. [195.38.113.90])
        by smtp.gmail.com with ESMTPSA id jj26-20020a170907985a00b0099bd86f9248sm832891ejc.63.2023.08.25.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:38:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 25 Aug 2023 12:38:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/23] SRSO fixes/cleanups
Message-ID: <ZOiEvVOqwjZHzVgT@gmail.com>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> v2:
> - reorder everything: fixes/functionality before cleanups
> - split up KVM patch, add Sean's changes
> - add patch to support live migration
> - remove "default:" case for enums throughout bugs.c
> - various minor tweaks based on v1 discussions with Boris
> - add Reviewed-by's
> 
> Josh Poimboeuf (23):
>   x86/srso: Fix srso_show_state() side effect
>   x86/srso: Set CPUID feature bits independently of bug or mitigation
>     status
>   x86/srso: Don't probe microcode in a guest
>   KVM: x86: Add IBPB_BRTYPE support
>   KVM: x86: Add SBPB support
>   x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
>   x86/srso: Fix SBPB enablement for (possible) future fixed HW
>   x86/srso: Print actual mitigation if requested mitigation isn't
>     possible
>   x86/srso: Print mitigation for retbleed IBPB case
>   x86/srso: Fix vulnerability reporting for missing microcode
>   x86/srso: Fix unret validation dependencies
>   x86/alternatives: Remove faulty optimization
>   x86/srso: Improve i-cache locality for alias mitigation
>   x86/srso: Unexport untraining functions
>   x86/srso: Remove 'pred_cmd' label
>   x86/bugs: Remove default case for fully switched enums
>   x86/srso: Move retbleed IBPB check into existing 'has_microcode' code
>     block
>   x86/srso: Remove redundant X86_FEATURE_ENTRY_IBPB check
>   x86/srso: Disentangle rethunk-dependent options
>   x86/rethunk: Use SYM_CODE_START[_LOCAL]_NOALIGN macros
>   x86/retpoline: Remove .text..__x86.return_thunk section
>   x86/nospec: Refactor UNTRAIN_RET[_*]
>   x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()
> 
>  Documentation/admin-guide/hw-vuln/srso.rst |  22 ++-
>  arch/x86/include/asm/nospec-branch.h       |  69 ++++-----
>  arch/x86/include/asm/processor.h           |   2 -
>  arch/x86/kernel/alternative.c              |   8 -
>  arch/x86/kernel/cpu/amd.c                  |  28 ++--
>  arch/x86/kernel/cpu/bugs.c                 | 104 ++++++-------
>  arch/x86/kernel/vmlinux.lds.S              |  10 +-
>  arch/x86/kvm/cpuid.c                       |   5 +-
>  arch/x86/kvm/cpuid.h                       |   3 +-
>  arch/x86/kvm/x86.c                         |  29 +++-
>  arch/x86/lib/retpoline.S                   | 171 +++++++++++----------
>  include/linux/objtool.h                    |   3 +-
>  scripts/Makefile.vmlinux_o                 |   3 +-
>  13 files changed, 230 insertions(+), 227 deletions(-)

Thank you, this all looks very nice. I've applied your fixes to
tip:x86/bugs, with the exception of the two KVM enablement patches.

I've also cherry-picked the apply_returns() fix separately to x86/urgent,
AFAICS that's the only super-urgent fix we want to push to the final v6.5
release before the weekend, right? The other fixes look like
reporting bugs, Kconfig oddities and inefficiencies at worst. Backporters
may still pick the rest from x86/bugs too - but we are too close to the
release right now.

Thanks,

	Ingo
