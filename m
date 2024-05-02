Return-Path: <linux-kernel+bounces-166607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B78B9CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA32E1F22D3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C51553B2;
	Thu,  2 May 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXMAOQBT"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEA15534B;
	Thu,  2 May 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662038; cv=none; b=oUZDAPyE5fqSAk+WTLtumQO/bdaGcyx8wcLDBRn/dSghIC3fC9udC5x6qPWTsDS36HYJgiLlJYA+tJIW8Zrbr5t7KgKaYhXdbvulVpsUfljvSywRfDYoLzPMKosGeWG562kKRIOML2eoOWVb9GxTMYMHVVozXqLcWWphmQ5W8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662038; c=relaxed/simple;
	bh=9i89iRnjbop0gjYQp2qlVcMZlLZzhMD7MQgIoE+aPks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8uy2pNxN6tpkHUUQCN7+yHPaPfo4lIIWLRknhxsRzl73NT5xL4+qsb9q+1nnvE/OEQLEwnFbyd2vCqAzyqRwsMChl0+5tkaZYajN01EZ8HuOVklxRtevlx8DOJs4n70+aP+uenSuTNQ6NhmvVA6Fd95ptuqXvqjwoqSnYWk8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXMAOQBT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso132141391fa.1;
        Thu, 02 May 2024 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714662035; x=1715266835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wth6UOWV0u78MclXNV5VaVOquIcqMmgS4fouTy/uY7k=;
        b=hXMAOQBT7y4/O1HoGLa5m74/tv3u53WDlSdpCHvab7GHK1bNS+rQfm+WxJ4sCMoYaw
         BKRKLqlZLrY8OkPzAp7XJzTUZ0XgjPAjlpqIgWrHu0xrJJOVVbCPhC2TGTaz+jhAuATK
         T2IMtfNaIZDOx96tX81uKtVOzSlgZ8s3Z/edxLU4q+M5KJpenVG+m5C3WyCF7H/R8aNS
         wZDGpVw2XW6YDlxCh5VCpJ9e4I0MkRv40oyzcjh1Mw6qFCypdZAcVA0anYloVfA1W4+J
         hzmxiLtM9RWSsMUqZdLD2tpE98pmjEKdiHwHs0eFs9s7tK5f/EbQjICKBbNiO7LPMsH+
         nhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662035; x=1715266835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wth6UOWV0u78MclXNV5VaVOquIcqMmgS4fouTy/uY7k=;
        b=LUTeH4Da58ElgClvRmx+Z3oavlX/yETpWnU9CiGpL+j0qblBBXepA2xDOLWMcEiPHz
         t9+T0+ZD7dExO+YfA+w4IiZrvvEVm8DzeuvS6NYsReVhfU98mkZ+sH8mGfYTf5GIOJlW
         erES6s9m0knB6HnuIo/V0it/dr5opPFmG3O6pEO/CxQbqHBhYqmUrwgBF/gaMG+LSqY4
         /W56100o56UmoA1NpemqXH7+yW8CdNjWjZKIq1nwY5LyVyl3OfmSdNmeHX/+bbZD/MwM
         Z2P5l7rfdh509NUunPjjw+qJfTPPOsK+Y/HIp8RAE5ntOPaqn6yKbtnCN6FzSmEsTILs
         pjmg==
X-Forwarded-Encrypted: i=1; AJvYcCXQgNxU/eLNrJyy0Fc8VYqpaNAsEI6Ijc1bb5Jj1c3ydVK8uhBkpMxiHfW86z5pJIeFVGCuZPPfv3hjrlOFbT3FbGY5eFjFMeotP+t0/e00P9R/iaWTMQU7zSdNZ+IWtHefD2KZhIge8+Ez26k2
X-Gm-Message-State: AOJu0Yx9uVCWmGZ2N2kcsC8sDqWBEw1Lnj+y5wk241O/J/sptohgbDov
	K1da35Ic+m9QcDSyszbZ//E82RGjDiicBi51IwKlfAJ085ApRnuh1UBqenU7BAV5HqZRmMaAcAR
	DNDlh7CXVFhxcQ2bREuZCqpGRfnQ=
X-Google-Smtp-Source: AGHT+IE6WrpRa6ZV58hADd9Jh1SV0I2pEy3c6uP9Ip7bCShs7bFdRltxN+XqVYkrqwF12XRbfUDfG8AUV/BWWV45DBg=
X-Received: by 2002:a05:651c:2106:b0:2d4:5370:5e8a with SMTP id
 a6-20020a05651c210600b002d453705e8amr5558471ljq.22.1714662035148; Thu, 02 May
 2024 08:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502141359.89567-1-harry021633@gmail.com>
