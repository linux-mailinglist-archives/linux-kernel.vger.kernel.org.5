Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453EB7E7670
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjKJBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJBOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:14:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFF3C2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:14:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so1885079276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699578846; x=1700183646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrQ+gxpnjkKgi3JxYTT73SI9ToeZhNDb+Kb3YH/r30w=;
        b=ZOf4mzZkwVI5ykeDpPXjgoT7d/zNG+Cy4vNkCWrcDLBfsHlMh2aq/hXfZecoFxZkU8
         xJ+XUur/T07N4oA0oRlS2WbjjrEquGIaIy37LTD7WkJfwNa5KU4DgICYQGn9PgnrIFoE
         f3huelu1RzJV2vl+c7G5qgTNBtWOGdXKyeYjlVqK1/R4t2+5b5eg145Daa6SRTHz6L+e
         7xAL7SH+1vR3ECwWkTTSYMKlGcsSDX5F08XQqLflTOye2+/ZShEoI18eNBPPvibVUoXq
         Mb5Z4QmVkFy7B+w31GjRZw5exkI2KNUmSUXYf8wVLzb6rNMlGYJF4L82/qzOaR/9qi9B
         G14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578846; x=1700183646;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lrQ+gxpnjkKgi3JxYTT73SI9ToeZhNDb+Kb3YH/r30w=;
        b=nfcRMS2muXDRyV9fwzUJpy52jz6ozdT9KDbtXulYBR0T6qWAq6nzAWqFfqKvvIgTik
         Qf2T2sgQCVRDZrFIi8QjvRoX9cZ1sUwJ7rHoG3Y9MetdstdisdUHdlTnrPl5LgLNFGGN
         TgH3wJBXBG92MlSi57yjiDMqd8AGqQkUYKLRNppMUoT9MvkfKXZR2R0DGtEs32GjQPxN
         VjZgYpa6iwWbZrSZyArIfHfsQsJvuW1M7wgLBxIsErDDSe/mDgbOUt2xyRL0wfWd1rEl
         8daJhOvUA5KdT9Pfxf5H/kdPHte10t03mboDFCqPa0HwLd0ptkPFpDIY2wOs/NRMyZne
         +lYg==
X-Gm-Message-State: AOJu0Yz519helSVFIErhSTAVuhXbPoahda61tohICqnky0IPtUYaWsVt
        EGq657JwlFkR925OeMTDVNOZPg7lw1I=
X-Google-Smtp-Source: AGHT+IGKWoeGsO4hriSx6DSWMVi29RAJ4A8gnoO4AttuaWGuavcDVTxU5cD+ixUslDVltoGGzYWeuPh1KAc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102:b0:da3:723b:b2a4 with SMTP id
 o2-20020a056902010200b00da3723bb2a4mr170083ybh.7.1699578846684; Thu, 09 Nov
 2023 17:14:06 -0800 (PST)
Date:   Thu, 9 Nov 2023 17:14:05 -0800
In-Reply-To: <ZU1-sTcb2fvU2TYZ@google.com>
Mime-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
 <CALMp9eQGqqo66fQGwFJMc3y+9XdUrL7ageE8kvoAOV6NJGfJpw@mail.gmail.com>
 <ZU1ua1mHDZFTmkHX@google.com> <CALMp9eTqdg32KGh38wQYW-fvyrjrc7VQAsA1wnHhoCn-tLwyYg@mail.gmail.com>
 <ZU1-sTcb2fvU2TYZ@google.com>
Message-ID: <ZU2D3f6kc0MDzNR5@google.com>
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

On Fri, Nov 10, 2023, Sean Christopherson wrote:
> On Thu, Nov 09, 2023, Jim Mattson wrote:
> > On Thu, Nov 9, 2023 at 3:42=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > static inline bool pmc_is_eventsel_match(struct kvm_pmc *pmc, u64 eve=
ntsel)
> > > {
> > >         return !((pmc->eventsel ^ eventsel) & AMD64_RAW_EVENT_MASK_NB=
);
> > > }
> >=20
> > The top nybble of AMD's 3-nybble event select collides with Intel's
> > IN_TX and IN_TXCP bits. I think we can assert that the vCPU can't be
> > in a transaction if KVM is emulating an instruction, but this probably
> > merits a comment.
>=20
> Argh, more pre-existing crud.  This is silly, the vendor mask is already =
in
> kvm_pmu_ops.EVENTSEL_EVENT.  What's one more patch...

Ah, I see what your saying.  Checking the bits is actually correct, probabl=
y through
sheer dumb luck.  I'll expand the comment to cover that and the reserved bi=
ts.
