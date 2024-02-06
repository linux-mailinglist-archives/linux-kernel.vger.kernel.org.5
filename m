Return-Path: <linux-kernel+bounces-55209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF684B92A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8431C242C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C313A88D;
	Tue,  6 Feb 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXzMsPXz"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5313A883;
	Tue,  6 Feb 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232337; cv=none; b=aKVM9KIyR4yK50vqm8ctanmOs5z4wzEWyRxnvYADSvdtSwNwd2inK19OPk6D4uJ5x//3Kj3R942B9SmhsPPfxC/l94weRUMu/XQV8N3Eea3F8UFWXe8m1XrUbolTkEFN6usmo5ilRpVJpq5fL2ghk9i3W5gry6L+TlT/NBhvyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232337; c=relaxed/simple;
	bh=oYEWehvFMJ9pwDF4l/eISgFkLfERvZLJKloD31RHQww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhPh67M8lTgAKDWuLj3uCeeBUdgFzZszqB+cBiyxW3mgrHJnHBVSeZUEzhjWvv6oNsaWt2aYufCoj9W15DxtSgOQttX9Py2Xd5zD1CSIkmLE1wbgO6m4bx7ORWT/FqJ1pgOEq3HcivMAUOSM0pY6Tqkoi2PQm1m+qtmksM+osZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXzMsPXz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c7a26a5cbso5278636d6.1;
        Tue, 06 Feb 2024 07:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707232334; x=1707837134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMA6OtoS96Zf+GkoCGJn556i+luGg4v6HW8Cwy5kkeY=;
        b=HXzMsPXzD2XG3rufHjk0otiwLpelFQrGpLPlVjZA6Jgi0wB6U5Q3ONKaa1XMZca7rV
         FZGRpfNhDL6S6AYCuYnIfS+ZW6XGWFZATeELqWp08hWYeYn//1nwUYs3BEJjcCrHi/c8
         UqBt2Pu9R4onqhhDCTRvVZxfPiKCZSqoBSIqdkNVNVxS3f7sFhyHHskPh8fwKxZWJUGQ
         UwpnBt4gBP83BOAp64Z8EfEvfvIXJeHpysMGez4Tu6W/5CZI2niMDU3w7TkiVfvkad08
         p/DVxAi+ZnYJI8kxr96ago6WI78PBvVhRHLacan6k3NjMTL3PIpyrZRuzToTpnPTVhjT
         4o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232334; x=1707837134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMA6OtoS96Zf+GkoCGJn556i+luGg4v6HW8Cwy5kkeY=;
        b=AMDy3Q4btY1yOuF3EHkzON1bzjLR3UX4fr+frqPYM5n1KITZu5H3AAKV3Vv2HImC0B
         taK7rOCBqZ7r32uqaXQVto3ziJRxqP6VpHaDBOXJdnwKEWYDulyO/BHETBOd+1Yhxo3Y
         WtYvwukSdFvwnCp8THr3nIxum9Kd5uT8xJKRmc7icopTaw0ZgCvoIhul/3hFcGOQxODG
         6TTjYLFHRlvY7zqlc9vvkbXC092lj4Q/vEUduOgMG3rnNZjsG99JJi7LBWKjqO/7Btno
         v4l2UJ/vM0Sh3nGkbxq7CrqHrpFaybkJl7e6XBUqbfVvyy4TcSJldE1v8zaX8hJfG29W
         mJkg==
X-Gm-Message-State: AOJu0YyQF7MoF64G2hM+8lBMJbzk3FhhvByRgtob4oUj4xb/es9uaP+j
	Th8GpDoyoK4ex5TRMsbgyXB52clQCMPF8/Byzvo1V0AXrhv1EFjXcadn2j/6fe7/OFMDaJr/IGL
	V51rA9ea0BhPsBd9ALZbCRMxfyzs=
X-Google-Smtp-Source: AGHT+IFgX6Kscb6kSDKa8HOGT2SMWHo1VbDYPIkFmBOocSq5uIw/IqPcHyfBt8SQxsU8CBLdLkg5u+NoumkL0jm/3Xo=
X-Received: by 2002:ad4:5881:0:b0:68c:a2c9:9a7 with SMTP id
 dz1-20020ad45881000000b0068ca2c909a7mr10465946qvb.13.1707232334509; Tue, 06
 Feb 2024 07:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-3-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-3-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:12:03 +0200
Message-ID: <CAOQ4uxhTVaHpo6NgoA6q3bBH+-JSY3in1bEzYMviBHO7N15Kow@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] security: allow finer granularity in permitting
 copy-up of security xattrs
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
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

