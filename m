Return-Path: <linux-kernel+bounces-130491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D173B8978E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4031C21A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7981552FD;
	Wed,  3 Apr 2024 19:16:09 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDA153BED;
	Wed,  3 Apr 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171769; cv=none; b=ncM8RjiSNmYWeVYyw6WY8DN3ft+uGeD69JOCtJ4MYtswBqExQcoBaustagX2qV7o04AdGc+Rh6pUI+qGrFBkX7jjTFcFvS7+Kwb+TVDv4Q/GL5grj6gam7ALDcXLesJs666Y3phzJisL5AvRSeeDqhGGubgxtrq+X0xvw8SarDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171769; c=relaxed/simple;
	bh=WQHELEydoFdXUfkrRwBS7RIXUMEFdP7aOIybB6jPe+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Da6CBTZRYfgBGP1+HgfNCZFl66BPrr7sV1llpKBN/w6SlsWdTLvPehOKLcDWtOIzYLl7qHSG5I7CoouF5Nk+8nJATDZxedvknHcpsMrcQMKwMvrbM5XbNABPVHaY0qtQgAy3U2sfzgS6n9T0SndRz/PBabE4ephtfWQVzNTEYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516c403cc46so380940e87.3;
        Wed, 03 Apr 2024 12:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1XQPP1nzqiwOBcOFnPBGLnyCw24jC+FAGpJsEZTChVRDGRk51ZGE7/CkkT2Gd1m9Ged1lQhS5vU1c0Cu8IOnel/4buooqcoNH4AmBtwfqH/s/cqybbW3fl883AaRWNMaL+1v14TcUvA==
X-Gm-Message-State: AOJu0Yy9GXGEfZ0TMHwQmtYN11a2MQKRFyMylrAjcB9/KjJ22pkXPegt
	mDnAouWD2HK6qYTDfy4rKY1jAY5uRXndvY16+eYFGgrNkAnkrdHbvfFnoEakV4P+Znr07MNfBAZ
	6wN5q6/Meqg8dNy2C0UyeOlGDvtE=
X-Google-Smtp-Source: AGHT+IGvuo2+HrzCh53daOA8jLqLhVaaxfxtLvUxT5bAuWUrP4E3dDceu8fC/6CJK3Hh4P9zvBVHbH3xZBEbFTR4/Rs=
X-Received: by 2002:a19:6b12:0:b0:515:cb05:e749 with SMTP id
 d18-20020a196b12000000b00515cb05e749mr348585lfa.12.1712171764219; Wed, 03 Apr
 2024 12:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306171149.3843481-1-floppym@gentoo.org>
In-Reply-To: <20240306171149.3843481-1-floppym@gentoo.org>
From: Mike Gilbert <floppym@gentoo.org>
Date: Wed, 3 Apr 2024 15:15:52 -0400
X-Gmail-Original-Message-ID: <CAJ0EP42dLgjk5ucgzDoknBzkByL=O5v43gCmMR2BvgBxsaAkCg@mail.gmail.com>
Message-ID: <CAJ0EP42dLgjk5ucgzDoknBzkByL=O5v43gCmMR2BvgBxsaAkCg@mail.gmail.com>
Subject: Re: [PATCH] sparc: move struct termio to asm/termios.h
To: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:11=E2=80=AFPM Mike Gilbert <floppym@gentoo.org> w=
rote:
>
> Every other arch declares struct termio in asm/termios.h, so make sparc
> match them.
>
> Resolves a build failure in the PPP software package, which includes
> both bits/ioctl-types.h via sys/ioctl.h (glibc) and asm/termbits.h.
>
> Closes: https://bugs.gentoo.org/918992
> Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/sparc/include/uapi/asm/termbits.h | 10 ----------
>  arch/sparc/include/uapi/asm/termios.h  |  9 +++++++++
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/=
uapi/asm/termbits.h
> index 4321322701fc..0da2b1adc0f5 100644
> --- a/arch/sparc/include/uapi/asm/termbits.h
> +++ b/arch/sparc/include/uapi/asm/termbits.h
> @@ -10,16 +10,6 @@ typedef unsigned int tcflag_t;
>  typedef unsigned long  tcflag_t;
>  #endif
>
> -#define NCC 8
> -struct termio {
> -       unsigned short c_iflag;         /* input mode flags */
> -       unsigned short c_oflag;         /* output mode flags */
> -       unsigned short c_cflag;         /* control mode flags */
> -       unsigned short c_lflag;         /* local mode flags */
> -       unsigned char c_line;           /* line discipline */
> -       unsigned char c_cc[NCC];        /* control characters */
> -};
> -
>  #define NCCS 17
>  struct termios {
>         tcflag_t c_iflag;               /* input mode flags */
> diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include/u=
api/asm/termios.h
> index ee86f4093d83..cceb32260881 100644
> --- a/arch/sparc/include/uapi/asm/termios.h
> +++ b/arch/sparc/include/uapi/asm/termios.h
> @@ -40,5 +40,14 @@ struct winsize {
>         unsigned short ws_ypixel;
>  };
>
> +#define NCC 8
> +struct termio {
> +       unsigned short c_iflag;         /* input mode flags */
> +       unsigned short c_oflag;         /* output mode flags */
> +       unsigned short c_cflag;         /* control mode flags */
> +       unsigned short c_lflag;         /* local mode flags */
> +       unsigned char c_line;           /* line discipline */
> +       unsigned char c_cc[NCC];        /* control characters */
> +};
>
>  #endif /* _UAPI_SPARC_TERMIOS_H */
> --
> 2.44.0
>

Ping. Could we get this merged please?

