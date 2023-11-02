Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3607DFD64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKBX6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjKBX6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:58:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D1193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:58:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so20441367b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698969527; x=1699574327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4tjnGpFWX0ueNFeTtSdnMph2gJgcBhqin9rkQkui7U=;
        b=e3EsYydG6yaGIayNWhO3ouzjLRrFKXmG23KlGGNFWCMA8edSX5FBz/5wbSpdFMSX21
         PMqk2RhfC4eNUIY1bKmWc1L3O8xk5EbyuvcuaukMTZuFr8NnTX8cdLP+DFc2AMAhvlHW
         JVHwdsmDDj8h5tSk7fDKDYKcaDdk/HQlIuUjpdT114n70cCzf1GHL0Fh1Eq2BF33JS+G
         dFP4410zrZmlyinqKXETV94QRYpHVHgUA/FlI0RIpShsAGH2bCue17+ld2QncBCUdMEj
         0gsKmhHFtoetQuQKirVwa5ULFfzUMP0aCkgAtveeIGDRv1za4gcaEY8TnlIWC6pT1iA/
         +pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698969527; x=1699574327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4tjnGpFWX0ueNFeTtSdnMph2gJgcBhqin9rkQkui7U=;
        b=Jt1ZjxI3f+HkNeGyURQo5S+Cuc6I/xh81Xb+OzG50oJgpgBR/sHgriV7EjYHx9/H1O
         +l72yWkNoEyhUsMQ/QwlrWWcObCOacR02w0vH1clHvFP6sWMM79KuTPtoamTOMt/EYJk
         +ZSvtALfrZoxQGoBvve6tuWitJXwObA4TxdyyAxAfMQgOynSWw4btF1A0TrMvtxIiWFO
         QCTh8m2iYbJshqyVeEfBYYkme5xD2Cen017zFPbaGjQVRmMgOp7ScLleJyvz26MmQFFQ
         cGfAnYB71kufGQnX9aE6PFCw79zYbeRaWnnShrUb02nTHvtptDHUxS6ItfcAPE28Js6z
         V8Tg==
X-Gm-Message-State: AOJu0Yz0clWGDwpJzq2gZr19FpDWT78Z7YSG4FL0kUNMnKB77fVsT3Tw
        vMOiJoMhGLcWe4xvguq4rcRw4XI3/JQ=
X-Google-Smtp-Source: AGHT+IF7dwAAbp+cysYu4Z3itG12L4BxhEAvLhk5APpsVVgEVmCTWLw6MkXUOKe9rJcmC12wneai/pg0D5M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4f8f:0:b0:5a8:170d:45a9 with SMTP id
 d137-20020a814f8f000000b005a8170d45a9mr20253ywb.8.1698969527017; Thu, 02 Nov
 2023 16:58:47 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:58:45 -0700
In-Reply-To: <ff6b7e9d90d80feb9dcabb0fbd3808c04db3ff94.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-20-weijiang.yang@intel.com> <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
 <ZUJ9fDuQUNe9BLUA@google.com> <ff6b7e9d90d80feb9dcabb0fbd3808c04db3ff94.camel@redhat.com>
Message-ID: <ZUQ3tcuAxYQ5bWwC@google.com>
Subject: Re: [PATCH v6 19/25] KVM: VMX: Emulate read and write to CET MSRs
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

