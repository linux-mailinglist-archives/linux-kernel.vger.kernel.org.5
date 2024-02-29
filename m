Return-Path: <linux-kernel+bounces-87311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0130586D289
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF1B2228E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6A7BAF0;
	Thu, 29 Feb 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx/T48HD"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D7381C4;
	Thu, 29 Feb 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232375; cv=none; b=Fq7eybd/v71ixmposDlIjIisPCdABGh8IVr9CjegiXQ/ETWWjmGt0wC9Rzp9gWf+v50W/jfCQPj1x2SYxPifY6hukSmWPO/F8lRR8pShP+4bgXP7YA3rEnzeF/NGwrZC3VuQx1ruhosK1PUjL9+4XNtr7P9e4V8QjFLl50aOI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232375; c=relaxed/simple;
	bh=ZHOZtbc9jIlMQ8sVcH8NKlDTQkl9CqsIyPPne4FIDC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSFp2MtunZKnGHQ/GtiYzuOg7SuO0YUlKa8n9XM0f4nVeBcDIAhyBFrxlk+AWpnUj9y5pPz+OvOfVFFlya7gnHqF9pkuXUvXkiZT3mNF6UBJoRzWeQ0WbkLzUkBoNgr+GhOA3EicvoJ8JssFV0j0twpzVWgOyHu6kqjjOLy6Iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx/T48HD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d23114b19dso14600621fa.3;
        Thu, 29 Feb 2024 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709232372; x=1709837172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTAjALwdcVDn5UTXy5fJ9LpNRV83Hhro9y0hEKx4DCw=;
        b=Wx/T48HD13bQz5d+3TVTq4/mQT+sjFdd9NPQ16WcTN8WP+docNsacvcw7kKJIIk3zp
         emYsmYMAU9kxWbJLofOLipdCzQ/agAEmMnCkLDBhNRD5cnDnfvvmZHeCFsqs+yu4M1wZ
         QQxQP9fKYOay3VSN1CTTOsxq8KAjKnDm5lLc24jD2Jy1kTPmiSvEuEElIEUC2iC6CGlb
         kFiNAd9BP2feCRTTuA1A3jevKfGgW3/jAZCLSf5zQVwOjK7X2sdHzL7/D2U4WYLIBAw5
         HEiQU3xrtl3KVg9QXWpIVf7qX3Ch/QRlqui7Hbxy/Io9OdXUeY/RNcZb9nfQOXn1YamA
         kYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232372; x=1709837172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTAjALwdcVDn5UTXy5fJ9LpNRV83Hhro9y0hEKx4DCw=;
        b=hsC5oDKACcy8xFIvEGVhreeA4ypow0Z4x2erjywbpHXT88ejM8mq/zi8Znzp1xU6sr
         cnf+fQ70CAbXUsUk5e7nRLwtAqYZL786BWqSeSEjYqQvEf9aSVXEOdQ9yzUUEsgPmoRq
         KiCnlNYi+RPCiqnyg+4pRMgssVTqcsK/UAnu3P2F8Xmmkmohl13Nq1CQkfk62KQzVb9J
         eRrqHPr1qJS/v26/kLyc295S56jRic0ZDahrkSkq8rk948oWMgoM3SqQQxiOX4Le2aIL
         /ndn210vEtXXa4HtBvbJCAyYy4hLkG9Stm+MszGpa6F0KD3qxKbL/lf7QASOhCT9SYUT
         ovnw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1n3ksHJdf5CtPuJyC53+1ZigkXAKFJ6hoPUVxQkdEc7iqRlV1pFclWR3NAYcXcr339FeqkawlBfGFtEeAxWaKYiBRGIFRl85OIVK
X-Gm-Message-State: AOJu0YzHG3FyHbuQo3zcmwGUFbRYv4V0W4Nfu68VMPILCQ6DS0+4gpkA
	KMEcbGB3z6vy9/5tyl7gKindNKtLHHnzMtBKCoiXTuzoL6NFnIq8Y6bWyiiIQADGvyS7pWvV0rt
	zSFEjVpAbCNL8u761SftnrdNTkP7yl3o6jTw=
