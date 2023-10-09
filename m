Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57E7BE562
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377019AbjJIPve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjJIPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B509E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696866645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8lVe7axHHYscKZXFbEXrxOyJs8hdVECqH+D/vMLRVA=;
        b=FOSQlBKd9aSygpyTrm9cNv1IsjqOhZpsQu3U8G6pfqNYGLJZVBQxnYklRUoF3iNUmcoQt4
        j4rK3dc64bTgo+AEBZXhVBg6GlzFNP5w7qOHFZGkcUo4yMK1lM8lAnL0JwFPMQ3rkjgaz1
        DBGjj+p4sEgROf+OnCYKAJ8GBjdarzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-PaEYgMHhNp2cIa2Ia39xww-1; Mon, 09 Oct 2023 11:50:43 -0400
X-MC-Unique: PaEYgMHhNp2cIa2Ia39xww-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4054743df06so34182645e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866642; x=1697471442;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8lVe7axHHYscKZXFbEXrxOyJs8hdVECqH+D/vMLRVA=;
        b=TSzYEQB4EEXqUY5r7CS6UlKa9KkXRPawpkKRjUiLyU8hJE1Ir5PBnu9gV6NWwhqJez
         FdjcvXsTaDD2upzo3wxtbGBG5pGPy91yxJ+Z3LvSIVjiuKqRH0dBsb2AN0bsV+Ltz2SF
         suHnBPbNx9nLo4cIEoB61T+FfE7+Su2jz3tC26SeNDNHwKH5NxIiegTsddECRy177Sfn
         8Sxq9MT2XxJSysD7/OpniSLJkk8+pwEqZonrrGqYqwl4q/9Oxl4DL8lB6uXEXWMEnQB7
         aqopXh6ceChm9VjuHZwhH3RiA+rU+hNfHqB1jYdkniOaNCG+LcX7WDRVmXcbb/XkSPC5
         BySw==
X-Gm-Message-State: AOJu0Yxd+O6NMDCL9crKTP6fMuAeFpgpIKPVVpDvoPI6WVPSPljkCtBl
        29bLxxPn/yNITQGTyH60rkoTwpDQm7upbF2qVhfn77MnjSwdz/uZ3b7HA7yYVCZdtVglNXDeo0w
        /U48vk8zjMtQyEmAJNxtu0NQ5d7iR6++/
X-Received: by 2002:a5d:4049:0:b0:323:33cf:7872 with SMTP id w9-20020a5d4049000000b0032333cf7872mr13268727wrp.6.1696866642394;
        Mon, 09 Oct 2023 08:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYqEO2mlrfiZcjFN7Zvhq/J263TbutqXmvr3srcAGgJkp784Y34zAf/gti0FnzGrYUcdMO7g==
X-Received: by 2002:a5d:4049:0:b0:323:33cf:7872 with SMTP id w9-20020a5d4049000000b0032333cf7872mr13268714wrp.6.1696866641994;
        Mon, 09 Oct 2023 08:50:41 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b0032320a9b010sm10078471wrv.28.2023.10.09.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:50:41 -0700 (PDT)
