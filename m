Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B8786759
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbjHXGN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbjHXGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:13:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02A10F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:13:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso146331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692857612; x=1693462412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFZbALfD5j8bkOsPp24wLCSxuLIXKQlbu5x+aUv5CFk=;
        b=eVA/2gc1TLCiER+jX93Iv4jVefRl0whhczr1Li9l99jTiofSagEOfDWAowHCiZ2jK/
         g/i9Htozhn3owsRd4swHz6ZAuYPIEjw99Lj7vtas4fVVMHnjrn/n9cgx3WpvebEwxMBg
         wklumIqevwYMwJfPebQXD5x1e3I/OgMpSMnrilJPsDjf5CBU4GJj+oRhmzTXJr4APF+4
         eZ1CtywEdht3aXULDvqDnS7WvSVLObLM3HRxE/f8Se0JiK50kXSXusKZYnFIOzmaeTUA
         wNT304PjS5CUF6rWdmM1NxCm6B5nMU4mF5caJkc5TWoDxzLEQwBgAPhnjt+zk7SLw5aX
         05Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692857612; x=1693462412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFZbALfD5j8bkOsPp24wLCSxuLIXKQlbu5x+aUv5CFk=;
        b=bWCgWIa9eKfHluOE9fZduP2K/GSLE94IeIwdMEaz3QHOxuXT++9qzaTFiS66pts40i
         mDmBx+zKEWkGjtAhBPTHbCdMJukx79vSi8EKBe8CPpkHiSCkHXkR7ZG+nX3sXJn72g2R
         MCcvSLMbK0j3Mb4t5JROHZ2KFf/K9kgesi9AixvOWzFcTimGxXapkhbz1LPt4bwrcgl5
         DnFcP4cNzwOkcbUFrUuWG3DyGLzjq9YoEOXDND5K6FobXyAH0A4cLEh+xIk/8jmGFilZ
         2WEb1n/HCZsX3KPM9zaOHkoE2WZvYXPSQ8U/pbU4JJU7gOi8Bn1Otea8D4d27jHmeHOp
         xWGw==
X-Gm-Message-State: AOJu0YzmM95ZQXA09mDWjAootD1Q7s3WCowOTidCLJDTtvpFsNsYIkP2
        4Ce9IcEZYwvZr3F2/8mYwkkW4SHVqxZN7xnS3uC3jA==
X-Google-Smtp-Source: AGHT+IGR3X8UN3n/H5GJpozFOeFboKSmh+s5sqpVSHkY11BSfDY+oPUJESYIqqjCXkSDgIatozWe4VCYRRZsPiOK4YE=
X-Received: by 2002:a05:622a:1888:b0:403:b6ff:c0b with SMTP id
 v8-20020a05622a188800b00403b6ff0c0bmr771555qtc.6.1692857611746; Wed, 23 Aug
 2023 23:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <20230822174835.253469-1-denik@chromium.org>
 <CAFP8O3KunP9CzT_U2cj1_oysojTxCNJRWX_kvvu_wOx4tbYHug@mail.gmail.com>
 <CAK7LNASstNj2HEfJHcRzqt7hay65T-yEgzaAuXbEQPuCS+yC6w@mail.gmail.com>
 <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com> <CAK7LNARVi1sfBjv5a5OoQWPEeM-6bFuwPJE+i32NC=wdum-AKw@mail.gmail.com>
In-Reply-To: <CAK7LNARVi1sfBjv5a5OoQWPEeM-6bFuwPJE+i32NC=wdum-AKw@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 23 Aug 2023 23:13:18 -0700
Message-ID: <CAFP8O3Lm_nDTPcvLyA-kkwnuiTNnv+s3hEf3dneUU3s0Th_-hA@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: Skip .llvm.call-graph-profile section check
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Denis Nikitin <denik@chromium.org>, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 6:34=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Aug 24, 2023 at 8:30=E2=80=AFAM Denis Nikitin <denik@chromium.org=
> wrote:
> >
> > On Wed, Aug 23, 2023 at 4:02=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 3:00=E2=80=AFAM Fangrui Song <maskray@google.=
com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 10:49=E2=80=AFAM Denis Nikitin <denik@chrom=
ium.org> wrote:
> > > > >
> > > > > .llvm.call-graph-profile section is added by clang when the kerne=
l is
> > > > > built with profiles (e.g. -fprofile-sample-use=3D or -fprofile-us=
e=3D).
> > > > >
> > > > > The section contains edge information derived from text sections,
> > > > > so .llvm.call-graph-profile itself doesn't need more analysis as
> > > > > the text sections have been analyzed.
> > > > >
> > > > > This change fixes the kernel build with clang and a sample profil=
e
> > > > > which currently fails with:
> > > > >
> > > > > "FATAL: modpost: Please add code to calculate addend for this arc=
hitecture"
> > >
> > >
> > > Curious.
> > >
> > > This message is only displayed for REL.
> > >
> > > (Please not it is located in section_rel() function)
> > >
> > >
> > > I think modern architectures use RELA instead of REL.
> > > Which architecture are we talking about?
> >
> > Aarch64. There was also a report on x86-64 but the error message could =
be
> > different there.
> >
> > >
> > >
> > > What does the output of this command look like?
> > >
> > > $ llvm-readelf -S vmlinux.o | grep  .llvm.call-graph-profile
> > >
> > >
> > > Is it REL?
> > >
> >
> >   [119] .llvm.call-graph-profile LLVM_CALL_GRAPH_PROFILE 00000000000000=
00
> > 1c74a458 0104c8 08   E  0   0  1
> >   [120] .rel.llvm.call-graph-profile REL 0000000000000000 1c75a920 0413=
20 10
> > I 26090 119  8
>
>
> Fangrui,
>
> Aarch64 uses RELA for other sections, but REL for this one.
>
> I'd like to confirm if this is an expectation, not a toolchain bug.

Hi Masahiro,

Yes, using REL is intentional. It makes the relocations of
.llvm.call-graph-profile smaller.
The format encodes the (from,to,count) information with

* the section content holds 'count'
* two R_*_NONE relocations hold 'from' and 'to'. The addend field is
unused, therefore REL is better.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