X-Google-Smtp-Source: AGHT+IERfDMvzKhe1oyB823VEheG6bjObEGKRw0uBxAT4vp+ZcvxfeKyYqZDAc3oe7QDnRjfGgdapGYkrTgP4vrIG0s=
X-Received: by 2002:a05:651c:1990:b0:2d2:fb9f:f7e7 with SMTP id
 bx16-20020a05651c199000b002d2fb9ff7e7mr2286247ljb.35.1709232371815; Thu, 29
 Feb 2024 10:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229121650.33983-1-thorsten.blum@toblux.com>
In-Reply-To: <20240229121650.33983-1-thorsten.blum@toblux.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 1 Mar 2024 03:45:55 +0900
Message-ID: <CAKFNMomtp7ZwB0gmxoemp_ums4rqOSbfF2BMS6kX+LwtKYtvCg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Use div64_ul() instead of do_div()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:19=E2=80=AFPM Thorsten Blum wrote:
>
> Fixes Coccinelle/coccicheck warning reported by do_div.cocci.
>
> Compared to do_div(), div64_ul() does not implicitly cast the divisor and
> does not unnecessarily calculate the remainder.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/nilfs2/cpfile.c | 2 +-
>  fs/nilfs2/dat.c    | 2 +-
>  fs/nilfs2/ioctl.c  | 4 ++--
>  fs/nilfs2/sufile.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> index 39136637f715..bafbdca1a17d 100644
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -28,7 +28,7 @@ nilfs_cpfile_get_blkoff(const struct inode *cpfile, __u=
64 cno)
>  {
>         __u64 tcno =3D cno + NILFS_MDT(cpfile)->mi_first_entry_offset - 1=
;
>
> -       do_div(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
> +       tcno =3D div64_ul(tcno, nilfs_cpfile_checkpoints_per_block(cpfile=
));
>         return (unsigned long)tcno;
>  }
>
> diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
> index 9cf6ba58f585..df5324b0c0cd 100644
> --- a/fs/nilfs2/dat.c
> +++ b/fs/nilfs2/dat.c
> @@ -460,7 +460,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *=
buf, unsigned int visz,
>                 kaddr =3D kmap_atomic(entry_bh->b_page);
>                 /* last virtual block number in this block */
>                 first =3D vinfo->vi_vblocknr;
> -               do_div(first, entries_per_block);
> +               first =3D div64_ul(first, entries_per_block);
>                 first *=3D entries_per_block;
>                 last =3D first + entries_per_block - 1;
>                 for (j =3D i, n =3D 0;
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index cfb6aca5ec38..f1a01c191cf5 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -1111,7 +1111,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode=
 *inode, void __user *argp)
>         segbytes =3D nilfs->ns_blocks_per_segment * nilfs->ns_blocksize;
>
>         minseg =3D range[0] + segbytes - 1;
> -       do_div(minseg, segbytes);
> +       minseg =3D div64_ul(minseg, segbytes);
>
>         if (range[1] < 4096)
>                 goto out;
> @@ -1120,7 +1120,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode=
 *inode, void __user *argp)
>         if (maxseg < segbytes)
>                 goto out;
>
> -       do_div(maxseg, segbytes);
> +       maxseg =3D div64_ul(maxseg, segbytes);
>         maxseg--;
>
>         ret =3D nilfs_sufile_set_alloc_range(nilfs->ns_sufile, minseg, ma=
xseg);
> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> index 0a8119456c21..c02b523d9c7e 100644
> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -48,7 +48,7 @@ nilfs_sufile_get_blkoff(const struct inode *sufile, __u=
64 segnum)
>  {
>         __u64 t =3D segnum + NILFS_MDT(sufile)->mi_first_entry_offset;
>
> -       do_div(t, nilfs_sufile_segment_usages_per_block(sufile));
> +       t =3D div64_ul(t, nilfs_sufile_segment_usages_per_block(sufile));
>         return (unsigned long)t;
>  }
>
> --
> 2.44.0
>

All of the fixes in this patch seem to be correct, but this doesn't
cover nilfs_resize_fs(), nilfs_max_segment_count(), and
nilfs_sb2_bad_offset(), which also have do_div() that doesn't use the
return value.

Did do_div.cocci make a difference ?

Thanks,
Ryusuke Konishi

