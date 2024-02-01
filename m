Return-Path: <linux-kernel+bounces-48302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1678459E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E740287408
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204165F48B;
	Thu,  1 Feb 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcznWrr/"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C48665E;
	Thu,  1 Feb 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797126; cv=none; b=cOoHRex2gb6CNY3aMxYtwwpMdI6fCtMHyLLzWUE+ob565AYy0GuItwVfFhjBWIR7tKnuQqBO5rDO8N+NR9nH1Gn/Us74oJQWDOsxdwFqHKgqqpKcJ464+lC24bSlVq9Kh+Vr5k1UzikGEM/NjMFfmkoWmglofyvdGi4UUn1IDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797126; c=relaxed/simple;
	bh=CwySW7XET/AnUFJ154ZcOrACzdF3MwDFaGctz7AiiVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2RC4X92AsE0Bi8awdIOjEzfpqP3yQVff9gA6wZKmbZxzxcHQ5XmDjezGSiHHDFdha41KSBZmYHGm+eQomFRoXafqLSpm/ue32HZOVuSMhGYa5aaZwGfb+niacdPzP1rxgqaKmdoKUgKy6d5o8C60Zo/nF6ZQ8ATFjyJ/Lqt1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcznWrr/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aa241b91aso8017641cf.1;
        Thu, 01 Feb 2024 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706797124; x=1707401924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CibH9NsUUmfyfumQzMWLxe29z8lLHioKeun4/4R69c0=;
        b=IcznWrr/jqED9cECjc8UqLY4pcuq9wZVV1zyPy46R6gwjcUn1dCKVwTwNO9X6eyW4Z
         8m5LSaykeWbXBSkAhw/6GdO4MBXWdAbubAXIA5W+PG03sxfadtYL5skH+avKs2oQCRhP
         p+fyhxDAbeRVKuX6rcPYBUUTGpM8FYEW9bskF0iVvm3FVbXO88z5aspXLzZzc1z8oLfl
         pNyDmmpLzFq4s3IolEQxMPoXh+BNn+TaOr3MXYBpr4pHW3F938e9zlTIv1+iSPq0y0Xw
         h4ie4AyRj4U1iOs0m+t7t/I/jl4pRl1XmcG5QT1h7yWBlBuUCxKHwY8cASwK13Ktz61f
         B+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797124; x=1707401924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CibH9NsUUmfyfumQzMWLxe29z8lLHioKeun4/4R69c0=;
        b=Yx+Y+hte9Yy9UTqaHBKGPkzA+4b4lc+UIMKfksnYD+gwUPZsZIGOM6MVPAx3GFG0qs
         NzevwrJ7pBBoHL3wrMUnkisJOuWjPIQs6gU2LuVBqdD//yz4WSdortS8wYtX8c405ehI
         JBnsJ9nyzSFF+wu29UBWsV4H5d1AcqWtz+VPMvWbxJ9Wqao3dZFQ+B8uwQRC8w8gieFi
         ypO6Ryn97uSQfgvAlIcQC0ky1h4LS9tFCz/E8d9bQcnCpWwzsaUgxPIjtePoTkDPR5Wy
         0QBVvaFOQtnii8V3OfyWkofc7CcNfU5rvZrtMoGS0l9lC8qwz1hiPYgXb3e1Ye1mncS9
         Yggg==
X-Gm-Message-State: AOJu0Yx14kWbeX8zGApfkUyKD9Z9vRuaxwBM6uCPABXMkIXBA0cvHM4y
	2Lz8zEvDY3pVmppJqQc7RuEWw54cCqHNDPZR8d1gMahpgUD3+MVDdKaR9HW0Tyj3wavjreX2h3P
	mo0QNLeceYI0QI3sP9u/Dus93PS4=
