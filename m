Return-Path: <linux-kernel+bounces-153488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 118AB8ACEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3258B24D17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA8150984;
	Mon, 22 Apr 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlfi6QPn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B85028B;
	Mon, 22 Apr 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793724; cv=none; b=pmu4lXuOXDF+UsXjGBmK+t3UHHyxMbutfgqvpeXhzS+pGa0V6j8jphf9kB10yDXB7R8Y8t0P7oOUGNt3UQ23h0SUopvNQ86eUH77DD4t5gGed9AMlUBtbaQFWplg58y3/btWAnxoqdYWBVlROWocCHipdLDpiNhQ34yDGBky1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793724; c=relaxed/simple;
	bh=LA9NpgkN2YWBJpJx6+P7+pYt6WwKEiygjRfGrqXOsZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoDWPFn41H2YFSpj6R+zu7/h8dxz9AkYMiVN2HTyKWY6k8fmd1qQw6I4b2w699dpVtPdLSW4kF1ZMe+vFdJMVHds8pFO8XQfkeKtHOvE3xVeRpRprn0FiIFYGgtYsy1JNVDCYYBcDepIzmNB4QBl6eQqqILmSCOORggoDnwCeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlfi6QPn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5200afe39eso485868866b.1;
        Mon, 22 Apr 2024 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713793721; x=1714398521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA9NpgkN2YWBJpJx6+P7+pYt6WwKEiygjRfGrqXOsZE=;
        b=Vlfi6QPnerD5MeEd1FPOs8/w/TlrMnXTrIQcSyHeDklLgCfNP2gBeN9h5M106CWal/
         fBL8/K/lPLwjKOa30PYrp1zxDPht2G67jqUIohELg8+wJz5o5VbKRH1xGsdF6PDD95qj
         8EstCi1shnhwfpv6nuV+t1nD9OiWS0UhfLfoxlkXrhfDzLvqyy1hjU/cpRjG/ycuQMDE
         GO7FqnoBv5bpS0Lf5koPATybksf2RuKF1kdjGbanvVfW40wbSVamSFbpgw5PRsgaqcr5
         EVIbvjV8tMWc55xNqampUZ1tHrkRkPt36gbCllwEAdhd0C5pYEatFi3L8vr37K+WxdCY
         vdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793721; x=1714398521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA9NpgkN2YWBJpJx6+P7+pYt6WwKEiygjRfGrqXOsZE=;
        b=DIhKN+29osuto1wBrHr5Eb1aYDvoxJ8cfzKOd/SiCDGuHj41zFdW3V6ccyblmpR19h
         xrG5aBmZRg9eJQ4xWvpW/jkYUIvY7UOWbM1ix4+oD+KM5CTJeVxc6nHSmLyFjnt6Fe4G
         u8FSnNSBFg/SE6TY6g/xB6bNqZLOeZfxel5My01f7ctuwnnuTpLelZscyVX6lRGezrKo
         q8/Nx+BkG6hJVM9AXkATzdjN6S+BCvUOhZoElEWgZkW9Zx+ToLT37GiG7WAlgtY4aA2M
         rUFhp3iWNc+ipnSNKrVMKk52aXHi5O8Sll/RrbHD+DRokBwUmW5OqRqJsqC6JRT1skRw
         gGzg==
X-Forwarded-Encrypted: i=1; AJvYcCW1XwOK3cCOJcZCMaQnrlpe9aaDI0TTwBvTEGXHLHSB4Ti6XlU3fcu0AAWQlZHdlt92Nyc7wii7SEkylfljK1InqwK2dmoEXbp5Zt8j5HcZdWhVHhefHMrXQuZeXsY+GqUjndcJmexcNIg6
X-Gm-Message-State: AOJu0Ywz8pzUjHAsOZ1b+3VQJEjdtD7tHrhp7I1P4RCJPH4m9E2MZRqb
	Qs5jm/HWbr00qUps356m7987Zi9t+29JC/29emhVHVJBHgFafjgpLdd2Nw6FnNdkIfIvBQDyrPj
	OMusKhEhSwRT3vNLVkBYhjkP+c9g=
X-Google-Smtp-Source: AGHT+IEy13vNN2q9EzMOBwsWc3IbfmMAtNbtdv1gNuwjQ/ElweR5KDU5V1pgzEgg2hJsQxRWwWp9f5ZhkzAXjdDBoyk=
X-Received: by 2002:a17:906:589:b0:a51:de95:f592 with SMTP id
 9-20020a170906058900b00a51de95f592mr9376424ejn.63.1713793721421; Mon, 22 Apr
 2024 06:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422133219.2710061-1-ria.freelander@gmail.com> <e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org>
In-Reply-To: <e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 16:50:53 +0300
Message-ID: <CAF1WSuzqLxpxwYuNYfHyvXLDMBE-ZU69YLXwBdQokZzhs49xzw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] add support for EXAR XR20M1172 UART
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org, 
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, 
	corbet@lwn.net, ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, 
	Maarten.Brock@sttls.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andy@kernel.org>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:45=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 22/04/2024 15:32, Konstantin Pugin wrote:
> > EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > it has additional register which can change UART multiplier
> > to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > flag to guard access to its specific DLD register. It seems than
> > other EXAR SPI UART modules also have this register, but I tested
> > only XR20M1172.
> > Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > or "DLD - Divisor Fractional Register", calling depends on datasheet
> > version.
> >
> > I am sorry about too many submissions and top post reply. About second =
-
> > I do not know how to reply properly to this ML from GMail phone app. Ab=
out first - I just
> > get very good feedback from Andy Shevchenko, and want to fix his review=
 picks ASAP.
> >
>
> One patchset per 24h.
>
> Plus, you already got such review comment:
>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
>
> Just start using b4.

There is not only for tag. I submit fixes for version 4 by mistake,
so, repost to 7 was necessary, because v6 was not work (as v4). But v7
should be based on v5, and v5 is tested better around tty-next.

> Best regards,
> Krzysztof
>

