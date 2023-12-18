Return-Path: <linux-kernel+bounces-3772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3629C8170C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A075FB21696
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5351D127;
	Mon, 18 Dec 2023 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itDeCEwX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145A129EF7;
	Mon, 18 Dec 2023 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd86e3a9afso1056696a12.1;
        Mon, 18 Dec 2023 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702907230; x=1703512030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4k4Fh/TASWn1uJrItxeFdHWOjIQFIOHIcCI80h3IYQ=;
        b=itDeCEwXhrSLykXNxA9lV5oC4zcQV1hHC28ibq9gUITlXIFkeI8Y523mo2HGlGPxRf
         XsBlbNMhwOZxaA47RD7a9UJ/srIowUzKEm6lIzXyOAoudD2p7TJhDZXzlpBqRdlYB7P1
         1jGNxLnJnXTWx6Xlp0QzjZHzMFkE+L/N1VrhpEPL+7GCQtLR6n71Md1Qnhcrn+nlbUCQ
         zc3HPRNzty/Rs5LTznQb3eofz2RAqqURESogAUcj3AL18dttGa7n/TMEjgFg+FUOVTGf
         AflqSAav7JT6jG81H/SZdKfgZRxzZnzvHzd5oe7P50a86gWoEwvfB+hZZSTbTwS8uXba
         LQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907230; x=1703512030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4k4Fh/TASWn1uJrItxeFdHWOjIQFIOHIcCI80h3IYQ=;
        b=LZz1YaR2keoMwHZPT5Ozlg77hG4rX+J5Bzd1knDHQ2j3FH81B6G5Tk+nEXjpJioDWz
         k01gkPYGSjsP32mUzXYFz1kzvVLPJPgph+i9KDa+EeuddmDk+J2AIZrQ6SzDW1kjrPiw
         UkqzAAIzOZ/hz/Rt9kVsia9LXlSVo76s8ehWQD2ksOyUFhA4/hsjwvk/G4fcFxRuI+Rz
         lx/4OTjl8Cdnjd2FDlGA8M4zMEcz5/Vn7T5kkSzUNm4GJsvrtBNvGuvwTaTIm0bze/ra
         B7vyE2OW4Cs58K71Nhy0v01kbUX1/zpYZUmirdQ6srbfmy/MviSpZOGMnjxcFnrDsHtQ
         5y+w==
X-Gm-Message-State: AOJu0YzLVdHO8m2q5Jz0hJU8UHrHudqB8xCJLH8yjZUyywvdlyFwEH+2
	Ag1tmHtHAdZmNya3bFTNX/ObqIPa3LhC62suHqg=
X-Google-Smtp-Source: AGHT+IGhl9l0lQahMBCLz8nW0EUJgHXkqNUVfWTa3Qroj7zWtlnZkSw49etJjZvFD67/3Xd38zGFkm/VAJIi1eYBap4=
X-Received: by 2002:a05:6a20:65b0:b0:190:6d:1c5a with SMTP id
 p48-20020a056a2065b000b00190006d1c5amr15311555pzh.56.1702907229671; Mon, 18
 Dec 2023 05:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231218124137.2476015-1-alpic@google.com>
In-Reply-To: <20231218124137.2476015-1-alpic@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 08:46:58 -0500
Message-ID: <CAEjxPJ6G7gHi=kLmgT3m1kDQeTpT1xLexDXbZRBMjJdiWrx=mw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:43=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emmits

s/emmits/emits/

> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that
> replaces security_file_ioctl if the CONFIG_COMPAT flag is on. All
> current LSMs have been changed to hook into the compat flag.

It doesn't (or shouldn't) replace security_file_ioctl, and the hook
doesn't appear to be conditional on CONFIG_COMPAT per se.
It is a new hook that is called from the compat ioctl syscall. The old
hook continues to be used from the regular ioctl syscall and
elsewhere.

> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 83ef66644c21..170687b5985b 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -751,7 +751,11 @@ static int ovl_security_fileattr(const struct path *=
realpath, struct fileattr *f
>         else
>                 cmd =3D fa->fsx_valid ? FS_IOC_FSGETXATTR : FS_IOC_GETFLA=
GS;
>
> +#ifdef CONFIG_COMPAT
> +       err =3D security_file_ioctl_compat(file, cmd, 0);
> +# else
>         err =3D security_file_ioctl(file, cmd, 0);
> +#endif

I don't understand why you made this change, possibly a leftover of an
earlier version of the patch that tried to replace
security_file_ioctl() everywhere?

