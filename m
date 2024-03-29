Return-Path: <linux-kernel+bounces-124324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428778915AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15DA2859F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6583B1B2;
	Fri, 29 Mar 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzjM+7bm"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377333BBE9;
	Fri, 29 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704053; cv=none; b=PofyhBHqAPPL34r4pxi7SNnItIbg1XfX6fGydAfDE+jvwNSVj1KpLiLs/10D4Dl336EYD/gY9gQn9WKt14uwl5ZKbUSBZ4neVmXkZ5VGfIKmv09H4IyhcnfqpPvIswwKjUqAqmYR1D81qENoCqyeQeCRLmKw/vpliACfMva7n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704053; c=relaxed/simple;
	bh=3+KzKfoPxJkXYBWH4jETA2PB/rqfcklrqomjdJgXvF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRCR6GtUI47snLajuYso2BBV1ZXh7TP1QIYUezYa6UvDDgEc1XbIT3jO+GoZOgO81Hk2aoCNoaI2Z251r391V7nZd94Vq7nYUxDUQrK+9PiIZu52sJ6Zc4YjTpjJvPLN5Vpm1zpqCe8Sg8vohLYaduyPRK+BibHgw5KIItQRhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzjM+7bm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so18120741fa.1;
        Fri, 29 Mar 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704050; x=1712308850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lBcjPdLmjGCTnnG0LCAOX7aShBT4O93mQYNeFnPHhk=;
        b=VzjM+7bmDbalbdtTUFAkh+BhCmPFX8dEx4RVhNVVYgvm6lCU+dr+mZlOKKGgcA/Azj
         ECGupwMIMcefuMVSCVCp8rnHAa55RnbitqRxjFTK9sd7ohs9zgoElGrOFsGitCNFVAwC
         trdXvcNCpZwfgYd1kf88em6Gy/+ENeJReo6VxRfBReV+A4r/KayiCAn8I83PvJ8BhxV8
         IOoc6NhNEXWekRwTbqie5s70ftIWsO8QlbMEx1oxhtUuaMmOLhSOGIHmGBKBnneflV2g
         UrURmSW6sleCmALLdTR17KMRpHUB3vuDbOic05f+F/zCCMnZ/lql2f1jLjRM7v6jRxvh
         AEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704050; x=1712308850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lBcjPdLmjGCTnnG0LCAOX7aShBT4O93mQYNeFnPHhk=;
        b=tVQDIkY/L+f+Ubh6oVNXmbkBnrb0MrXad9ZJs5zLB+wa3DAoM6HlX5qx9Mp5sj3gA6
         mpEgXBP6g3aWvj/gTgvpqAF5bRjUOZ0BGqjlT/dj1EArv6jmVQ+Na3tGFkLsQ2rQD9UC
         DUAYRD0uhLZdFJ8QMVqXf6dD0TrM15RwoHFRx/bpSBqgJNBIsAggA7/9hDvBZbi3FMKt
         4bRHfSOkKrJ48T51vk7cs6MziiFHroYFHfqVuhi6BsZtaq6F3wgHx0qhf9dEYy/Cflp8
         l6Pl+jH8E1vdYJv5A3Jde3YKzZQ0N2FdgyKxtzHGRKw7fkrVzc9jIuj3T1MzT0GpIf8F
         HM0g==
X-Forwarded-Encrypted: i=1; AJvYcCVCjQZdINhjLDsPuUN0rtUlFW94bWlVMJ8xW5tET5Kw4moxSjW/uf82MFUTynM5vDdYdtEX2uxcqfUordZCnT1A4jRvQej+hfR9Q80=
X-Gm-Message-State: AOJu0YwEJzYqAEDw9g1ebLjM5g1HnS35/8ZIaXV80w+qEUessJBrDAX9
	CcejqoPLdgLGIeLb67QdMrRTdjwZH+6jKysRr0K/zdR1+ttoBXNN4o2lvyBclUaXW+DX9MJyqKv
	ikIYACEOYl3z4rtmGEGZr3Le+Bds=
X-Google-Smtp-Source: AGHT+IEvNfeOSZz8foV9UcNnuHUSiocg+9dt7y0SfIy5ywRQtsqYBK4r66KNFjq0SIqf3ZE8DH1iYRbFyCTHa0wmbVw=
X-Received: by 2002:a2e:a366:0:b0:2d4:57c5:886c with SMTP id
 i6-20020a2ea366000000b002d457c5886cmr921811ljn.13.1711704050115; Fri, 29 Mar
 2024 02:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-7-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-7-arnd@kernel.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 29 Mar 2024 18:20:33 +0900
Message-ID: <CAKFNMonPyESp5m2fuUn+w2mvwxxfaZB19ansXix9kV9jJCzUew@mail.gmail.com>
Subject: Re: [PATCH 6/9] nilfs2: fix out-of-range warning
To: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Philipp Stanner <pstanner@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Thorsten Blum <thorsten.blum@toblux.com>, 
	linux-nilfs@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:32=E2=80=AFPM Arnd Bergmann wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 points out that v_size is always smaller than a 64KB
> page size if that is configured by the CPU architecture:
>
> fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant 65536 wi=
th expression of type '__u16' (aka 'unsigned short') is always false [-Werr=
or,-Wtautological-constant-out-of-range-compare]
>         if (argv->v_size > PAGE_SIZE)
>             ~~~~~~~~~~~~ ^ ~~~~~~~~~
>
> This is ok, so just shut up that warning with a cast.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/nilfs2/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index f1a01c191cf5..8be471ce4f19 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilf=
s,
>         if (argv->v_nmembs =3D=3D 0)
>                 return 0;
>
> -       if (argv->v_size > PAGE_SIZE)
> +       if ((size_t)argv->v_size > PAGE_SIZE)
>                 return -EINVAL;
>
>         /*
> --
> 2.39.2
>

Andrew, could you please apply this to the -mm tree along with the
following tags and Justin's reviewed-by tag?

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Fixes: 3358b4aaa84f ("nilfs2: fix problems of memory allocation in ioctl")

Thank you, Arnd.
I didn't notice this warning existed depending on the environment.

Ryusuke Konishi

