Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141047E4862
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKGSja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:39:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC6D79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:39:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b3715f3b41so80316677b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699382365; x=1699987165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT9bj/29t1BqbSJ5iHMrrGwZYaUkERVnWSnezKZ0wXI=;
        b=kwk7yBSrMnZdncH1jQcReilehc08ZAVeylnNRnGJcel3U+U7LzoT0Ckv799nsN3rdi
         KKN28wQcuitUzYHrZkU+HeeIVmg3tZA7gjcnWmJFETxkwNDdk9v4rwy6aOo4x6tV/ca+
         /Gyl6OBNTyFfLsfjRI8KzbUCdCzqq7p0uV8d4nFtustyt9+CNm2adKjShYDHw+cyAhAA
         Vmrxkf1yrVGmt6sQZDBHP7WWdbxHfqh+NOsuOB4caufuMeHRgjNzL7Z2sja8mH01LhHV
         BF9FyXbUuxdu37EiuoBQAgULMIiH/rRkdthjkz+RhAm2nXMXy4Hcjs5uOVceJaJpwbCA
         m1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699382365; x=1699987165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT9bj/29t1BqbSJ5iHMrrGwZYaUkERVnWSnezKZ0wXI=;
        b=psLweBFZIopOWijmzXx9NoZkI/mJF5g62WR3ufUknIXWUy+ZOsiDHKJ79u7bJI1gkz
         1Jsh7I/1q026F2g2S2BvxhkJUF8hgBGsV4YHsGwszu2rXHgRSW/PyJJIvR/RMZkDNbkg
         KTIMcKo762GXtC/SZ53MMyyWvuYsFYC8OL5NT+FzfXU/nTKodnMQZOdGtId9oZpKOBn3
         t+jApL2+z8DFALr2twlJtS3btpidnidq0CbtqlQZBqOhHt6k4pVwFOAGfSBOUseCvnYS
         XNNduiKozoyNceXecHq6ZESoS+Ybd/QAbShCcry7x/Emqp8+suNKk5BUE+D+wVgk5q6p
         Lvfw==
X-Gm-Message-State: AOJu0YzlVPlXkE6ny6TW5gnaacbePO9V1+K5CYwaM35OU/7dylRdNx7Q
        mhutzy/iJBNuQ6bZyRSRRSx3RsVwYZM=
X-Google-Smtp-Source: AGHT+IG4HOSCPYw9f8qMhhQB2ugljmmWkWpna/lil2xtTRCeFCmFCpSgEesdvsEQwdd66zWxIR+SgTLrK/8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9182:0:b0:5af:a9ab:e131 with SMTP id
 i124-20020a819182000000b005afa9abe131mr275401ywg.1.1699382365501; Tue, 07 Nov
 2023 10:39:25 -0800 (PST)
Date:   Tue, 7 Nov 2023 10:39:23 -0800
In-Reply-To: <690bd404204106fc17d465e2fdb9be8863767544.camel@redhat.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-20-weijiang.yang@intel.com> <d67fe0ca19f7aef855aa376ada0fc96a66ca0d4f.camel@redhat.com>
 <ZUJ9fDuQUNe9BLUA@google.com> <ff6b7e9d90d80feb9dcabb0fbd3808c04db3ff94.camel@redhat.com>
 <ZUQ3tcuAxYQ5bWwC@google.com> <690bd404204106fc17d465e2fdb9be8863767544.camel@redhat.com>
Message-ID: <ZUqEWySrEeJXCoAO@google.com>
Subject: Re: [PATCH v6 19/25] KVM: VMX: Emulate read and write to CET MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Maxim Levitsky wrote:
> On Thu, 2023-11-02 at 16:58 -0700, Sean Christopherson wrote:
> > Ooh, if we're clever, I bet we can extend KVM_{G,S}ET_ONE_REG to also work with
> > existing MSRs, GPRs, and other stuff,
> 
> Not sure if we want to make it work with MSRs. MSRs are a very well defined thing
> on x86, and we already have an API to read/write them.

Yeah, the API is weird though :-)

> Other registers maybe, don't know.
> 
> >  i.e. not force userspace through the funky
> > KVM_SET_MSRS just to set one reg, and not force a RMW of all GPRs just to set
> > RIP or something.
> Setting one GPR like RIP does sound like a valid use case of KVM_SET_ONE_REG.
> 
> >   E.g. use bits 39:32 of the id to encode the register class,
> > bits 31:0 to hold the index within a class, and reserve bits 63:40 for future
> > usage.
> > 
> > Then for KVM-defined registers, we can route them internally as needed, e.g. we
> > can still define MSR_KVM_SSP so that internal it's treated like an MSR, but its
> > index isn't ABI and so can be changed at will.  And future KVM-defined registers
> > wouldn't _need_ to be treated like MSRs, i.e. we could route registers through
> > the MSR APIs if and only if it makes sense to do so.
> 
> I am not sure that even internally I'll treat MSR_KVM_SSP as MSR. 
> An MSR IMHO is a msr, a register is a register, mixing this up will
> just add to the confusion.

I disagree, things like MSR_{FS,GS}_BASE already set the precedent that MSRs and
registers can be separate viewpoints to the same internal CPU state.  AIUI, these
days, whether a register is exposed via an MSR or dedicated ISA largely comes
down to CPL restrictions and performance.

> Honestly if I were to add support for the SSP register, I'll just add a new
> ioctl/capability and vendor callback. All of this code is just harmless
> boilerplate code.

We've had far too many bugs and confusion over error handling for things like
checking "is this value legal" to be considered harmless boilerplate code.

> Even using KVM_GET_ONE_REG/KVM_SET_ONE_REG is probably overkill, although using
> it for new registers is reasonable.

Maybe, but if we're going to bother adding new ioctls() for x86, I don't see any
benefit to reinventing a wheel that's only good for one thing.
