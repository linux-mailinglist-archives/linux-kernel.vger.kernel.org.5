Return-Path: <linux-kernel+bounces-55045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0546B84B6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20D11F23A02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5FE130E30;
	Tue,  6 Feb 2024 13:42:59 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688A131E21;
	Tue,  6 Feb 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226979; cv=none; b=S26Xsdl8vRFp7r0F67N1aN1H1i3GPq7glaDm6tA74q491m27gKqSDprY64aO0oDAnuFL/QoVYMe/RdwXZMuvZJCV6xEIgXNY1dMCoCo14sq5xEtFkfzjAy5bQAYpoUdtfk67gk8Ahz/qof2kIR57+S9kJdGaY21ag7zXoeCWmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226979; c=relaxed/simple;
	bh=y4k3xV8mp+U/3R/xNRZOwbyBlWf39dt/H732GyHvG80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC5/qwE9XZQKRG+lNN8wpFRNyTjepJbJ5Y6dvKo4uyBgGGD3J5xqXaibVcSg8xEXd4PbvPJ98z+ivfLOLCbnq6IPnrhZn92u8nyO+dithsdxd3PRqFSV0rjmDoWoHr7DeEXDq1oMH86vVh6lqwXo/xbz/u8b2TER8gT4tAwz60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60406f4e1d0so49478837b3.1;
        Tue, 06 Feb 2024 05:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226975; x=1707831775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yATTSkX3Mca0eYcQSx0nPTfy/xoyCCu1xWIXC3gdwXI=;
        b=N1c6C4EObijCEmC8vaz6JimwJ7SElmXaaN1p/OxsNw9RMx2IiORDiNmdPmbVUSlnew
         a/p64UrCU35o9k9jj8i7/PILR+p3P8kErTOgyNAe5BU57J7c/Pe9ydpveUCGr6kNNntJ
         8TbL4FrBcI2mWUcuCiHA7jHJDm6Fgf0+kpsbMRqD4BxXb68gH+f9cqCMajnnIN6f794a
         HctBD846E02FInlY41WcVGm7HS6lIm92cfWpC82MKHzsCBEs28JUTeAhsnUGLvuIHySK
         j/hgVr2W7/DnYKJhW9C9lAPiC/WJr8WmlfXQZr41gVdxOktEUzTtixbeYEaQ2ZG5uSoE
         vpow==
X-Gm-Message-State: AOJu0YxN+3hB6C94ibrjNAm/9yGOFsX1TPJ3zBMLBS57ay4M7M5ikRjo
	NzCILy8JRKBhLjPL4X/3IACbFCnY4viVBV87XFtKsdceS4n1/vuoGSUkcxxGTIc=
X-Google-Smtp-Source: AGHT+IGhrtBGvw3CYzvc1YVHaa1jMMeo9edhVNmnaaeKfZzRkVca8ZES5Mb/Y97gm7xkfR0mLQGFAQ==
X-Received: by 2002:a0d:ea01:0:b0:604:7c34:a44 with SMTP id t1-20020a0dea01000000b006047c340a44mr1625950ywe.36.1707226975577;
        Tue, 06 Feb 2024 05:42:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg+3PDtWgMTMsus+4QQV9yKaLttNCV4D/I9xV+tYMKfDUdHmQKZbMqMjIvAz/k4traaznAawVtqUPPLE3M14uGtm/Pgcc32FQ8o7PbpNVXm6Z6tcvDnMdnkGYwtPU+WzRi0HzjNQxcwQ==
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d132-20020a814f8a000000b006048395c0f9sm63094ywb.77.2024.02.06.05.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:42:55 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffdf06e009so49643637b3.3;
        Tue, 06 Feb 2024 05:42:55 -0800 (PST)
X-Received: by 2002:a81:ef14:0:b0:604:b55:f078 with SMTP id
 o20-20020a81ef14000000b006040b55f078mr1681909ywm.7.1707226975018; Tue, 06 Feb
 2024 05:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206131050.0e86d882@canb.auug.org.au> <CAMuHMdWjAKbt_bne8Mjpg3N_7R8TcKvAoVV8T4VrwTC2apAr_g@mail.gmail.com>
In-Reply-To: <CAMuHMdWjAKbt_bne8Mjpg3N_7R8TcKvAoVV8T4VrwTC2apAr_g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 14:42:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXMexzzkj=pSdGOPhGncZ3BO8PFCrtfeh2XPoWsZ9-+kw@mail.gmail.com>
Message-ID: <CAMuHMdXMexzzkj=pSdGOPhGncZ3BO8PFCrtfeh2XPoWsZ9-+kw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jens Axboe <axboe@kernel.dk>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:12=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Feb 6, 2024 at 3:11=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> > After merging the block tree, today's linux-next build (arm
> > multi_v7_defconfig) produced these warnings:
> >
> > In file included from /home/sfr/next/next/include/linux/bits.h:6,
> >                  from /home/sfr/next/next/include/linux/bitops.h:6,
> >                  from /home/sfr/next/next/include/linux/kernel.h:23,
> >                  from /home/sfr/next/next/io_uring/nop.c:2:
> > /home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count=
 >=3D width of type [-Wshift-count-overflow]
> >     7 | #define BIT(nr)                 (UL(1) << (nr))
> >       |                                        ^~
> > /home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in exp=
ansion of macro 'BIT'
> >   538 |         REQ_F_CAN_POLL          =3D BIT(REQ_F_CAN_POLL_BIT),
> >       |                                   ^~~
> >
> > (and mny more similar)
> >
> > Introduced by commit
> >
> >   d964e8440442 ("io_uring: add io_file_can_poll() helper")
> >
> > REQ_F_CAN_POLL_BIT is 32.
>
> All of these BIT() have to be changed to BIT_ULL().
> And let's hope all variables used for storing these flags have been
> changed from unsigned long to u64...

I have sent a fix
https://lore.kernel.org/1960190f37b94276df50d382b9f1488cd6b6e662.1707226862=
git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

