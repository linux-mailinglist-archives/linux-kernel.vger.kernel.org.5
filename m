Return-Path: <linux-kernel+bounces-72168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FA85B043
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E94A1F22844
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCFE17547;
	Tue, 20 Feb 2024 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXj6N3W9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DF168AB;
	Tue, 20 Feb 2024 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708391582; cv=none; b=HOv6AcvFdnBV09ChZHITxHAScig2Tr2bxCli6t3ClWd3qrSArnyM2CiBiaBJ7SnFAndCA2PdLQGS5G5BqGfbdsT/ReFM0L3SPDuiuqPwa7+auJECVs0N1exj+lTzIutWAdIaht4tLyYf6ThrVBvv2zVXkM0dc9S/zL3jUxWDVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708391582; c=relaxed/simple;
	bh=DCl+zUGC9+EEyj9bRGh8CRIqpnw/B3lVFtfwXYPtE4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXZoA7CyKfvWk+kFSIoJDE7XeMtsdSE5j6epu8kOHv9ztD0B9By3oRHFtOtKg9iu2IQfvOIucGUfHgNiK/Gc1Bli8Fw14MmYzglYqqZwL618y25Yi4/s26KUGoZ0VukTlWg/0rD0qx95u8PlDhmqio0ze4ikKBKU6EX1hJklzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXj6N3W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F1C43390;
	Tue, 20 Feb 2024 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708391581;
	bh=DCl+zUGC9+EEyj9bRGh8CRIqpnw/B3lVFtfwXYPtE4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QXj6N3W9LtNX7jPlhliCSsQlSYwnjxxIhmHfo2qC6jyvzdocvxvORfqGDAUKUQv6l
	 x9nGEbh/QrW3mCkVewwE/AqD8TTO/Phzky+xAGannh6L+4gjb7gujWcRRU8zznhNSw
	 QVGTanv+QoeZMNBZUzh52y5rffWGDTW4rkAAAi1ispXbs8MV3QSWV3u5d82crStjFf
	 fL6gvy8sfeXmzKZgWwyI1TXfp9MfnL3YNZ60/3RTF24xdVfAw57XWlka98V/A+pU/u
	 N3N4vJEfcnas0EqOyYX+LiwLfnQQnBfXSznYZZSzxwdnx/ahSN05rXx+mFO8Win4aa
	 5pknBE8ZwhtRw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so3155486a12.1;
        Mon, 19 Feb 2024 17:13:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV13Ro9D6/g1zOnLDcNxDjnlT0/2IkEsMKwwpaeFBdHfUehrjBx1c2qy3hQm1PeyS+R/nyf0S+o+qMBO7z04TzByQ6te2LCynJPbw==
X-Gm-Message-State: AOJu0YwmbpRbSzc5TAPvt8bjWoSRtnp4wMRWlAlgnnBLrErLBNi2nu/r
	jy6shjsjV8Cra7QYsADhyhAGwS2hLolTAJWnMfn9EFt3Y4rXRHmrRTheLDj/G1uns0qG3j9xqU6
	WXKQ1KRSWeVYAvcLji2qqrW163xs=
X-Google-Smtp-Source: AGHT+IFo2i+CcWUoZ9mNaaSW+jhLre9HCGYXLs9yO923qkZQ1yTXNI+ATxc5XSVUu+mYzY1zjJoVACrqrb07oD+3Hac=
X-Received: by 2002:aa7:de0e:0:b0:564:b9be:5c16 with SMTP id
 h14-20020aa7de0e000000b00564b9be5c16mr958882edv.8.1708391580101; Mon, 19 Feb
 2024 17:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219153939.75719-1-anna-maria@linutronix.de> <20240219153939.75719-4-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-4-anna-maria@linutronix.de>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 20 Feb 2024 09:12:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0EtmvxS9n0s2w1oOfhvT1KhMR+6jzFyHCDaTZvKzVbQ@mail.gmail.com>
Message-ID: <CAJF2gTS0EtmvxS9n0s2w1oOfhvT1KhMR+6jzFyHCDaTZvKzVbQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] csky/vdso: Remove superfluous ifdeffery
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:40=E2=80=AFPM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> CSKY selects GENERIC_TIME_VSYSCALL. GENERIC_TIME_VSYSCALL dependent
> ifdeffery is superfluous. Clean it up.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/include/asm/vdso.h | 5 -----
>  arch/csky/kernel/vdso.c      | 4 ----
>  2 files changed, 9 deletions(-)
>
> diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
> index bdce581b5fcb..181a15edafe8 100644
> --- a/arch/csky/include/asm/vdso.h
> +++ b/arch/csky/include/asm/vdso.h
> @@ -5,11 +5,6 @@
>
>  #include <linux/types.h>
>
> -#ifndef GENERIC_TIME_VSYSCALL
> -struct vdso_data {
> -};
> -#endif
> -
>  /*
>   * The VDSO symbols are mapped into Linux so we can just use regular sym=
bol
>   * addressing to get their offsets in userspace.  The symbols are mapped=
 at an
> diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
> index 16c20d64d165..e74a2504d331 100644
> --- a/arch/csky/kernel/vdso.c
> +++ b/arch/csky/kernel/vdso.c
> @@ -8,11 +8,7 @@
>  #include <linux/slab.h>
>
>  #include <asm/page.h>
> -#ifdef GENERIC_TIME_VSYSCALL
>  #include <vdso/datapage.h>
> -#else
> -#include <asm/vdso.h>
> -#endif
>
>  extern char vdso_start[], vdso_end[];
>
> --
> 2.39.2
>
Acked-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

