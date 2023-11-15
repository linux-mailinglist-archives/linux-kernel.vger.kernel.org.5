Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A517EBB11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjKOB7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:59:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7EE3;
        Tue, 14 Nov 2023 17:59:50 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso305840b3a.1;
        Tue, 14 Nov 2023 17:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700013590; x=1700618390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKp1IVa8FokCsakCmu51XuRgPQg/O/K1X2iQKriLEpE=;
        b=cjNKUf9+mLxhVZRlFnUz6BHYp0yCm0ZgiI8F/wBB4SM4qtzPcbUFcFTxtNE1l/lIw5
         nZOZGjAsb1DOuNmfi5wofchiPyn95M3D6gj6hFM5EOxgiEgRqGfjIKPd9ffmnKAoJ8vi
         9lTfNAfDbsoRALw/SsBQTn+qNrd0lW9RAkfcOTTj+C95FyaLaGVuM0yiyZX/D22ee9UV
         R4jLta1uRmf1Ux1T1sKbaIfB1403RkyioSR47kE5PPQ4is2HgfECyl+5lo6WlkPhfbPr
         Z0/4isL/yXdpBdT/MTLtVESwMqPH/v6u2ESjb234oIX/6qfpqMr0lt1xNV8P3GkrnfbD
         ZjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700013590; x=1700618390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKp1IVa8FokCsakCmu51XuRgPQg/O/K1X2iQKriLEpE=;
        b=i66x6QOYjdo2GYJ3a+4AcRyFCb5L9OPrSVL7JwIrtSmWSna++Qgh8fGTYiMHrs+bOX
         pL/Ibpoyi/+pz4m9AxaatCokk+7+QwetEHbtM7ilQbXpd1wqgNzv2ucjQ9Z7uYc+WIll
         LrmURnZJM3YiSfNKLJ/P3/QSwFKNCns8bYf6de7vqnowI67xZRvM5WodexdmLjObhbNz
         D/IpwWDKQoQsUop4IQCwjOtZ0Z+8DqEe3vxUx4m7IJS+RsHMHBBNBBApnZGtKoDUwN94
         g5ixm6Leaq0CKYQRsZUi0QG2yZoscmh1xI8ZD03kzfJFK3TMG+DI5/jmyi0ASlyACTy5
         5pvA==
X-Gm-Message-State: AOJu0YwhsttRNnlwcCCrbYUef3UFvwd/84TQasK6KYbEBxvKKOnNEj1q
        m3qVnkgYfh0zep6Z/ABGUWZoFlJShy8=
X-Google-Smtp-Source: AGHT+IHNjljHRDFVDK2/j/pMhmDAqhQPiur31Y+IBYW4/g4fv8vpVUjZvySR2BZKMnhg6YMzFAu9Nw==
X-Received: by 2002:a05:6a00:2e9e:b0:6c9:8b95:c054 with SMTP id fd30-20020a056a002e9e00b006c98b95c054mr1626745pfb.5.1700013589643;
        Tue, 14 Nov 2023 17:59:49 -0800 (PST)
Received: from [172.27.224.79] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7838e000000b006c345e192cfsm1825791pfm.119.2023.11.14.17.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 17:59:49 -0800 (PST)
Message-ID: <9395d416-cc5c-536d-641e-ffd971b682d1@gmail.com>
Date:   Wed, 15 Nov 2023 09:59:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/9] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20231110235528.1561679-1-seanjc@google.com>
 <20231110235528.1561679-7-seanjc@google.com>
 <ffec2e93-cdb1-25e2-06ec-deccf8727ce4@gmail.com>
 <ZVN6w2Kc2AUmIiJO@google.com>
Content-Language: en-US
From:   Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <ZVN6w2Kc2AUmIiJO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2023 9:48 PM, Sean Christopherson wrote:
> On Mon, Nov 13, 2023, Robert Hoo wrote:
...
>> u32 *caps  = vcpu->arch.cpu_caps;
>> and update guest_cpu_cap_set(), guest_cpu_cap_clear(),
>> guest_cpu_cap_change() and guest_cpu_cap_restrict() to pass in
>> vcpu->arch.cpu_caps instead of vcpu, since all of them merely refer to vcpu
>> cap, rather than whole vcpu info.
> 
> No, because then every caller would need extra code to pass vcpu->cpu_caps, 

