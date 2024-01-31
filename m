Return-Path: <linux-kernel+bounces-46541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C884411E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3BF287EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A280C0C;
	Wed, 31 Jan 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0PWlv0R"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F597BAFA;
	Wed, 31 Jan 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709402; cv=none; b=M/rlZ4yC5UrdF/QoHIVdafW+HQ6U/0Wsol1X++pTeIYnMXOx1mKaTCC31IlF17qwFQFhv7sRwVVuSY6tpByOyojE0QncgkPC6TsjiPp4pSaGhXcQr9xxA+8Ic/CRzFwY42w9ofwPFt3KPW9dhN1IxV7xFQY9vQqkWHuvK3NrnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709402; c=relaxed/simple;
	bh=w5siA9sGMBf7veAhjHbaJt4PyHM/ZANL2abhaYEQEVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TepOLaVn5R6+tt+PBHUFUts5ylebO9R6VX/zlAqgcgtZPWwOF8GGs+cnWo9DSSx3icDEcHDxSjzdLQRoXR7LkIjc8FYRscmDxqxcM9mplL0sWG9QsTUOsxjwi6FZCIVwpHeNhpqAVZwGr40Ranp2/tgHfcuXmxhKcXCHOq8OB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0PWlv0R; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6818a9fe3d4so35191426d6.0;
        Wed, 31 Jan 2024 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706709400; x=1707314200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX69lf1UBcmeU7AcsTpm4saig8TXToBAcBQEpKY5iZs=;
        b=l0PWlv0RNtCDN5TcM3W8vjigBXK7Ic9HljMaWKK11iPuVkechySvglxFgvmihPk0H2
         8/FURKjxW21GTVl4CzccGYrPfCVUVBbngRmoUIqLPC4jLlK/D1G7Fys0dy6TJS+dRt7t
         DGrYiyKDz6Pp5DiZ9q+LagiiIkWFppV6QHjZppPrscKK7eUqV7WIRx8+zD2xjIIGR0OJ
         10/N57Y3oZRyPhhTkyHkTVpxHitajybxKkSNoc45ZISrYhQ7rX6I1hycDYvc9sPRhR9U
         eNno9zDAPf6zkdS1dw0SqTCK84WDmLzrteEJ3rYX+QO+4vt+9OtAvY+51Rl4PdahvWGF
         xLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706709400; x=1707314200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX69lf1UBcmeU7AcsTpm4saig8TXToBAcBQEpKY5iZs=;
        b=wLO0L3KvgzcMmF4Kmfwlb1WiaZ+Pp+z3q7RTPI20PGUAuKd9BK1i9jiYs29y/My90s
         79StHl+9fESZ1iwNUHRkhmZTtMpoKwWDutwbAdj41hbzCl2/ABqXbtquOdwttIpi/OyP
         joDdOOYDZBAzvngQb+pCPealzDDSQzwMY3YKsD/W4E+GS4UZO6zZJ5FeXoYZEpn5fbJP
         aZISLUhieL1GzMerARSRf7m1HyxsPe81cD9hrkqJ7dSBDw+arRUwzD9XFb50Eeu2gvNq
         WMOliEOVgtalg4qMv+WNWcrkJT9BPU93ZZ2QcabXW2p3t4sVkjIdFoAI0Kw5kBPa5MH5
         YAnA==
X-Gm-Message-State: AOJu0YwKYQ3gFJDmL0iqrhrm+g+hzI+w+NypFq3AQzcxCwiyqs5PyBaO
	ILDBEz7eQGMUQMDGCj7SUWrmSvcR+UgwlBBDx1s+Um28WqNg3ECYVYOxjYEr9XG3hKHFoX1lrTc
	RKAmqzoiJtCzNGSTzrE7UdKwMHGU=