For ovl part

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/copy_up.c            | 2 +-
>  include/linux/evm.h               | 5 +++--
>  include/linux/lsm_hook_defs.h     | 3 ++-
>  include/linux/security.h          | 4 ++--
>  security/integrity/evm/evm_main.c | 2 +-
>  security/security.c               | 7 ++++---
>  security/selinux/hooks.c          | 2 +-
>  security/smack/smack_lsm.c        | 2 +-
>  8 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 8586e2f5d243..de20fe9333c0 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const stru=
ct path *oldpath, struct de
>                 if (ovl_is_private_xattr(sb, name))
>                         continue;
>
> -               error =3D security_inode_copy_up_xattr(name);
> +               error =3D security_inode_copy_up_xattr(old, name);
>                 if (error < 0 && error !=3D -EOPNOTSUPP)
>                         break;
>                 if (error =3D=3D 1) {
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 36ec884320d9..840ffbdc2860 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -31,7 +31,7 @@ extern void evm_inode_post_setxattr(struct dentry *dent=
ry,
>                                     const char *xattr_name,
>                                     const void *xattr_value,
>                                     size_t xattr_value_len);
> -extern int evm_inode_copy_up_xattr(const char *name);
> +extern int evm_inode_copy_up_xattr(struct dentry *dentry, const char *na=
me);
>  extern int evm_inode_removexattr(struct mnt_idmap *idmap,
>                                  struct dentry *dentry, const char *xattr=
_name);
>  extern void evm_inode_post_removexattr(struct dentry *dentry,
> @@ -118,7 +118,8 @@ static inline void evm_inode_post_setxattr(struct den=
try *dentry,
>         return;
>  }
>
> -static inline int  evm_inode_copy_up_xattr(const char *name)
> +static inline int evm_inode_copy_up_xattr(struct dentry *dentry,
> +                                         const char *name)
>  {
>         return 0;
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 185924c56378..7dd61f51d84a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -163,7 +163,8 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *in=
ode, char *buffer,
>          size_t buffer_size)
>  LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *s=
ecid)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
> -LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
> +        const char *name)
>  LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>          struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..9fc9ca6284d6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -387,7 +387,7 @@ int security_inode_setsecurity(struct inode *inode, c=
onst char *name, const void
>  int security_inode_listsecurity(struct inode *inode, char *buffer, size_=
t buffer_size);
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
> -int security_inode_copy_up_xattr(const char *name);
> +int security_inode_copy_up_xattr(struct dentry *src, const char *name);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
>                                   struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
> @@ -980,7 +980,7 @@ static inline int security_kernfs_init_security(struc=
t kernfs_node *kn_dir,
>         return 0;
>  }
>
> -static inline int security_inode_copy_up_xattr(const char *name)
> +static inline int security_inode_copy_up_xattr(struct dentry *src, const=
 char *name)
>  {
>         return -EOPNOTSUPP;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index cc7956d7878b..2555aa4501ae 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -896,7 +896,7 @@ void evm_inode_post_setattr(struct dentry *dentry, in=
t ia_valid)
>                 evm_update_evmxattr(dentry, NULL, NULL, 0);
>  }
>
> -int evm_inode_copy_up_xattr(const char *name)
> +int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
>  {
>         if (strcmp(name, XATTR_NAME_EVM) =3D=3D 0)
>                 return 1; /* Discard */
> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..ee63863c1dc0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2596,6 +2596,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>
>  /**
>   * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-u=
p op
> + * @src: union dentry of copy-up file
>   * @name: xattr name
>   *
>   * Filter the xattrs being copied up when a unioned file is copied up fr=
om a
> @@ -2606,7 +2607,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>   *         if the security module does not know about attribute, or a ne=
gative
>   *         error code to abort the copy up.
>   */
> -int security_inode_copy_up_xattr(const char *name)
> +int security_inode_copy_up_xattr(struct dentry *src, const char *name)
>  {
>         struct security_hook_list *hp;
>         int rc;
> @@ -2618,12 +2619,12 @@ int security_inode_copy_up_xattr(const char *name=
)
>          */
>         hlist_for_each_entry(hp,
>                              &security_hook_heads.inode_copy_up_xattr, li=
st) {
> -               rc =3D hp->hook.inode_copy_up_xattr(name);
> +               rc =3D hp->hook.inode_copy_up_xattr(src, name);
>                 if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
>                         return rc;
>         }
>
> -       return evm_inode_copy_up_xattr(name);
> +       return evm_inode_copy_up_xattr(src, name);
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a6bf90ace84c..ebb8876837c6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3530,7 +3530,7 @@ static int selinux_inode_copy_up(struct dentry *src=
, struct cred **new)
>         return 0;
>  }
>
> -static int selinux_inode_copy_up_xattr(const char *name)
> +static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char=
 *name)
>  {
>         /* The copy_up hook above sets the initial context on an inode, b=
ut we
>          * don't then want to overwrite it by blindly copying all the low=
er
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0fdbf04cc258..bffca165f07f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4873,7 +4873,7 @@ static int smack_inode_copy_up(struct dentry *dentr=
y, struct cred **new)
>         return 0;
>  }
>
> -static int smack_inode_copy_up_xattr(const char *name)
> +static int smack_inode_copy_up_xattr(struct dentry *src, const char *nam=
e)
>  {
>         /*
>          * Return 1 if this is the smack access Smack attribute.
> --
> 2.43.0
>

