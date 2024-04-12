Return-Path: <linux-kernel+bounces-143174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD98A3560
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24350283CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21C14E2F9;
	Fri, 12 Apr 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3gzv0LR"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A44146D7B;
	Fri, 12 Apr 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945310; cv=none; b=tlq08zSQ++VfPHKCZjVx7yICcUSpPd/B/8io8Y+CLPBlhXFXnP69w6h84jp88r4/XEcKbSUYZEOV/zoGyoUwwy4NLpYyzX7GEa04XczRsb0cbJB/wRhUTc8FU7d3BAzXMb8fSe7SUdZkZFICPTbevGFV4+zMkqNO64BplbIfQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945310; c=relaxed/simple;
	bh=JwinJ+56F00Bok4ZHv00HXiS+MRsoU58UtvT6ntsQtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qab8XElBQMQY4RC78+mDa5r9Z77iLBDx0cs+1fR20Xf1U89YlJC+ouDx+XqfmTgnGpOPXWdZ7YEwu0ePQ385KHCdwrbC/H5L2b1GcpRA36maL0E92WCyorx6fr/6FaWRhvSLda9SOC7jykOBzCkpSAqK+nYJ1/avcHCP+DOIu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3gzv0LR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6962950c6bfso8531226d6.2;
        Fri, 12 Apr 2024 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945308; x=1713550108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71AS/RhfzT4OFCuMU4sTRrRC1MxAEiMomV0IFU3BZGo=;
        b=c3gzv0LRhzNE+eYgjMOG7CgJiFzNzz6hBZW2oXHVgX3qPeBrvQChYVvVJVvnBAzszY
         hwdq92RTCuVljEqZ0h8VQ1PtprRBrXzo2gPxDMu5kAoTVAqa6t62qu9acRQY1yLHxnzf
         k2huImpzXSQ5UfGmgozij5e0GSydYUCiPxbQJl5T1JdgGhvDiQTqXSvdqeQlSWf/PmY5
         5F4hWaiAJaSrmw8sLenPbuX+P1hxpjmV2vS/4Z9kJsQY/G2I6vkaCRVDzp7++6pSQCn+
         3H6BIcPRpDvzo4lEZW16A/Xv32Uqhg8UmJiEE6eUTedEmaJgx2rP6TiiTJpuhmP81+1a
         sZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945308; x=1713550108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71AS/RhfzT4OFCuMU4sTRrRC1MxAEiMomV0IFU3BZGo=;
        b=AetEHaU1dzWw9mEe5d6L+sxxIRuXeGZSEoiYakBAeGOmPNXmKXz5dxQyg52SQtKFFU
         5/jRXQSDn2gPSBtR0+M1YzlMrkSShXNYFr9pvsothFKGRP1McuNAVeN0Gd9EWXSftvFM
         6HEXEFRfT1Mkjs2kbRPPm5wi8Rhmf0VOXcYytg2foG+FUoSaiKge4sNRVv9H8j5FnkFB
         aL1T+sLF5Vqdfd7CGpkEf1JVgSc6nVZ/cXncdLGFA3WiU8uhnZB77dmvfpn+pF2gEYkQ
         81gPOq2QjRf7PNIaYFX5KlZykqF81+1D+NeHlMy8NcVcvCnwc9qIoxzXeqmL2AjYCM51
         4rig==
X-Forwarded-Encrypted: i=1; AJvYcCWQtTi8N0k1lHh1kutLX+q122/0Nk3JfHHcki8AJvX3KBXYlb7fHA7i+dMPEC0Fmx6E5y8MLy8vZvfABkGmXtkYrWZ5O1pDJ6sUbzjY6tAFzpYvpyKuNXrHmUcwB/XCN7vUjNTqAt3yX5B0Ow==
X-Gm-Message-State: AOJu0YyYeYApTWvy1nXOUTxfxNHm0q1JTcAd4dgJM7R92K0dxUUkgOua
	8IKJ1kHH+wQXPMGmC5j2utJg0gAS1UtEjke1EniQFxAJXpVbYcfA/aVdSKbga1FWvnmJky3sTOY
	6Ty//RoFGd8bHhbAcetVX8voisMQ=
X-Google-Smtp-Source: AGHT+IE9sp7tQGutL/L0NwqyKVJwHH6p0DBjE9dwP/6Yr5O13kFbA9n12+A81R1yyHxR6EMJZbGT9hCw7SkfJsUIgMk=
X-Received: by 2002:a05:6214:d82:b0:699:17cc:3e69 with SMTP id
 e2-20020a0562140d8200b0069917cc3e69mr5120956qve.61.1712945308196; Fri, 12 Apr
 2024 11:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com> <20240412140122.2607743-3-stefanb@linux.ibm.com>
In-Reply-To: <20240412140122.2607743-3-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 21:08:17 +0300
Message-ID: <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	miklos@szeredi.hu, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:01=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> On a stacked filesystem, when one process opens the file holding a file's
> data (e.g., on upper or lower layer on overlayfs) then issue a violation
> when another process opens the file for reading on the top layer (overlay
> layer on overlayfs). This then provides similar behavior to the existing
> case where a violation is generated when one process opens a file for
> writing and another one opens the same file for reading. On stacked
> filesystem also search all the lower layers for relevant files opened for
> writing and issue the violation if one is found.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima_main.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index f04f43af651c..590dd9d5d99a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -121,8 +121,11 @@ static void ima_rdwr_violation_check(struct file *fi=
le,
>                                      const char **pathname,
>                                      char *filename)
>  {
> +       struct inode *real_inode =3D d_real_inode(file_dentry(file));
>         struct inode *inode =3D file_inode(file);
> +       struct dentry *fd_dentry, *d;
>         fmode_t mode =3D file->f_mode;
> +       struct inode *fd_inode;
>         bool send_tomtou =3D false, send_writers =3D false;
>
>         if (mode & FMODE_WRITE) {
> @@ -134,11 +137,25 @@ static void ima_rdwr_violation_check(struct file *f=
ile,
>                                                 &iint->atomic_flags))
>                                 send_tomtou =3D true;
>                 }
> -       } else {
> -               if (must_measure)
> -                       set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> -               if (inode_is_open_for_write(inode) && must_measure)
> -                       send_writers =3D true;
> +       } else if (must_measure) {
> +               set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> +
> +               if (inode =3D=3D real_inode) {
> +                       if (inode_is_open_for_write(inode))
> +                               send_writers =3D true;
> +               } else {
> +                       d =3D d_real(file_dentry(file), D_REAL_FILEDATA);
> +                       do {
> +                               fd_dentry =3D d;
> +                               fd_inode =3D d_inode(fd_dentry);
> +                               if (inode_is_open_for_write(fd_inode)) {
> +                                       send_writers =3D true;
> +                                       break;
> +                               }
> +                               /* next layer of stacked fs */
> +                               d =3D d_real(fd_dentry, D_REAL_FILEDATA);
> +                       } while (d !=3D fd_dentry);
> +               }

The idea of digging though ovl layers feels wrong to me.
As Miklos is the designer of overlayfs and its vfs architecture,
I am deferring the call about adding this interface to Miklos.

Thanks,
Amir.

