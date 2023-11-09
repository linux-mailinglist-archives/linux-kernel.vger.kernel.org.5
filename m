Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B127B7E74EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbjKIXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:05:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C994482
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:05:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b1ff96d5b9so19832447b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699571138; x=1700175938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjzQ70dIii0aQke9hZY91N1JYyLYd3OjxGBZLLov1ig=;
        b=QG5XY3abfTxF4xZnHUG9Z8XAaCN4zUMpxhYqmc2+MhQZRbFTT0+u8cKnpJx12iFrNO
         1eQgpiorC3TZGle7pVOOO0zJSVgsaa3zzegKJFy3PYsXdMG4FOT7m2S5XawRgkkCqnzU
         gURdatdsPPMelaJm3pFtsPF3u4zBLu2FeNZolB2WLjtQUajEQlCQ3Dw56c2cIHY1851r
         BwOSwq5Oc5Z/7XvHEOqyAOCo5MqNw8eH7SS8x+hbIgmEU7XkfqYLQIr3lF1uFSLf7YGN
         RaDLtLSDTRbpFZj63kan3Jq0OCUFY6/yRuVrSNRtiHlphcCSETnkltW5lITmZeEyPEYF
         HaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699571138; x=1700175938;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjzQ70dIii0aQke9hZY91N1JYyLYd3OjxGBZLLov1ig=;
        b=BMmqmyKm4pI3cUE2YQSYPOtBDqMeFhwAk2av7bMGj0mSggiL9Tx0hvX7f3n4qbeaPH
         G7p9pU64F3/zmilVQXvRdKR8dy0HEQzOneCd5qpLPVgq0GeO9JeVtHeCP0wVxh33uIni
         Vfppeqfk0dwfYjF0uxQZJIXsqpkVNZiJJ85r76l/k0BSZXHJIxX0J8nSc8dwI+jOAuLc
         lY/z/I1se12+pwgoD+dHLMAIw/gpgHgSeA1FI5ZnJPnTlAoTNjqarF4930MKQLetAUjv
         PUcBkXnaYDeSaTscgL5oQ676PAZp26H8kp1+xceObprx95ArachAmlSYN4GABXbdZleE
         A2Cw==
X-Gm-Message-State: AOJu0YyavfoNLVVUnrMASycPpKG0RdiqrFwZn0uRCcUd8v5fpbapybV6
        AjR3RGVAROY+64Q/JqeGIKvFajeWTwA=
X-Google-Smtp-Source: AGHT+IE018ErF8huRo2NaTD/Dz6GiBtvPamqI3xiGKEPPMgVfo9uZlg4dPCR0tyEabNajivXmcQRoRw7tj4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:6c56:0:b0:59b:ec33:ec6d with SMTP id
 h83-20020a816c56000000b0059bec33ec6dmr201069ywc.5.1699571138466; Thu, 09 Nov
 2023 15:05:38 -0800 (PST)
Date:   Thu, 9 Nov 2023 15:05:36 -0800
In-Reply-To: <CALMp9eRpq+vYDD7s9t54ZMOK6WaXTY_trKzSE3R2vWP9PeSCOA@mail.gmail.com>
Mime-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
 <20231109180646.2963718-2-khorenko@virtuozzo.com> <CALMp9eRpq+vYDD7s9t54ZMOK6WaXTY_trKzSE3R2vWP9PeSCOA@mail.gmail.com>
Message-ID: <ZU1lwEONQv_CtBM9@google.com>
Subject: Re: [PATCH 1/1] KVM: x86/vPMU: Check PMU is enabled for vCPU before
 searching for PMC
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
> On Thu, Nov 9, 2023 at 10:24=E2=80=AFAM Konstantin Khorenko <khorenko@vir=
tuozzo.com> wrote:
> > ---
> >  arch/x86/kvm/pmu.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index 9ae07db6f0f6..290d407f339b 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -731,12 +731,38 @@ static inline bool cpl_is_matched(struct kvm_pmc =
*pmc)
> >         return (static_call(kvm_x86_get_cpl)(pmc->vcpu) =3D=3D 0) ? sel=
ect_os : select_user;
> >  }
> >
> > +static inline bool guest_pmu_is_enabled(struct kvm_pmu *pmu)
> > +{
> > +       /*
> > +        * Currently VMs do not have PMU settings in configs which defa=
ults
> > +        * to "pmu=3Doff".
> > +        *
> > +        * For Intel currently this means pmu->version will be 0.
> > +        * For AMD currently PMU cannot be disabled:
>=20
> Isn't that what KVM_PMU_CAP_DISABLE is for?

Yeah, see my response.  KVM doesn't clear the metadata, so internally it lo=
oks
like the PMU is enabled even though it's effectively disabled from the gues=
t's
perspective.
