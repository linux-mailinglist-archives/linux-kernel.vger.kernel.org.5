Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49A7B6F13
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbjJCQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjJCQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB907C6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696352109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKz6JlccCVdwAjHFNSIJ5aqOB7SHuX73H5DKrk7P0eA=;
        b=NV3xFTQqMwgD8KpiFHYzwYJr6yQD76cozrANOUZiW8o04MHxXt56oOihx/QASM0vfLUSAo
        hT+rV/hS3ibUL7PDLvj4G0pL23m9amLeAEV1iqJNBawnnm3cU4mSBxO69pAJEtXnAU4F87
        VI4k8mKxgLTT/mmcZRcy4XBn7Ijb6nc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-gVIMYK-1O5-c0FIvQaxWPg-1; Tue, 03 Oct 2023 12:54:52 -0400
X-MC-Unique: gVIMYK-1O5-c0FIvQaxWPg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe1521678fso9378915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352091; x=1696956891;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKz6JlccCVdwAjHFNSIJ5aqOB7SHuX73H5DKrk7P0eA=;
        b=dPKiCPk4e5LWy0+MMDglfdGkI8XPVzbI18z11boGkEgoQpyqQSIJL7FUXKMuZA+z2K
         5wY4ayTbB+PqfJq8QsyZpLI49bij/8bCm2I7dg2K51fDW5juDM74h87TF3J1V6utcnNG
         lXysZsfINn2TbH2820LMt9g5J5/xr5/45Ngb8JKgM9X0IYJapEYVzxrTYx1AvVl6MpKf
         ede5Ll8OwY1i9l2aBAvvP14PQ9lM/xzjRx4VXugmbNRT07bjuq0IMP3Ia8aAeNqWkWsQ
         LVJxpPwXuuncpJYYXVVFM5J9kesktiXraeUw/jrvbcJXh6CiquRXuGNubcmhZoyKuWI0
         gkwQ==
X-Gm-Message-State: AOJu0YzoButjeT3RrYcFARi27VlRD5z2ZPIxt7SeOJddGD6a8PHd8nET
        Q6ctd57NYWNh3vuYzEg3HL1hUlktkBJP4Ol4GR+lawf6no3C+pP18J6jSYeBy81leCK62KSGa2m
        oEW42kneI2l3rdvHQlzajCL7j
X-Received: by 2002:a5d:46cc:0:b0:31f:8999:c409 with SMTP id g12-20020a5d46cc000000b0031f8999c409mr12798724wrs.66.1696352091205;
        Tue, 03 Oct 2023 09:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEw8GrseodyMNQjRvXwM2R7y7QiATyOCHeguCOnxlPwguiOvboAnAcudNz+gmFlWejG4+qew==
X-Received: by 2002:a5d:46cc:0:b0:31f:8999:c409 with SMTP id g12-20020a5d46cc000000b0031f8999c409mr12798708wrs.66.1696352090912;
        Tue, 03 Oct 2023 09:54:50 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4cc6000000b00325c7295450sm1977795wrt.3.2023.10.03.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:54:50 -0700 (PDT)
Message-ID: <fe832be36d46a946431567cbc315766fbdc772b1.camel@redhat.com>
Subject: Re: [PATCH v9 5/6] KVM: x86: Migrate to __kvm_follow_pfn
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     David Stevens <stevensd@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Date:   Tue, 03 Oct 2023 19:54:48 +0300
In-Reply-To: <20230911021637.1941096-6-stevensd@google.com>
References: <20230911021637.1941096-1-stevensd@google.com>
         <20230911021637.1941096-6-stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У пн, 2023-09-11 у 11:16 +0900, David Stevens пише:
