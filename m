Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EB7DE499
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjKAQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:32:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8CB101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:31:58 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc323b2aa3so30372455ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698856318; x=1699461118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YV/Jadwf9F+4h9faQyKBO/VGXY2YU0z1WDp/3xRNHSA=;
        b=H0peW2VgEHgEAmUBl8WSgwDu6k3CQIV6n15GUScEvSn79JwEn8g4dsqv2PfNQmSRHg
         mOr2XyOBSXinROqvvc2GgKs1M6Psbmyf3XBBY7PvM9YV5NQChNUy3xr0RR1I0AdhZFNj
         /SEtTbNu0cOhpnalVQUgXoJd6qFRGEirEilPOzervJ/2/0VSipCg1CQpoQKk5UNouxy0
         71lE735dwCIub4yXv1iTRdUMUZ3mAyODMCZLa3WDd4K01dmctSTNMadjXZeKZf7Okjqb
         G8704HOhBl/ifqqMLgPT98Ih3vTLySx1YzU1a92CT0vd+c0zoH8M5gkyV02gwZzB2ptg
         x/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856318; x=1699461118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV/Jadwf9F+4h9faQyKBO/VGXY2YU0z1WDp/3xRNHSA=;
        b=GjB7cdmOaYm67bPAWU/96JV8q45KwK4N4MM/36UaNsHKbugGcHHlkXanWhSzpgvdTY
         0Cw74+WLNKnXzFdoyfUsLb5VEZ/WIDOoQOhKvK6ZraNdNukvmgIe/ggevcw5hKCYjWY/
         GHjNwRQ7tpz/wqy3T6e+nTsoAeaM7R5G6JokKffmAMVxVZgQstUHQMOkhGuiqK14ol5f
         oh0Zcac/ViXQemMiKbU1mgLp/zy9Tu5bbXPf3OaB8waPbvziFlIfscYUbSPgfANkLjzF
         k5E6w80oV5ajNI+48ESRT1JfRQUfoHBuVHygEI43VRXr7erxh9hm8qMyproXLeV0AXYF
         j0CQ==
X-Gm-Message-State: AOJu0YyOxvA1R/LzYpF8flCs0UspjZArd12Gw9vMJUh3mTJK0pUS+cg0
        w5ZaFFFphq4RmpEb+8cic/4j+EBkC5Y=
X-Google-Smtp-Source: AGHT+IFjPqC/TQoUJx9xijTOJvOyhtwW2g8NWHhEyZb55Fnj2J2udLjDB8ouZshuVH4VRanHeJsp8MbYxRU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:25d2:b0:1cc:2ffe:5a27 with SMTP id
 jc18-20020a17090325d200b001cc2ffe5a27mr230020plb.9.1698856318050; Wed, 01 Nov
 2023 09:31:58 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:31:56 -0700
In-Reply-To: <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-20-weijiang.yang@intel.com> <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
Message-ID: <ZUJ9fDuQUNe9BLUA@google.com>
Subject: Re: [PATCH v6 19/25] KVM: VMX: Emulate read and write to CET MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
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

On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > Add emulation interface for CET MSR access. The emulation code is split
> > into common part and vendor specific part. The former does common check
> > for MSRs and reads/writes directly from/to XSAVE-managed MSRs via the
> > helpers while the latter accesses the MSRs linked to VMCS fields.
> > 
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---

...

> > +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > +	case MSR_KVM_SSP:
> > +		if (host_msr_reset && kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> > +			break;
> > +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > +			return 1;
> > +		if (index == MSR_KVM_SSP && !host_initiated)
> > +			return 1;
> > +		if (is_noncanonical_address(data, vcpu))
> > +			return 1;
> > +		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
> > +			return 1;
> > +		break;
> Once again I'll prefer to have an ioctl for setting/getting SSP, this will
> make the above code simpler (e.g there will be no need to check that write
> comes from the host/etc).

I don't think an ioctl() would be simpler overall, especially when factoring in
userspace.  With a synthetic MSR, we get the following quite cheaply:

 1. Enumerating support to userspace.
 2. Save/restore of the value, e.g. for live migration.
 3. Vendor hooks for propagating values to/from the VMCS/VMCB.

For an ioctl(), #1 would require a capability, #2 (and #1 to some extent) would
require new userspace flows, and #3 would require new kvm_x86_ops hooks.

The synthetic MSR adds a small amount of messiness, as does bundling 
MSR_IA32_INT_SSP_TAB with the other shadow stack MSRs.  The bulk of the mess comes
from the need to allow userspace to write '0' when KVM enumerated supported to
userspace.

If we isolate MSR_IA32_INT_SSP_TAB, that'll help with the synthetic MSR and with
MSR_IA32_INT_SSP_TAB.  For the unfortunate "host reset" behavior, the best idea I
came up with is to add a helper.  It's still a bit ugly, but the ugliness is
contained in a helper and IMO makes it much easier to follow the case statements.

get:

	case MSR_IA32_INT_SSP_TAB:
		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) ||
		    !guest_cpuid_has(vcpu, X86_FEATURE_LM))
			return 1;
		break;
	case MSR_KVM_SSP:
		if (!host_initiated)
			return 1;
		fallthrough;
	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
			return 1;
		break;

static bool is_set_cet_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u64 data,
				   bool host_initiated)
{
	bool any_cet = index == MSR_IA32_S_CET || index == MSR_IA32_U_CET;

	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
		return true;

	if (any_cet && guest_can_use(vcpu, X86_FEATURE_IBT))
		return true;

	/* 
	 * If KVM supports the MSR, i.e. has enumerated the MSR existence to
	 * userspace, then userspace is allowed to write '0' irrespective of
	 * whether or not the MSR is exposed to the guest.
	 */
	if (!host_initiated || data)
		return false;

	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK))
		return true;

	return any_cet && kvm_cpu_cap_has(X86_FEATURE_IBT);
}

set:
	case MSR_IA32_U_CET:
	case MSR_IA32_S_CET:
		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
			return 1;
		if (data & CET_US_RESERVED_BITS)
			return 1;
		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK) &&
		    (data & CET_US_SHSTK_MASK_BITS))
			return 1;
		if (!guest_can_use(vcpu, X86_FEATURE_IBT) &&
		    (data & CET_US_IBT_MASK_BITS))
			return 1;
		if (!IS_ALIGNED(CET_US_LEGACY_BITMAP_BASE(data), 4))
			return 1;

		/* IBT can be suppressed iff the TRACKER isn't WAIT_ENDBR. */
		if ((data & CET_SUPPRESS) && (data & CET_WAIT_ENDBR))
			return 1;
		break;
	case MSR_IA32_INT_SSP_TAB:
		if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
			return 1;

		if (is_noncanonical_address(data, vcpu))
			return 1;
		break;
	case MSR_KVM_SSP:
		if (!host_initiated)
			return 1;
		fallthrough;
	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
		if (!is_set_cet_msr_allowed(vcpu, index, data, host_initiated))
			return 1;
		if (is_noncanonical_address(data, vcpu))
			return 1;
		if (!IS_ALIGNED(data, 4))
			return 1;
		break;
	}
