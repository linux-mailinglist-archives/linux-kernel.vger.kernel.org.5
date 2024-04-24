Return-Path: <linux-kernel+bounces-157184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9FA8B0E06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCEB1C23C42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326616130C;
	Wed, 24 Apr 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzcVnCJQ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140E15E5CC;
	Wed, 24 Apr 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972081; cv=none; b=XJVjvA7WVLJJLPVaVHZypejNvVrs5FEl9OqTnuZ6vm/6NmjGHr26QoXSKY6xoP4JinTQRufRjnImZnTsH1fZuPw9c7FhuBFbDe/z+jS39LVVpRiGh58xsDJawheQnXb6ncuuusd28bq4S72RAxSMeLZ80U5eXVnkgCwK1sMv2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972081; c=relaxed/simple;
	bh=die5GEdR93SZJIrj+6mbvz6RS0d1bUoi/TXLw5RP8dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K5+nVxqiPT/AU8ow28gJ2Id69QLVwshDhULOHMhHfQnuexEENCDRAJX5V5EOF20PTOJwactcqZsqoD72p/W0UeO/gBK1P3Kc36Eu0TFG6YciTF1uUOQwvpjlTCyS5UeQliXiHEWyPoFYMJumAGJbL+zMKv+JWT7kqYUJdqEZIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzcVnCJQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5544fd07easo68366b.0;
        Wed, 24 Apr 2024 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713972078; x=1714576878; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xmbep3Wj2edBDGZAic+hg2xj7nE0C73pjSQNpMAXt4k=;
        b=PzcVnCJQAvQA2+mMxauGIo/XWcsm2/lUw9jHxK04kGnPaFPao/T/FX3ABVeiSfuxfc
         MHN1rl/bVzfvAbe4YcsatEpeHggf/ZlXEFW0jnNHu1ltvYApUUf+eSZV5N+gb28/rZAp
         nRoyotu5LkjRvYj7fm/iDul68jbEaAKgVs1oYGrZKCbYkByvmDLnd0Q2lkfcyHeVrNdy
         JMnR6BiL6Jj+Zgf071z1c5CGIrlboSFCTxFEDFmy5SivkDJC3rsojQJy+cCD+0OoBPdE
         CtGrUHd+HijWBvaFcGbCV+CFFxS///qpFBgLmUykhLpkDNR7Z2DGbEdxHPdIyB/lZOvL
         6KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972078; x=1714576878;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xmbep3Wj2edBDGZAic+hg2xj7nE0C73pjSQNpMAXt4k=;
        b=APm3X8J+xn9KNMRrot3OCMRniImNGxsMjQ6eVpwWPGrOWeJMERm5oIBS0BrTUy/wnC
         iDVt56oIgPUv8R/Ne7XQCwGN+Yi9S7ZqkZfwu7lLJAz9/msU22sbSActxTeb+PfqBzjJ
         Ya8knfcm5TK1+S1BFn8ORacv2iEEU9IdJ2pgqzc2igGUiBsmeZVrwEwTP4U2nCBDm4DF
         DaDYL2G4MPC3vClOybFjbeBO1p3y1yQ6QVf09cbDR8h6F0CriKWM6JTNbvB9JSl69vlZ
         QpfSoMV+5JRot6MUGi1tgmInsCQsA/kCJY7ACTuZklukcFPTtJXOfX2Jc48CAPGfph1R
         PEnw==
X-Forwarded-Encrypted: i=1; AJvYcCVD6nZuGLylKNp+Y+2beVV9s7YCIg+aFV2QPnQyAkUj1vh3LdVaTyh5uTZ1GUyS7EuoxtcVgJTOXizE7ANN1LOP6hYHa9hr9SRaDHdXOB12Ao/rsEkmG+x5tLooWvpeV0OZ3g7OEYrEFDJc85TdIBSm5Qd3tRCueVg+zcRQWtX9y4NJBd3IZtkGaO0Tn222wgsnce7rrQl5cVwNbfTZep/J
X-Gm-Message-State: AOJu0YxPup5VvkeYN0hcwo/+K6Tb5uOdBS+f3aDa4uBBzYT/LDbWI3Y9
	Vf9jGvcLhfS9L2R17iQoSq1Fad9Jrsi49Bq+loZnJQ5fPsyuZel/yQnFIKUDmjSkvlSA2wBhJLV
	79G1Z1g+bU1KLDuNwOZhjqiyXhTQ=
X-Google-Smtp-Source: AGHT+IGQUEPZE3TBNrB7jm9cFv207FSC0kpyhsF+3dnUvHUba9LKAV3qWkn9Wz5L3PgDviOeIm6K6r9u4HEv/wd6LO4=
X-Received: by 2002:a17:906:308c:b0:a51:8d60:215a with SMTP id
 12-20020a170906308c00b00a518d60215amr1836143ejv.27.1713972077907; Wed, 24 Apr
 2024 08:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423223309.1468198-2-aren@peacevolution.org>
 <20240423223309.1468198-4-aren@peacevolution.org> <CAHp75VeRDSPvpmSbUyZPp0RMoTOE193U2ma18qxv_qZQKLCq8g@mail.gmail.com>
 <5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
In-Reply-To: <5qqil7ltqhdeabml6toqpcy773uhjxgwaz3txpy4kv4sz55o2y@hmar674eey7s>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 18:20:41 +0300
Message-ID: <CAHp75VdR9HtWbSif+j8QHX5zG9xPF1GzUFY2s-0OjD3RAWD9-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aren Moynihan <aren@peacevolution.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:59=E2=80=AFPM Ond=C5=99ej Jirman <megi@xff.cz> wr=
ote:
> On Wed, Apr 24, 2024 at 02:16:06AM GMT, Andy Shevchenko wrote:
> > On Wed, Apr 24, 2024 at 1:41=E2=80=AFAM Aren Moynihan <aren@peacevoluti=
on.org> wrote:

..

> > >         ret =3D stk3310_init(indio_dev);
> > >         if (ret < 0)
> > > -               return ret;
> > > +               goto err_vdd_disable;
> >
> > This is wrong. You will have the regulator being disabled _before_
> > IRQ. Note, that the original code likely has a bug which sets states
> > before disabling IRQ and removing a handler.
>
> How so? stk3310_init is called before enabling the interrupt.

Exactly, IRQ is registered with devm and hence the error path and
remove stages will got it in a wrong order.

> Original code has a bug that IRQ is enabled before registering the
> IIO device,

Indeed, but this is another bug.

> so if IRQ is triggered before registration, iio_push_event
> from IRQ handler may be called on a not yet registered IIO device.
>
> Never saw it happen, though. :)

Because nobody cares enough to enable DEBUG_SHIRQ.

--=20
With Best Regards,
Andy Shevchenko