In-Reply-To: <20240502141359.89567-1-harry021633@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 May 2024 17:59:58 +0300
Message-ID: <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] string: improve strlen performance
To: "Hsin-Yu.Chen" <harry021633@gmail.com>
Cc: keescook@chromium.org, andy@kernel.org, akpm@linux-foundation.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:14=E2=80=AFPM Hsin-Yu.Chen <harry021633@gmail.com>=
 wrote:
>
> Port `strlen` in gcc,

This is the Linux kernel project. What does this mean?
Also note we refer to the function as strlen() (and no [back]quotes).

> which enhance performance over 10 times

>
> Please refer to these following articles
> 1. [Determine if a word has a byte less than n]
>    (https://graphics.stanford.edu/~seander/bithacks.html#HasLessInWord)
> 2. [Determine if a word has a zero byte]
>    (https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord)

Make these proper Link: tags

Link: URL#1 [1]
Link: URL#2 [2]

..

> -       const char *sc;
> +       const char *char_ptr;

No need to change the var name for this.

> +       const unsigned long *longword_ptr;
> +       unsigned long longword, himagic, lomagic;

Keep it in reversed xmas tree order.

..

> +       /* Handle the first few characters by reading one character at a =
time.
> +        * Do this until CHAR_PTR is aligned on a longword boundary.
> +        */

/*
 * This is the wrong comment style. You may
 * use this example.
 */

..

> +       for (char_ptr =3D s; ((unsigned long) char_ptr
> +               & (sizeof(longword) - 1)) !=3D 0;
> +               ++char_ptr)

This is too verbose (too many unneeded symbols) and why pre-increment?
What is special about it?

..

> +       /* All these elucidatory comments refer to 4-byte longwords,
> +        * but the theory applies equally well to 8-byte longwords.
> +        */

Use proper style.

> +       longword_ptr =3D (unsigned long *) char_ptr;

No space after casting and why do you need it?

..

> +       /* Bits 31, 24, 16, and 8 of this number are zero.
> +        * Call these bits the "holes."
> +        * Note that there is a hole just to the left of
> +        * each byte, with an extra at the end:
> +        * bits:  01111110 11111110 11111110 11111111
> +        * bytes: AAAAAAAA BBBBBBBB CCCCCCCC DDDDDDDD
> +        * The 1-bits make sure that carries propagate to the next 0-bit.
> +        * The 0-bits provide holes for carries to fall into.
> +        */

Use proper style.

..

> +               /* 64-bit version of the magic. */
> +               /* Do the shift in two steps to avoid a warning if long h=
as 32 bits.
> +                */

Ditto.

..

> +       if (sizeof(longword) > 8)
> +               abort();

Huh?!

..

> +       /* Instead of the traditional loop which tests each character,
> +        * we will test a longword at a time.  The tricky part is testing
> +        * if *any of the four* bytes in the longword in question are zer=
o.
> +        */

Proper style, please.

..

> +       for (;;) {
> +               longword =3D *longword_ptr++;
> +               if (((longword - lomagic) & ~longword & himagic) !=3D 0) =
{
> +
> +                       /* Which of the bytes was the zero?
> +                        * If none of them were, it was a misfire; contin=
ue the search.
> +                        */
> +                       const char *cp =3D (const char *) (longword_ptr -=
 1);

> +                       if (cp[0] =3D=3D 0)
> +                               return cp - s;
> +                       else if (cp[1] =3D=3D 0)
> +                               return cp - s + 1;
> +                       else if (cp[2] =3D=3D 0)
> +                               return cp - s + 2;
> +                       else if (cp[3] =3D=3D 0)
> +                               return cp - s + 3;

> +                       if (sizeof(longword) > 4) {

  if (... <=3D 4)
    continue;

> +                               if (cp[4] =3D=3D 0)
> +                                       return cp - s + 4;
> +                               else if (cp[5] =3D=3D 0)
> +                                       return cp - s + 5;
> +                               else if (cp[6] =3D=3D 0)
> +                                       return cp - s + 6;
> +                               else if (cp[7] =3D=3D 0)
> +                                       return cp - s + 7;

A lot of redundant 'else':s.

> +                       }
> +               }
> +       }

--=20
With Best Regards,
Andy Shevchenko

