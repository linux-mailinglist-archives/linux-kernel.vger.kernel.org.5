Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134877DF9F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbjKBSbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKBSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60167136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698949865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7gKntsq0pYbkfeFJCt8Zd0FsZ8RWC0rBYeV+n1CMQE=;
        b=fztEhlzu9Jmz2wiamBM3SQpokUQI8YN+zY9v4boeI8mkIzhYXvUNj/CIz5uVT/73u2GnRE
        ZsFXchclDJ26TNGy0Fwo1jODV5lSgofDEgie4jjpuuyzvAe8G5LHyt5U3TCvkIGL8zTBtr
        sFxkYRb9sckQE3yLOWJ/DPp+fxspWTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-B2vxhV5IM6qs3zK2uqen6Q-1; Thu, 02 Nov 2023 14:31:04 -0400
X-MC-Unique: B2vxhV5IM6qs3zK2uqen6Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-407d3e55927so7610055e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949863; x=1699554663;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7gKntsq0pYbkfeFJCt8Zd0FsZ8RWC0rBYeV+n1CMQE=;
        b=Gal/E3t1/xyeAGKHoUIlLIZBCw8lgKNOmY+qArud5JTxdAqJYg0rf7wpqhifyMaMTc
         XVMCSsosbep4mB0N7QLUECvsuhiJU6qogQlpGlHYrN5EC0+jRVjCbmgvjEsLLk4jorSl
         yb3Z65q7W24Lf+rm7mK8ZVu7oRnKgCQBr2J8zYIWWuZKoF8inCnForX5cxktoIcbWqa5
         +3o7+JIpM/tgb7byfdHsaf/IMd00QwCwFo6euOBlO2X3KdmyY7fUN+j49wlta998WBt4
         Ztz17+eC4tSsV296Bfn6h61b0aSVyN+j/sr21ZZrrK3ef1bj7ffhZ0zk7lN55kO9xbxe
         +b0Q==
X-Gm-Message-State: AOJu0Yws60GPNfXsO1W0mEUQNSeKyracOOIomG6CtlcsytCgBssyzpwm
        v/AtPDpVf+lm3mev2KQZqRqTDZ6N9OYvH9Dg4xiyrDUaIR7QadqhMBu9utQrmRLJGQzRAZJtUAB
        UWMuEaew8kFgbH++lciWoZ/7T
X-Received: by 2002:a5d:60ce:0:b0:32d:9d64:b429 with SMTP id x14-20020a5d60ce000000b0032d9d64b429mr12661644wrt.21.1698949862981;
        Thu, 02 Nov 2023 11:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyTRjHBh4XLFLlF8nlOfhVj+y0WDCs7teQHeawFTI0NTv0xngknPHSE7Z7tkUMfFXuAsyYMw==
X-Received: by 2002:a5d:60ce:0:b0:32d:9d64:b429 with SMTP id x14-20020a5d60ce000000b0032d9d64b429mr12661624wrt.21.1698949862647;
        Thu, 02 Nov 2023 11:31:02 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id dd23-20020a0560001e9700b0032f7f4d008dsm21268wrb.20.2023.11.02.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:31:02 -0700 (PDT)
Message-ID: <f2fa2c78a45eb95ba7458bfe6bc7ca7d91f63467.camel@redhat.com>
Subject: Re: [PATCH v6 11/25] KVM: x86: Report XSS as to-be-saved if there
 are supported features
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 02 Nov 2023 20:31:00 +0200
In-Reply-To: <ZUKknZ7qEzzQ5Cgi@google.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-12-weijiang.yang@intel.com>
         <e10fb116aa67509f7a63660a6b0731e28935c820.camel@redhat.com>
         <ZUKknZ7qEzzQ5Cgi@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 12:18 -0700, Sean Christopherson wrote:
