Return-Path: <linux-kernel+bounces-3774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EA8170D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A618F1F225DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5061D12A;
	Mon, 18 Dec 2023 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbvjY0qD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDE129EF3;
	Mon, 18 Dec 2023 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so1506823b3a.1;
        Mon, 18 Dec 2023 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702907422; x=1703512222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9YQ00TgO4RAAdXW8hCyL+ZlYnPQMKfWy8FBIciPw58=;
        b=nbvjY0qDJGtqwwrh7DjmLfJNP3abQi+yMyd+nx8Hm07Y9RsWev/IB/huKsvM4bmZG3
         xDZSNOH/4rVEk9VDifmVS0BKvmCOq4TI1zB10GNa3Gl9kSPLKJnCbpRNFXZEmL0i/+w/
         GFWy65cNLeE0GyK3mUBl22IeIOovdOXYc4+VU09kO6TvmeNr4HolLtabwnqgzB5uwc/G
         GPdo5P62Z23IrwwRlV0kuAtNgHgS7+k17u+uQgNDt5rM9zF8zuaQ4QqZMXckTP9CiQG2
         FT15jhySaoM4Fvm7uo/tB9gCTKNzhqCtOtAdB/HJpH/4kieq1RxcF8Wm72uROp5666Ht
         471A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907422; x=1703512222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9YQ00TgO4RAAdXW8hCyL+ZlYnPQMKfWy8FBIciPw58=;
        b=wwo3SbHSbxK3dpY3rMsTrSB8mTspS7cDFVZNA/syz0c8YNTnQfsbDMWB5EtOZFjUTS
         Hxp+GVAblAzErWrFY343MOC2Jvmvszmt97oDmhOoWrdpGWp2mm3kyr2Zhvr82MaWmfVJ
         cKVB65fc4kgIThiaFoFjnyM4vAahdXSTyFuce1ywV6q5TaTqKcaTsAK+XMRburzWxq0I
         lTq4WEPR0U5koy9KcvhIt3LcSbt2zdPN9yf/KT/EXMYq2rNbKi5DLgHLMlRgSRa1Dnl8
         hTh4ZmnB2SqnP0EWSn+yUitat4XaT3VzDFhWb4EhOIIxVlndlGfvO+Mbkqaz1TgrYD8y
         bBxg==
X-Gm-Message-State: AOJu0YwATFDjGk/HaNE89B9+fjxPEwrXiWpPftvuoTlUb2H0giJlMMY3
	Gb2qv1mjRqUd0qmQqXRLbwK//cz2xqooFK8RjbY=
X-Google-Smtp-Source: AGHT+IHYpzP/ipl9BdmPJBcfE+uq5FYLLAZ2SyHmmT7wlXmmlEsrpsj/vcRvITT7zJ5nZbGEpq/B1kHxkxDL0Vdwe9Y=
X-Received: by 2002:a05:6a20:1604:b0:194:72d8:6c6f with SMTP id
 l4-20020a056a20160400b0019472d86c6fmr569510pzj.98.1702907421865; Mon, 18 Dec
 2023 05:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231218124137.2476015-1-alpic@google.com>
 <CAEjxPJ6G7gHi=kLmgT3m1kDQeTpT1xLexDXbZRBMjJdiWrx=mw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6G7gHi=kLmgT3m1kDQeTpT1xLexDXbZRBMjJdiWrx=mw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 08:50:10 -0500
Message-ID: <CAEjxPJ5mpMbTpnP1tbrFs9o2F0ymtaRbBPMMT4xogRmKbtZ2AA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
To: Alfred Piccioni <alpic@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>, stable@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 8:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Dec 18, 2023 at 7:43=E2=80=AFAM Alfred Piccioni <alpic@google.com=
> wrote:
> >
> > Some ioctl commands do not require ioctl permission, but are routed to
> > other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> > done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
> >
> > However, if a 32-bit process is running on a 64-bit kernel, it emmits
>
> s/emmits/emits/
>
> > 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> > being checked erroneously, which leads to these ioctl operations being
> > routed to the ioctl permission, rather than the correct file
> > permissions.
> >
> > This was also noted in a RED-PEN finding from a while back -
> > "/* RED-PEN how should LSM module know it's handling 32bit? */".
> >
> > This patch introduces a new hook, security_file_ioctl_compat, that
> > replaces security_file_ioctl if the CONFIG_COMPAT flag is on. All
> > current LSMs have been changed to hook into the compat flag.
>
> It doesn't (or shouldn't) replace security_file_ioctl, and the hook
> doesn't appear to be conditional on CONFIG_COMPAT per se.
> It is a new hook that is called from the compat ioctl syscall. The old
> hook continues to be used from the regular ioctl syscall and
> elsewhere.
>
> > Reviewing the three places where we are currently using
> > security_file_ioctl, it appears that only SELinux needs a dedicated
> > compat change; TOMOYO and SMACK appear to be functional without any
> > change.
> >
> > Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> > Signed-off-by: Alfred Piccioni <alpic@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index 83ef66644c21..170687b5985b 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -751,7 +751,11 @@ static int ovl_security_fileattr(const struct path=
 *realpath, struct fileattr *f
> >         else
> >                 cmd =3D fa->fsx_valid ? FS_IOC_FSGETXATTR : FS_IOC_GETF=
LAGS;
> >
> > +#ifdef CONFIG_COMPAT
> > +       err =3D security_file_ioctl_compat(file, cmd, 0);
> > +# else
> >         err =3D security_file_ioctl(file, cmd, 0);
> > +#endif
>
> I don't understand why you made this change, possibly a leftover of an
> earlier version of the patch that tried to replace
> security_file_ioctl() everywhere?

By the way, for extra credit, you could augment the ioctl tests in the
selinux-testsuite to also exercise this new hook and confirm that it
works correctly. See
https://github.com/SELinuxProject/selinux-testsuite particularly
tests/ioctl and policy/test_ioctl.te. Feel free to ask for help on
that.