X-Google-Smtp-Source: AGHT+IHpUaL8efMK3QQWjl9InIeOROIpSFzCRENAnrd8HpKFGyCtceNv1gZ80ujkxT22g7FQqcAu2lYK+HDvYkScRc8=
X-Received: by 2002:ad4:5bcf:0:b0:68c:6b70:ff4a with SMTP id
 t15-20020ad45bcf000000b0068c6b70ff4amr1891251qvt.37.1706709399954; Wed, 31
 Jan 2024 05:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com> <20240130214620.3155380-4-stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-4-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 15:56:28 +0200
Message-ID: <CAOQ4uxjC=-GOFi3J4ctcNgdMfaerkae30OH9=TkKTWCf=TP95g@mail.gmail.com>
Subject: Re: [PATCH 3/5] ima: Reset EVM status upon detecting changes to
 overlay backing file
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
> To avoid caching effects to take effect reset the EVM status upon
> detecting changes to the overlay backing files. This prevents a not-yet-
> copied-up file on the overlay from executing if for example the
> security.evm xattr on the file on the 'lower' layer has been removed.
>

And what is expected to happen when file is executed after copy up?
Doesn't this change also protect the same threat after copy up?

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  include/linux/evm.h               | 8 ++++++++
>  security/integrity/evm/evm_main.c | 7 +++++++
>  security/integrity/ima/ima_main.c | 2 ++
>  3 files changed, 17 insertions(+)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index d8c0343436b8..e7d6742eee9d 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -66,6 +66,8 @@ extern int evm_protected_xattr_if_enabled(const char *r=
eq_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>                                      int buffer_size, char type,
>                                      bool canonical_fmt);
> +extern void evm_reset_cache_status(struct dentry *dentry,
> +                                  struct integrity_iint_cache *iint);
>  #ifdef CONFIG_FS_POSIX_ACL
>  extern int posix_xattr_acl(const char *xattrname);
>  #else
> @@ -189,5 +191,11 @@ static inline int evm_read_protected_xattrs(struct d=
entry *dentry, u8 *buffer,
>         return -EOPNOTSUPP;
>  }
>
> +static inline void evm_reset_cache_status(struct dentry *dentry,
> +                                         struct integrity_iint_cache *ii=
nt)
> +{
> +       return;
> +}
> +
>  #endif /* CONFIG_EVM */
>  #endif /* LINUX_EVM_H */
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 22a5e26860ea..e96d127b48a2 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -721,6 +721,13 @@ static void evm_reset_status(struct inode *inode)
>                 iint->evm_status =3D INTEGRITY_UNKNOWN;
>  }
>
> +void evm_reset_cache_status(struct dentry *dentry,
> +                           struct integrity_iint_cache *iint)
> +{
> +       if (d_real_inode(dentry) !=3D d_backing_inode(dentry))
> +               iint->evm_status =3D INTEGRITY_UNKNOWN;
> +}
> +
>  /**
>   * evm_revalidate_status - report whether EVM status re-validation is ne=
cessary
>   * @xattr_name: pointer to the affected extended attribute name
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cc1217ac2c6f..84bdc6e58329 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -26,6 +26,7 @@
>  #include <linux/ima.h>
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/evm.h>
>
>  #include "ima.h"
>
> @@ -295,6 +296,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>                     !inode_eq_iversion(backing_inode, iint->version)) {
>                         iint->flags &=3D ~IMA_DONE_MASK;
>                         iint->measured_pcrs =3D 0;
> +                       evm_reset_cache_status(file_dentry(file), iint);
>                 }
>         }

Make sense.
Unrelated to your change, I now noticed something odd about Mimi's change:

        backing_inode =3D d_real_inode(file_dentry(file));

I find the choice of variable name to be quite confusing, because ima/evm c=
ode
uses  d_backing_inode() all over the place and d_real_inode() !=3D
d_backing_inode().

First of all, there is never any reason to use d_backing_inode() and its na=
me is
quite confusing in the first place, but it will be a big cleanup to
remove them all.

Suggest to rename the variable to real_inode, same as in
ima_collect_measurement()
to be consistent and reduce confusion factor, which is already high enough =
;)

Thanks,
Amir.

