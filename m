Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C1F7E0BFC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjKCXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjKCXH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:07:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD5D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:07:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso52919067b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052846; x=1699657646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8W+2NWvl/ISsintIOYFdBFqIf7YRn8uJS46S8vZKyM=;
        b=DJiNVCHfhlws+G3Kh7DP6drG8ncPDVimfU6Tmx7GxbsE3kMq850h4r7f6q4HE1XHEY
         +yl2W8537K0Nfmw2kwI0Av+BGjd+j4cuui86QBpBeQBaZ4wvG3Ck4YMDnpHWkpqNMqp2
         82iB4APXJeNorY94VOFzkXTexGpclyIsciuoTmaoKVExI9rqTopwn0izNzdKKVJP9Tn/
         gkGE7eyyazYniQHHqE/u1xDOQ618CWc6/NWJ9Jjj+UAbEdN8Ya4bHZD/y5oxe9Khgdsu
         5RtUkO5WcHsMO7nKnp1ZAjjkRuhaULDZ41fAL76VV+09QQuHZn63AAYHEx7DA+fdwPZ+
         34yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052846; x=1699657646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8W+2NWvl/ISsintIOYFdBFqIf7YRn8uJS46S8vZKyM=;
        b=YPhqpImsnF4dg5bm0eMSBnyWyZyQzMLRsl21Z2OPlGHolzSv/u5MovMF5FILi3Qzq6
         TuQDuuTPQrP+3rKIy6+aEwPn9dbnYk7ddFI8ex4/JCkxWrY4NEXVGKVAU53FehUi8/Wz
         PVtBGbNxv7iKweQ7EVDJ8qq2Tdm3OQ46n/K+FBZHiwWodIFc32v26E5R0XDZDP+xd3Sc
         Tj1h75y3sqvnzbGFg2IXJwafwGEvpS+j0HFp3PtsfiSmbbkzEiHO4QTZ14Jcs9uwpLPj
         H+t+QZK9PbKvfqEHQEyrXeXM/NRa9MUeI4CBcAZFx3jaAxMSP26x0LW4R1UKikg8GWHa
         zk6w==
X-Gm-Message-State: AOJu0YxaGAbXmCj/ZeLrze+vyJQXCltS/5tD40gwFft7vFQYNz0LOpkA
        PH5zy127Q5yKfsYCrKJT5IBREWtLWTQ=
X-Google-Smtp-Source: AGHT+IEv4++Q1C9rcXoxdGG3JIifTGRCIs+wlQdOev8bn3mrnbSFdi3zO0Emju/7xXl8DljXTq0hIYtkEwM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e204:0:b0:59b:ccba:1249 with SMTP id
 l4-20020a0de204000000b0059bccba1249mr78883ywe.10.1699052845958; Fri, 03 Nov
 2023 16:07:25 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:07:24 -0700
In-Reply-To: <734ac3e7-9fc4-47a4-9951-2fa04e10fe7d@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-3-paul@xen.org>
 <ZUGNkCljRm5VXcGg@google.com> <734ac3e7-9fc4-47a4-9951-2fa04e10fe7d@xen.org>
Message-ID: <ZUV9LMM8FhQD8ycD@google.com>
Subject: Re: [PATCH v7 02/11] KVM: pfncache: add a mark-dirty helper
From:   Sean Christopherson <seanjc@google.com>
To:     paul@xen.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023, Paul Durrant wrote:
> On 31/10/2023 23:28, Sean Christopherson wrote:
> > On Mon, Oct 02, 2023, Paul Durrant wrote:
> > > diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> > > index 0f36acdf577f..b68ed7fa56a2 100644
> > > --- a/virt/kvm/pfncache.c
> > > +++ b/virt/kvm/pfncache.c
> > > @@ -386,6 +386,12 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
> > >   }
> > >   EXPORT_SYMBOL_GPL(kvm_gpc_activate);
> > > +void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
> > > +{
> > 
> > If there's actually a reason to call mark_page_dirty_in_slot() while holding @gpc's
> > lock, then this should have a lockdep.  If there's no good reason, then don't move
> > the invocation.
> > 
> > > +	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> > > +}
> > > +EXPORT_SYMBOL_GPL(kvm_gpc_mark_dirty);
> > 
> > This doesn't need to be exported.  Hrm, none of the exports in this file are
> > necessary, they likely all got added when we were thinking this stuff would be
> > used for nVMX.  I think we should remove them, not because I'm worried about
> > sub-modules doing bad things, but just because we should avoid polluting exported
> > symbols as much as possible.
> 
> That in a separate clean-up patch too, I assume?

Yes, but feel free to punt that one or post it as a standalone patch.  For this
series, please just don't add more exports unless they're actually used in the
series.
