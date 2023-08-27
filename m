Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEE78A358
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjH0XPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjH0XPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:15:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE2124;
        Sun, 27 Aug 2023 16:15:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so39907741fa.3;
        Sun, 27 Aug 2023 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693178104; x=1693782904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDyOSgiaTZBOTyCSK6opZGFKNTnmThLJYrBi96TQhjw=;
        b=bTHuEAmnT6JOXukEZ1V4X4jfm3+86j1EBtBDVMWkL0ZLgc6qashFc9bnY2Uy1EMB/7
         mGZbOfqtiPwmidNjkyOyOEKsk2Ld19JiDqSzfYka5b2JyGFfkxX4VPKC27ABIJzxPpOz
         Wnoagux2hZS9EfxuF9k0zrnjOOJfQ0CV0q3yVm1C6ufdUhvDEXXoyUi6BV0b3Z844kjA
         FjwVmXRdPDtfo9ov8Dr1exQymcKrq8UsP8b6b/0x+NyXY0EDBcW+J+mnAreQetPW8VQR
         Ey8M0IEzw/ftWN4AmcK+iZJ9/V7FQTM3NJFbIxE4IUDWNICtPG/nBMhQzu3vtARdePKe
         Cicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693178104; x=1693782904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDyOSgiaTZBOTyCSK6opZGFKNTnmThLJYrBi96TQhjw=;
        b=XMQYfwSu80h0TZhAek1Lxpdo6oAGXoQ3wtycmAkfRpLBtI1YNt/BZgAUz1Lez8V+Nc
         JZf2tdIbIyf2hRT5dSuj7cx27G905GEIpfaEGbddirhKXbmo0YKPTzM7XWFEevRiHmx1
         0RlmFi+t7IU5urHAqcfyY0LnpyG/ISxZvDXPG6I6/bFy3aIwZnq0oZZILVbB/UmeT6oF
         1XLvJyni1Atchu8I2Fl7jXCR8MgjmTokJI+dx5VF1mkD0Wvm4ISnzVh9efOKVmfVFYZt
         fSOSFBTYIAQFyuGa5ZjAGnjO2T/j9jQIpVe75UlaB/krY+GhMfflcmA+TIfkBn6i8A2M
         nbeg==
X-Gm-Message-State: AOJu0YyXWLYoh6dm9sUoo+OrDTzFaxEoYrZJ95PCzFxwYWQsQQgmWupZ
        rVJADUucZ7PeBhwXLobCL2ysIPVYDe44H42OhD4=
X-Google-Smtp-Source: AGHT+IFTLhSC/X57Eee7vJx7GkarEgudwMA51wceosPi5cv22aXm4ogyqwY/Wgz4IJ11cpeytqMgTta5hWoKHE0rNJc=
X-Received: by 2002:a2e:8717:0:b0:2bc:c11c:4471 with SMTP id
 m23-20020a2e8717000000b002bcc11c4471mr16078819lji.21.1693178104154; Sun, 27
 Aug 2023 16:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230628232417.120844-1-linux@treblig.org> <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey> <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
In-Reply-To: <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 27 Aug 2023 18:14:52 -0500
Message-ID: <CAH2r5muFqOx91jiukxSVy3iqxZm+NOEZy7-oXKOT0G+yrUF3yw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        linkinjeon@kernel.org, tom@talpey.com, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shaggy,
I can add these - am updating the series to include your RB

