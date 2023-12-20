Return-Path: <linux-kernel+bounces-6317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB281971F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160BC1C25682
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141DE8F42;
	Wed, 20 Dec 2023 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLyJDiAp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154608BF9;
	Wed, 20 Dec 2023 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-67aa0f5855cso24456636d6.1;
        Tue, 19 Dec 2023 19:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703042528; x=1703647328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHLaEbtVlZfM0JuHWoDFXkodYsemyzUUuaKGG9ekSS8=;
        b=SLyJDiApMOLoYeghJ7N6fU11P+drpx5uZyoj2AsvpNkTi4wel6lD+A+9Ex4sAXDh4Q
         eEYeZ7KKQfYfGn9Sa75e0sVSdVpit+wwLtn1CRcpHMB9FeYbs9k0Fnx2cCN8Q2nKSAC+
         vjLv13XLZIbzulH2hpXT9+EgTt+BltbjgcSzP/MfE9B1GLW1dNTbjKEN3N8yDezyaRV/
         aagfygFr/jnw7MoW3RDJpywJxTg4Qyaaj7rGIokC/S+/R65/q2NPgWeFN3bimHbsRhoo
         8RkuSpoV/OnGni//+OzWqfxmyZdKpGCFBuIwP9F44vNkEYRIk1BOfyRoiLAly01I1cRQ
         4e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042528; x=1703647328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHLaEbtVlZfM0JuHWoDFXkodYsemyzUUuaKGG9ekSS8=;
        b=nzeu/kwt5MVZQ287+iKzEIKgFbEl3z1rvaXZnSfHuuybTjYA0jWLfLcEKhuZmueSK+
         IWkbsOxtQl+TfHDmy+PPuZDfsX+0vIwog719IUZ+zBxDvZf9PqpwjlrnhyJsr7Z4ktPB
         Qe97npnM/ji1Logz5K6mc+9AZwzokANqO6y2yo1P0lswkvKIbLMaPIpNDt/5gtj3SSt3
         JOtLRCORI0xoF8YIBSXFstvBIkHsp0JoeZReoIvFUn1zc2vp/DHWNj1ssXfqsW+uVcSm
         vj/cisv4uuYUQ8BBcAMUbDH59mGlRHGfHQeHgwzfko+/GCzK6aQ4/jNWoXCxyf3u1Bgy
         hgYw==
X-Gm-Message-State: AOJu0Yx8U5g9luBjOrL7MCKxCtbeGSqfH9QwF0t5hxLcgfOF16HPsZO4
	zzXJ6CrSr0WuvTeyQQq0aARmMM30FweN5hFialpUrs8fEhk=
X-Google-Smtp-Source: AGHT+IGOBepBqzlcd63kDoSmoDtNAxT7C39IpEGRFsw5Sn7SnNzTw5MAo4Qu6yZIhUdhz4WHIYYHni6Cq/xfgVh1pMQ=
X-Received: by 2002:ad4:5685:0:b0:67a:c37b:57f with SMTP id
 bd5-20020ad45685000000b0067ac37b057fmr12197293qvb.42.1703042527789; Tue, 19
 Dec 2023 19:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220105605.6f288fb6@canb.auug.org.au>
In-Reply-To: <20231220105605.6f288fb6@canb.auug.org.au>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Dec 2023 05:21:56 +0200
Message-ID: <CAOQ4uxiwgW1-6vyUwWNJqBXBdU85i5HytPnSO_PRtRKv2MChhg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:56=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vfs tree got a conflict in:
>
>   fs/overlayfs/copy_up.c
>
> between commit:
>
>   413ba91089c7 ("ovl: fix dentry reference leak after changes to underlyi=
ng layers")
>
> from the overlayfs-fixes tree and commit:
>
>   a8b0026847b8 ("rename(): avoid a deadlock in the case of parents having=
 no common ancestor")
>
> from the vfs tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>

You solved it correctly, but anyway, ovl-fixes is for v6.7-rc7 and I plan
to send a PR for it soon.

I did try to give Al a heads up:
https://lore.kernel.org/linux-unionfs/CAOQ4uxi+4-jyNY6jzNt1wG5xcYSZiSfU0AtC=
WtF71PSW160zRw@mail.gmail.com/

Thanks,
Amir.

>
> diff --cc fs/overlayfs/copy_up.c
> index 696478f09cc1,e44dc5f66161..000000000000
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@@ -779,13 -757,14 +779,15 @@@ static int ovl_copy_up_workdir(struct o
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>  -       * If temp was moved, abort without the cleanup.
>          */
>         ovl_start_write(c->dentry);
> -       if (lock_rename(c->workdir, c->destdir) !=3D NULL ||
> -           temp->d_parent !=3D c->workdir) {
> +       trap =3D lock_rename(c->workdir, c->destdir);
> +       if (trap || temp->d_parent !=3D c->workdir) {
>  +              /* temp or workdir moved underneath us? abort without cle=
anup */
>  +              dput(temp);
>                 err =3D -EIO;
> +               if (IS_ERR(trap))
> +                       goto out;
>                 goto unlock;
>         } else if (err) {
>                 goto cleanup;

