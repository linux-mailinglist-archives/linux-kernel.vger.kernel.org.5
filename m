Return-Path: <linux-kernel+bounces-55237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023684B9D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A81EB2F740
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364C13667A;
	Tue,  6 Feb 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh2hGqik"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC191384B7;
	Tue,  6 Feb 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233039; cv=none; b=NQZam8pS8YC866yanZIHkuuVwo/TZoPQIXyBA/VDfJWua7+7Nk46beA0eRwqeGMtLaUX58gPlULCKvB806vjk6lM3tg+TyglZg9BW9q3iegs9NVTkoMi/w2XRQfhFLSRZdS1EHp/wQXq4RCUd0ubH6RdT7JD5aIwXWjmFXicFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233039; c=relaxed/simple;
	bh=h6D7G40HLhvkIPZAkoYgGRkOEa7a+WeavQnqf68/ZkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMK3oQV64Apf4aqWFoUdV6wTKlirXpi2rxShuHXpeMeWwq2cYVKFiHCOZ60nFNu6B1iYbj1X6tbT/dGzVTVJQYnL92KO9kFmGHxG2vfAj1d+78lzn79JkTFQ4O+7lwU9uKI8R+qYjnPVN+qALtLHjJBPfAHTYhK5ibDACKItDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh2hGqik; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c4300518bso26272926d6.3;
        Tue, 06 Feb 2024 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233036; x=1707837836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6xtk+lTQ1Wv+Q+hYgJigN7nkM3Jee/QikU40oHDl6o=;
        b=gh2hGqik9xsYI0PoSblqr3HtoYJbJDGPKSA1cdOiLU8R6uGgWwIAJF/xl0lPD3grUB
         0inSWo2aic8xoEITO7voxNPqALYUg8U0KIo7RUJHtbx6i1N/PDkWkla7Cc9jSc+WN/ns
         /FK1zCwyeE0tSplopioa83ZCn6YwQIgwwtl97NGcSNSTzPcOOhbh/nWzCIAuH0sGA8Ih
         YyIUvV/TPsqrjNWPsBBgbhEddhHpQVZzlyxhIegNS73fXO0hlcqjQUNAAYU35upo4/tb
         FCUIgTPq8umxBvQ3aAjXuZ8I2lqT3hIq8s6IbOBNPyIENHB6mGOhcG1uiNKljnS1e5Gt
         l9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233036; x=1707837836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6xtk+lTQ1Wv+Q+hYgJigN7nkM3Jee/QikU40oHDl6o=;
        b=UnMoMLsdd3v0Zc98Km6ALpMacwxnm1voBdx5ImzSqdNEgXQHlwZMXjYxwfk1B3s0E6
         IuUDGWK47KL58cvefBChhvNuebUG4vkueWTw4CqgT2uLDkkkxxD4Qq5e+/yzDBlnu9QI
         MMetUEN4vncy8qh2Mzw7rp1UTFzuY1VIrvbwOWr8E69QO8mJsYbZHghRfpncfi5cbmIg
         my1UUdfq3BiSnqeUWgmALlmqTGkzn0Y2SRTGsqOeRNRV9uxFqwmubyeU8ldWC1Lkf4QE
         QUaMPG259tVXSu/DSmgAtArZgia20OIXqEOrsuXPG6KlHShTEmtcYMBsHvNVaZqX4iNu
         8pqQ==
X-Gm-Message-State: AOJu0Yw8C0W/VXaT/dZwqx7T3WDy71hnmS4H0pYnfafSllkD+5+uKMqu
	k1GXIAtwkEv9Le8r8zNfAiiuKAlga1zCCoMtZd8aIKp8tCq3yjAQu68uit+GzYbZ2bgh0ks71nO
	3M8VYGmAKNOe4AkjVtKggSiSZ99oTEQAQT4Y=
X-Google-Smtp-Source: AGHT+IGAhQgw7rqwh9fWZV7xPP1QZLXTOgkjzOJgAh+wuWPd4YxVLgxbcEE3cxrYPsHAUANbCX0YgFlHCUmCxEBkg80=
X-Received: by 2002:a05:6214:1c07:b0:68c:6cc8:1bfe with SMTP id
 u7-20020a0562141c0700b0068c6cc81bfemr4008827qvc.38.1707233036632; Tue, 06 Feb
 2024 07:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-2-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-2-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:23:45 +0200
Message-ID: <CAOQ4uxirYv94ub+WP=Lo5HPh6T0QHtkAM2v4tXjkofJrDvtBHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] ima: Rename backing_inode to real_inode
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, brauner@kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Rename the backing_inode variable to real_inode since it gets its value
> from real_inode().
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  security/integrity/ima/ima_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cc1217ac2c6f..f1a01d32b92a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -208,7 +208,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>                                u32 secid, char *buf, loff_t size, int mas=
k,
>                                enum ima_hooks func)
>  {
> -       struct inode *backing_inode, *inode =3D file_inode(file);
> +       struct inode *real_inode, *inode =3D file_inode(file);
>         struct integrity_iint_cache *iint =3D NULL;
>         struct ima_template_desc *template_desc =3D NULL;
>         char *pathbuf =3D NULL;
> @@ -285,14 +285,16 @@ static int process_measurement(struct file *file, c=
onst struct cred *cred,
>                 iint->measured_pcrs =3D 0;
>         }
>
> -       /* Detect and re-evaluate changes made to the backing file. */
> -       backing_inode =3D d_real_inode(file_dentry(file));
> -       if (backing_inode !=3D inode &&
> +       /*
> +        * Detect and re-evaluate changes made to the inode holding file =
data.
> +        */
> +       real_inode =3D d_real_inode(file_dentry(file));
> +       if (real_inode !=3D inode &&
>             (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> -               if (!IS_I_VERSION(backing_inode) ||
> -                   backing_inode->i_sb->s_dev !=3D iint->real_dev ||
> -                   backing_inode->i_ino !=3D iint->real_ino ||
> -                   !inode_eq_iversion(backing_inode, iint->version)) {
> +               if (!IS_I_VERSION(real_inode) ||
> +                   real_inode->i_sb->s_dev !=3D iint->real_dev ||
> +                   real_inode->i_ino !=3D iint->real_ino ||
> +                   !inode_eq_iversion(real_inode, iint->version)) {
>                         iint->flags &=3D ~IMA_DONE_MASK;
>                         iint->measured_pcrs =3D 0;
>                 }
> --
> 2.43.0
>

