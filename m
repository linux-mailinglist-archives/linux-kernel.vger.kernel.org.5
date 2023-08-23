Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC32786428
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbjHWXyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbjHWXyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:54:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0A10E5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:54:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-407db3e9669so79431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692834860; x=1693439660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rb211/84XCj5s3qEzxk41sOs/W0hEXnv4lzDGpZ7/s=;
        b=plbFCExLt7v0bXnBw3cmP4n1wGJJqGxlyRSmARMOdqM05KwnEmugCrxnLnjuFilEfI
         aprcBHJICWxmjszuyFDlJjN2LTyCvLa5BFaA+vKzTStDt5+Bl5Ye8jWrC+/IEZXap8g/
         z37xQNdBT2QOwsEl5W5fqMY+8ncpLqDSWscJqKavU2MGCnVdy3fI5WsphXKOrKhMzpgr
         v+o+e/4Lixge/lNpsz3cCpwSPh4jlmdvn0POb/dT82goAx/MntTe2pxQjh1mjJmttUKQ
         YEnKjg7SlkkkOr27Z5hssaRFyIYl0kC+CVpCcH2PWI08W+Sin00Jr+4NoNK2glP3T71f
         JerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692834860; x=1693439660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rb211/84XCj5s3qEzxk41sOs/W0hEXnv4lzDGpZ7/s=;
        b=TR/TcB9dVMAZhkpan/Zm89gTkEEL9zBw1KHic+6U33qQPjjQ55XaMq+b4echsF/YLv
         z9Ituk1ADxtF/TSjQkCmi1ZQ5v9DkS7pR1mRXxloL+s2O+e4YD5CoAyA2fEoiuJwrHih
         urg0YCVkXGHX3/3/jhiYS2ahRMDioMtIYX8aEIS67Kifr7taQWx7rogx07DMcrYaceOI
         kKmBlsvV1OPNPpoQ35vl8ViGxYKPsmR7VHz2qgdt20Oya7jwsnH8a2DPl2eBcI3AWLq/
         1aTiqdYLk0By1LeoEoPQnlUyzetdVJkYLu8dGvn9F3XBh3RUCNSga7BfkJKGecWz8cPN
         mvUg==
X-Gm-Message-State: AOJu0YzCQSA5ezyvCni9rgcfZGy6zGCrUMJARHpsB64qKCHJMoNYd5pn
        fIKGt7pW8wejKyh9xMwQNAm5CI/gkcyTeSFtb8duhA==
X-Google-Smtp-Source: AGHT+IFdBZ4akZ1jbijZBu76p8cAnEURgS1ppfDWsN/o5PqPBeHSAZ6IvKEh2bsJ9rSoshR8QaEDOtbQee7NLvkpkWQ=
X-Received: by 2002:a05:622a:19a0:b0:3f8:8c06:c53b with SMTP id
 u32-20020a05622a19a000b003f88c06c53bmr761620qtc.0.1692834860332; Wed, 23 Aug
 2023 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <20230822174835.253469-1-denik@chromium.org>
 <CAFP8O3KunP9CzT_U2cj1_oysojTxCNJRWX_kvvu_wOx4tbYHug@mail.gmail.com>
 <CAK7LNASstNj2HEfJHcRzqt7hay65T-yEgzaAuXbEQPuCS+yC6w@mail.gmail.com> <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com>
In-Reply-To: <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 23 Aug 2023 16:54:10 -0700
Message-ID: <CAFP8O3+3++awDi9uZueFC_xi+KAud0Ds3k3vdd_ruVngOEOKiw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:13=E2=80=AFPM Denis Nikitin <denik@chromium.org> =
wrote:
>
> On Wed, Aug 23, 2023 at 4:02=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 3:00=E2=80=AFAM Fangrui Song <maskray@google.co=
m> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 10:49=E2=80=AFAM Denis Nikitin <denik@chromiu=
m.org> wrote:
> > > >
> > > > .llvm.call-graph-profile section is added by clang when the kernel =
is
> > > > built with profiles (e.g. -fprofile-sample-use=3D or -fprofile-use=
=3D).
> > > >
> > > > The section contains edge information derived from text sections,
> > > > so .llvm.call-graph-profile itself doesn't need more analysis as
> > > > the text sections have been analyzed.
> > > >
> > > > This change fixes the kernel build with clang and a sample profile
> > > > which currently fails with:
> > > >
> > > > "FATAL: modpost: Please add code to calculate addend for this archi=
tecture"
> >
> >
> > Curious.
> >
> > This message is only displayed for REL.
> >
> > (Please not it is located in section_rel() function)
> >
> >
> > I think modern architectures use RELA instead of REL.
> > Which architecture are we talking about?
>
> Aarch64. There was also a report on x86-64 but the error message could be
> different there.

Regarding REL:

The original format of .llvm.call-graph-profile
(SHT_LLVM_CALL_GRAPH_PROFILE=3D0x6fff4c02) used symbol indices without
relocations and could be corrupted by symbol table change.
https://github.com/llvm/llvm-project/commit/a224c5199b327ed0efcdcd87b6dbf95=
0cf4d9ee1
(2021) changed the format to represent call edge information with
R_*_NONE and changed SHT_LLVM_CALL_GRAPH_PROFILE to 0x6fff4c09.

We don't use the addend field of R_*_NONE relocations, so I proposed
that we use REL for all targets.
My https://github.com/llvm/llvm-project/commit/ca3bdb57fa1ac98b711a735de048=
c12b5fdd8086
selected REL for .llvm.call-graph-profile

aaelf64 says:

> A binary file may use ``REL`` or ``RELA`` relocations or a mixture of the=
 two (but multiple relocations of the same place must use only one type).

Other psABI documents may be more vague on how REL is used, but as
long as the tool that needs to process it (currently just lld and
readelf like tools) supports it, it's fine.
binutils seems to support REL for all ELF targets, even if its
objcopy/strip may unintentionally convert REL to RELA. lld can consume
RELA SHT_LLVM_CALL_GRAPH_PROFILE.

> >
> >
> > What does the output of this command look like?
> >
> > $ llvm-readelf -S vmlinux.o | grep  .llvm.call-graph-profile
> >
> >
> > Is it REL?
> >
>
>   [119] .llvm.call-graph-profile LLVM_CALL_GRAPH_PROFILE 0000000000000000
> 1c74a458 0104c8 08   E  0   0  1
>   [120] .rel.llvm.call-graph-profile REL 0000000000000000 1c75a920 041320=
 10
> I 26090 119  8
>
> Thanks,
> Denis



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