> From: David Stevens <stevensd@chromium.org>
> 
> Migrate functions which need access to is_refcounted_page to
> __kvm_follow_pfn. The functions which need this are __kvm_faultin_pfn
> and reexecute_instruction. The former requires replacing the async
> in/out parameter with FOLL_NOWAIT parameter and the KVM_PFN_ERR_NEEDS_IO
> return value. Handling non-refcounted pages is complicated, so it will
> be done in a followup. The latter is a straightforward refactor.
> 
> APIC related callers do not need to migrate because KVM controls the
> memslot, so it will always be regular memory. Prefetch related callers
> do not need to be migrated because atomic gfn_to_pfn calls can never
> make it to hva_to_pfn_remapped.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 43 ++++++++++++++++++++++++++++++++----------
>  arch/x86/kvm/x86.c     | 12 ++++++++++--
>  2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e1d011c67cc6..e1eca26215e2 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4254,7 +4254,14 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
>  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  {
>  	struct kvm_memory_slot *slot = fault->slot;
> -	bool async;
> +	struct kvm_follow_pfn foll = {
> +		.slot = slot,
> +		.gfn = fault->gfn,
> +		.flags = fault->write ? FOLL_WRITE : 0,
> +		.try_map_writable = true,
> +		.guarded_by_mmu_notifier = true,
> +		.allow_non_refcounted_struct_page = false,
> +	};
>  
>  	/*
>  	 * Retry the page fault if the gfn hit a memslot that is being deleted
> @@ -4283,12 +4290,20 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  			return RET_PF_EMULATE;
>  	}
>  
> -	async = false;
> -	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
> -					  fault->write, &fault->map_writable,
> -					  &fault->hva);
> -	if (!async)
> -		return RET_PF_CONTINUE; /* *pfn has correct page already */
> +	foll.flags |= FOLL_NOWAIT;
> +	fault->pfn = __kvm_follow_pfn(&foll);
> +
> +	if (!is_error_noslot_pfn(fault->pfn))
> +		goto success;
Unrelated but I can't say I like the 'is_error_noslot_pfn()' name, 
I wish it was called something like is_valid_pfn().

> +
> +	/*
> +	 * If __kvm_follow_pfn() failed because I/O is needed to fault in the
> +	 * page, then either set up an asynchronous #PF to do the I/O, or if
> +	 * doing an async #PF isn't possible, retry __kvm_follow_pfn() with
> +	 * I/O allowed. All other failures are fatal, i.e. retrying won't help.
> +	 */
> +	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
> +		return RET_PF_CONTINUE;
>  
>  	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
>  		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
> @@ -4306,9 +4321,17 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  	 * to wait for IO.  Note, gup always bails if it is unable to quickly
>  	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
>  	 */
> -	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, true, NULL,
> -					  fault->write, &fault->map_writable,
> -					  &fault->hva);
> +	foll.flags |= FOLL_INTERRUPTIBLE;
> +	foll.flags &= ~FOLL_NOWAIT;
> +	fault->pfn = __kvm_follow_pfn(&foll);
> +
> +	if (!is_error_noslot_pfn(fault->pfn))
> +		goto success;
> +
> +	return RET_PF_CONTINUE;
> +success:
> +	fault->hva = foll.hva;
> +	fault->map_writable = foll.writable;
>  	return RET_PF_CONTINUE;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6c9c81e82e65..2011a7e47296 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8556,6 +8556,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  {
>  	gpa_t gpa = cr2_or_gpa;
>  	kvm_pfn_t pfn;
> +	struct kvm_follow_pfn foll;
>  
>  	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
>  		return false;
> @@ -8585,7 +8586,13 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  	 * retry instruction -> write #PF -> emulation fail -> retry
>  	 * instruction -> ...
>  	 */
> -	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
> +	foll = (struct kvm_follow_pfn) {
> +		.slot = gfn_to_memslot(vcpu->kvm, gpa_to_gfn(gpa)),
> +		.gfn = gpa_to_gfn(gpa),
> +		.flags = FOLL_WRITE,
> +		.allow_non_refcounted_struct_page = true,
> +	};
> +	pfn = __kvm_follow_pfn(&foll);
>  
>  	/*
>  	 * If the instruction failed on the error pfn, it can not be fixed,
> @@ -8594,7 +8601,8 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  	if (is_error_noslot_pfn(pfn))
>  		return false;
>  
> -	kvm_release_pfn_clean(pfn);
> +	if (foll.is_refcounted_page)
> +		kvm_release_page_clean(pfn_to_page(pfn));
>  
>  	/* The instructions are well-emulated on direct mmu. */
>  	if (vcpu->arch.mmu->root_role.direct) {


Overall looks good, I might have missed something.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky




