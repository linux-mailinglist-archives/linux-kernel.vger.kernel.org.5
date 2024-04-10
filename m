Return-Path: <linux-kernel+bounces-137764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1889E6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08AB282FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4534625;
	Wed, 10 Apr 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZ67S2aJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF7372
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708877; cv=none; b=f7QGEvbwzGbSWx8rv8yv5JyUqiS+FhfY0MFsGbG5IkVxvmWS7jtijed0mGBsULdSsccxRqmDr3AZoByO/f5YcuKPU44rUf7fgL30/bkC6vA0bZdjjlH+HAsYOxFGy/588+BHuYHewWyoAifmxjgAaYFV9Cr6OtE9prkqfBvTENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708877; c=relaxed/simple;
	bh=1g3Jwd101yosBOnAamyJC+sD1SyFil7LtbqBjatinpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIiMpwC3Ft+XZkyxnSPVimeWybS8rAuPvtw54HEi/3mFYveZ6CaQVDgCfJbNl6rGdQRUwGZ1qcW+oD4YaQ/O8zoii1/gZaalwYth0qlh4jZYTd0iu9+zsT/O5bk/lWLN81SxofdG7tV2+/+Ecta7CzlIiUAD2CtVUr9ob3DryTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZ67S2aJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso3037350a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712708872; x=1713313672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJMJEkzZNvW9+O43vYppDJCzIvChB6Myj7KkmaC6Lng=;
        b=YZ67S2aJsxuW7ZWwhDrapvfXVU0Uv3tDTcQpvJzB1gq3eVO+2/VDwMBKTa4+Zi+1Ls
         fc9uRvM+LosX4JDX/eha18nxd7OXK+OODFIVxNKXW0DiDN9//FK27rFf+svUEg24Q6Jy
         9pxn3/4dNqDywU/1VQSXuDL5VC6Cl4rUPiH2F4OZ25MOWgLvdHzJYd7oIyc0by71ihOS
         ZkcPdQgTBV9kG9+oafaQil+2dsbi1CDKnSKNM797lZlzFZYtiVt7tRKkt9bVbAzB92Lk
         7fMPMs8v9m93E9x60R+D5LVWzKmegoYIHZboTJqWiqOx9FTHd+mnJjj07dP4jUzCDMKz
         CcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708872; x=1713313672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJMJEkzZNvW9+O43vYppDJCzIvChB6Myj7KkmaC6Lng=;
        b=YH/LBCFYnzjHhnNlaJeSfeZbi7My8PAInkUmYCa3TUyfLMttaB6/PsOa9V37uT6ZNo
         lbL0W2gnksGL3lQXlMRKBjm6SWQNVEHS1KCs93z8bG0ouBkkND8dxupVMcLgagcdrMUb
         dFEV+kWzFOTFEUWTqkiF2GmBHCQM5ar5vc3haRH85w401l3r6kBBSpvzFBrwamdhPzQY
         frBRaYcigEWBhOKrYfp0qA/blsuxJm3EItFAWPS2V3+VrApiexJWjw9nRxLlzGv8Aum/
         3obfZQ1SUpSgNxLCASOeP0+v6kgZl+kSVcBwJ3jl8N5/9J1R7G2qPld49UxjD0S1gLfs
         dyCw==
X-Forwarded-Encrypted: i=1; AJvYcCWZcTLUTtXKCfeeY4Ih5t6qPouwRjS/cr9TSe45Kr8G3IeSnSNHw/HtBEcvp040d5crTNBd5eYKGAXzmK/7Lluc0CFpAtpzP62bgnfr
X-Gm-Message-State: AOJu0YzgqIrD+zAyABZZANKGJmySjQsGxxTiKJwx6j9qHd7FwQJJoc5T
	Ydp6HUsAh0jFB/5CyZugDecx6bUY2qFO7VNt7BlGmN2iVAFEP9uDMb3UOPwexS0k08swxTU3Twz
	V1ZGGh6GohU4NudV7/4vgfxU4r8cwxfLFf8MG
