Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE917DCCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjJaMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjJaMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:07:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B5559D;
        Tue, 31 Oct 2023 05:06:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso3837139f8f.2;
        Tue, 31 Oct 2023 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698753983; x=1699358783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hybhq6NLhNrYC65inYGzlTEeA27NBYWLW8XyRxxack4=;
        b=aRUTqFbSG0xrT/mMnKNQMaZ+UACZaJdlwiVMzYSw4OrFKSvmte1GCNA5kJWcQJT6HG
         WBONXOu48HTT9FhW/M7Ue8CYDxBYQEHqhyi4CAyAPANWW4iVecmlyo7eGBPUI2DE5bC3
         9irLN/5OWBqE8s7AcreUircF5X5ZBGd+bDQw1tWSzK3Y2BE/rJrlLlOnaSxf+SyOtNXs
         vJ1XWR9co7V1fqnpC8GqQPpJqGEwcQ0jyF7+z2GKdJhAvrk8qhqWfwIbAFINn/PNhiGT
         F75TTQzldkjo6A0cZzOOD1VVJ3Y3OXQLqh5SXwE+bOz8PQ8Hp3fBq6Sa2SwhtDwR4xiX
         cDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698753983; x=1699358783;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hybhq6NLhNrYC65inYGzlTEeA27NBYWLW8XyRxxack4=;
        b=mjHm/dDJNNYAWJMVPg8jUzviuvfD5/os1rvB3f6duLoilPXB1XWQIZsVqDaQ552696
         00VqNE4H8sBerrmYq7awyyZKdItiBE/UkAOJ009pvA/t8wR4uSenJ/KgZ2XA6CDiw8E1
         8znVUJKY7mKzE1rOSFhnVYVrPA2n+YHbOTe0zwOZqfXb2XJbSFtErq7j/DKzbUSZ935Y
         0nWrMSCYK0YyVnZycXvQWQF8FXMnLqHYA3wqVkl1obxCb7WRjGmM6ZcUPyjRwanLKNKm
         CKWlzz6TAFuigQV6p7GOOu5PUNvpJLx6xS76REAkaL0NK5npEFpkC6pgOU/lBws+f4d+
         dPTw==
X-Gm-Message-State: AOJu0YwikvBnpEXZLdrDjR6x2r9YE8pS0jJ1x/PYaJcgRn6+CXISXnhi
        cDdX/ZHE0/p8xnb9NK+itGs=
X-Google-Smtp-Source: AGHT+IEqpDSmuAq7M4X90kHDGBJSVDPiJ0eW6Kr34CwScKYD6BiqZw6nay9jAqJDkqf7Xh3mC57WOQ==
X-Received: by 2002:a5d:6051:0:b0:317:393f:8633 with SMTP id j17-20020a5d6051000000b00317393f8633mr8280793wrt.58.1698753982889;
        Tue, 31 Oct 2023 05:06:22 -0700 (PDT)
