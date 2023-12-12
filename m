Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503E80E157
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjLLCVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLCVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:21:36 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0CB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:21:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6ce7c430c16so3472417b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702347702; x=1702952502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OSQ0+CxvAwQ+j1iPdWpWeAVyvf5e+mUT1407P9+KdQ=;
        b=AVSHXp03CmxZrm7ViQTpSMQSLT6Ud9ICfpv//3DmLJylwMeveTo94K+wgumbzu2Qoa
         IPIHEENVkt8ilRFbwGpWmlF81TaB8CGTQurkJvzZ6SA/7F96nBilTCNBktE6hZhaxsKS
         23IAK/LW60kD1bYrkgXvWaQEcW1tb0a33NJdMlRTbWWMyTOcO8P0VC7tGgaG+4DcsXXh
         bV66Fm9d4ZGL/BLYqaTGQCYFfIpi1rchCGf2pI9RDtPha0x2N/6GyzaxmJbbbZ8PBoPr
         Xzm2v00bLJrd7JAtvDpO3WnHzBa1jPrByWpYZtXVGzw0yE8dHPcRbS7CnH6utEF4l0xT
         vT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702347702; x=1702952502;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4OSQ0+CxvAwQ+j1iPdWpWeAVyvf5e+mUT1407P9+KdQ=;
        b=PrwlAiTdMW050Sct1AE++4AktkM7jwqncFS12wuWbBTpApp3p9G8Vx9zqZFnumttEE
         itMZKopnLNwR3YSThdW++1AsXvT508+y44pTJOl6PR88Xvz8dLbcPcHVxZawZItKBQyA
         EHOo9pZSMssOa+vziLojSHzqosa2/aBrVJRTpuwj5/vkrp5sBp/TbWOw75kVSD3kosKB
         F9p2bxGbCGYrU31a9u/gWTVIzOhXGzk9xX3kMWfvh6K8fnMDPAQWinA51ck9rDaxxnnT
         h1iWchajCWOnrjy3XspY9qQlSN2OiMUL4nNju7NGmXFaOrdIeR+boqeWAr0u9wnAvM14
         KQJA==
X-Gm-Message-State: AOJu0YwP57x1WorVvUMuP3KVjadRpLPu3Stlv+f9ZbEGRO9+5Sq8eD5k
        jDYsXwILl3fGVwearaDjHP42+GAkc7c=
X-Google-Smtp-Source: AGHT+IHdOsYGsoWCm8uyCA8qxisPuNhOF2q/ZEZkAdNvR3f0Oj9wJqNGOwsljcCj5NH140QB+/01lkr2al8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f54a:b0:1d0:5d31:4672 with SMTP id
 h10-20020a170902f54a00b001d05d314672mr44837plf.5.1702347702132; Mon, 11 Dec
 2023 18:21:42 -0800 (PST)
Date:   Mon, 11 Dec 2023 18:21:40 -0800
In-Reply-To: <b028a431-92e0-4440-adf9-6b855edb88c0@suse.com>
Mime-Version: 1.0
References: <20231030141728.1406118-1-nik.borisov@suse.com>
 <ZT_UtjWSKCwgBxb_@google.com> <b028a431-92e0-4440-adf9-6b855edb88c0@suse.com>
Message-ID: <ZXfDtIful3mjgPTA@google.com>
Subject: Re: [PATCH] KVM: x86: User mutex guards to eliminate __kvm_x86_vendor_init()
From:   Sean Christopherson <seanjc@google.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Dec 09, 2023, Nikolay Borisov wrote:
>=20
>=20
> On 30.10.23 =D0=B3. 18:07 =D1=87., Sean Christopherson wrote:
> > On Mon, Oct 30, 2023, Nikolay Borisov wrote:
> > > Current separation between (__){0,1}kvm_x86_vendor_init() is
> > > superfluos as
> >=20
> > superfluous
> >=20
> > But this intro is actively misleading.=C2=A0 The double-underscore vari=
ant
> > most definitely
> > isn't superfluous, e.g. it eliminates the need for gotos reduces the
> > probability
> > of incorrect error codes, bugs in the error handling, etc.=C2=A0 It _be=
comes_
> > superflous
> > after switching to guard(mutex).
> >=20
> > IMO, this is one of the instances where the then solution problem
> > appoach is
> > counter-productive.=C2=A0 If there are no objections, I'll massage the =
change
> > log to
> > the below when applying (for 6.8, in a few weeks).
> >=20
> >  =C2=A0Use the recently introduced guard(mutex) infrastructure acquire =
and
> >  =C2=A0automatically release vendor_module_lock when the guard goes out=
 of
> > scope.
> >  =C2=A0Drop the inner __kvm_x86_vendor_init(), its sole purpose was to =
simplify
> >  =C2=A0releasing vendor_module_lock in error paths.
> >=20
> >  =C2=A0No functional change intended.
> >=20
> > > the the underscore version doesn't have any other callers.
> > >=20
>=20
>=20
> Has this fallen through the cracks as I don't see it in 6.7?

As above, I have this tagged for inclusion in 6.8, not 6.7.  Though admitte=
dly,
this one did actually fall through the cracks as I moved it to the wrong ma=
ilbox
when Paolo usurped the thread for unrelated guest_memfd stuff.  Anyways, I =
do
plan on grabbing this for 6.8, I'm just buried in non-upstream stuff right =
now.
