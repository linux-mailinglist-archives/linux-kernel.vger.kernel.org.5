Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B01E7DFD42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKBXWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:22:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1ED13E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:22:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9b0850fdso20564387b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698967350; x=1699572150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YRkB8htpyDPTu6BgYSX0PLd58VnN26LAJgP50Ott6I=;
        b=zCIKELSSbx95KtavTspW4KdKDJgIf1MadCCL3+dncSnAH6dDxDEol72AJReT+zBGEN
         zOA/x59duzPx24gsj3uvZjaMPD5WAFlPQvQD5SQ5c7+nNzABmNNW9yQDgiaHQpiMBIgb
         A+r0ixHj4K2elL+vaIRsuNsBOgJPWnBQYdigZBZdVAW2sDg+5oRHNLcv95pDVIliROFH
         xbGg0axSBAYiJOpKSiRVnp4EWUibkskOI2GjkJWw9ZOl7G3Fx82atei0GXDFgzbqGDT6
         fm3CCb0GL1MC7IhRxg1/dHoeUxJ1JXMKRqY6JCe1IvrlrloNxUdEI28EusT+SldLnFsQ
         uMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698967350; x=1699572150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YRkB8htpyDPTu6BgYSX0PLd58VnN26LAJgP50Ott6I=;
        b=LbWEns1IUR/EnbwmMNAh+MqqYsWb3Ur3f3QjtApNkhM6NPI1sGk08+oNYrbWQjSh/p
         kMAKsAxESyG2EeDmZ3pKB84v3FpE0voz8ZdPUCLlX4inmSqMdrq+og0A79zAmzb2wkeL
         w6khI0f/c/ynU5fqg4UL94L4JtCXwOnvCfU1MnyG0Qh4yqQOaQK7qSx7AgQsXSq9VQtm
         HYBcj9ZzSFbuVSFfd+zycwmFaAFIDokza/fBiOVXLhYMJdh8kir5HF9kBnf1T+xjGDq/
         Ii1fgjEJoQQY6YZxEOK+r+Rs0JdrydMugriX3BXWP2fd92QHdkxpp8p9T5BObD9F64si
         y4Hw==
X-Gm-Message-State: AOJu0Yzt5Ls+tJBj7lqartXxWSxGLhlQobPz+OIw8ono7kvqDg687OoQ
        sZDmJxBeOuevfwGilEAfcV47dWmcxuU=
X-Google-Smtp-Source: AGHT+IFpguaXjs1mFtQIBReFFSAFNL6cabRLrkwBDxjS6lYP3wyg0FizgaCLqz3Go16Ls1bDM+ff9pyh/ZM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:830d:0:b0:576:af04:3495 with SMTP id
 t13-20020a81830d000000b00576af043495mr19461ywf.9.1698967349975; Thu, 02 Nov
 2023 16:22:29 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:22:28 -0700
In-Reply-To: <5e413e05de559971cdc2d1a9281a8a271590f62b.camel@redhat.com>
Mime-Version: 1.0
References: <20231010200220.897953-1-john.allen@amd.com> <20231010200220.897953-7-john.allen@amd.com>
 <5e413e05de559971cdc2d1a9281a8a271590f62b.camel@redhat.com>
Message-ID: <ZUQvNIE9iU5TqJfw@google.com>
Subject: Re: [PATCH 6/9] KVM: SVM: Add MSR_IA32_XSS to the GHCB for hypervisor kernel
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Maxim Levitsky wrote:
> On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> > @@ -3032,6 +3037,9 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
> >  		if (guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDTSCP))
> >  			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
> >  	}
> > +
> > +	if (kvm_caps.supported_xss)
> > +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_XSS, 1, 1);
> 
> This is not just a virtualization hole. This allows the guest to set MSR_IA32_XSS
> to whatever value it wants, and thus it might allow XSAVES to access some host msrs
> that guest must not be able to access.
> 
> AMD might not yet have such msrs, but on Intel side I do see various components
> like 'HDC State', 'HWP state' and such.

The approach AMD has taken with SEV-ES+ is to have ucode context switch everything
that the guest can access.  So, in theory, if/when AMD adds more XCR0/XSS-based
features, that state will also be context switched.

Don't get me wrong, I hate this with a passion, but it's not *quite* fatally unsafe,
just horrific.

> I understand that this is needed so that #VC handler could read this msr, and
> trying to read it will cause another #VC which is probably not allowed (I
> don't know this detail of SEV-ES)
> 
> I guess #VC handler should instead use a kernel cached value of this msr
> instead, or at least KVM should only allow reads and not writes to it.

Nope, doesn't work.  In addition to automatically context switching state, SEV-ES
also encrypts the guest state, i.e. KVM *can't* correctly virtualize XSS (or XCR0)
for the guest, because KVM *can't* load the guest's desired value into hardware.

The guest can do #VMGEXIT (a.k.a. VMMCALL) all it wants to request a certain XSS
or XCR0, and there's not a damn thing KVM can do to service the request.
