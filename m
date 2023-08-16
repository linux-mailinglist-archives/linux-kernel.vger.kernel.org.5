Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D477E35D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjHPOPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbjHPOP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:15:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22D26BF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:15:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6887a398cd6so1284357b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692195328; x=1692800128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNXQwyFgL/nF2McBfL9JuiSI+rCYCvflVJEMmY8Rc/c=;
        b=K9Rg0s8Hs2FCUTTdqjupHxk+9bA6sT/r1KWlIiJh46SUclYTej1jnl1o1vT4KC1t7h
         ooz9xBBRowyz+ozfljUI7cb2TT2X0K3psoLtzwIQseyF9z4F6/51rhfcsP0ZSvLJ5YLG
         GzR66ju4G5T8NI6qd//9VIdP2E7QnItsSV5uVGsDBKHVtCpOMlirfCow41/AQbggwRqj
         Wgp1GgvWrfxIUaSl/9j+fLqCcJXJ8jiyZa7RVBAV0twIAwTQFQLfOROzUFTil1Hglyh/
         AI/FnGGDrsfB4lCtB741NsJwbqMFMZZAs/B55mW/swwGgDD3krkq+Obdg6R79+1wsu26
         Dsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692195328; x=1692800128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNXQwyFgL/nF2McBfL9JuiSI+rCYCvflVJEMmY8Rc/c=;
        b=CzREzF9K9UXRJNT83ynndyCpmKW2JhDv35ufv15MtrJZAQealyqPd172zYo4ovoIZ6
         6udN3ti28jpURMh+/j3mSItR6AvhQIAHQfDLakePbzi9gaYrUuZxlWG0jkEqmeosC7JI
         HDQDiDYxYc7jIruy2aJS3Rc3759JXkUJDibL0EakbYl09oFeDQWZZOKm56lPScrFQcIX
         kxvNSdyQ++eQtlnDpoiBKdeiwG9m++KvrjzuX5J68fThVsfifpRvA0bvbhIFYrISS9Vd
         TvDVISK2SZOH6y79dAYTf/QPk1vnYo8oNleMyb4SwxRe3/Pnd/BwUadnI6BxOymniln+
         Bgiw==
X-Gm-Message-State: AOJu0Yxf/Qw2GvV+5fvR1o4XaExnIajF5BoyUSsnwdmRfqfkfCCtr47s
        +qeDT7LeoENAIVtxPZhY9bHO6uRh0n8=
X-Google-Smtp-Source: AGHT+IF25rOUR3yngiVCMb4VMmhApZpKoR0qlwJ2PfREPozudLPk4gBnRNPMOgkQ0PrqNhfMYXT/6J/PlnY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:22cb:b0:674:1663:1270 with SMTP id
 f11-20020a056a0022cb00b0067416631270mr970219pfj.4.1692195327813; Wed, 16 Aug
 2023 07:15:27 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:15:26 -0700
In-Reply-To: <87y1ib5sta.fsf@redhat.com>
Mime-Version: 1.0
References: <20230815203653.519297-1-seanjc@google.com> <20230815203653.519297-6-seanjc@google.com>
 <87y1ib5sta.fsf@redhat.com>
Message-ID: <ZNzZ/vpK6lgvc62d@google.com>
Subject: Re: [PATCH v3 05/15] KVM: VMX: Rename XSAVES control to follow KVM's
 preferred "ENABLE_XYZ"
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > index 0d02c4aafa6f..0e73616b82f3 100644
> > --- a/arch/x86/include/asm/vmx.h
> > +++ b/arch/x86/include/asm/vmx.h
> > @@ -71,7 +71,7 @@
> >  #define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
> >  #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
> >  #define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
> > -#define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
> > +#define SECONDARY_EXEC_ENABLE_XSAVES		VMCS_CONTROL_BIT(XSAVES)
> >  #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
> >  #define SECONDARY_EXEC_PT_USE_GPA		VMCS_CONTROL_BIT(PT_USE_GPA)
> >  #define SECONDARY_EXEC_TSC_SCALING              VMCS_CONTROL_BIT(TSC_SCALING)
> 
> To avoid the need to make up these names in KVM we can probably just
> stick to SDM; that would make it easier to make a connection between KVM
> and Intel docs if needed. E.g. SDM uses "Use TSC scaling" so this
> could've been "SECONDARY_EXEC_USE_TSC_SCALING" for consistency.
> 
> Unfortunatelly, SDM itself is not very consistent in the naming,
> e.g. compare "WBINVD exiting"/"RDSEED exiting" with "Enable ENCLS
> exiting"/"Enable ENCLV exiting" but I guess we won't be able to do
> significantly better in KVM anyways..

Heh, I agree that we should default to whatever the SDM uses, but I disagree with
the assertion that KVM can't do better.  Every once in a while the SDM ends up with
a name that is weirdly different for no obvious reason, or aggressively abbreviated
to the point where the "name" is completely inscrutable without an absurb amount of
context (I've mostly seen this with MSR bits).

In those cases I think we should exercise common sense and deviate from the SDM,
e.g. in the outliers you pointed out, omit the "ENABLE" from the ENCLS/ENCLV flags.