> On Tue, Oct 31, 2023, Maxim Levitsky wrote:
> > On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > > 
> > > Add MSR_IA32_XSS to list of MSRs reported to userspace if supported_xss
> > > is non-zero, i.e. KVM supports at least one XSS based feature.
> > 
> > I can't believe that CET is the first supervisor feature that KVM supports...
> > 
> > Ah, now I understand why:
> > 
> > 1. XSAVES on AMD can't really be intercepted (other than clearing CR4.OSXSAVE
> >    bit, which isn't an option if you want to support AVX for example) On VMX
> >    however you can intercept XSAVES and even intercept it only when it touches
> >    specific bits of state that you don't want the guest to read/write freely.
> > 
> > 2. Even if it was possible to intercept it, guests use XSAVES on every
> >    context switch if available and emulating it might be costly.
> > 
> > 3. Emulating XSAVES is also not that easy to do correctly.
> > 
> > However XSAVES touches various MSRs, thus letting the guest use it
> > unintercepted means giving access to host MSRs, which might be wrong security
> > wise in some cases.
> > 
> > Thus I see that KVM hardcodes the IA32_XSS to 0, and that makes the XSAVES
> > work exactly like XSAVE.
> > 
> > And for some features which would benefit from XSAVES state components,
> > KVM likely won't even be able to do so due to this limitation.
> > (this is allowed thankfully by the CPUID), forcing the guests to use
> > rdmsr/wrmsr instead.
> 
> Sort of?  KVM doesn't (yet) virtualize PASID, HDC, HWP, or arch LBRs (wow,
> there's a lot of stuff getting thrown into XSTATE), so naturally those aren't
> supported in XSS.
> 
> KVM does virtualize Processor Trace (PT), but PT is a bit of a special snowflake.
> E.g. the host kernel elects NOT to manage PT MSRs via XSTATE, but it would be
> possible for KVM to the guest to manage PT MSRs via XSTATE.

I must also note that PT doesn't always uses guest physical addresses to write
its trace output, because there is a secondary execution control 
'Intel PT uses guest physical addresses', however I see that KVM requires it, so yes,
we could likely have supported PT xsaves component.

> 
> I suspect the answer to PT is threefold:
> 
>  1. Exposing a feature that isn't "supported" by the host kernel is scary.
>  2. No one has pushed for the support, e.g. Linux guests obviously don't complain
>     about lack of XSS support for PT.
>  3. Toggling PT MSR passthrough on XSAVES/XRSTORS accesses would be more complex
>     and less performant than KVM's current approach.
> 
> Re: #3, KVM does passthrough PT MSRs, but only when the guest is actively using
> PT.  PT is basically a super fancy PMU feature, and so KVM "needs" to load guest
> state as late as possible before VM-Entry, and load host state as early as possible
> after VM-Exit.  I.e. the context switch happens on *every* entry/exit pair.
> 
Makes sense.

> By passing through PT MSRs only when needed, KVM avoids a rather large pile of
> RDMSRs and WRMSRs on every entry/exit, as the host values can be kept resident in
> hardware so long as the main enable bit is cleared in the guest's control MSR
> (which is context switch via a dedicated VMCS field).
> 
> XSAVES isn't subject to MSR intercepts, but KVM could utilize VMX's XSS-exiting
> bitmap to effectively intercept reads and writes to PT MSRs.  Except that as you
> note, KVM would either need to emulate XSAVES (oof) or save/load PT MSRs much more
> frequently.
> 
> So it's kind of an emulation thing, but I honestly doubt that emulating XSAVES
> was ever seriously considered when KVM support for PT was added.
> 
> CET is different than PT because the MSRs that need to be context switched at
> every entry/exit have dedicated VMCS fields.  The IA32_PLx_SSP MSRs don't have
> VMCS fields, but they are consumed only in privelege level changes, i.e. can be
> safely deferred until guest "FPU" state is put.
> 
> > However it is possible to enable IA32_XSS bits in case the msrs XSAVES
> > reads/writes can't do harm to the host, and then KVM can context switch these
> > MSRs when the guest exits and that is what is done here with CET.
> 
> This isn't really true.  It's not a safety or correctness issue so much as it's
> a performance issue. 
True as well, I haven't thought about it from this POV.


>  E.g. KVM could let the guest use XSS for any virtualized
> feature, but it would effectively require context switching related state that
> the host needs loaded "immediately" after VM-Exit.  And for MSRs, that gets
> very expensive without dedicated VMCS fields.

Yes, unless allowing setting a MSR via xrstors causes harm to the host,
(for example msr that has a physical address in it). 

Such MSRs cannot be allowed to be set by the guest even for the duration of the guest run,
and that means that we cannot pass through the corresponding XSS state component.

> 
> I mean, yeah, it's a correctness thing to not consume guest state in the host
> and vice versa, but that's not unique to XSS in any way.
> 

Best regards,
	Maxim Levitsky