On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> On Wed, 2023-11-01 at 09:31 -0700, Sean Christopherson wrote:
> > On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > > Add emulation interface for CET MSR access. The emulation code is split
> > > > into common part and vendor specific part. The former does common check
> > > > for MSRs and reads/writes directly from/to XSAVE-managed MSRs via the
> > > > helpers while the latter accesses the MSRs linked to VMCS fields.
> > > > 
> > > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > > ---
> > 
> > ...
> > 
> > > > +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> > > > +	case MSR_KVM_SSP:
> > > > +		if (host_msr_reset && kvm_cpu_cap_has(X86_FEATURE_SHSTK))
> > > > +			break;
> > > > +		if (!guest_can_use(vcpu, X86_FEATURE_SHSTK))
> > > > +			return 1;
> > > > +		if (index == MSR_KVM_SSP && !host_initiated)
> > > > +			return 1;
> > > > +		if (is_noncanonical_address(data, vcpu))
> > > > +			return 1;
> > > > +		if (index != MSR_IA32_INT_SSP_TAB && !IS_ALIGNED(data, 4))
> > > > +			return 1;
> > > > +		break;
> > > Once again I'll prefer to have an ioctl for setting/getting SSP, this will
> > > make the above code simpler (e.g there will be no need to check that write
> > > comes from the host/etc).
> > 
> > I don't think an ioctl() would be simpler overall, especially when factoring in
> > userspace.  With a synthetic MSR, we get the following quite cheaply:
> > 
> >  1. Enumerating support to userspace.
> >  2. Save/restore of the value, e.g. for live migration.
> >  3. Vendor hooks for propagating values to/from the VMCS/VMCB.
> > 
> > For an ioctl(), 
> > #1 would require a capability, #2 (and #1 to some extent) would
> > require new userspace flows, and #3 would require new kvm_x86_ops hooks.
> > 
> > The synthetic MSR adds a small amount of messiness, as does bundling 
> > MSR_IA32_INT_SSP_TAB with the other shadow stack MSRs.  The bulk of the mess comes
> > from the need to allow userspace to write '0' when KVM enumerated supported to
> > userspace.
> 
> Let me put it this way - all hacks start like that, and in this case this is API/ABI hack
> so we will have to live with it forever.

Eh, I don't view it as a hack, at least the kind of hack that has a negative
connotation.  KVM effectively has ~240 MSR indices reserved for whatever KVM
wants.  The only weird thing about this one is that it's not accessible from the
guest.  Which I agree is quite weird, but from a code perspective I think it
works quite well.

> Once there is a precedent, trust me there will be 10s of new 'fake' msrs added, and the
> interface will become one big mess.

That suggests MSRs aren't already one big mess. :-)  I'm somewhat joking, but also
somewhat serious.  I really don't think that adding one oddball synthetic MSR is
going to meaningfully move the needle on the messiness of MSRs.

Hmm, there probably is a valid slippery slope argument though.  As you say, at
some point, enough state will get shoved into hardware that KVM will need an ever
growing number of synthetic MSRs to keep pace.

> As I suggested, if you don't want to add new capability/ioctl and vendor
> callback per new x86 arch register, then let's implement
> KVM_GET_ONE_REG/KVM_SET_ONE_REG and then it will be really easy to add new
> regs without confusing users, and without polluting msr namespace with msrs
> that don't exist.

I definitely don't hate the idea of KVM_{G,S}ET_ONE_REG, what I don't want is to
have an entirely separate path in KVM for handling the actual get/set.

What if we combine the approaches?  Add KVM_{G,S}ET_ONE_REG support so that the
uAPI can use completely arbitrary register indices without having to worry about
polluting the MSR space and making MSR_KVM_SSP ABI.

Ooh, if we're clever, I bet we can extend KVM_{G,S}ET_ONE_REG to also work with
existing MSRs, GPRs, and other stuff, i.e. not force userspace through the funky
KVM_SET_MSRS just to set one reg, and not force a RMW of all GPRs just to set
RIP or something.  E.g. use bits 39:32 of the id to encode the register class,
bits 31:0 to hold the index within a class, and reserve bits 63:40 for future
usage.

Then for KVM-defined registers, we can route them internally as needed, e.g. we
can still define MSR_KVM_SSP so that internal it's treated like an MSR, but its
index isn't ABI and so can be changed at will.  And future KVM-defined registers
wouldn't _need_ to be treated like MSRs, i.e. we could route registers through
the MSR APIs if and only if it makes sense to do so.

Side topic, why on earth is the data value of kvm_one_reg "addr"?
