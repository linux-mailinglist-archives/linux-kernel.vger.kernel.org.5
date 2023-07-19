Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A3759CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGSR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjGSR4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:56:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCBE2101;
        Wed, 19 Jul 2023 10:56:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9352ff1aeso68509721fa.1;
        Wed, 19 Jul 2023 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689789389; x=1690394189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+XMp8h3m8dCu8neoz5W1i52keRbzheZjzjhOpBzlSo=;
        b=srpU9LvvLcII1UinIHpxS2X9G5nD1jhKi8rB1amEkHn2FpIORNq8uRlKumxPNPg85h
         ubcU8Lx44ngV/Db65GlJTDg6BMfirT34yxTZgadMD4aqA4VgkiGCaD8QsIa7sMpgirEq
         Y/Mf+a6VT18TEb5XcT1PriTTe5qkM1GQEUebmDa0sqIEnThMNAcsR+qyALujpzOJakVe
         6jPgfgZRA+VZjwsJgB8kcpbGcDYDuZCrrXkih4FHAjx2YweQ7tcmFO27y4V7z56xuSPK
         2b/kMuZjbJ9W7CM7Ehk0IHsTE2fSTeehtTLYPhoasQ3CFpDipu4Wg73bJXk3+nbSk6sM
         AbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789389; x=1690394189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+XMp8h3m8dCu8neoz5W1i52keRbzheZjzjhOpBzlSo=;
        b=RXgO9durO7t7MJ69xC32FgnVt6v3AtNU/ENF/p5E6KCBgzBDXB6tihJ/Y4ZNaWO/5P
         62jXSe7GhaTqBIwOe5G7En2hoBGIppfHNYZCTSYUP+KW6aCU6Zj3WB2hMXjZaL6pe7ks
         T+90jQzn5h3tVn2zA8yitzty5pRC+E9nscgISzHEaUguBpGT9qkSKL5YpIDF+lBuXiTi
         et0GwGwfR3s0+ffDVMlagFZRzSChjmVq+uRVMfvikdtCRqM8kcBKLCaf/Xhm1O4HUuJa
         H4q3ZQqO+TZ0m75ZzmFpVlTcijcClkrZQPD2bwO5FtxM+UDpPR2NvAlJdSyOOV7DlIHM
         B1sw==
X-Gm-Message-State: ABy/qLZXMC72Ft1VqyxZldq0dcb87JHtQAKf6x4LcBKclXaSWj8dY1md
        YvG8jVLG2YYLAEZUNJ+LJ8b8frkqXjPygXi2izw=
X-Google-Smtp-Source: APBJJlHbu45fZzYbZYn/cZ2aaY9iML8EUbFLOUhXDrVS3/iIVLTblzc0ysCC9Hbwp87Zw9J5ELt78UNF0vivTYkVZdw=
X-Received: by 2002:a2e:6e13:0:b0:2b6:e2c1:6cda with SMTP id
 j19-20020a2e6e13000000b002b6e2c16cdamr12642ljc.46.1689789388374; Wed, 19 Jul
 2023 10:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230628232417.120844-1-linux@treblig.org> <ZK80mu/YbHLEABAB@gallifrey>
In-Reply-To: <ZK80mu/YbHLEABAB@gallifrey>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 19 Jul 2023 12:56:17 -0500
Message-ID: <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No objections to this on my part.  If Shaggy is ok with the JFS
change, we could target it for 6.6-rc1 if it tests out ok

On Wed, Jul 12, 2023 at 6:28=E2=80=AFPM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > The smb client and server code have (mostly) duplicated code
> > for unicode manipulation, in particular upper case handling.
> >
> > Flatten this lot into shared code.
>
> Gentle two week ping on this please.
>
> Dave
>
> (Apologies to the 3 of you who already got a copy of this ping,
> recent due to a missing header ',' )
>
> > There's some code that's slightly different between the two, and
> > I've not attempted to share that - this should be strictly a no
> > behaviour change set.
> >
> > In addition, the same tables and code are shared in jfs, however
> > there's very little testing available for the unicode in there,
> > so just share the raw data tables.
> >
> > I suspect there's more UCS-2 code that can be shared, in the NLS code
> > and in the UCS-2 code used by the EFI interfaces.
> >
> > Lightly tested with a module and a monolithic build, and just mounting
> > itself.
> >
> > This dupe was found using PMD:
> >   https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> >
> > Dave
> >
> > Version 2
> >   Moved the shared code to fs/nls after v1 feedback.
> >   Renamed shared tables from Smb to Nls prefix
> >   Move UniStrcat as well
> >   Share the JFS tables
> >
> > Dr. David Alan Gilbert (4):
> >   fs/smb: Remove unicode 'lower' tables
> >   fs/smb: Swing unicode common code from smb->NLS
> >   fs/smb/client: Use common code in client
> >   fs/jfs: Use common ucs2 upper case table
> >
> >  fs/jfs/Kconfig               |   1 +
> >  fs/jfs/Makefile              |   2 +-
> >  fs/jfs/jfs_unicode.h         |  17 +-
> >  fs/jfs/jfs_uniupr.c          | 121 -------------
> >  fs/nls/Kconfig               |   8 +
> >  fs/nls/Makefile              |   1 +
> >  fs/nls/nls_ucs2_data.h       |  15 ++
> >  fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
> >  fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
> >  fs/smb/client/Kconfig        |   1 +
> >  fs/smb/client/cifs_unicode.c |   1 -
> >  fs/smb/client/cifs_unicode.h | 330 +----------------------------------
> >  fs/smb/client/cifs_uniupr.h  | 239 -------------------------
> >  fs/smb/server/Kconfig        |   1 +
> >  fs/smb/server/unicode.c      |   1 -
> >  fs/smb/server/unicode.h      | 325 +---------------------------------
> >  fs/smb/server/uniupr.h       | 268 ----------------------------
> >  17 files changed, 467 insertions(+), 1293 deletions(-)
> >  delete mode 100644 fs/jfs/jfs_uniupr.c
> >  create mode 100644 fs/nls/nls_ucs2_data.h
> >  create mode 100644 fs/nls/nls_ucs2_utils.c
> >  create mode 100644 fs/nls/nls_ucs2_utils.h
> >  delete mode 100644 fs/smb/client/cifs_uniupr.h
> >  delete mode 100644 fs/smb/server/uniupr.h
> >
> > --
> > 2.41.0
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/



--=20
Thanks,

Steve
