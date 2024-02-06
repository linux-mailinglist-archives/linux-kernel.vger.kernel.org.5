Return-Path: <linux-kernel+bounces-55236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90C284B979
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC2D291C66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C813666F;
	Tue,  6 Feb 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3D7GsJ/"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17494134CE4;
	Tue,  6 Feb 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233008; cv=none; b=aErXIwhlW3QxWI7Wp1x/IYiMKLZbVpQaKgYqM3+MQ+tzj4VEyrYYLugmEoTBEYQ4u9IHAJICcziW3mn/YHMKeLDg/2H1Z//IcN9lO6/aQRzgZIRyBu9RkQVrL510CGUys3480urlagZGBbVIs0icfXcZYYzn2PJB0BJKhcm7Rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233008; c=relaxed/simple;
	bh=Gh9wuJm14vCFANUo4tl3lHc80pd3ixaoVbcshke1Wt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaSAxMAlgZWpy9F2nzYFReA+DA2zHmJL67BvMkcofr7PS5MmGFNlJH6UPBUKrumtiJvdO7fPfsryxuXrNx9NzcohBl/9IYRxe2mEA5qhNBZF1egPtUp5v7LAOtsASvVacXA5LP5UikiZtR/0PI9OqYEVJyDmAABxVbeihmeHozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3D7GsJ/; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6869e87c8d8so20933836d6.2;
        Tue, 06 Feb 2024 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233006; x=1707837806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/7TPM7Tazk5LDtz7VEiySoWxaEy9ATdPXGmfgfBPRA=;
        b=j3D7GsJ/B5dHkqAnAZ0JY6IgHpWZOjvcpvTmsrmjG5jSzegqhp7p90t2HAwiiXDn+S
         jzoKpn5gzjq3u7D3gstDWbrlJ48oV+kjy7JeRdWswljKjx2G871uRFL+/FJusVEN5oJ5
         yMutPKuBb0SDy3PVRp+NbJDTuVX68QkdDK6tO+uqvnkcRjXlsZGEZ2BRbYiWhZPtOp7s
         3Z8lQWY1+5VAp/TMSU4Zrb2PiYY0TktLuDRk8Gplq9Jf8DzSe2B3VRchfhXuMhhzgidN
         5Mno2W6ILbn3SvNTSgrRioxch7ySVxVMDVjOg6w0ew5DrJ2fyKGbBBx4D2ONbs3tSuKC
         G/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233006; x=1707837806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/7TPM7Tazk5LDtz7VEiySoWxaEy9ATdPXGmfgfBPRA=;
        b=mfwgLIiqgirfUaAto2mTfzgTL1zoXRH17jB6Kd6anL0B3zPn6Rf/RLdqQs531w68KH
         nPiF1edoPAA7vb+FXIZCetq7/g4p2fAq5JWJtJ5ePbQeIaoTstOlsm+cc+r1CIiDyFLX
         Ews+RDS3JAD1grfdL7qxim24phQTeeonzehWC4QBf8wmXywSIlABTtLQ+jSEq14y/ns2
         bIFPlwHfvQfKHzwdy4lv3o15pJxvujZYyIrrBZY3oi7V8s7fxPvoMWhLdxIbVsMJxig+
         9SZW9KttwypC8BXAUt07crO77pxib121JDVlvolqGhI/MuDULDoHGWtXNLJqbKML4whr
         eIcg==
X-Gm-Message-State: AOJu0Yw92kUa3yEoehph7O0msDf0u9P6JK1uDm7vxxF01eWag9kxehub
	clD95cN62odmxy4+1IbUF1ZeNTLBAee9gYecbcb/Usy/FkcHOwN1180lLcshUj/s1n0lP0z2LfZ
	itDd575LyMU2AJyOKMZLTRQgTCfKVWC5yXqk=
