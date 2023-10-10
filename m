Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A597BF9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjJJL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:28:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745094;
        Tue, 10 Oct 2023 04:28:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77428510fe7so457800185a.1;
        Tue, 10 Oct 2023 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696937328; x=1697542128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcSSo08SAPJZ3ThH/EN9NJsskGHvIldiErOVapxxF7E=;
        b=A8i8mN4V49cnnglJg64WrxbR/Ipn2dPnMDSEmX5OnS2Vji7XhFHUsqStQ0D+yCVqvm
         xReHikr4Qng98tAgLf06g6uRFUnfeLxaJhtKCRNyPJHy5iuLaoy7tvd54f4YkFevINTd
         +Qp477895T2s/dw7zPTcJdr3Q2Hc2tzTXc3jsSc8igEqiU0Difcbof9Sd2WV38YrmzBw
         7knrd9wc8yd0mMMHD8IxWbiODYHJI24qpH9hKwhHEGpg83bKEdep1iokWsvO2JZvuN4Y
         xgs1ePqFPYSr93f72ezazsVzDrL3W+e68zvJIIMlRLx+fq1/YpFJrSeYJOZBEBg1gwa7
         fAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696937328; x=1697542128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcSSo08SAPJZ3ThH/EN9NJsskGHvIldiErOVapxxF7E=;
        b=UivAvixwaSjTf7vXX1LKx0TlsRcTHyK9UKVoV81c8Itvxc4p7CLXwhcdmATj3G1S5s
         OyNKw0jLSfn4/ublJlx4XWYE3KOw1uhE9yTwkMLFiwWjkpvCB/WqIcqogzk53tT/87iJ
         raxoQRsRvo1Zt2Y0tA24tpwMY1oaGf7QlBf/3avcAe9gzpzpaGVDdAQ2JNtBbbs0qmMN
         M3ozkFki+dD4l0zf7ubeEedUJFVlp6TkJ1AVBXycJ7QBDtAmjUeRmKLp2iE+enT/RwT9
         TdrKjWFeH7DQ+0xglLm0NIlaz4f3knjFACvFXk3QNN6lvu3n/0DdScFGF+6HYlchaD8B
         LErA==
X-Gm-Message-State: AOJu0YxNER2EKJrD4RWPO1gnie159PxONgjclJKT7SZdTmYpEdD/itdG
        yLZTRVsJn4epoCwpeAEPfiDwRhnkRLdMQrYCs2A=
X-Google-Smtp-Source: AGHT+IGvbOqAtyEESrFFsNZv65ts1R9QNQ2A/2PCFJ2xf9pzGp69I+a1slYjW05g3/woRYo5m2hvYKa+uV53A0G0H9Y=
X-Received: by 2002:a05:620a:410b:b0:773:f6ea:1f59 with SMTP id
 j11-20020a05620a410b00b00773f6ea1f59mr18229652qko.16.1696937327676; Tue, 10
 Oct 2023 04:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231010105021.57fa4379@canb.auug.org.au> <20231010111436.46f64716@canb.auug.org.au>
In-Reply-To: <20231010111436.46f64716@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Oct 2023 14:28:36 +0300
Message-ID: <CAOQ4uxivzEgMxqQkVVH7QfUsq7Dji9KOMcuZAWxKqwXd+MywAg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 overlayfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Larsson <alexl@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 3:14=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> On Tue, 10 Oct 2023 10:50:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> >
> >   fs/overlayfs/super.c
> >
> > between commit:
> >
> >   1e97d6e67406 ("ovl: Move xattr support to new xattrs.c file")
> >
> > from the overlayfs tree and commit:
> >
> >   3f644c1cd7b5 ("overlayfs: move xattr tables to .rodata")
> >

Doh! I should've notice that when I acked the constify patch.

> > from the vfs-brauner tree.
> >
> > I fixed it up (I used the former version of this file and applied the
> > following merge fix patch) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tre=
e
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularl=
y
> > complex conflicts.
>
> Actually needs this:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 10 Oct 2023 10:47:16 +1100
> Subject: [PATCH] fix up for "ovl: Move xattr support to new xattrs.c file=
"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/overlayfs/overlayfs.h | 2 +-
>  fs/overlayfs/xattrs.c    | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 620d89ba4b6e..ca88b2636a57 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -864,7 +864,7 @@ static inline bool ovl_force_readonly(struct ovl_fs *=
ofs)
>
>  /* xattr.c */
>
> -const struct xattr_handler **ovl_xattr_handlers(struct ovl_fs *ofs);
> +const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *of=
s);
>  int ovl_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>                 struct iattr *attr);
>  int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
> diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
> index 1b16b0abdf91..383978e4663c 100644
> --- a/fs/overlayfs/xattrs.c
> +++ b/fs/overlayfs/xattrs.c
> @@ -251,19 +251,19 @@ static const struct xattr_handler ovl_other_xattr_h=
andler =3D {
>         .set =3D ovl_other_xattr_set,
>  };
>
> -static const struct xattr_handler *ovl_trusted_xattr_handlers[] =3D {
> +static const struct xattr_handler * const ovl_trusted_xattr_handlers[] =
=3D {
>         &ovl_own_trusted_xattr_handler,
>         &ovl_other_xattr_handler,
>         NULL
>  };
>
> -static const struct xattr_handler *ovl_user_xattr_handlers[] =3D {
> +static const struct xattr_handler * const ovl_user_xattr_handlers[] =3D =
{
>         &ovl_own_user_xattr_handler,
>         &ovl_other_xattr_handler,
>         NULL
>  };
>
> -const struct xattr_handler **ovl_xattr_handlers(struct ovl_fs *ofs)
> +const struct xattr_handler * const *ovl_xattr_handlers(struct ovl_fs *of=
s)
>  {
>         return ofs->config.userxattr ? ovl_user_xattr_handlers :
>                 ovl_trusted_xattr_handlers;
> --

I will rebase overlayfs-next over Christian's vfs.xattr branch and
squash your fix.

Thanks!
Amir.