Message-ID: <ac45ac86a17c68e0b76edaf06d60ca2948c0723f.camel@redhat.com>
Subject: Re: [PATCH v7] KVM: x86/tsc: Don't sync user-written TSC against
 startup values
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Oct 2023 18:50:39 +0300
In-Reply-To: <20231008025335.7419-1-likexu@tencent.com>
References: <20231008025335.7419-1-likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У нд, 2023-10-08 у 10:53 +0800, Like Xu пише:
> From: Like Xu <likexu@tencent.com>
> 
> The legacy API for setting the TSC is fundamentally broken, and only
> allows userspace to set a TSC "now", without any way to account for
> time lost to preemption between the calculation of the value, and the
> kernel eventually handling the ioctl.
> 
> To work around this we have had a hack which, if a TSC is set with a
> value which is within a second's worth of a previous vCPU, assumes that
> userspace actually intended them to be in sync and adjusts the newly-
> written TSC value accordingly.
> 
> Thus, when a VMM restores a guest after suspend or migration using the
> legacy API, the TSCs aren't necessarily *right*, but at least they're
> in sync.
> 
> This trick falls down when restoring a guest which genuinely has been
> running for less time than the 1 second of imprecision which we allow
> for in the legacy API. On *creation* the first vCPU starts its TSC
> counting from zero, and the subsequent vCPUs synchronize to that. But
> then when the VMM tries to set the intended TSC value, because that's
> within a second of what the last TSC synced to, KVM just adjusts it
> to match that.
> 
> But we can pile further hacks onto our existing hackish ABI, and
> declare that the *first* value written by userspace (on any vCPU)
> should not be subject to this 'correction' to make it sync up with
> values that only come from the kernel's default vCPU creation.
> 
> To that end: Add a flag in kvm->arch.user_set_tsc, protected by
> kvm->arch.tsc_write_lock, to record that a TSC for at least one vCPU in
> this KVM *has* been set by userspace. Make the 1-second slop hack only
> trigger if that flag is already set.
> 
> Note that userspace can explicitly request a *synchronization* of the
> TSC by writing zero. For the purpose of this patch, this counts as
> "setting" the TSC. If userspace then subsequently writes an explicit
> non-zero value which happens to be within 1 second of the previous
> value, it will be 'corrected'. For that case, this preserves the prior
> behaviour of KVM (which always applied the 1-second 'correction'
> regardless of user vs. kernel).
> 
> Reported-by: Yong He <alexyonghe@tencent.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217423
> Suggested-by: Oliver Upton <oliver.upton@linux.dev>
> Original-by: Oliver Upton <oliver.upton@linux.dev>
> Original-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Tested-by: Yong He <alexyonghe@tencent.com>
> ---
> V6 -> V7 Changelog:
> - Refine commit message and comments to make more sense; (David & Sean)
> - A @user_value of '0' would still force synchronization; (Sean)
> V6: https://lore.kernel.org/kvm/20230913103729.51194-1-likexu@tencent.com/
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 34 +++++++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 41558d13a9a6..7c228ae05df0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1334,6 +1334,7 @@ struct kvm_arch {
>  	int nr_vcpus_matched_tsc;
>  
>  	u32 default_tsc_khz;
> +	bool user_set_tsc;
>  
>  	seqcount_raw_spinlock_t pvclock_sc;
>  	bool use_master_clock;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fdb2b0e61c43..776506a77e1b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2709,8 +2709,9 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
>  	kvm_track_tsc_matching(vcpu);
>  }
>  
> -static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 data)
> +static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value)
>  {
> +	u64 data = user_value ? *user_value : 0;
>  	struct kvm *kvm = vcpu->kvm;
>  	u64 offset, ns, elapsed;
>  	unsigned long flags;
> @@ -2725,25 +2726,37 @@ static void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 data)
>  	if (vcpu->arch.virtual_tsc_khz) {
>  		if (data == 0) {
>  			/*
> -			 * detection of vcpu initialization -- need to sync
> -			 * with other vCPUs. This particularly helps to keep
> -			 * kvm_clock stable after CPU hotplug
> +			 * Force synchronization when creating a vCPU, or when
> +			 * userspace explicitly writes a zero value.
>  			 */
>  			synchronizing = true;
> -		} else {
> +		} else if (kvm->arch.user_set_tsc) {
>  			u64 tsc_exp = kvm->arch.last_tsc_write +
>  						nsec_to_cycles(vcpu, elapsed);
>  			u64 tsc_hz = vcpu->arch.virtual_tsc_khz * 1000LL;
>  			/*
> -			 * Special case: TSC write with a small delta (1 second)
> -			 * of virtual cycle time against real time is
> -			 * interpreted as an attempt to synchronize the CPU.
> +			 * Here lies UAPI baggage: when a user-initiated TSC write has
> +			 * a small delta (1 second) of virtual cycle time against the
> +			 * previously set vCPU, we assume that they were intended to be
> +			 * in sync and the delta was only due to the racy nature of the
> +			 * legacy API.
> +			 *
> +			 * This trick falls down when restoring a guest which genuinely
> +			 * has been running for less time than the 1 second of imprecision
> +			 * which we allow for in the legacy API. In this case, the first
> +			 * value written by userspace (on any vCPU) should not be subject
> +			 * to this 'correction' to make it sync up with values that only
> +			 * come from the kernel's default vCPU creation. Make the 1-second
> +			 * slop hack only trigger if the user_set_tsc flag is already set.
>  			 */
>  			synchronizing = data < tsc_exp + tsc_hz &&
>  					data + tsc_hz > tsc_exp;
>  		}
>  	}
>  
> +	if (user_value)
> +		kvm->arch.user_set_tsc = true;
> +
>  	/*
>  	 * For a reliable TSC, we can match TSC offsets, and for an unstable
>  	 * TSC, we add elapsed time in this computation.  We could let the
> @@ -3869,7 +3882,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case MSR_IA32_TSC:
>  		if (msr_info->host_initiated) {
> -			kvm_synchronize_tsc(vcpu, data);
> +			kvm_synchronize_tsc(vcpu, &data);
>  		} else {
>  			u64 adj = kvm_compute_l1_tsc_offset(vcpu, data) - vcpu->arch.l1_tsc_offset;
>  			adjust_tsc_offset_guest(vcpu, adj);
> @@ -5639,6 +5652,7 @@ static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
>  		tsc = kvm_scale_tsc(rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
>  		ns = get_kvmclock_base_ns();
>  
> +		kvm->arch.user_set_tsc = true;
>  		__kvm_synchronize_tsc(vcpu, offset, tsc, ns, matched);
>  		raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
>  
> @@ -12073,7 +12087,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (mutex_lock_killable(&vcpu->mutex))
>  		return;
>  	vcpu_load(vcpu);
> -	kvm_synchronize_tsc(vcpu, 0);
> +	kvm_synchronize_tsc(vcpu, NULL);
>  	vcpu_put(vcpu);
>  
>  	/* poll control enabled by default */
> 
> base-commit: 86701e115030e020a052216baa942e8547e0b487


Just small note: Note that qemu resets TSC on the CPU reset,
But recently it started to reset it to '1' instead of '0' to avoid trigerring this synchronization.

As far as I can see, this patch should still work in this case,
because vCPU reset usually happens long after the vCPUs are all created and running, 
but this is still something to keep in the mind.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


