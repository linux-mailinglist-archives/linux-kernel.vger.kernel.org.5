Return-Path: <linux-kernel+bounces-40187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E983DBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813F6B21B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11A1C697;
	Fri, 26 Jan 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmoiS7im"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B61C683;
	Fri, 26 Jan 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279674; cv=none; b=FOH3YORLcQEgjD01LsOsNxPEKZygrHlcm3yE+XLqZ0Jt3vwQ3Y5Oy283yNtYeW5/C0JiV4dc62Gb8Pu9DnJEZFRB2STQVUZQYk26FoTIQiS69QhgAgcZTXsbeePje9JXC0BT8WD2ZDNb0iVHnKhoHVMr/e6aSqSx/xvBKDOkZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279674; c=relaxed/simple;
	bh=VlHEm8CiSi592wojj3UsutYwrubNjD27MWN2kaDZJdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFjgmSz1x1I9+gPGi1u15c0MLSDQXdL47PvUIj+Jz0FnYMUYnK2ExtRXilZVnsloaVpTQanToHAnuoBCC5OzlhCYtwc3fovxeKvRNNeoJ/gULeWBXjZGCbH2njTinfPqOT5Bh3XNu4Ue10TSfmhYG4zAka4N7qrSjJtD3/6BZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmoiS7im; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6de424cef01so229260a34.2;
        Fri, 26 Jan 2024 06:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706279672; x=1706884472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emTp1NUA7NOW6whRrPCnnRtv6Gl2tOXIM2ZOxRmunDs=;
        b=NmoiS7imJiUtRUi5c4YdV5gWnq1RBF+J7v5gncs243EgcIHrX8hFnoMSuHdL5+dokC
         zJZKNvFZYVW1XzPVAK/dyAxlrPDYPgQ5HYZqEByrLUOBV7st2W3Ioq+nV/ByUKj0qEOl
         cTrFbQD7EhmOIqEf9V+l1dDON53/XRhfVPm7V8vxi+/pHSrcXD9OEd5rP3uWZhPOVSqz
         Wk2OecxIzmtxDxIy7CD8jt0tSpXKVVgvdWsNxRXpRXToRAHPHaJSIghvGwSpKVjzrElZ
         ri2f5Wcwl7mf1EogrNqgjLO7jutY+vr5ujtc4Dy9227RjsJtRs0cvSeYqPZYZLXXvuzs
         01mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279672; x=1706884472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emTp1NUA7NOW6whRrPCnnRtv6Gl2tOXIM2ZOxRmunDs=;
        b=LERoHmJw2yHEtw2179d4ATivuyVBUJjvdvcoGA35f5HRtbuKeYgLjl3/KLrYzjhu+A
         pqmNs+umsrCrzzUqWEC6cgVQuRfNrQhUZs7SDp8zsmelicRXc+5gul1abvd4lpk1REey
         /xFp9U+GXyoG3XKq1wTHZ9SXrYbBKkTFHd48BbUzr0SnwvPT2AG0hgg/3OJIfpiesCVE
         a38/znwdCIfzSQdEIRoPQXGLl3F96pu16in6KoCYCuFNJNUEP1Tc04LYza2MUoSDJOJW
         Yi2nYDem2NoMJY5P+Mm2lcMS6Ql8AjTyl/IHsCS2IQ+gBz2vakLh4T4gTNq/UAL97RbM
         z1FQ==
X-Gm-Message-State: AOJu0YxvYtQMrpF/TQP6uBvw3wRd2ng7XljyM3pMNYFiSRs6y9RD7qbZ
	nkbjBE/B+WsjkwkWm17kd0CRq7eF0C7nlicPtJZxjl2FOyrgOIiH/fwZeoS4lMxUhV+yaDXwIeY
	Wi2oNVi+qTwORWSt3L0oa9hj7z4s=
