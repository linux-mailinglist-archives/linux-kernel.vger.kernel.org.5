Return-Path: <linux-kernel+bounces-6367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC48197B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B6C1C254CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31951DA34;
	Wed, 20 Dec 2023 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbnlcBVj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E81D699;
	Wed, 20 Dec 2023 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67a338dfca7so44176386d6.2;
        Tue, 19 Dec 2023 20:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046121; x=1703650921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ooTJpxsdDr4enEEmEM9lcMYReU/3YLQLnQ0aOFZ1aY=;
        b=RbnlcBVjBNfxaVnXIelHcxTVf49vCsdujG0AflDaWCZPpovTXEzPRRyPtbJD70umfT
         zsohWQMiBJ6u54tgP++kLhaPItT1XNWTUMYiuH+cz+McAEqfeZABDvifE87iteS8cK0u
         F5uXxY/zUjI+SpkUFGieWLRzNjRkl67ocy/vLEtHF4tBv/RkalPueNfdCl+mXkpK48fL
         gp5Gbu2Un47pqBerNhzDoLANfD3GT7L95Gt2ryrD07ammWu4FOfOS6pa/DvlC6NJzxUA
         GNFVOibJiDZKSNu8hXhTXCgnNAxrfodknWQPzHGdVgkzHBrkDR61O+aqcdpaCa463eTs
         sbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046121; x=1703650921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ooTJpxsdDr4enEEmEM9lcMYReU/3YLQLnQ0aOFZ1aY=;
        b=A8N/I93jeKJ3bVSRvGlnQBxDGdB2Azd39oC3BwKUlXTk50jStxpYGSG2/GIrFhpLgB
         53UL4jAp4det0rdvQ+fjTRyoYAxX2NIt9iPnK02bo76Cysamj+dvRWmBD7leHSdaZtk9
         AezMAfibQXmacy5rJI1QHel5uwTtv95a3ESbf4FIvEyXwVYu+xnGEqSuJ2wVWo8m7nJY
         uoq7CVxCqEw8bJ5zPonBf7iWfHC93YOkoAWkzu9Y2lMA6mvkll+pKqZayD1z3j9rKrf5
         1LWK4TASeuVAwtGN6sZ3O4AQbyojqGU/Mpkm8UpV6ApgYh8orKopV0ITyF/dvuuS6yOw
         cxEw==
X-Gm-Message-State: AOJu0YxmzpEqObaEo57SHWH3NFmu2eVJVG8uPqDstw5NTZrKSxXSJ12w
	gYUjA2gfA2/1ZOevJ7zH5bx5yfaTYqCE6BbkS4A=
X-Google-Smtp-Source: AGHT+IGNfjDRlc4odV4V7xrLFPVpAEKIzsKn1I/97J+GLLNgkPNSfOZTkcQdZoygASG7WTiR5F9MHkkTUOM/4srXPnA=
X-Received: by 2002:a05:6214:2a46:b0:67f:3d7f:ff8c with SMTP id
 jf6-20020a0562142a4600b0067f3d7fff8cmr5923952qvb.114.1703046121405; Tue, 19
 Dec 2023 20:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219175206.12342-1-zohar@linux.ibm.com> <20231219175206.12342-4-zohar@linux.ibm.com>
In-Reply-To: <20231219175206.12342-4-zohar@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Dec 2023 06:21:50 +0200
Message-ID: <CAOQ4uxiajZKJQWG8JWSRwO5a9nzJVt73sOOXLCuTRn8kMPK3Nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] overlay: disable EVM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:52=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Until a complete solution is developed, update 'sb->s_iflags' to
> disable EVM.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a0967bb25003..e3d9c6c80a47 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1454,6 +1454,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>          * lead to unexpected results.
>          */
>         sb->s_iflags |=3D SB_I_NOUMASK;
> +       sb->s_iflags |=3D SB_I_EVM_UNSUPPORTED;
>
>         err =3D -ENOMEM;
>         root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> --
> 2.39.3
>

