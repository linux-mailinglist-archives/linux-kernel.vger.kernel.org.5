Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8807CC772
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjJQP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344242AbjJQP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:27:15 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE99E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:27:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b5fd0b7522so1728036241.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697556433; x=1698161233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8cg6jGLFG7A51F+ARcwLcIxkWY8BQUYMBYpLmYj4Ek=;
        b=D+eubzFVy5d70RAJUb9Bk+l35No5mKchk5eBvaoWekyR3CWL5rlhmQupYHq1CtY0BV
         dRUFJwT4KssVcNZRiogDJLtk+Di8S2+YjhCBhiRmzWz62VwAg/s9um+JiCe5cpeP9/G/
         uZ68MlvA/IdKbq9JBoL2zlO2F9Cws3D+QhSOvAWZZyFAPz5Y2YB0pANpxfDqo2yIx6dG
         y/+DDHLWEl22OL53n75bY4l8S7OvDJ4TazmpEtERijN0IrrFLV00nfvMLB4QchUz7hyw
         Wvs+/Y+Hi1fo3DTd6wriHWRFP2VPXMlM2G5qed6tBLH8LoUNA4gsvYMJZGH2fNS0RTxc
         mCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556433; x=1698161233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8cg6jGLFG7A51F+ARcwLcIxkWY8BQUYMBYpLmYj4Ek=;
        b=i98VTRV1aUIBpOJc9Kwkb8PHingCZmg+Glo5rSKKephrqsSsH/OYFj/Rwjp9un32yQ
         0G1UIiJ05frLL2GzwagKOcAJD4ynUHJz+s7FsXrzXVPJX29XZgUeJoaKrVLMte/N6diJ
         J/WfYQ3IV/4+jUYr6JW6jNVO3PJZ/gHl8jh/tyrUAaJDMO/UIPRWpJcAb0hoyhvhg2Qw
         o8HBSnhLDY4kuhDl/NdTFUv+yhYV24eTB9+9S35Ps6WIOxk5rUH3qmTNQUvqlCjMqT7N
         G9lr3ZzPHesconfxPrbr4YUtCozAaJS4xU5I4Mv1wFo1ev8RNXiuW+WBRuPjmRpAEu9f
         Cl5Q==
X-Gm-Message-State: AOJu0YyqqhSRyfR09VhQOkaqMNLg2RwFbapfy/IQi3Y6NYfuzAjF0qRP
        ZJWaTLLI++HwriAd5GgJHnJuajq3jkD4ZVQ1CnRexg==
X-Google-Smtp-Source: AGHT+IEUOzsOIcQs2Itnk6BUDIEZuj0yvkvLTTMSnmIp8yWNGVYs2Zsqc2xNe0nLP+5/1uvEJRJpVEm0fE4anbp1rMk=
X-Received: by 2002:a67:c10f:0:b0:454:701c:7717 with SMTP id
 d15-20020a67c10f000000b00454701c7717mr2625620vsj.5.1697556432713; Tue, 17 Oct
 2023 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X> <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X> <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231017052834.v53regh66hspv45n@treble> <CAKwvOd=pA_gpxC9ZP-woRm2-+eSCSHtwvG3vsz9xugs-u3kAMQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=pA_gpxC9ZP-woRm2-+eSCSHtwvG3vsz9xugs-u3kAMQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Oct 2023 17:26:36 +0200
Message-ID: <CANpmjNPnP2_4oHSnhEO89ZhpqNfUg51XzL0awWVkYGNhxUayhw@mail.gmail.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kaplan, David" <David.Kaplan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 17:24, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> + Marco, Dmitry
>
> On Mon, Oct 16, 2023 at 10:28=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.=
org> wrote:
> >
> > On Tue, Oct 17, 2023 at 04:31:09AM +0000, Kaplan, David wrote:
> > > Perhaps another option would be to not compile these two files with K=
CSAN, as they are already excluded from KASAN and GCOV it looks like.
> >
> > I think the latter would be the easy fix, does this make it go away?
>
> Yeah, usually when I see the other sanitizers being disabled on a per
> object basis, I think "where there's smoke, there's fire."
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/lkml/20231016214810.GA3942238@dev-arch.th=
elio-3990X/

Acked-by: Marco Elver <elver@google.com>

Instrumenting these files really doesn't make sense. Thanks for
catching this and the fix!

> >
> > diff --git a/init/Makefile b/init/Makefile
> > index ec557ada3c12..cbac576c57d6 100644
> > --- a/init/Makefile
> > +++ b/init/Makefile
> > @@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
> >  $(obj)/version-timestamp.o: include/generated/utsversion.h
> >  CFLAGS_version-timestamp.o :=3D -include include/generated/utsversion.=
h
> >  KASAN_SANITIZE_version-timestamp.o :=3D n
> > +KCSAN_SANITIZE_version-timestamp.o :=3D n
> >  GCOV_PROFILE_version-timestamp.o :=3D n
> > diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> > index 3cd6ca15f390..c9f3e03124d7 100644
> > --- a/scripts/Makefile.vmlinux
> > +++ b/scripts/Makefile.vmlinux
> > @@ -19,6 +19,7 @@ quiet_cmd_cc_o_c =3D CC      $@
> >
> >  ifdef CONFIG_MODULES
> >  KASAN_SANITIZE_.vmlinux.export.o :=3D n
> > +KCSAN_SANITIZE_.vmlinux.export.o :=3D n
> >  GCOV_PROFILE_.vmlinux.export.o :=3D n
> >  targets +=3D .vmlinux.export.o
> >  vmlinux: .vmlinux.export.o
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
