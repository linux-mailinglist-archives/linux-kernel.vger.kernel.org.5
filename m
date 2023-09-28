Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8BE7B22B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjI1Qrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1Qr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4298
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695919600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1nG43NAk1FHCA+ImOZ9oNANJUjy6sdGqu8LxM+SXvk=;
        b=CmNq95lNy4RHZ/qLyEDmcKkE9EG++GFjFknslrRZQwp6OW1SN2KUaA7vx441Q4VXIhbHgP
        Cpkc4GXdWe5GCnfY9kQgJ0YZFyvBukiDqLUPjHc+9g8RVllyox9czAF4DVgY+yKRd1gJih
        FXZvpcg5JgJP6kuOKdJumTmpVZKZ7a8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-7_w0n77-PQK7_BRBWAzlag-1; Thu, 28 Sep 2023 12:46:39 -0400
X-MC-Unique: 7_w0n77-PQK7_BRBWAzlag-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315af0252c2so10571255f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919598; x=1696524398;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1nG43NAk1FHCA+ImOZ9oNANJUjy6sdGqu8LxM+SXvk=;
        b=pFz4rFmM9FD3l4RXExHu4IzooFoEjVn24aUMF1ZZgwXgqPFuxDBWWi6tUIEWs6FUsL
         fM1EAUAj9/5BHM/j43p0qdma1yrV8ypzAmVJ424Pxaukqz+t78MeM2IcbP6u3uq2qDt7
         xuOVSXaWfcXfg55xOHTnjRlcSui2Vp6WXarmHVukpYV4pgH8OUDaOfUOjDtH8h+eqaZ+
         /nMyk5Nd7ULudshZLBR6oWg3ioPAinzusMXEQAenEaBePSdYsI5jTMMhKcIQ1NDMxKkY
         DpzSJr/8Q6MTPy2V0Guge6vBQ5ZkcgFFBEkNDKXKJ63zmUygOQAv+n2If4LwzodU3524
         +uPg==
X-Gm-Message-State: AOJu0YzhKUf+5oeNX8qKjkzsEQ30WcJzq2Z6PQEvfPS/MuaP+rzm9u6A
        zxMbU54tnoIdLIBpxYft2hZbWrte2YhhmKKPzPG9Wi1VTYjnT8TwwZz5sme+95QPHG2gRmEaP4q
        dwi/+mAS9UPtQA4ODV5IimTwxNjXxjaUC
X-Received: by 2002:a5d:5151:0:b0:31f:eb88:e3c8 with SMTP id u17-20020a5d5151000000b0031feb88e3c8mr1641085wrt.32.1695919597782;
        Thu, 28 Sep 2023 09:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECAhLGbnen61UUw8FpaxsVW7uCtdSfU9iZ7QE8TtuL/KJb16ImOsM03QIoWXomHtErupETRg==
X-Received: by 2002:a5d:5151:0:b0:31f:eb88:e3c8 with SMTP id u17-20020a5d5151000000b0031feb88e3c8mr1641070wrt.32.1695919597459;
        Thu, 28 Sep 2023 09:46:37 -0700 (PDT)
Received: from starship ([89.237.96.178])
        by smtp.gmail.com with ESMTPSA id ba6-20020a0560001c0600b003248a490e3asm1383100wrb.39.2023.09.28.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:46:36 -0700 (PDT)
Message-ID: <0b5e476cd0a31376fbda4be62fb650a1caf004dd.camel@redhat.com>
Subject: Re: [PATCH 1/3] KVM: x86/mmu: remove unnecessary "bool shared"
 argument from functions
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Thu, 28 Sep 2023 19:46:35 +0300
In-Reply-To: <20230928162959.1514661-2-pbonzini@redhat.com>
References: <20230928162959.1514661-1-pbonzini@redhat.com>
         <20230928162959.1514661-2-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У чт, 2023-09-28 у 12:29 -0400, Paolo Bonzini пише:
