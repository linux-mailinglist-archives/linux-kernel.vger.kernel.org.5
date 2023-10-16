Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954BD7CAD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPPZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjJPPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:25:38 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01200100
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:25:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4577c1ae94fso1911577137.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697469932; x=1698074732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdJuKEfOYE5A8Kjx9jh0E3Zg2w1jYR6HPq2kjcrmS/0=;
        b=JcdSr72rvpPlwazyJ0Q57SAwJ7RrLaVVjxiZk94wb4Ic8/AJKYgLMgVERPuyFLOlOa
         3HukoMzI24rdo8Lc5jTpOWY9UTe8Gls+BwSiAkmjGUa1zo/X9zW+GQ8XgOOuwcJvqyoU
         TBtZ75WNkwpZxg6AxSM+4ixSI1gQd0tGKV+xBhIuDJCx821vRpv7kM68r66A+POorETj
         6GGeip+lXNUxs1vz8Tz3RfhbFinICPVY8sNDUScrEdrxc6bxkWjp8KW4wnknZj53v2QE
         tMWo9MoE86nse31dq3YbCgX+S/dMNd1YEWLwj/wCvNEC8BeCxAbejM6pv57+fx+iJuQj
         00Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697469932; x=1698074732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdJuKEfOYE5A8Kjx9jh0E3Zg2w1jYR6HPq2kjcrmS/0=;
        b=eX3usP0TOzq1yDiJ6l30kPnlP3zTeBu5iB6frQZGFssoWyQ9WJmFrN5JP74KUAMSej
         edife41n+ivODD0Z0by/qjZTF10VkuWFXyz8KTpn47GNsCbpUwbkCo4Djq6+FmXFi8px
         EoH6bJOUGnSCDqRsae0C7KwJzdGF1M/X7Gdr4CqgB+fadiLsqp8zH7n1dlKHGUjOgAX8
         IgiIPzXZaItStWytBdD//4YX8CYjuBH8Zd2SJPbZMYHk1Nvr2rU1h8zAzEnc57gAWIqQ
         KE5lJGQ604P6ane04+Rt/4PRfSejINoX7mL8KN0cPEQI9gr8qpx2MMRv+Yh63AOrfOnF
         8E/Q==
X-Gm-Message-State: AOJu0Yx4vIO7SsweK3h/Yf0KbWE1Y5h1ycdsaUcjmfkkBdCpaq6SrCp9
        mp8dDo2MWcMA099reZ8fQ8tOx5WWPehn2YwcTigrB67p
X-Google-Smtp-Source: AGHT+IHv6LjWv4HRL2UxPCMbLFi0e3vcsrOMIJJaPnJhhozM8EwMLhbByMTuBqLyW6wAzcEu6poTCfw8lOddnKHAqEs=
X-Received: by 2002:a67:c205:0:b0:458:11dd:87aa with SMTP id
 i5-20020a67c205000000b0045811dd87aamr1217133vsj.22.1697469931930; Mon, 16 Oct
 2023 08:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231013222453.240961-1-daeho43@gmail.com> <b16ea8fb-b3f2-4ae9-c543-cd84e0f3fa48@kernel.org>
In-Reply-To: <b16ea8fb-b3f2-4ae9-c543-cd84e0f3fa48@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 16 Oct 2023 08:25:21 -0700
Message-ID: <CACOAw_y4L_8YcJu3rK4cFFjwMg+z=XKppTGd2A6F+W9=mMV2Lg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: initialize allocated node area
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 11:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/10/14 6:24, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Need to initialize allocated node areas after memory allocation.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fsck/node.c       | 1 +
> >   include/f2fs_fs.h | 2 ++
> >   2 files changed, 3 insertions(+)
> >
> > diff --git a/fsck/node.c b/fsck/node.c
> > index 3761470..6508340 100644
> > --- a/fsck/node.c
> > +++ b/fsck/node.c
> > @@ -127,6 +127,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
> >
> >       node_blk =3D calloc(BLOCK_SZ, 1);
>
> calloc() has already initialized memory w/ zero, it doesn't need to reini=
tialize
> it again?

Sorry, I was confused. :(


>
> >       ASSERT(node_blk);
> > +     memset(node_blk, 0, BLOCK_SZ);
> >
> >       F2FS_NODE_FOOTER(node_blk)->nid =3D cpu_to_le32(dn->nid);
> >       F2FS_NODE_FOOTER(node_blk)->ino =3D F2FS_NODE_FOOTER(f2fs_inode)-=
>ino;
> > diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> > index 3c7451c..7e22278 100644
> > --- a/include/f2fs_fs.h
> > +++ b/include/f2fs_fs.h
> > @@ -1826,6 +1826,8 @@ static inline void show_version(const char *prog)
> >   static inline void f2fs_init_inode(struct f2fs_super_block *sb,
> >               struct f2fs_node *raw_node, nid_t ino, time_t mtime, mode=
_t mode)
> >   {
> > +     memset(raw_node, 0, F2FS_BLKSIZE);
>
> Ditto,
>
> Thanks,
>
> > +
> >       F2FS_NODE_FOOTER(raw_node)->nid =3D cpu_to_le32(ino);
> >       F2FS_NODE_FOOTER(raw_node)->ino =3D cpu_to_le32(ino);
> >       F2FS_NODE_FOOTER(raw_node)->cp_ver =3D cpu_to_le64(1);