Emm, I don't understand this. I tried to modified and compiled, all need to do 
is simply substitute "vcpu" with "vcpu->arch.cpu_caps" in calling. (at the end 
is my diff based on this patch set)

> and
> passing 'u32 *' provides less type safety than 'struct kvm_vcpu *'.  That tradeoff
> isn't worth making this one path slightly easier to read.

My point is also from vulnerability, long term, since as a principle, we'd 
better pass in param/info to a function of its necessity. e.g. cpuid_entry2_find().
Anyway, this is a less important point, shouldn't distract your focus.

This patch set's whole idea is good, I also felt confusion when initially 
looking into vCPUID code and its complicated dependencies with each other and 
KVM cap (or your word govern)  ( and even Kernel govern and HW cap ?). With this 
guest_cap[], the layered relationship can be much clearer, alone with fast guest 
cap queries.
> 
>> Or, for simple change, here rename variable name "caps" --> "vcpu", to less
>> reading confusion.
> 
> @vcpu is already defined and needs to be used in this function.  See the comment
> below.
> 
> I'm definitely open to a better name, though I would like to keep the name
> relative short so that the line lengths of the callers is reasonable, e.g. would
> prefer not to do vcpu_caps.
> 
>>> +	/*
>>> +	 * Don't update vCPU capabilities if KVM is updating CPUID entries that
>>> +	 * are coming in from userspace!
>>> +	 */
>>> +	if (entries != vcpu->arch.cpuid_entries)
>>> +		caps = NULL;
>>>    	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
>>> -	if (best) {
>>> -		/* Update OSXSAVE bit */
>>> -		if (boot_cpu_has(X86_FEATURE_XSAVE))
>>> -			cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
>>> +
>>> +	if (boot_cpu_has(X86_FEATURE_XSAVE))
>>> +		kvm_update_feature_runtime(caps, best, X86_FEATURE_OSXSAVE,
>>>    					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
>>> -		cpuid_entry_change(best, X86_FEATURE_APIC,
>>> -			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
>>> +	kvm_update_feature_runtime(caps, best, X86_FEATURE_APIC,
>>> +				   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6407e5c45f20..3e8976705342 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -262,7 +262,7 @@ static u64 cpuid_get_supported_xcr0(struct kvm_cpuid_entry2 
*entries, int nent)
         return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
  }

-static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
+static __always_inline void kvm_update_feature_runtime(u32 *guest_caps,
                                                        struct kvm_cpuid_entry2 
*entry,
                                                        unsigned int x86_feature,
                                                        bool has_feature)
@@ -270,15 +270,15 @@ static __always_inline void 
kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
         if (entry)
                 cpuid_entry_change(entry, x86_feature, has_feature);

-       if (vcpu)
-               guest_cpu_cap_change(vcpu, x86_feature, has_feature);
+       if (guest_caps)
+               guest_cpu_cap_change(guest_caps, x86_feature, has_feature);
  }

  static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct 
kvm_cpuid_entry2 *entries,
                                        int nent)
  {
         struct kvm_cpuid_entry2 *best;
-       struct kvm_vcpu *caps = vcpu;
+       u32 *caps = vcpu->arch.cpu_caps;

         /*
          * Don't update vCPU capabilities if KVM is updating CPUID entries that
@@ -397,7 +397,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
          */
         allow_gbpages = tdp_enabled ? boot_cpu_has(X86_FEATURE_GBPAGES) :
                                       guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES);
-       guest_cpu_cap_change(vcpu, X86_FEATURE_GBPAGES, allow_gbpages);
+       guest_cpu_cap_change(vcpu->arch.cpu_caps, X86_FEATURE_GBPAGES, 
allow_gbpages);

         best = kvm_find_cpuid_entry(vcpu, 1);
         if (best && apic) {
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 98694dfe062e..a3a0482fc514 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -183,39 +183,39 @@ static __always_inline bool guest_pv_has(struct kvm_vcpu 
*vcpu,
         return vcpu->arch.pv_cpuid.features & (1u << kvm_feature);
  }

-static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_set(u32 *caps,
                                               unsigned int x86_feature)
  {
         unsigned int x86_leaf = __feature_leaf(x86_feature);

         reverse_cpuid_check(x86_leaf);
-       vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
+       caps[x86_leaf] |= __feature_bit(x86_feature);
  }

-static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_clear(u32 *caps,
                                                 unsigned int x86_feature)
  {
         unsigned int x86_leaf = __feature_leaf(x86_feature);

         reverse_cpuid_check(x86_leaf);
-       vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
+       caps[x86_leaf] &= ~__feature_bit(x86_feature);
  }

-static __always_inline void guest_cpu_cap_change(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_change(u32 *caps,
                                                  unsigned int x86_feature,
                                                  bool guest_has_cap)
  {
         if (guest_has_cap)
-               guest_cpu_cap_set(vcpu, x86_feature);
+               guest_cpu_cap_set(caps, x86_feature);
         else
-               guest_cpu_cap_clear(vcpu, x86_feature);
+               guest_cpu_cap_clear(caps, x86_feature);
  }

-static __always_inline void guest_cpu_cap_restrict(struct kvm_vcpu *vcpu,
+static __always_inline void guest_cpu_cap_restrict(u32 *caps,
                                                    unsigned int x86_feature)
  {
         if (!kvm_cpu_cap_has(x86_feature))
-               guest_cpu_cap_clear(vcpu, x86_feature);
+               guest_cpu_cap_clear(caps, x86_feature);
  }

  static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6fe2d7bf4959..dd4ca07c3cd0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4315,14 +4315,14 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
          * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
          * the guest read/write access to the host's XSS.
          */
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
-       guest_cpu_cap_change(vcpu, X86_FEATURE_XSAVES,
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_XSAVE);
+       guest_cpu_cap_change(vcpu->arch.cpu_caps, X86_FEATURE_XSAVES,
                              boot_cpu_has(X86_FEATURE_XSAVES) &&
                              guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE));

-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_NRIPS);
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_TSCRATEMSR);
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_LBRV);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_NRIPS);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_TSCRATEMSR);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_LBRV);

         /*
          * Intercept VMLOAD if the vCPU mode is Intel in order to emulate that
@@ -4330,12 +4330,12 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
          * SVM on Intel is bonkers and extremely unlikely to work).
          */
         if (!guest_cpuid_is_intel(vcpu))
-               guest_cpu_cap_restrict(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
+               guest_cpu_cap_restrict(vcpu->arch.cpu_caps, 
X86_FEATURE_V_VMSAVE_VMLOAD);

-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_PAUSEFILTER);
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_PFTHRESHOLD);
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_VGIF);
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_VNMI);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_PAUSEFILTER);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_PFTHRESHOLD);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_VGIF);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_VNMI);

         svm_recalc_instruction_intercepts(vcpu, svm);

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7645945af5c5..c23c96dc24cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7752,13 +7752,13 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
          * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
          * set if and only if XSAVE is supported.
          */
-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVE);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_XSAVE);
         if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVE))
-               guest_cpu_cap_restrict(vcpu, X86_FEATURE_XSAVES);
+               guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_XSAVES);
         else
-               guest_cpu_cap_clear(vcpu, X86_FEATURE_XSAVES);
+               guest_cpu_cap_clear(vcpu->arch.cpu_caps, X86_FEATURE_XSAVES);

-       guest_cpu_cap_restrict(vcpu, X86_FEATURE_VMX);
+       guest_cpu_cap_restrict(vcpu->arch.cpu_caps, X86_FEATURE_VMX);

         vmx_setup_uret_msrs(vmx);

