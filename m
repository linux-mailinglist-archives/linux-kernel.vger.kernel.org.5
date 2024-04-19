Return-Path: <linux-kernel+bounces-151747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8E8AB357
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABF31F24B16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BDC13174E;
	Fri, 19 Apr 2024 16:29:08 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C01311B9;
	Fri, 19 Apr 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544147; cv=none; b=LJZP4Rim3OyO5PoswEiFp1Zo9CrTA6pVqm98+z0disFLiuQ4ZJ/67mc1nD6NZpLqnHlu93msdJgZ+KKMZoJV9DfSVVaaP8RtD1EBMNlOomxXDEOs7JQsYa+vxUH3nQ8AlKhorUJhdMHKSdWuI/3ngv9WIrYKht+0kookRZvA9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544147; c=relaxed/simple;
	bh=ezY9lIHJUPii+5GdCwA6/18Koh5RgsMU5I39216AfOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShQij+Ls2W953oJflNSNqejeKb++mOpPdaBaHGwMFN/Tk8PurM2YpHEHqppnTcO8OMIrwiGt+WuMHmAjt4EwHjtBpEVm3EWl1ohVnQHXLh3Ks8eIshPGlJFrPiWX2JsHZemq8jHlMjXmeBMxBMKy8aLovScUfZx/vclYTx43OrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5568bef315so390403066b.1;
        Fri, 19 Apr 2024 09:29:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy2U0jC1PEbcNO31z4xeQjR1lI6bwEgnGmAYB935/LpOOHqaEsKjDUP69PE+KpBPZ8QWfag3MJUgajmLBNxluYpItPks0eQT85Kw==
X-Gm-Message-State: AOJu0YyF+YfGWI99qj05VipgxDEHqjyxK+CvAmDvJW76Q3ctph+bdof9
	ddR+5ye+CRxaQ5LpqUEI/UaeV8G9afz9XYMrrA2u8rnUayUt5bqnZgV2WxfLduHQSrWqbc7T947
	4A8hoU34vkLJx4lDddaedejKyF0o=
X-Google-Smtp-Source: AGHT+IEVEabqKcu9eSY49T1AtpQFY4UB0nkwSjaSaTuptyXMJCug2muIi2v3znemu/NffBUEWviDXqEITFTlgcoMj4c=
X-Received: by 2002:a17:907:3601:b0:a55:577e:4e2e with SMTP id
 bk1-20020a170907360100b00a55577e4e2emr5791100ejc.20.1713544142900; Fri, 19
 Apr 2024 09:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306171149.3843481-1-floppym@gentoo.org> <CAJ0EP42dLgjk5ucgzDoknBzkByL=O5v43gCmMR2BvgBxsaAkCg@mail.gmail.com>
In-Reply-To: <CAJ0EP42dLgjk5ucgzDoknBzkByL=O5v43gCmMR2BvgBxsaAkCg@mail.gmail.com>
From: Mike Gilbert <floppym@gentoo.org>
Date: Fri, 19 Apr 2024 12:28:51 -0400
X-Gmail-Original-Message-ID: <CAJ0EP41garVk6XMggpQ-zsvREa-oy7qq6PpuyyCPoztBr=8K6A@mail.gmail.com>
Message-ID: <CAJ0EP41garVk6XMggpQ-zsvREa-oy7qq6PpuyyCPoztBr=8K6A@mail.gmail.com>
Subject: Re: [PATCH] sparc: move struct termio to asm/termios.h
To: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:15=E2=80=AFPM Mike Gilbert <floppym@gentoo.org> wr=
ote:
>
> On Wed, Mar 6, 2024 at 12:11=E2=80=AFPM Mike Gilbert <floppym@gentoo.org>=
 wrote:
> >
> > Every other arch declares struct termio in asm/termios.h, so make sparc
> > match them.
> >
> > Resolves a build failure in the PPP software package, which includes
> > both bits/ioctl-types.h via sys/ioctl.h (glibc) and asm/termbits.h.
> >
> > Closes: https://bugs.gentoo.org/918992
> > Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/sparc/include/uapi/asm/termbits.h | 10 ----------
> >  arch/sparc/include/uapi/asm/termios.h  |  9 +++++++++
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/includ=
e/uapi/asm/termbits.h
> > index 4321322701fc..0da2b1adc0f5 100644
> > --- a/arch/sparc/include/uapi/asm/termbits.h
> > +++ b/arch/sparc/include/uapi/asm/termbits.h
> > @@ -10,16 +10,6 @@ typedef unsigned int tcflag_t;
> >  typedef unsigned long  tcflag_t;
> >  #endif
> >
> > -#define NCC 8
> > -struct termio {
> > -       unsigned short c_iflag;         /* input mode flags */
> > -       unsigned short c_oflag;         /* output mode flags */
> > -       unsigned short c_cflag;         /* control mode flags */
> > -       unsigned short c_lflag;         /* local mode flags */
> > -       unsigned char c_line;           /* line discipline */
> > -       unsigned char c_cc[NCC];        /* control characters */
> > -};
> > -
> >  #define NCCS 17
> >  struct termios {
> >         tcflag_t c_iflag;               /* input mode flags */
> > diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include=
/uapi/asm/termios.h
> > index ee86f4093d83..cceb32260881 100644
> > --- a/arch/sparc/include/uapi/asm/termios.h
> > +++ b/arch/sparc/include/uapi/asm/termios.h
> > @@ -40,5 +40,14 @@ struct winsize {
> >         unsigned short ws_ypixel;
> >  };
> >
> > +#define NCC 8
> > +struct termio {
> > +       unsigned short c_iflag;         /* input mode flags */
> > +       unsigned short c_oflag;         /* output mode flags */
> > +       unsigned short c_cflag;         /* control mode flags */
> > +       unsigned short c_lflag;         /* local mode flags */
> > +       unsigned char c_line;           /* line discipline */
> > +       unsigned char c_cc[NCC];        /* control characters */
> > +};
> >
> >  #endif /* _UAPI_SPARC_TERMIOS_H */
> > --
> > 2.44.0
> >
>
> Ping. Could we get this merged please?

Ping again. Any response from a SPARC maintainer would be appreciated.

