Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136A7FC1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjK1Qdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjK1Qds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:33:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55310DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:33:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db3ef4c7094so6788685276.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701189233; x=1701794033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/95/Uj9Fg4uJeKo+eJAx6dpBh0gdcUuvBHqXATckU=;
        b=NaNNIfLgB93VcUkI9OpjV5L9tEcnng14sJr3vjy0Q0Z1j8TSQS7jFTvfS6Qk+vhNH9
         IftTXZYyVs24Tm/f9sEZeWtq2MdPFTNlZmHeWvfzjQlkGq3zyUztRufC+Ae/f+HK/9pQ
         tDW25YoSaXzX0dUundpAGiO7c2s2UjOdiP4rOK/CgTFEGg+KKcLpiI68c7v4QjYTmKO9
         xIgCqxej0Yv4rg2ceCMe2b9DP+/uBcijwB+Car0nsTvaFB+R9MgJNOUSOnXbjqq17z7/
         srTEWRmqK+1/pxlBb/oJMm5/e3L8+PxUJXDG4if1Mqx3mm8CRfClJqrzku7EmUWx9PIi
         xjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189233; x=1701794033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo/95/Uj9Fg4uJeKo+eJAx6dpBh0gdcUuvBHqXATckU=;
        b=Z8DqVtVeyaEi7YYYlPIE8YgqSYM9aVya2mbEiKaUmbO6Uzl2YQ1vcp6FO5wok/brN0
         5hvXOzbPcGmGr0oodIBs/Wx7ZGXTmd6gZNVtAGNimlabLaoYg2aH1s7XXDuW29CyuaG8
         +Fr9iJT9yuK6Z7Gmpu4PfD3lEM2v0Nm6LRvWmGkabMXeooBbTSUlbNcznt2hqEoWgJko
         9DO6gjXW6/JPVTalKNtikHuvlkJLP7tti7SPIETSv1RtuMzxP2DPHthq3tMC23UfBnym
         /eD8jwm8GXyDburEGhzw0/77MqhKt4sBTxwO/JbXdB7sztztinUNMGNvgcQgxlO086op
         AlSA==
X-Gm-Message-State: AOJu0YzImBrcyGwQn2+sy+bsa313wGJmp6rcQcVe1wJT0RV/Ch3mWYji
        VD5CAA0CgcVQMZfteAaxs59/7HffQRw=
X-Google-Smtp-Source: AGHT+IEo0YpirGMFLOQPu1+JPSR0DG5FDk303PQza9eOuDyOragnS042ndzE8Pd0ow1j/PtRzL0iHYgXDSU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d081:0:b0:d9a:fd29:4fe6 with SMTP id
 h123-20020a25d081000000b00d9afd294fe6mr562511ybg.3.1701189233386; Tue, 28 Nov
 2023 08:33:53 -0800 (PST)
Date:   Tue, 28 Nov 2023 08:33:51 -0800
In-Reply-To: <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-6-nsaenz@amazon.com>
 <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
Message-ID: <ZWYWb3OQG3CaS7-f@google.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com,
        graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com,
        corbert@lwn.net, kys@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023, Maxim Levitsky wrote:
> On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 78d053042667..d4b1b53ea63d 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -259,7 +259,8 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
> >  static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> >  {
> >  	struct kvm *kvm = vcpu->kvm;
> > -	u8 instructions[9];
> > +	struct kvm_hv *hv = to_kvm_hv(kvm);
> > +	u8 instructions[0x30];
> >  	int i = 0;
> >  	u64 addr;
> >  
> > @@ -285,6 +286,81 @@ static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> >  	/* ret */
> >  	((unsigned char *)instructions)[i++] = 0xc3;
> >  
> > +	/* VTL call/return entries */
> > +	if (!kvm_xen_hypercall_enabled(kvm) && kvm_hv_vsm_enabled(kvm)) {
> > +#ifdef CONFIG_X86_64
> > +		if (is_64_bit_mode(vcpu)) {
> > +			/*
> > +			 * VTL call 64-bit entry prologue:
> > +			 * 	mov %rcx, %rax
> > +			 * 	mov $0x11, %ecx
> > +			 * 	jmp 0:
> 
> This isn't really 'jmp 0' as I first wondered but actually backward jump 32
> bytes back (if I did the calculation correctly).  This is very dangerous
> because code that was before can change and in fact I don't think that this
> offset is even correct now, and on top of that it depends on support for xen
> hypercalls as well.
> 
> This can be fixed by calculating the offset in runtime, however I am
> thinking:
> 
> 
> Since userspace will have to be aware of the offsets in this page, and since
> pretty much everything else is done in userspace, it might make sense to
> create the hypercall page in the userspace.
> 
> In fact, the fact that KVM currently overwrites the guest page, is a
> violation of the HV spec.
> 
> It's more correct regardless of VTL to do userspace vm exit and let the
> userspace put a memslot ("overlay") over the address, and put whatever
> userspace wants there, including the above code.
> 
> Then we won't need the new ioctl as well.
> 
> To support this I think that we can add a userspace msr filter on the
> HV_X64_MSR_HYPERCALL, although I am not 100% sure if a userspace msr filter
> overrides the in-kernel msr handling.

Yep, userspace MSR filters override in-kernel handling.
