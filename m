Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE0782E78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjHUQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjHUQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:35:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365D102
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:35:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8cbf0a0dso88137747b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692635742; x=1693240542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQFX6ESeM4R4rw5GzIZsjrnEk3F+GGnFXRzOfWAG62w=;
        b=RnmJnS4hSB2sb8nZrvQvMN0bPd7GSMmBrehu5jBe406BkO3nqWMhMlPHfnSJkOMHhE
         oT9cBOSC0xl0s+IuY7alVxHlHdcIhaIJF7KqT+l6j7eCQTIJ7hKfp7dDrdL2oUzZA/k2
         qkJu9ewDOj5RYAZ6JqQqCG8B6fCPU242QIu/4xux5PvjpPKXDn19Ll+TxaNlA2Bde+2E
         XbS5cQxFjKWVr0Q7DvpPU13AcfwjkimcxWKoHY4mQDg5Hp3SmiJFbnMOhPKC5BtpqSLf
         jhSR5rIbIqZyiC+l13648JQUvtG/F76vj3Jb6OCNGVXro4x7B+0+bHJl4z0zpOjlc7K0
         gTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635742; x=1693240542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQFX6ESeM4R4rw5GzIZsjrnEk3F+GGnFXRzOfWAG62w=;
        b=RPDEYpNw9O7z0zV2Z2VuQfymZrXmeNGLZxT0tYukAkc1/fRD6EAHmNx7FJTRkMYJ+A
         pS0DtWVOlusP5F/WtMiOGmH0ha23b0DK3s6e5tjSVDDasz+F+51zvZ1pDXeH2X+Vq2jr
         v3fV4zBJtWHH4yUZlzojUMIo65nYfl5sdBezeg4Mq9s9r7CgU2iXEordwbP75xGVDr+Y
         pPKPztrd1qy15wydNZ67Ksuup2bWZ4OFaVLBjHjUBtBBhzWle9fXikHMvm820COeEuAB
         o2pzOH/cKzirWnPRX7Lc4d/aQourQuRONo6OK5uvmu+oglnSEmzpbbIRH885r488pOn8
         D38Q==
X-Gm-Message-State: AOJu0Yxw/qoiV8lAwjXCJckZC4Cx+a7dxN6zS1XX2wc5uGXbMrBWhy8x
        5x4aFdCJmQ+T0eVwd09ucsWx8VvGBJU=
X-Google-Smtp-Source: AGHT+IGTkvGv8dxGThu+459+aDKK2l8D6TQ1Z9kTIM8+olsej/sYLmEKwn/zrKNfMC6VfheUOKWzK6gvyKo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad14:0:b0:58c:e8da:4d1a with SMTP id
 l20-20020a81ad14000000b0058ce8da4d1amr110163ywh.2.1692635742668; Mon, 21 Aug
 2023 09:35:42 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:35:41 +0000
In-Reply-To: <20230821162337.imzjf3golstkrrgd@treble>
Mime-Version: 1.0
References: <cover.1692580085.git.jpoimboe@kernel.org> <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com> <20230821162337.imzjf3golstkrrgd@treble>
Message-ID: <ZOOSXc9NE1rMHDZ1@google.com>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
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

On Mon, Aug 21, 2023, Josh Poimboeuf wrote:
> On Mon, Aug 21, 2023 at 10:34:38AM +0100, Andrew Cooper wrote:
> > On 21/08/2023 2:19 am, Josh Poimboeuf wrote:
> > > The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.
> > 
> > "Current hardware".
> > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index c381770bcbf1..dd7472121142 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -3676,12 +3676,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >  		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
> > >  			return 1;
> > >  
> > > -		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
> > > +		if (boot_cpu_has(X86_FEATURE_IBPB) && data == PRED_CMD_IBPB)
> > > +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> > > +		else if (boot_cpu_has(X86_FEATURE_SBPB) && data == PRED_CMD_SBPB)
> > > +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_SBPB);
> > > +		else if (data)
> > >  			return 1;
> > 
> > SBPB | IBPB is an explicitly permitted combination, but will be rejected
> > by this logic.
> 
> Ah yes, I see that now:
> 
>   If software writes PRED_CMD with both bits 0 and 7 set to 1, the
>   processor performs an IBPB operation.

The KVM code being a bit funky isn't doing you any favors.  This is the least
awful approach I could come up with:

	case MSR_IA32_PRED_CMD: {
		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);

		if (!msr_info->host_initiated) {
			if (!guest_has_pred_cmd_msr(vcpu))
				return 1;

			if (!guest_cpuid_has(vcpu, X86_FEATURE_SBPB))
				reserved_bits |= PRED_CMD_SBPB;
		}

		if (!boot_cpu_has(X86_FEATURE_IBPB))
			reserved_bits |= PRED_CMD_IBPB;

		if (!boot_cpu_has(X86_FEATURE_SBPB))
			reserved_bits |= PRED_CMD_SBPB;

		if (!data)
			break;

		wrmsrl(MSR_IA32_PRED_CMD, data);
		break;
	}

There are more wrinkles though.  KVM passes through MSR_IA32_PRED_CMD based on
IBPB.  If hardware supports both IBPB and SBPB, but userspace does NOT exposes
SBPB to the guest, then KVM will create a virtualization hole where the guest can
write SBPB against userspace's wishes.  I haven't read up on SBPB enought o know
whether or not that's problematic.

And conversely, if userspace expoes SBPB but not IBPB, then KVM will intercept
writes to MSR_IA32_PRED_CMD and probably tank guest performance.  Again, I haven't
paid attention enough to know if this is a reasonable configuration, i.e. whether
or not it's worth caring about in KVM.

If the virtualization holes are deemed safe, then the easiest thing would be to
treat MSR_IA32_PRED_CMD as existing if either IBPB or SBPB exists.  E.g.

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index b1658c0de847..e4db844a58fe 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -174,7 +174,8 @@ static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
 static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
 {
        return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
-               guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB));
+               guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
+               guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
 }
 
 static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 12688754c556..aa4620fb43f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3656,17 +3656,33 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
                vcpu->arch.perf_capabilities = data;
                kvm_pmu_refresh(vcpu);
                break;
-       case MSR_IA32_PRED_CMD:
-               if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
-                       return 1;
+       case MSR_IA32_PRED_CMD: {
+               u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
+
+               if (!msr_info->host_initiated) {
+                       if (!guest_has_pred_cmd_msr(vcpu))
+                               return 1;
+
+                       if (!guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
+                           !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB))
+                               reserved_bits |= PRED_CMD_IBPB;
+
+                       if (!guest_cpuid_has(vcpu, X86_FEATURE_SBPB))
+                               reserved_bits |= PRED_CMD_SBPB;
+               }
+
+               if (!boot_cpu_has(X86_FEATURE_IBPB))
+                       reserved_bits |= PRED_CMD_IBPB;
+
+               if (!boot_cpu_has(X86_FEATURE_SBPB))
+                       reserved_bits |= PRED_CMD_SBPB;
 
-               if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
-                       return 1;
                if (!data)
                        break;
 
-               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
+               wrmsrl(MSR_IA32_PRED_CMD, data);
                break;
+       }
        case MSR_IA32_FLUSH_CMD:
                if (!msr_info->host_initiated &&
                    !guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D))