Received: from [10.95.146.166] (54-240-197-230.amazon.com. [54.240.197.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a5d47ac000000b0032ddc3b88e9sm1453127wrb.0.2023.10.31.05.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 05:06:22 -0700 (PDT)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <6c9671b4-d997-42ac-9821-06accb97357f@xen.org>
Date:   Tue, 31 Oct 2023 12:06:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH] KVM: x86/xen: improve accuracy of Xen timers
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <xadimgnik@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <96da7273adfff2a346de9a4a27ce064f6fe0d0a1.camel@infradead.org>
 <1a679274-bbff-4549-a1ea-c7ea9f1707cc@xen.org>
 <F80266DD-D7EF-4A26-B9F8-BC33EC65F444@infradead.org>
Organization: Xen Project
In-Reply-To: <F80266DD-D7EF-4A26-B9F8-BC33EC65F444@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 11:42, David Woodhouse wrote:
> 
> 
> On 31 October 2023 10:42:42 GMT, Paul Durrant <xadimgnik@gmail.com> wrote:
>> There is no documented ordering requirement on setting KVM_XEN_VCPU_ATTR_TYPE_TIMER versus KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO or KVM_XEN_ATTR_TYPE_SHARED_INFO but kvm_xen_start_timer() now needs the vCPU's pvclock to be valid. Should actually starting the timer not be deferred until then? (Or simply add a check here and have the attribute setting fail if the pvclock is not valid).
> 
> 
> There are no such dependencies and I don't want there to be. That would be the *epitome* of what my "if it needs documenting, fix it first" mantra is intended to correct.
> 
> The fact that this broke on migration because the hv_clock isn't set up yet, as we saw in our overnight testing, is just a bug. In my tree I've fixed it thus:
> 
> index 63531173dad1..e3d2d63eef34 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -182,7 +182,7 @@ static void kvm_xen_start_timer(st
> ruct kvm_vcpu *vcpu, u64 guest_abs,
>           * the absolute CLOCK_MONOTONIC time at which
> the timer should
>           * fire.
>           */
> -       if (vcpu->kvm->arch.use_master_clock &&
> +       if (vcpu->arch.hv_clock.version && vcpu->kvm->
> arch.use_master_clock &&
>              static_cpu_has(X86_FEATURE_CONSTANT_TSC))
> {
>                  uint64_t host_tsc, guest_tsc;
> 
> @@ -206,9 +206,23 @@ static void kvm_xen_start_timer(s
> truct kvm_vcpu *vcpu, u64 guest_abs,
> 
>                  /* Calculate the guest kvmclock as the
>   guest would do it. */
>                  guest_tsc = kvm_read_l1_tsc(vcpu, host
> _tsc);
> -               guest_now = __pvclock_read_cycles(&vcp
> u->arch.hv_clock, guest_tsc);
> +               guest_now = __pvclock_read_cycles(&vcp
> u->arch.hv_clock,
> +                                                 gues
> t_tsc);
>          } else {
> -               /* Without CONSTANT_TSC, get_kvmclock_
> ns() is the only option */
> +               /*
> +                * Without CONSTANT_TSC, get_kvmclock_
> ns() is the only option.
> +                *
> +                * Also if the guest PV clock hasn't b
> een set up yet, as is
> +                * likely to be the case during migrat
> ion when the vCPU has
> +                * not been run yet. It would be possi
> ble to calculate the
> +                * scaling factors properly in that ca
> se but there's not much
> +                * point in doing so. The get_kvmclock
> _ns() drift accumulates
> +                * over time, so it's OK to use it at
> startup. Besides, on
> +                * migration there's going to be a lit
> tle bit of skew in the
> +                * precise moment at which timers fire
>   anyway. Often they'll
> +                * be in the "past" by the time the VM
>   is running again after
> +                * migration.
> +                */
>                  guest_now = get_kvmclock_ns(vcpu->kvm)
> ;
>                  kernel_now = ktime_get();
>          }
> --
> 2.41.0
> 
> We *could* reset the timer when the vCPU starts to run and handles the KVM_REQ_CLOCK_UPDATE event, but I don't want to for two reasons.
> 
> Firstly, we just don't need that complexity. This approach is OK, as the newly-added comment says. And we do need to fix get_kvmclock_ns() anyway, so it should work fine. Most of this patch will still be useful as it uses a single TSC read and we *do* need to do that part even after all the kvmclock brokenness is fixed. But the complexity on KVM_REQ_CLOCK_UPDATE isn't needed in the long term.
> 
> Secondly, it's also wrong thing to do in the general case. Let's say KVM does its thing and snaps the kvmclock backwards in time on a KVM_REQ_CLOCK_UPDATE... do we really want to reinterpret existing timers against the new kvmclock? They were best left alone, I think.

Do we not want to do exactly that? If the master clock is changed, why 
would we not want to re-interpret the guest's idea of time? That update 
will be visible to the guest when it re-reads the PV clock source.

   Paul

