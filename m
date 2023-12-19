Return-Path: <linux-kernel+bounces-5403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B1818A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C0E28E376
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5BC1C68D;
	Tue, 19 Dec 2023 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUpyot3a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A31BDF4;
	Tue, 19 Dec 2023 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4258b8632f4so42043681cf.2;
        Tue, 19 Dec 2023 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996918; x=1703601718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nir7D1z6Ri01c3KJKDkvEWuMnaSsoeNEUkYwm+l97o=;
        b=kUpyot3ao3xU5XDPGTnknquZzPZu58i4hBgA5YEVsmRQVSrGXKiOEQ2T3tUoz5lnwJ
         /DhOksoVy4Pq1nKZ+vwoYQ32X4g5Nj24tbCYmgrir+MEp7lQI1tsjAwpXol+zgUl5k5b
         TqZ8oulNQu3TylXk2eaQAnSMJt6FX4eC5YxJEbyyvy49v0OwlbancbruaoWwdbe29Lmy
         McXXgb8Yn80s9GEb0poeZYQD+fyGfx8WceGIq3cxA7Bt2bVPcAh5911cwLPwC9olZVzR
         p6IjqW6NmHgf4Z1eipHk5AqTMIa4q997+EwCfnUzdrPENWDY0Pq06c/SDE4z3QZQk7de
         urkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996918; x=1703601718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nir7D1z6Ri01c3KJKDkvEWuMnaSsoeNEUkYwm+l97o=;
        b=H2tdOVzDzs6YLBu7cNfFFwduSrIILHwt5pfvWNvUX0r2PlwbcfC/CF+ZpIm5bsHXY+
         DHxXwK4148zN4TjerYMKQmwerYGzLN2DSYjBb5ik5/PEFYuEwyDb2eyG1/7f3yXcV8KQ
         ctDsSlDAzDDhmZLBRqJNmr1zSvPcdptPS6q99HDSFflHTdvYEH/LYQii/2xscRvMPB57
         r0QMrwG6rzqJelT84AAjUkuHk8gisK4mnYyHJ3STPfpUAdIF9ybvrMui6hsYfYCuAoHq
         sNg4tb15pha8rR0b19Ub2mzGIMr2MbLaaYFamPVEueQBSVQsm+sIzo30fbhRearjifU5
         Q6NQ==
X-Gm-Message-State: AOJu0YxBve2WLvsNzM8hp2dwUDVHZmPIqMjxqmLGCuSAKmthgp2QaQu8
	vPX+TnvL249HY140+P3bMeWFP1INGCj/mpF3/x3R1bPDgKY=
X-Google-Smtp-Source: AGHT+IFUYu9dArT+DIVXCCdsVgHdijRYpDz5mOvgaB9mdHv3O2yNSPfrbjcMEEiEPqFSHjsK9f07cuAvV2oxVHfrk18=
X-Received: by 2002:a05:6214:4b94:b0:67a:8e94:2bb2 with SMTP id
 qf20-20020a0562144b9400b0067a8e942bb2mr21009192qvb.21.1702996918026; Tue, 19
 Dec 2023 06:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219134901.96300-1-zohar@linux.ibm.com> <20231219134901.96300-2-zohar@linux.ibm.com>
In-Reply-To: <20231219134901.96300-2-zohar@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Dec 2023 16:41:46 +0200
Message-ID: <CAOQ4uxi8yX_z2HAGhGeXNRgUJpvX8nuWHBgbVUBoJYJeAM5i4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] evm: don't copy up 'security.evm' xattr
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> The security.evm HMAC and the original file signatures contain
> filesystem specific data.  As a result, the HMAC and signature
> are not the same on the stacked and backing filesystems.
>
> Don't copy up 'security.evm'.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/evm.h               | 6 ++++++
>  security/integrity/evm/evm_main.c | 7 +++++++
>  security/security.c               | 4 ++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 01fc495a83e2..36ec884320d9 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -31,6 +31,7 @@ extern void evm_inode_post_setxattr(struct dentry *dent=
ry,
>                                     const char *xattr_name,
>                                     const void *xattr_value,
>                                     size_t xattr_value_len);
> +extern int evm_inode_copy_up_xattr(const char *name);
>  extern int evm_inode_removexattr(struct mnt_idmap *idmap,
>                                  struct dentry *dentry, const char *xattr=
_name);
>  extern void evm_inode_post_removexattr(struct dentry *dentry,
> @@ -117,6 +118,11 @@ static inline void evm_inode_post_setxattr(struct de=
ntry *dentry,
>         return;
>  }
>
> +static inline int  evm_inode_copy_up_xattr(const char *name)
> +{
> +       return 0;
> +}
> +
>  static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
>                                         struct dentry *dentry,
>                                         const char *xattr_name)
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 894570fe39bc..02adba635b02 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -863,6 +863,13 @@ void evm_inode_post_setattr(struct dentry *dentry, i=
nt ia_valid)
>                 evm_update_evmxattr(dentry, NULL, NULL, 0);
>  }
>
> +int evm_inode_copy_up_xattr(const char *name)
> +{
> +       if (strcmp(name, XATTR_NAME_EVM) =3D=3D 0)
> +               return 1; /* Discard */
> +       return -EOPNOTSUPP;
> +}
> +
>  /*
>   * evm_inode_init_security - initializes security.evm HMAC value
>   */
> diff --git a/security/security.c b/security/security.c
> index dcb3e7014f9b..a02e78c45007 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2539,6 +2539,10 @@ int security_inode_copy_up_xattr(const char *name)
>                         return rc;
>         }
>
> +       rc =3D evm_inode_copy_up_xattr(name);
> +       if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> +               return rc;
> +
>         return LSM_RET_DEFAULT(inode_copy_up_xattr);

The rest of the hooks call evm last, e.g.:
        return evm_inode_setattr(idmap, dentry, attr);
        return evm_inode_remove_acl(idmap, dentry, acl_name);
        evm_inode_post_setxattr(dentry, name, value, size);
        return evm_inode_removexattr(idmap, dentry, name);

best keep a consistent LSM order.

Other than that, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