> Neither tdp_mmu_next_root nor kvm_tdp_mmu_put_root need to know
> if the lock is taken for read or write.  Either way, protection
> is achieved via RCU and tdp_mmu_pages_lock.  Remove the argument
> and just assert that the lock is taken.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c     |  2 +-
>  arch/x86/kvm/mmu/tdp_mmu.c | 34 +++++++++++++++++++++-------------
>  arch/x86/kvm/mmu/tdp_mmu.h |  3 +--
>  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f7901cb4d2fa..64b1bdba943e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3548,7 +3548,7 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
>  		return;
>  
>  	if (is_tdp_mmu_page(sp))
> -		kvm_tdp_mmu_put_root(kvm, sp, false);
> +		kvm_tdp_mmu_put_root(kvm, sp);
>  	else if (!--sp->root_count && sp->role.invalid)
>  		kvm_mmu_prepare_zap_page(kvm, sp, invalid_list);
>  
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 6cd4dd631a2f..ab0876015be7 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -73,10 +73,13 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
>  	tdp_mmu_free_sp(sp);
>  }
>  
> -void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> -			  bool shared)
> +void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
>  {
> -	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
> +	/*
> +	 * Either read or write is okay, but the lock is needed because
> +	 * writers might not take tdp_mmu_pages_lock.
> +	 */
> +	lockdep_assert_held(&kvm->mmu_lock);

I double checked all callers and indeed at least the read lock is held.

>  
>  	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
>  		return;
> @@ -106,10 +109,16 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
>   */
>  static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>  					      struct kvm_mmu_page *prev_root,
> -					      bool shared, bool only_valid)
> +					      bool only_valid)
>  {
>  	struct kvm_mmu_page *next_root;
>  
> +	/*
> +	 * While the roots themselves are RCU-protected, fields such as
> +	 * role.invalid are protected by mmu_lock.
> +	 */
> +	lockdep_assert_held(&kvm->mmu_lock);
> +
>  	rcu_read_lock();
>  
>  	if (prev_root)
> @@ -132,7 +141,7 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>  	rcu_read_unlock();
>  
>  	if (prev_root)
> -		kvm_tdp_mmu_put_root(kvm, prev_root, shared);
> +		kvm_tdp_mmu_put_root(kvm, prev_root);
>  
>  	return next_root;
>  }
> @@ -144,13 +153,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>   * recent root. (Unless keeping a live reference is desirable.)
>   *
>   * If shared is set, this function is operating under the MMU lock in read
> - * mode. In the unlikely event that this thread must free a root, the lock
> - * will be temporarily dropped and reacquired in write mode.
> + * mode.
>   */
>  #define __for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, _only_valid)\
> -	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, _only_valid);	\
> -	     _root;								\
> -	     _root = tdp_mmu_next_root(_kvm, _root, _shared, _only_valid))	\
> +	for (_root = tdp_mmu_next_root(_kvm, NULL, _only_valid);	\
> +	     _root;							\
> +	     _root = tdp_mmu_next_root(_kvm, _root, _only_valid))	\
>  		if (kvm_lockdep_assert_mmu_lock_held(_kvm, _shared) &&		\
>  		    kvm_mmu_page_as_id(_root) != _as_id) {			\
>  		} else
> @@ -159,9 +167,9 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>  	__for_each_tdp_mmu_root_yield_safe(_kvm, _root, _as_id, _shared, true)
>  
>  #define for_each_tdp_mmu_root_yield_safe(_kvm, _root, _shared)			\
> -	for (_root = tdp_mmu_next_root(_kvm, NULL, _shared, false);		\
> -	     _root;								\
> -	     _root = tdp_mmu_next_root(_kvm, _root, _shared, false))		\
> +	for (_root = tdp_mmu_next_root(_kvm, NULL, false);		\
> +	     _root;							\
> +	     _root = tdp_mmu_next_root(_kvm, _root, false))
>  		if (!kvm_lockdep_assert_mmu_lock_held(_kvm, _shared)) {		\
>  		} else
>  
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> index 733a3aef3a96..20d97aa46c49 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.h
> +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> @@ -17,8 +17,7 @@ __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
>  	return refcount_inc_not_zero(&root->tdp_mmu_root_count);
>  }
>  
> -void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> -			  bool shared);
> +void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root);
>  
>  bool kvm_tdp_mmu_zap_leafs(struct kvm *kvm, gfn_t start, gfn_t end, bool flush);
>  bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp);


I don't know all of the details of the kvm mmu, so I might have missed something,
but still I need to get back to reviewing....

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky

