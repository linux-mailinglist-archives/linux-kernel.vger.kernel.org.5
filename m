Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2695782EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjHUQuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHUQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:50:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6CCC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7475f45d31so2962424276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692636599; x=1693241399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8i+P5WxQIihs8Lc+oerWsvDy9PhdE2AhLCs+M13OZMQ=;
        b=rOC9vWbZ2cg6CxR35iSybXVMDp5HUN6pol+gCJXQ/gS8w2jSwfk0iYh57pV66llQRG
         wPQ1CjDZkXRrnkhaaIW2xo/fIG8jYDLqVzEaj70yFMSDZfMRbk2Psu2n+qyE+BR9bSkf
         P96cIof9+YCsLxRTFNKwAkPmWfPqNK1go7bJI4QjzKPIEKxqwryhPYSkjOVPTXWzgcle
         VzFX5Pjgy2/nB0eK0ap3cf/w90NpwQYikdvb7fClePwddSh4grb4GdWhwgRgh1D/6IBy
         W0I/iaFNgX7MhS1z10MsrnVQlzhh5ZFaqjHOs6H0v1oIgdy5vznbU0MAzu77ahg0aTlM
         LaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636599; x=1693241399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8i+P5WxQIihs8Lc+oerWsvDy9PhdE2AhLCs+M13OZMQ=;
        b=CRzVtIYGvGDj00gAPy4ehZ/Qvcc+8TsyiKdg3uonDq1+i4bzf3tYIugKqJinJBIftQ
         0KDFuzJyCLqVxe1PlItVqJ083yv7NfA1nxMGlJHI1wScd/jIav7tV9hkx22dFRpJlzEp
         zE4u59HsmozmalKGGYv6jXTeLlciYRf3S46HrKwnMpNYw3RWXr0wT9nW5VIUYHDrkS/I
         3wRZMcarQz1GERM+61Oyi622O+PzYjKdeM7r+/Wf+fCEXZYWUOJZbZCnqIDsmxbiAGcM
         dJsKaEYWCWvex5mIYb58wUioAQeXZesCmLpQA+j/SWB7ipZdEq81Gu+3i6ha8VhZ27mx
         q84g==
X-Gm-Message-State: AOJu0YwsGNH61RID2LL17QvsLJ+Cv++5hGI5/AWWP0aozFGLfD2wi/s3
        F2txzyjb5lfzFGsuxfh6h5fFY70ohes=
X-Google-Smtp-Source: AGHT+IEIZwInuPbNM5ZjkxcXNKb42ioZDSPJlciPck6Z5k4a3n358dyK2f/LIQkIIEKNAyTdkvgUa+cTODg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6602:0:b0:d44:be8a:ca39 with SMTP id
 a2-20020a256602000000b00d44be8aca39mr65365ybc.7.1692636599411; Mon, 21 Aug
 2023 09:49:59 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:49:57 +0000
In-Reply-To: <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
Mime-Version: 1.0
References: <cover.1692580085.git.jpoimboe@kernel.org> <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
Message-ID: <ZOOVtYB5GXJT+Fk6@google.com>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023, Josh Poimboeuf wrote:
> The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.
> 
> From the AMD SRSO whitepaper:
> 
>   "Hypervisor software should synthesize the value of both the
>   IBPB_BRTYPE and SBPB CPUID bits on these platforms for use by guest
>   software."
> 
> These bits are already set during kernel boot.  Manually propagate them
> to the guest.

Setting the bits in kvm_cpu_caps just advertises them to userspace, i.e. it doesn't
propagate them to the guest, that's up to userspace.

> Also, propagate PRED_CMD_SBPB writes.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++++
>  arch/x86/kvm/x86.c   | 9 +++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d3432687c9e6..cdf703eec42d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -729,6 +729,10 @@ void kvm_set_cpu_caps(void)
>  		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
>  	);
>  
> +	if (cpu_feature_enabled(X86_FEATURE_SBPB))
> +		kvm_cpu_cap_set(X86_FEATURE_SBPB);

This can simply be:

	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);

If there's a strong desire to use cpu_feature_enabled() instead of boot_cpu_has(),
then I would rather make than change in kvm_cpu_cap_check_and_set() for all features.

> +	if (cpu_feature_enabled(X86_FEATURE_IBPB_BRTYPE))
> +		kvm_cpu_cap_set(X86_FEATURE_IBPB_BRTYPE);

Assuming IBPB_BRTYPE doesn't require any extra support, it's probably best to add
that one in a separate patch, as SBPB support is likely going to be a bit more
involved.

>  	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
>  		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);

Ah, this snuck in without going through the normal review channels.  This too
can use kvm_cpu_cap_check_and_set().
