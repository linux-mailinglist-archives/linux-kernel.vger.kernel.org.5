Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B68759D04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGSSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGSSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:02:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551581FCB;
        Wed, 19 Jul 2023 11:02:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b700e85950so106515611fa.3;
        Wed, 19 Jul 2023 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689789758; x=1690394558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBHJ5zznIS99/1DyqAk4yervL0PEta1EYDdROer+oA8=;
        b=CJi8/yl+47Yh9Kwk9UJYfszuGOwBrtcd3kkj8+k/hM6XwtvYQnswt+9l5kx5w6l+JW
         Pf1pkx4nAG2GxfLdljDLsrpuGn4910S++QJI/u7DkoAR2tHmuMLCayjLX9v9NK3ddR29
         EV/DjrjjyxXK1m+JJvit5D+pzBDTUmvDWLAlEg1fmjD2WHvAHd/bUuugJlLuserF3hVH
         D3ZMff/erGW7+o+J0uN2fSJ06ct6NOAJlRi1WKLxdSd+p7pij+gvMwq8CHGjM+4qeFGy
         M82JVyCsZD2Y+Tx2zQ8MIs7hLH0KvKONhM3EimNxr3SoEqpfVNym/8jrt4YrTnNXYmJp
         Qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789758; x=1690394558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBHJ5zznIS99/1DyqAk4yervL0PEta1EYDdROer+oA8=;
        b=jdWlXDGCJeVFbb0iE9HaOywTc2kQaveaM4HtMib7gYnIE/08nQ3VQ1CQBKx8rxKtWJ
         CXSUnwqsG+uLCYikJP/TsmkQ1otPLV9JV2RH2DCVhsQ0BI9IKJR0C7t1p10TlnOWpyeR
         Tyu89EvVoYknalx/tuBvcdxCNfM+FPkSfWuS/sPXmbP1a7IhoBoSQv5llORf+7T0kECy
         66m6YfB0RnOD0acO84dfkCy2dxunr9ZJA118SS/6Xh1S1upRGkLojndIK0h0GyJkKls9
         qn/UB47qUjHyy1xlrB1S1GxpXWj4TCOG5exqw8GLCLG/kDegRf7rAI6V3e17Nr3FGGip
         A3ig==
X-Gm-Message-State: ABy/qLbfq0OrOIZkYWvL5jARi1cfQJEtnbMM1FY2pA+TZ0Zov2pmxz6H
        rqeIMlq4Z5sm6eLdAsumeDoDklzFrzj+4k/lIQY=
X-Google-Smtp-Source: APBJJlEmxHipuzXPKDdED5w7bl7mjtpLoEV1pqtEokzwAwo2FlEBgMIh13kfzR6FclKI1K183n9Tobgj4uzDjPnC/l0=
X-Received: by 2002:a2e:86d1:0:b0:2b7:3633:2035 with SMTP id
 n17-20020a2e86d1000000b002b736332035mr502768ljj.32.1689789758212; Wed, 19 Jul
 2023 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230628232417.120844-1-linux@treblig.org> <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
In-Reply-To: <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 19 Jul 2023 13:02:27 -0500
Message-ID: <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     linkinjeon@kernel.org, tom@talpey.com, dave.kleikamp@oracle.com,
        shaggy@kernel.org, linux-cifs@vger.kernel.org,
        krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The related question is which tree to send it from, if no problems
reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
and because there hasn't been activity in fs/nls for years)

On Wed, Jul 19, 2023 at 12:56=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> No objections to this on my part.  If Shaggy is ok with the JFS
> change, we could target it for 6.6-rc1 if it tests out ok
>
> On Wed, Jul 12, 2023 at 6:28=E2=80=AFPM Dr. David Alan Gilbert <dave@treb=
lig.org> wrote:
> >
> > * linux@treblig.org (linux@treblig.org) wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > The smb client and server code have (mostly) duplicated code
> > > for unicode manipulation, in particular upper case handling.
> > >
> > > Flatten this lot into shared code.
> >
> > Gentle two week ping on this please.
> >
> > Dave
> >
> > (Apologies to the 3 of you who already got a copy of this ping,
> > recent due to a missing header ',' )
> >
> > > There's some code that's slightly different between the two, and
> > > I've not attempted to share that - this should be strictly a no
> > > behaviour change set.
> > >
> > > In addition, the same tables and code are shared in jfs, however
> > > there's very little testing available for the unicode in there,
> > > so just share the raw data tables.
> > >
> > > I suspect there's more UCS-2 code that can be shared, in the NLS code
> > > and in the UCS-2 code used by the EFI interfaces.
> > >
> > > Lightly tested with a module and a monolithic build, and just mountin=
g
> > > itself.
> > >
> > > This dupe was found using PMD:
> > >   https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > >
> > > Dave
> > >
> > > Version 2
> > >   Moved the shared code to fs/nls after v1 feedback.
> > >   Renamed shared tables from Smb to Nls prefix
> > >   Move UniStrcat as well
> > >   Share the JFS tables
> > >
> > > Dr. David Alan Gilbert (4):
> > >   fs/smb: Remove unicode 'lower' tables
> > >   fs/smb: Swing unicode common code from smb->NLS
> > >   fs/smb/client: Use common code in client
> > >   fs/jfs: Use common ucs2 upper case table
> > >
> > >  fs/jfs/Kconfig               |   1 +
> > >  fs/jfs/Makefile              |   2 +-
> > >  fs/jfs/jfs_unicode.h         |  17 +-
> > >  fs/jfs/jfs_uniupr.c          | 121 -------------
> > >  fs/nls/Kconfig               |   8 +
> > >  fs/nls/Makefile              |   1 +
> > >  fs/nls/nls_ucs2_data.h       |  15 ++
> > >  fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
> > >  fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
> > >  fs/smb/client/Kconfig        |   1 +
> > >  fs/smb/client/cifs_unicode.c |   1 -
> > >  fs/smb/client/cifs_unicode.h | 330 +--------------------------------=
--
> > >  fs/smb/client/cifs_uniupr.h  | 239 -------------------------
> > >  fs/smb/server/Kconfig        |   1 +
> > >  fs/smb/server/unicode.c      |   1 -
> > >  fs/smb/server/unicode.h      | 325 +--------------------------------=
-
> > >  fs/smb/server/uniupr.h       | 268 ----------------------------
> > >  17 files changed, 467 insertions(+), 1293 deletions(-)
> > >  delete mode 100644 fs/jfs/jfs_uniupr.c
> > >  create mode 100644 fs/nls/nls_ucs2_data.h
> > >  create mode 100644 fs/nls/nls_ucs2_utils.c
> > >  create mode 100644 fs/nls/nls_ucs2_utils.h
> > >  delete mode 100644 fs/smb/client/cifs_uniupr.h
> > >  delete mode 100644 fs/smb/server/uniupr.h
> > >
> > > --
> > > 2.41.0
> > >
> > --
> >  -----Open up your eyes, open up your mind, open up your code -------
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
>
>
>
> --
> Thanks,
>
> Steve



--
Thanks,

Steve
