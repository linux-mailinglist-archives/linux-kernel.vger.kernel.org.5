Return-Path: <linux-kernel+bounces-46491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D81C844081
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024681F2BE72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E517BB0D;
	Wed, 31 Jan 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H76iJFDD"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE274E24;
	Wed, 31 Jan 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707543; cv=none; b=HStpRzfRuNazWISZ0pKJpvo9Om4CkngKEEvilF/J7SIb/FkgWva+pajhRAfhjkhFDd0KQ/7mgGP+/K6VE9SuxXX0zxI9h8N0pG9Su0oKm6msM0b2V+zC3cc4y+JOJEOpqJre6KnC5k9xjPH8hYfW0oe1rnxSRwNk/XXYVVpTY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707543; c=relaxed/simple;
	bh=mrnPuo7MULhNnO7ai8Laqwn0SsYOAxZu1J39la8H5/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdTiZ0dwUz8C0BuqBy06uUTOo8zCTndlbsJeDLtzQRlOiHSi7A9nVoErynp6j5pcNEw1lZIjS2XS3qNmjiu8HUe19Dt+ZVFaMtt+e4O0ltvUyGLuimAQVTNBa2Dw3caRJk9UWaP+MKCvljZCLWd603pVE8CJjHmn0ztebKb/5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H76iJFDD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-686a92a8661so35717726d6.0;
        Wed, 31 Jan 2024 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707541; x=1707312341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Uf6+XRPgpi5oQnuc4d38dfYrYU0Kc9cu3ZpAUB+/+o=;
        b=H76iJFDDCyVEp6Lv5YPurKwteJX+MndVctXj5cTkMldIKXDjQmvsWMJi2m4AU+9MjK
         S512jeYsvs+d8KG1nRDrU162RK6cSU/FY6ixcvj+e3xXIYPHJQXVBilj6Ps00cCHbvm9
         5RCm6v/CSIC1n0HFgJFVTdk/djopkaYh9YZb6nPVV66WZ6H0VcQBE4CqeGgqUe3WUGpF
         Sz+eDCWmZk69Ppn/N0+Jau4i3sgCIecFsPdPzI9goZ4ZP10LfvyqOy3sqxAKYKNRfYx8
         GrkkIVaIkCnAd7ADUQJJvKy4PvqZSj6SueZ6TIor7EwydrHJ8w+d8spJUPb3g5LceZZG
         xLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707541; x=1707312341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Uf6+XRPgpi5oQnuc4d38dfYrYU0Kc9cu3ZpAUB+/+o=;
        b=q3H9iwZlnqdem8EeAXY1QyqyF5ZFYG93W/ElUUk10cUdtnPS1D50nf4jq73yjYUA65
         1bLK5hRi5d0A3Emq+vp/P2BIbaYdnU+fSCMgZFKYYModCrQ+IgNLmqb+TZdysdlt4f6O
         J9oX6cqUjZFpwudvft+R2vYXKL5iJf3LI2n3JQHhDxR7b2Ai+12plMFm/Wyn14RiuWE4
         Mlq3ZEbqwlLTdB9OKvYe+rDKXhW6rvTcuQ37A7Rc8zkdLS96ufJV4dHcD9exzIENDPGh
         qvh5cKHNGccHJh/C4hkWrkEPMQSx2BjFSMYoRJX+dvQk5KoCdQZMJJm37z3r6fatrppn
         r3/Q==
X-Gm-Message-State: AOJu0YzezZlh7LeJVJ7/nB4DBwy0RImJUiarEIGBETPIghfAh1IX3v4F
	BqkaWa5u62hYVVDDVGLWtLPv3tcUFLTB0MHLne1uUYE57g1cEEwBkkmWS6MgkwXOhKw3fsqho6F
	RrsrxOjBbb6qk/6jCc5G90+4NJcs6rmRw6OM=
X-Google-Smtp-Source: AGHT+IF0rFCz+Sbu4mEx3ApRgUFGYzvN4mVLVxYjSABEsCtH1c9/X2J9etEXURqYQtFa6EuS8Kcgw3imhNeVyQLiBrI=
X-Received: by 2002:a05:6214:2425:b0:68c:645d:1a14 with SMTP id
 gy5-20020a056214242500b0068c645d1a14mr2069494qvb.15.1706707540694; Wed, 31
 Jan 2024 05:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com> <20240130214620.3155380-2-stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-2-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 15:25:29 +0200
Message-ID: <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:46=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/copy_up.c            | 2 +-
>  include/linux/evm.h               | 2 +-
>  include/linux/lsm_hook_defs.h     | 3 ++-
>  include/linux/security.h          | 4 ++--
>  security/integrity/evm/evm_main.c | 2 +-
>  security/security.c               | 7 ++++---
>  security/selinux/hooks.c          | 2 +-
>  security/smack/smack_lsm.c        | 2 +-
>  8 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b8e25ca51016..bd9ddcefb7a7 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const stru=
ct path *oldpath, struct de
>                 if (ovl_is_private_xattr(sb, name))
>                         continue;
>
> -               error =3D security_inode_copy_up_xattr(name);
> +               error =3D security_inode_copy_up_xattr(old, name);

What do you think about:

                     error =3D security_inode_copy_up_xattr(name, NULL, 0);

and then later...

                     error =3D security_inode_copy_up_xattr(name, value, si=
ze);

I am asking because overlayfs uses mnt_idmap(path->mnt) and you
have used nop_mnt_idmap inside evm hook.
this does not look right to me?

Thanks,
Amir.

