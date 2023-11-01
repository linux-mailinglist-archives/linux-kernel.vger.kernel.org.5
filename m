Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B97DE7FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345555AbjKAWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKAWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:15:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B36211D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:15:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da307fb7752so376651276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698876900; x=1699481700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZUx8eyAtnd4MLrDQkE9b5iSo4ODlmVMuEOqA88XPCE=;
        b=dWGA/jlP9KYXfHOq1B00FLV+q8SPT/y6NA8JG7F33GlEvEXnG+6ziFJIWB3okmKtch
         zC+mfXw0NArJ/jU9+1qmvN0fljuLMMm7huD0CSpsk1B1VLNvh+ZvbJMU3fUvGxPic02L
         Xjl8CwPV719HHh6Nkp4cmg9imx6c2fUimE26px+68GCZXnCP2h5xY7UBZBzoXSEgnaDx
         qrcMrVAeNL+HqtTTMQGmb6oxNUz3euu1HVapnzboheNBb1+zcOl+U6HtZBxAySICEMgt
         Ny1RU0leyW9I1FnY2cq1EVGok7HZWN+6boEraD3kUezeHtjyCrxh7m4UTBW03/aukFgy
         FT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698876900; x=1699481700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZUx8eyAtnd4MLrDQkE9b5iSo4ODlmVMuEOqA88XPCE=;
        b=KwBSdW1F58MYZoMJbzbtQjVQuzuxpu7GUYj2cbCaQJUkjjcGbKY0Nk50Pic0vK29fN
         zgDmlg/1uMKj9Da1Fb5dClagye0LyOdiBq6C+IiMYmVGkqXTOC+SjWREfbB/5gxXnr8r
         ppxXjjfuBe7albcz6miTjoAno05UKGOp5rzSBHZvuHgByskf4wbG6SqUfg3WyiSoCpDZ
         Mw3JZCYU7lNuHwglpbT6/5XTfhBOzFUbVkcoXAmD9/IBGq5W9D2BeJi5vBDQaKlwbk34
         XfbXcxlyu91xNoOmQK96CD5BCZJu4PVXFfXgkK9A7JJJbpN1+eQyGrnV9T4YKWq799oR
         wOmg==
X-Gm-Message-State: AOJu0YwGP2GTBG735SMaVk1OdV3ZDyNttdxl+KuwVMInZc9MYQCiEAZw
        xcD/D8ZDhTj4uHKbIx04VT2F6821FK8=
X-Google-Smtp-Source: AGHT+IEXfjGw9mEX6v8vrZsfhwz+lK/Ks4rEmpGGTr1iX9SweIr9i1OP2rAJI23eUzGqrvJaXd4EC2JTg1g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8689:0:b0:d9a:3bee:255c with SMTP id
 z9-20020a258689000000b00d9a3bee255cmr316101ybk.7.1698876900547; Wed, 01 Nov
 2023 15:15:00 -0700 (PDT)
Date:   Wed, 1 Nov 2023 15:14:58 -0700
In-Reply-To: <c07416ff2919f0aa30d3a810ccdfbed8c387ce0a.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-24-weijiang.yang@intel.com> <c07416ff2919f0aa30d3a810ccdfbed8c387ce0a.camel@redhat.com>
Message-ID: <ZULN4vMwP1t_mKg7@google.com>
Subject: Re: [PATCH v6 23/25] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > @@ -685,6 +686,13 @@ void kvm_set_cpu_caps(void)
> >  		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
> >  	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
> >  		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
> > +	/*
> > +	 * The feature bit in boot_cpu_data.x86_capability could have been
> > +	 * cleared due to ibt=off cmdline option, then add it back if CPU
> > +	 * supports IBT.
> > +	 */
> > +	if (cpuid_edx(7) & F(IBT))
> > +		kvm_cpu_cap_set(X86_FEATURE_IBT);
> 
> The usual policy is that when the host doesn't support a feature, then the guest
> should not support it either. On the other hand, for this particular feature,
> it is probably safe to use it. Just a point for a discussion.

Agreed, this needs extra justification.  It's "safe" in theory, but if the admin
disabled IBT because of a ucode bug, then all bets are off.

I'm guessing this was added because of the virtualization hole?  I.e. if KVM
allows CR4.CET=1 for shadow stacks, then KVM can't (easily?) prevent the guest
from also using IBT.
