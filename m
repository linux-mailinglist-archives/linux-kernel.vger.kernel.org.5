Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF97E760D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbjKJAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:52:06 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A973859
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:52:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6c3467b6b52so2175739b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699577523; x=1700182323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaXRIkgga9Mbd8IaWbzrZruI1+6G67OpEX1+PWQwT6Q=;
        b=F7HaCclW92vWchWE6CS0/hgKUcrN61PEYhf3VNl59nGQU8HO2VmxWMtkkvITj6w/us
         MZ/IYDF8qlQ+2FpzHJ0dXzcDgljvFIr71N7uf4/WbKbYyL1yEG3Z6qNCSqWl71SwVwln
         saYcDRbH/F5tW09j0rK0RlDdxHG417GjJOyPN9sI8OcEqwcSkjgAYr47Nj3ajTBAIf8w
         ILztUP+fkU8mn0SWujkyZ7EUalMltB2UsKMQvQ/qARnCx3jdqAqbljRT+KcO5jCsX9om
         XUOxVEhxZ3CsBEQsGvhEhLzMa0TmhLcmHMA+y0cKJEnQyczEIq83GNTTX7sg2gZJRwEi
         JD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577523; x=1700182323;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaXRIkgga9Mbd8IaWbzrZruI1+6G67OpEX1+PWQwT6Q=;
        b=IH29rdsp4Ms/L+LU1r5eEYhYSofQFRzXDASPfW9PrjmEAg7dsgdNtodwCrPhu372gK
         yINo9D5jw+K7ag/fqL+2q+TxiPCxiIB/dEQA24nVWNm5r94yRH+CVDzPfCbpKt7JVhvr
         z5O8s1Tie5/12dCnIqg/7RxG+A+tC/zLZVw5BAqyhmcjAFN+3v3cT/sKwps1Kh4fIZmt
         IFeU4+sQnLL6bAlHbqqGqnQNm3FHVvulNPoKeTogSjrx4BylwYxVY7jMl6njJ4AyL/13
         fylgwwLfFrUpFHS6QX1m5q+FIcLNFFyxiIIwbEtC3mNX/sJplfjWN9gdGSr0akF4Y9Nh
         PEfA==
X-Gm-Message-State: AOJu0YxHnKZnj8U3fDiN17ugafo+/vOeufgjo4DxFFhCtFAqZRnHBmzO
        fhCiLMI66cm+xq26qX2UCz/nR02pXDw=
X-Google-Smtp-Source: AGHT+IEleztEQXckmOw7ag1CDdfyMSONAMeNUT17fzoOAYUS0cSBFGncdHLVezawzVjGRkeJMyfugEhb/wU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:84c1:b0:692:c216:8830 with SMTP id
 gl1-20020a056a0084c100b00692c2168830mr318481pfb.0.1699577523585; Thu, 09 Nov
 2023 16:52:03 -0800 (PST)
Date:   Fri, 10 Nov 2023 00:52:01 +0000
In-Reply-To: <CALMp9eTqdg32KGh38wQYW-fvyrjrc7VQAsA1wnHhoCn-tLwyYg@mail.gmail.com>
Mime-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
 <CALMp9eQGqqo66fQGwFJMc3y+9XdUrL7ageE8kvoAOV6NJGfJpw@mail.gmail.com>
 <ZU1ua1mHDZFTmkHX@google.com> <CALMp9eTqdg32KGh38wQYW-fvyrjrc7VQAsA1wnHhoCn-tLwyYg@mail.gmail.com>
Message-ID: <ZU1-sTcb2fvU2TYZ@google.com>
Subject: Re: [PATCH 0/1] KVM: x86/vPMU: Speed up vmexit for AMD Zen 4 CPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023, Jim Mattson wrote:
> On Thu, Nov 9, 2023 at 3:42=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Thu, Nov 09, 2023, Jim Mattson wrote:
> > > A better solution may be to maintain two bitmaps of general purpose
> > > counters that need to be incremented, one for instructions retired an=
d
> > > one for branch instructions retired. Set or clear these bits whenever
> > > the PerfEvtSelN MSRs are written. I think I would keep the PGC bits
> > > separate, on those microarchitectures that support PGC. Then,
> > > kvm_pmu_trigger_event() need only consult the appropriate bitmap (or
> > > the logical and of that bitmap with PGC). In most cases, the value
> > > will be zero, and the function can simply return.
> > >
> > > This would work even for AMD microarchitectures that don't support PG=
C.
> >
> > Yeah.  There are multiple lower-hanging fruits to be picked though, mos=
t of which
> > won't conflict with using dedicated per-event bitmaps, or at worst are =
trivial
> > to resolve.
> >
> >  1. Don't call into perf to get the eventsel (which generates an indire=
ct call)
> >     on every invocation, let alone every iteration.
> >
> >  2. Avoid getting the CPL when it's irrelevant.
> >
> >  3. Check the eventsel before querying the event filter.
> >
> >  4. Mask out PMCs that aren't globally enabled from the get-go (masking=
 out
> >     PMCs based on eventsel would essentially be the same as per-event b=
itmaps).
>=20
> The code below only looks at PGC. Even on CPUs that support PGC, some
> PMU clients still use the enable bits in the PerfEvtSelN. Linux perf,
> for instance, can't seem to make up its mind whether to use PGC or
> PerfEvtSelN.EN.

Ugh, as in perf leaves all GLOBAL_CTRL bits set and toggles only the events=
el
enable bit?  Lame.

> > I'm definitely not opposed to per-event bitmaps, but it'd be nice to av=
oid them,
> > e.g. if we can eke out 99% of the performance just by doing a few obvio=
us
> > optimizations.
> >
> > This is the end result of what I'm testing and will (hopefully) post sh=
ortly:
> >
> > static inline bool pmc_is_eventsel_match(struct kvm_pmc *pmc, u64 event=
sel)
> > {
> >         return !((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB);
> > }
>=20
> The top nybble of AMD's 3-nybble event select collides with Intel's
> IN_TX and IN_TXCP bits. I think we can assert that the vCPU can't be
> in a transaction if KVM is emulating an instruction, but this probably
> merits a comment.

Argh, more pre-existing crud.  This is silly, the vendor mask is already in
kvm_pmu_ops.EVENTSEL_EVENT.  What's one more patch...

> The function name should also be more descriptive, so that it doesn't get
> misused out of context. :)

Heh, I think I'll just delete the darn thing.  That also makes it easier to
understand the comment about ignoring certain fields.