On Wed, Jul 19, 2023 at 5:06=E2=80=AFPM Dave Kleikamp <dave.kleikamp@oracle=
.com> wrote:
>
> On 7/19/23 4:58PM, Dr. David Alan Gilbert wrote:
> > * Steve French (smfrench@gmail.com) wrote:
> >> The related question is which tree to send it from, if no problems
> >> reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
> >> and because there hasn't been activity in fs/nls for years)
> >
> > That was my hope, given that ~half of the patches are directly on that
> > code, and it's the only very active tree this touches as far as I can
> > tell.
> >
> >> On Wed, Jul 19, 2023 at 12:56=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> >>>
> >>> No objections to this on my part.  If Shaggy is ok with the JFS
> >>> change, we could target it for 6.6-rc1 if it tests out ok
>
> For the series:
> Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>
> Steve,
> Feel free to pull in even the 4th patch into your tree with my consent.
> Or if you're more comfortable, I could submit it after yours hits mainlin=
e.
>
> Shaggy
>
> >
> > Thanks.
> >
> > Dave
> >
> >>> On Wed, Jul 12, 2023 at 6:28=E2=80=AFPM Dr. David Alan Gilbert <dave@=
treblig.org> wrote:
> >>>>
> >>>> * linux@treblig.org (linux@treblig.org) wrote:
> >>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>>>
> >>>>> The smb client and server code have (mostly) duplicated code
> >>>>> for unicode manipulation, in particular upper case handling.
> >>>>>
> >>>>> Flatten this lot into shared code.
> >>>>
> >>>> Gentle two week ping on this please.
> >>>>
> >>>> Dave
> >>>>
> >>>> (Apologies to the 3 of you who already got a copy of this ping,
> >>>> recent due to a missing header ',' )
> >>>>
> >>>>> There's some code that's slightly different between the two, and
> >>>>> I've not attempted to share that - this should be strictly a no
> >>>>> behaviour change set.
> >>>>>
> >>>>> In addition, the same tables and code are shared in jfs, however
> >>>>> there's very little testing available for the unicode in there,
> >>>>> so just share the raw data tables.
> >>>>>
> >>>>> I suspect there's more UCS-2 code that can be shared, in the NLS co=
de
> >>>>> and in the UCS-2 code used by the EFI interfaces.
> >>>>>
> >>>>> Lightly tested with a module and a monolithic build, and just mount=
ing
> >>>>> itself.
> >>>>>
> >>>>> This dupe was found using PMD:
> >>>>>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> >>>>>
> >>>>> Dave
> >>>>>
> >>>>> Version 2
> >>>>>    Moved the shared code to fs/nls after v1 feedback.
> >>>>>    Renamed shared tables from Smb to Nls prefix
> >>>>>    Move UniStrcat as well
> >>>>>    Share the JFS tables
> >>>>>
> >>>>> Dr. David Alan Gilbert (4):
> >>>>>    fs/smb: Remove unicode 'lower' tables
> >>>>>    fs/smb: Swing unicode common code from smb->NLS
> >>>>>    fs/smb/client: Use common code in client
> >>>>>    fs/jfs: Use common ucs2 upper case table
> >>>>>
> >>>>>   fs/jfs/Kconfig               |   1 +
> >>>>>   fs/jfs/Makefile              |   2 +-
> >>>>>   fs/jfs/jfs_unicode.h         |  17 +-
> >>>>>   fs/jfs/jfs_uniupr.c          | 121 -------------
> >>>>>   fs/nls/Kconfig               |   8 +
> >>>>>   fs/nls/Makefile              |   1 +
> >>>>>   fs/nls/nls_ucs2_data.h       |  15 ++
> >>>>>   fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
> >>>>>   fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
> >>>>>   fs/smb/client/Kconfig        |   1 +
> >>>>>   fs/smb/client/cifs_unicode.c |   1 -
> >>>>>   fs/smb/client/cifs_unicode.h | 330 +-----------------------------=
-----
> >>>>>   fs/smb/client/cifs_uniupr.h  | 239 -------------------------
> >>>>>   fs/smb/server/Kconfig        |   1 +
> >>>>>   fs/smb/server/unicode.c      |   1 -
> >>>>>   fs/smb/server/unicode.h      | 325 +-----------------------------=
----
> >>>>>   fs/smb/server/uniupr.h       | 268 ----------------------------
> >>>>>   17 files changed, 467 insertions(+), 1293 deletions(-)
> >>>>>   delete mode 100644 fs/jfs/jfs_uniupr.c
> >>>>>   create mode 100644 fs/nls/nls_ucs2_data.h
> >>>>>   create mode 100644 fs/nls/nls_ucs2_utils.c
> >>>>>   create mode 100644 fs/nls/nls_ucs2_utils.h
> >>>>>   delete mode 100644 fs/smb/client/cifs_uniupr.h
> >>>>>   delete mode 100644 fs/smb/server/uniupr.h
> >>>>>
> >>>>> --
> >>>>> 2.41.0
> >>>>>
> >>>> --
> >>>>   -----Open up your eyes, open up your mind, open up your code -----=
--
> >>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy =
 \
> >>>> \        dave @ treblig.org |                               | In Hex=
 /
> >>>>   \ _________________________|_____ http://www.treblig.org   |______=
_/
> >>>
> >>>
> >>>
> >>> --
> >>> Thanks,
> >>>
> >>> Steve
> >>
> >>
> >>
> >> --
> >> Thanks,
> >>
> >> Steve



--=20
Thanks,

Steve