X-Google-Smtp-Source: AGHT+IFRvj8iQLkOF9LHUyNODvtxMMSaPlVZsDFwsH1v0atlDvgj+vMTCL06Sjyl5NiGm4tS/mE2f3YB2XRYAjZAdrI=
X-Received: by 2002:a05:6214:c6a:b0:68c:88a4:3fdd with SMTP id
 t10-20020a0562140c6a00b0068c88a43fddmr2834431qvj.27.1707233005762; Tue, 06
 Feb 2024 07:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-10-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-10-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:23:14 +0200
Message-ID: <CAOQ4uxhQgCqNZ_4Dy1PghCHBg7H4qaf-st2pWhXe9eq1+dsHHA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] ima: Record i_version of real_inode for change detection
To: Stefan Berger <stefanb@linux.ibm.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, brauner@kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> process_measurement() will try to detect file content changes for not-yet=
-
> copied-up files on a stacked filesystem based on the i_version number of
> the real inode: !inode_eq_iversion(real_inode, iint->version)
> Therefore, take a snapshot of the i_version of the real file to be used
> for i_version number-based file content change detection by IMA in
> process_meassurements().
>
> In this case vfs_getattr_nosec() cannot be used since it will return the
> i_version number of the file on the overlay layer which will trigger more
> iint resets in process_measurements() than necessary since this i_version
> number represents different state than that of the real_inode (of a
> not-yet-copied up file).
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima_api.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 597ea0c4d72f..530888cc481e 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -14,6 +14,7 @@
>  #include <linux/xattr.h>
>  #include <linux/evm.h>
>  #include <linux/fsverity.h>
> +#include <linux/iversion.h>
>
>  #include "ima.h"
>
> @@ -250,7 +251,6 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>         int result =3D 0;
>         int length;
>         void *tmpbuf;
> -       u64 i_version =3D 0;
>
>         /*
>          * Always collect the modsig, because IMA might have already coll=
ected
> @@ -263,16 +263,6 @@ int ima_collect_measurement(struct integrity_iint_ca=
che *iint,
>         if (iint->flags & IMA_COLLECTED)
>                 goto out;
>
> -       /*
> -        * Detecting file change is based on i_version. On filesystems
> -        * which do not support i_version, support was originally limited
> -        * to an initial measurement/appraisal/audit, but was modified to
> -        * assume the file changed.
> -        */
> -       result =3D vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_C=
OOKIE,
> -                                  AT_STATX_SYNC_AS_STAT);
> -       if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> -               i_version =3D stat.change_cookie;
>         hash.hdr.algo =3D algo;
>         hash.hdr.length =3D hash_digest_size[algo];
>
> @@ -302,10 +292,22 @@ int ima_collect_measurement(struct integrity_iint_c=
ache *iint,
>
>         iint->ima_hash =3D tmpbuf;
>         memcpy(iint->ima_hash, &hash, length);
> -       iint->version =3D i_version;
> -       if (real_inode !=3D inode) {
> +       if (real_inode =3D=3D inode) {
> +               /*
> +                * Detecting file change is based on i_version. On filesy=
stems
> +                * which do not support i_version, support was originally=
 limited
> +                * to an initial measurement/appraisal/audit, but was mod=
ified to
> +                * assume the file changed.
> +                */
> +               result =3D vfs_getattr_nosec(&file->f_path, &stat,
> +                                          STATX_CHANGE_COOKIE,
> +                                          AT_STATX_SYNC_AS_STAT);
> +               if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
> +                       iint->version =3D stat.change_cookie;
> +       } else {
>                 iint->real_ino =3D real_inode->i_ino;
>                 iint->real_dev =3D real_inode->i_sb->s_dev;
> +               iint->version =3D inode_query_iversion(real_inode);
>         }
>

The commit that removed inode_query_iversion db1d1e8b9867 ("IMA: use
vfs_getattr_nosec to get the i_version") claimed to do that because
inode_query_iversion() did not work in overlayfs and now this commit
uses inode_query_iversion() only for overlayfs.

STATX_CHANGE_COOKIE does not seem to make much sense in this
code anymore, unless it is still needed, according to original commit to
"allow IMA to work properly with a broader class of filesystems in the futu=
re."
Jeff?


Thanks,
Amir.

