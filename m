Return-Path: <linux-kernel+bounces-66695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED0785604D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00A328401F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129F1386AC;
	Thu, 15 Feb 2024 10:41:01 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5144131E58;
	Thu, 15 Feb 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993661; cv=none; b=MGqVU6jrtksn6f1IIEu0Sk61KhN1VCRSyIizbjgSArsnq5hoFMqjQyPpdTsgtcB1ILhHaJmkP4YrrliSmL6+l64vUVO3BwzZ6wCxfPPub4JhsFv6E21qt56WBqeii2VxxMNf6c+VVw3RjzfanShztZXr1criHJWic2+ZTgGOMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993661; c=relaxed/simple;
	bh=Y/NM07+ec8X945QyavCo9A6gSVvDgYuzRMM4zril0OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ5sn/n4SQVzeQFkhfXd8suh3St9EFitCL4oJqkjyktRaSSeGur3IVSmp3wtA1qlUg26FzjbjE+xnN19+L6u2JWBaE56YzsAoOZfNpR9McSITvqScE2jojcVpFXGRfgH/dCVdgGiWsS5V/1Fgy7ENqiOJuQKHsWkII0jjobDj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607dec82853so2036107b3.3;
        Thu, 15 Feb 2024 02:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993658; x=1708598458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o57CBG8kxGbBsN3aPo1NEC+C0U+G30UcOmuYFLRG5FE=;
        b=AbsSVirNgIKB7dEors/J5DIZnT9s4zcZaPaOfqa+ImOD85ZPXPLTdK1fvg6ci40AWE
         THTGtnmrDd4W11CyIdR3oTiN4ngotBm7VBOT8WWJWlpu8B9BFhay1nbcA6OweC9/D8dK
         lBh1SfCMkH9qyEJPax/o5E2No21gw2IqJ06OohN6mpxxzZo8GpKPeCOZ+8QlOmj0A1wO
         UprHS0EsBpcXXBWn0uOrGNgv3iN2vwGvfFiik/gNxAJ+JXxY1SBKtYoAGU6gPZ2IWtEk
         343lRPopqtF+TeUmlLVX1iz83Pn6TytSF6Tq4kijlOx60U8QizdL1XY+IikRj6R7aI4g
         QqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHZv4dIED/0CggRilhOPds+M2f+s+dg4wT7Ociet33fM+QS1HCaNJtlQ02RXu+rTkbAny5EKKc+z6tIj03HFtM3bSF58RGt6aboIqB
X-Gm-Message-State: AOJu0YyraAXEu7SL2h2X76t57uvcq5+FxoPA4rqZbKssJkLvHV4KfBtK
	W2QgFJSpMpxL6qoKFgm+Dw1UOYbnzEzGx6fz02X56S6SCuxkpD9R4nYR5/sl3fFYag==
X-Google-Smtp-Source: AGHT+IEHf96BeW0BIv4Njrjh4PAwlj3UkutpCOGzr6rypxE+ZTQfYmR8LEmQYwbw8zWq5RSaPRS/HA==
X-Received: by 2002:a0d:dd03:0:b0:607:8177:660 with SMTP id g3-20020a0ddd03000000b0060781770660mr1258057ywe.47.1707993657954;
        Thu, 15 Feb 2024 02:40:57 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x35-20020a81af63000000b00607b53565afsm187744ywj.97.2024.02.15.02.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:40:57 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so619249276.1;
        Thu, 15 Feb 2024 02:40:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtgnUZEmipl7sJyPHH17DAmN7JclgfOPTGYojVLf1TxHu/1TVaFWka9/nczJmpZWZ3joZvTeaZRaikL//WjlWjXyV1a3G/+j+99ugq
X-Received: by 2002:a25:ced3:0:b0:dc6:a74b:f200 with SMTP id
 x202-20020a25ced3000000b00dc6a74bf200mr1238211ybe.38.1707993657261; Thu, 15
 Feb 2024 02:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:40:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
Message-ID: <CAMuHMdVtqWBi4Y1tj74m4V4kp-3cFe_FphKKeY7zOkrbMVkKRg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] auxdisplay: linedisp: Provide a small buffer in
 the struct linedisp
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There is a driver that uses small buffer for the string, when we
> add a new one, we may avoid duplication and use one provided by
> the line display library. Allow user to skip buffer pointer when
> registering a device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/line-display.c
> +++ b/drivers/auxdisplay/line-display.c
> @@ -330,8 +330,8 @@ int linedisp_register(struct linedisp *linedisp, stru=
ct device *parent,
>         linedisp->dev.parent =3D parent;
>         linedisp->dev.type =3D &linedisp_type;
>         linedisp->ops =3D ops;
> -       linedisp->buf =3D buf;
> -       linedisp->num_chars =3D num_chars;
> +       linedisp->buf =3D buf ? buf : linedisp->curr;
> +       linedisp->num_chars =3D buf ? num_chars : min(num_chars, LINEDISP=
_DEFAULT_BUF_SZ);

I think it would be safer to return an error if buf =3D=3D NULL and
num_chars < LINEDISP_DEFAULT_BUF_SZ.
Else a careless driver that doesn't check linedisp->num_chars might
overflow the buffer.

>         linedisp->scroll_rate =3D DEFAULT_SCROLL_RATE;
>
>         err =3D ida_alloc(&linedisp_id, GFP_KERNEL);

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

