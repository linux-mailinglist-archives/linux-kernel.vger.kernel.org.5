Return-Path: <linux-kernel+bounces-137874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3689E8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D7A286BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D05C2D0;
	Wed, 10 Apr 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrgA4Ne+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48298BA2E;
	Wed, 10 Apr 2024 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722129; cv=none; b=M4uEUIjhba0MviAKJqm246e5koTc7UYoF6T/tpYHMsT0M6AZ5fOdGzqmT7JryWkiQF63SmGgyypub1YTyOzANHZPFANVbAyP/i0sP8fp2zwPPhoAYyxrnUG+6v7YPQLY3x8aaC4YZkO23pIdnwaAiseoG81J0ZqOVmN+nNorohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722129; c=relaxed/simple;
	bh=vk1wpjcIMZS12RSXSq0jsDq3eZv3hPJGoq3Tko2DR1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIwkavh9mwKsxEP9ELGQZs8a1SXk8R3zONaqhel/EfhHRgyfTCL7L5VmMZAbjfbq+/0iXZiMPFYZa8qVTg0PLlIfSmi2P5xIdOdRHcjJunp5BjCU6EQkM5kiE5yQTdUMlzGr2HTCiLNKJ6fIrkVwnsKvz2kwWKPATRujofJ30pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrgA4Ne+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso9280192a12.0;
        Tue, 09 Apr 2024 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712722126; x=1713326926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM95mqt70PA6qSjz9GJbuCz/6FBhl1PMP4ZJrRScoHI=;
        b=ZrgA4Ne+/rZr4z2aGyqleVyjSHBXF/OPlLOvDRgPVB7hlUMi7qqyU3DyuQX3qBhQ5Y
         ojrZbltarkHDDb9sp5AgI7Xl2IbzfAUwVdRAYd24EAZLVvW7qMh3Yb96rFYaUtvq+AhC
         o9Ay8n0frBzNc3bIwYyYDebxNVysJYYI72Yt/NtRarqbTvjV4jrm0Zy4m4ZPxMD7OKSh
         2mrDot/Qy0YsR7vyyJkWaGdrMwF+1vWFNIrLI3ovrzBUBIqAmv9mMiDlYkb2LqCJw0mc
         gbQIRqxTEtnG00WPHIBDVZea0U8Q/R6Dt9qhe/huofSVkE9yHbLuK1oQovEHJf6c3lGV
         GVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712722126; x=1713326926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM95mqt70PA6qSjz9GJbuCz/6FBhl1PMP4ZJrRScoHI=;
        b=fkonGt3+XntecuYP0K50ToUZvS+ztq+nNOA/iMRVWIhBCTBstZzVajM0FF+xjxRWZE
         nNj4YkNtwfK1sA4WBB2wH4zje3U9+gLu+6eOsYGkQW2EnUGY2DUOaxj1zv9t/wcmkmOt
         W2HTq0EDzgcnWww4fCQDU07ScMFIFfLdV8og3PzLHm/Tso1cuTevGPg2kMAE/e30M4WN
         nMqZsJHd+UoFSOq3oasaj0Sqn9vOUK3e9SMMNTMF3wSe9j9ARv88vsR5rwVXe4k+hwk3
         XsOQ3U2k5Go/m+Ztd73gztCxccHb/bast1fQef2JAAUopM4f8HNx0Q5Csx38jsl6xTZ3
         rVxw==
X-Forwarded-Encrypted: i=1; AJvYcCXBkzzBaYVjXA/txDAGXoq9RubwCHxdSP4Y/nXj2krP1He1juuD0UBp4H/FBYhfstolEfT3oxcVhUHZ+2FBO7Lm5IOlLbIDRMlQ1nbAJUibM0/mDgWuRKbOsWQ03XcF+eDk2b3aE+y9uf+2unsjdO10ryjeHwqLCjVxX3bojt2ccc+YEh1wQYtufw==
X-Gm-Message-State: AOJu0YzZ1zfmQ7mQ/XGBtay2URdwqbW5xjhAPdfF1XWRyzcBXNKfipy3
	dhiSoCWlmTnVynA8inlCiGIyKkk/wREfW+eM9j3HXnV8OfClvx/XBsd8Ne9kdAycNPXf+F2938o
	ftJ5iE/VUEmObcfKZoFrwQCEvp1M=
X-Google-Smtp-Source: AGHT+IH+bSUHIkz+0RFGK41a9MG2DwlgR7xM2qM9mlzSFJ2IU8ZElEblFn82R+lh4/FzMAFJgqf/Ups/UIkidin6tsM=
X-Received: by 2002:a17:907:6095:b0:a51:d49f:b6e3 with SMTP id
 ht21-20020a170907609500b00a51d49fb6e3mr1137115ejc.54.1712722126316; Tue, 09
 Apr 2024 21:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410021833.work.750-kees@kernel.org> <20240410023155.2100422-1-keescook@chromium.org>
In-Reply-To: <20240410023155.2100422-1-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Apr 2024 07:08:10 +0300
Message-ID: <CAHp75VeOQ+x3WgFeG89X=kGUo=w=ztkdBkA3_K6yy+2mWV83AA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: Introduce memtostr() and memtostr_pad()
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	Charles Bertsch <cbertsch@cox.net>, Bart Van Assche <bvanassche@acm.org>, 
	Sathya Prakash <sathya.prakash@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Nilesh Javali <njavali@marvell.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Himanshu Madhani <himanshu.madhani@oracle.com>, 
	linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 5:31=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Another ambiguous use of strncpy() is to copy from strings that may not
> be NUL-terminated. These cases depend on having the destination buffer
> be explicitly larger than the source buffer's maximum size, having
> the size of the copy exactly match the source buffer's maximum size,
> and for the destination buffer to get explicitly NUL terminated.
>
> This usually happens when parsing protocols or hardware character arrays
> that are not guaranteed to be NUL-terminated. The code pattern is
> effectively this:
>
>         char dest[sizeof(src) + 1];
>
>         strncpy(dest, src, sizeof(src));
>         dest[sizeof(dest) - 1] =3D '\0';
>
> In practice it usually looks like:
>
> struct from_hardware {
>         ...
>         char name[HW_NAME_SIZE] __nonstring;
>         ...
> };
>
>         struct from_hardware *p =3D ...;
>         char name[HW_NAME_SIZE + 1];
>
>         strncpy(name, p->name, HW_NAME_SIZE);
>         name[NW_NAME_SIZE] =3D '\0';
>
> This cannot be replaced with:
>
>         strscpy(name, p->name, sizeof(name));
>
> because p->name is smaller and not NUL-terminated, so FORTIFY will
> trigger when strnlen(p->name, sizeof(name)) is used. And it cannot be
> replaced with:
>
>         strscpy(name, p->name, sizeof(p->name));
>
> because then "name" may contain a 1 character early truncation of
> p->name.
>
> Provide an unambiguous interface for converting a maybe not-NUL-terminate=
d
> string to a NUL-terminated string, with compile-time buffer size checking
> so that it can never fail at runtime: memtostr() and memtostr_pad(). Also
> add KUnit tests for both.

Obvious question, why can't strscpy() be fixed for this corner case?

--=20
With Best Regards,
Andy Shevchenko