X-Google-Smtp-Source: AGHT+IGIJkLlZ+UTplYO6j9R8JlnlWzWhYP6rN8VJcdVk46vCMIHJg3EEg4FExa5Jc1uBoaE0JhsxxNQUoUWczOIZNo=
X-Received: by 2002:a05:6830:33fc:b0:6e1:3a1:3358 with SMTP id
 i28-20020a05683033fc00b006e103a13358mr1343858otu.52.1706279671719; Fri, 26
 Jan 2024 06:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125235723.39507-1-vinicius.gomes@intel.com> <20240125235723.39507-3-vinicius.gomes@intel.com>
In-Reply-To: <20240125235723.39507-3-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 16:34:20 +0200
Message-ID: <CAOQ4uxgZG487EMwDsxH-KkMeDExGPEFQP3zQVKk8BaKkWuZwDQ@mail.gmail.com>
Subject: Re: [RFC v2 2/4] cred: Add a light version of override/revert_creds()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Add a light version of override/revert_creds(), this should only be
> used when the credentials in question will outlive the critical
> section and the critical section doesn't change the ->usage of the
> credentials.
>
> To make their usage less error prone, introduce cleanup guards asto be
> used like this:
>
>      guard(cred)(credentials_to_override_and_restore);
>
> or this:
>
>      scoped_guard(cred, credentials_to_override_and_restore) {
>              /* with credentials overridden */
>      }
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I would also add:
Suggested-by: Christian Brauner <brauner@kernel.org>

Thanks,
Amir.

> ---
>  include/linux/cred.h | 21 +++++++++++++++++++++
>  kernel/cred.c        |  6 +++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 2976f534a7a3..e9f2237e4bf8 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -172,6 +172,27 @@ static inline bool cap_ambient_invariant_ok(const st=
ruct cred *cred)
>                                           cred->cap_inheritable));
>  }
>
> +/*
> + * Override creds without bumping reference count. Caller must ensure
> + * reference remains valid or has taken reference. Almost always not the
> + * interface you want. Use override_creds()/revert_creds() instead.
> + */
> +static inline const struct cred *override_creds_light(const struct cred =
*override_cred)
> +{
> +       const struct cred *old =3D current->cred;
> +
> +       rcu_assign_pointer(current->cred, override_cred);
> +       return old;
> +}
> +
> +static inline void revert_creds_light(const struct cred *revert_cred)
> +{
> +       rcu_assign_pointer(current->cred, revert_cred);
> +}
> +
> +DEFINE_GUARD(cred, const struct cred *, _T =3D override_creds_light(_T),
> +            revert_creds_light(_T));
> +
>  /**
>   * get_new_cred_many - Get references on a new set of credentials
>   * @cred: The new credentials to reference
> diff --git a/kernel/cred.c b/kernel/cred.c
> index c033a201c808..f95f71e3ac1d 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -485,7 +485,7 @@ EXPORT_SYMBOL(abort_creds);
>   */
>  const struct cred *override_creds(const struct cred *new)
>  {
> -       const struct cred *old =3D current->cred;
> +       const struct cred *old;
>
>         kdebug("override_creds(%p{%ld})", new,
>                atomic_long_read(&new->usage));
> @@ -499,7 +499,7 @@ const struct cred *override_creds(const struct cred *=
new)
>          * visible to other threads under RCU.
>          */
>         get_new_cred((struct cred *)new);
> -       rcu_assign_pointer(current->cred, new);
> +       old =3D override_creds_light(new);
>
>         kdebug("override_creds() =3D %p{%ld}", old,
>                atomic_long_read(&old->usage));
> @@ -521,7 +521,7 @@ void revert_creds(const struct cred *old)
>         kdebug("revert_creds(%p{%ld})", old,
>                atomic_long_read(&old->usage));
>
> -       rcu_assign_pointer(current->cred, old);
> +       revert_creds_light(old);
>         put_cred(override);
>  }
>  EXPORT_SYMBOL(revert_creds);
> --
> 2.43.0
>