X-Google-Smtp-Source: AGHT+IEuKIKRoRWAtz1Fzrb8vDg5FaE8tl591BEPTDBu2YRq/PE8z6sCg6mm7AmQH+8fXhFqgJeBXzyt/jepix/20h0=
X-Received: by 2002:a05:6214:f63:b0:68c:7f6f:2d9 with SMTP id
 iy3-20020a0562140f6300b0068c7f6f02d9mr1738565qvb.6.1706797123897; Thu, 01 Feb
 2024 06:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com> <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
 <20240131-lacht-elend-536d94682370@brauner> <05fe58a1-9b2c-4c1f-80a6-4cb5094a2126@linux.ibm.com>
 <20240201-zierpflanzen-allgegenwart-5eb1fa243a61@brauner>
In-Reply-To: <20240201-zierpflanzen-allgegenwart-5eb1fa243a61@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 16:18:32 +0200
Message-ID: <CAOQ4uxgfkdX+3VR9sA7SeB7f3BW89iAwF2-JRCcJNsurtune_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
To: Christian Brauner <brauner@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:35=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Jan 31, 2024 at 09:56:25AM -0500, Stefan Berger wrote:
> >
> >
> > On 1/31/24 09:25, Christian Brauner wrote:
> > > On Wed, Jan 31, 2024 at 03:25:29PM +0200, Amir Goldstein wrote:
> > > > On Tue, Jan 30, 2024 at 11:46=E2=80=AFPM Stefan Berger <stefanb@lin=
ux.ibm.com> wrote:
> > > > >
> > > > > Copying up xattrs is solely based on the security xattr name. For=
 finer
> > > > > granularity add a dentry parameter to the security_inode_copy_up_=
xattr
> > > > > hook definition, allowing decisions to be based on the xattr cont=
ent as
> > > > > well.
> > > > >
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > ---
> > > > >   fs/overlayfs/copy_up.c            | 2 +-
> > > > >   include/linux/evm.h               | 2 +-
> > > > >   include/linux/lsm_hook_defs.h     | 3 ++-
> > > > >   include/linux/security.h          | 4 ++--
> > > > >   security/integrity/evm/evm_main.c | 2 +-
> > > > >   security/security.c               | 7 ++++---
> > > > >   security/selinux/hooks.c          | 2 +-
> > > > >   security/smack/smack_lsm.c        | 2 +-
> > > > >   8 files changed, 13 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > > > index b8e25ca51016..bd9ddcefb7a7 100644
> > > > > --- a/fs/overlayfs/copy_up.c
> > > > > +++ b/fs/overlayfs/copy_up.c
> > > > > @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, co=
nst struct path *oldpath, struct de
> > > > >                  if (ovl_is_private_xattr(sb, name))
> > > > >                          continue;
> > > > >
> > > > > -               error =3D security_inode_copy_up_xattr(name);
> > > > > +               error =3D security_inode_copy_up_xattr(old, name)=
;
> > > >
> > > > What do you think about:
> > > >
> > > >                       error =3D security_inode_copy_up_xattr(name, =
NULL, 0);
> > > >
> > > > and then later...
> > > >
> > > >                       error =3D security_inode_copy_up_xattr(name, =
value, size);
> > > >
> > > > I am asking because overlayfs uses mnt_idmap(path->mnt) and you
> > > > have used nop_mnt_idmap inside evm hook.
> > > > this does not look right to me?
> > >
> > > So it's relevant if they interact with xattrs that care about the
> > > idmapping and that's POSIX ACLs and fscaps. And only if they perform
> > > permission checks such as posix_acl_update_mode() or something. IOW, =
it
> > > depends on what exactly EVM is doing.
> >
> > In 2/5 we are reading the value of security.evm to look at its contents=
.
>
> I'm not sure what this is supposed to be telling me in relation to the
> original question though. :) security.evm doesn't store any {g,u}id
> information afaict. IOW, it shouldn't matter?

But it does. in evm_calc_hmac_or_hash() =3D> hmac_add_misc():

        hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
        hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);

I guess as far as EVM is concerned, it should always be interested in the
absolute uig/gid values of the inode.

Thanks,
Amir.