X-Google-Smtp-Source: AGHT+IGStqxWPH5ahxvU9bcdmddGl/48mJ9/LNQW4hznFXCzuZH/DVbrRH2nwiaQ/F1lKkgsTNqDC26Qe6ALxXgjzDM=
X-Received: by 2002:a50:96c4:0:b0:56d:f035:7db2 with SMTP id
 z4-20020a5096c4000000b0056df0357db2mr517493eda.24.1712708872102; Tue, 09 Apr
 2024 17:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-strncpy-xattr-split2-v1-1-90ab18232407@google.com>
 <ZhVDgbRoF9X7JSdt@infradead.org> <CAFhGd8pwoBSvLDRLX8ekRk+u9uX6s6mcAfTz8E15E6EBsvuSag@mail.gmail.com>
In-Reply-To: <CAFhGd8pwoBSvLDRLX8ekRk+u9uX6s6mcAfTz8E15E6EBsvuSag@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 9 Apr 2024 17:27:34 -0700
Message-ID: <CAFhGd8qwCwycW=PpUWUGxAdU54jwi9D=k3xrNgC62CvM-Q+ukg@mail.gmail.com>
Subject: Re: [PATCH] xfs: xattr: replace strncpy and check for truncation
To: Christoph Hellwig <hch@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 5:23=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi,
>
> On Tue, Apr 9, 2024 at 6:32=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> >
> > On Fri, Apr 05, 2024 at 07:45:08PM +0000, Justin Stitt wrote:
> > > -     memcpy(offset, prefix, prefix_len);
> > > -     offset +=3D prefix_len;
> > > -     strncpy(offset, (char *)name, namelen);                 /* real=
 name */
> > > -     offset +=3D namelen;
> > > -     *offset =3D '\0';
> > > +
> > > +     combined_len =3D prefix_len + namelen;
> > > +
> > > +     /* plus one byte for \0 */
> > > +     actual_len =3D scnprintf(offset, combined_len + 1, "%s%s", pref=
ix, name);
> > > +
> > > +     if (actual_len < combined_len)
> >
> > Shouldn't this be a !=3D ?
>
> I guess it could be. It's a truncation check so I figured just
> checking if the amount of bytes actually copied was less than the
> total would suffice.
>
> >
> > That being said I think this is actually wrong - the attr names are
> > not NULL-terminated on disk, which is why we have the explicit
> > zero terminataion above.
>
> Gotcha, in which case we could use the "%.*s" format specifier which
> allows for a length argument. Does something like this look better?
>
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 364104e1b38a..1b7e886e0f29 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -206,6 +206,7 @@ __xfs_xattr_put_listent(
>  {
>   char *offset;
>   int arraytop;
> + size_t combined_len, actual_len;
>
>   if (context->count < 0 || context->seen_enough)
>   return;
> @@ -220,11 +221,16 @@ __xfs_xattr_put_listent(
>   return;
>   }
>   offset =3D context->buffer + context->count;
> - memcpy(offset, prefix, prefix_len);
> - offset +=3D prefix_len;
> - strncpy(offset, (char *)name, namelen); /* real name */
> - offset +=3D namelen;
> - *offset =3D '\0';
> +
> + combined_len =3D prefix_len + namelen;
> +
> + /* plus one byte for \0 */
> + actual_len =3D scnprintf(offset, combined_len + 1, "%.*s%.*s",
> +        prefix_len, prefix, namelen, name);
> +
> + if (actual_len < combined_len)
> + xfs_warn(context->dp->i_mount,
> + "cannot completely copy context buffer resulting in truncation");
>
>  compute_size:
>   context->count +=3D prefix_len + namelen + 1;
> ---

I copy pasted from vim -> gmail and it completely ate all my tabs.
When I actually send the new patch, if needed, it will be formatted
correctly :)

>
>
>
> >
> > How was this tested?
>
> With https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/about/
>
> but using scripts + image from: https://github.com/tytso/xfstests-bld
>
> here's the output log: https://pastebin.com/V2gFhbNZ wherein I ran the
> 5 default ones (I think?):
>
> |        Ran: generic/475 generic/476 generic/521 generic/522 generic/642
> |        Passed all 5 tests
>
> Thanks
> Justin

