Return-Path: <linux-kernel+bounces-43412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075B841388
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B461F27AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01852E3E3;
	Mon, 29 Jan 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hwuprVcp"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F448790
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556719; cv=none; b=WbtRX1nnWV5oMHD+XvVYMz4FPAzNiqms8iNbva6hCM1j5XqK4yFk/KXsBGxNa0odgNLGA4JyFu7hVjbbCVviAw0ix3pplNzTvTsWT1+UZk5lRqnluJOwB+jB3+r0j3uJj3Oi5c90NRrOSLhoLRzs8B+xesJ49WX5bjWA/s/BPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556719; c=relaxed/simple;
	bh=IsB9JY/4AyjDEDK/QCSn5bRVf6sdMPgHiV31yELbmAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi8/1wHp02h3/QA/fQqc5NbFYsgUAPXAOfx5jut+OWE5wKwgrOGlDtBoX4Q39PDpC8rqLScdfK5pbpFI1pL6kkeHXqaq5FdasMC14FGz5k5LmlkNOM798RpRQ1t2Kbd3aqD3pSuT758shaZ7uFAtIaU3josEcNmF8TWqdKSCNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hwuprVcp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so35137821fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706556714; x=1707161514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ9m1/F9S8yFHzEc2XLsfrTvCTLg95PwiYcPzfrZs1Y=;
        b=hwuprVcpL9KbL5FWEvgOzJ4WtD49Z2mB3cqO+9mVuZVtjlzyWzQQMgnSwvyXNUPdnI
         EIJn3awvfliePFHZFa8+Xk3vhQbmX+FmhyCnctkOg5ussmt9xBIo9LZ6ROpckJHrs9eM
         Gb1gLALA99MuyXxCf8a3S7upXv8CI10nwm7tXr9eFEWpcgHMzaEC3CJbx5IV0ucLQ+Qh
         /SSqdqK4a6AerB3xDbQw5KsTfPDzsAYj68fXmFONqrquhj3WU3lCzikZrJ4E5bEnMeAd
         Z38FBzsCGcznkbDIbX1uy7hMmoaW8xsvHzU139vedKXagsSc2l89Tmle/U/9FMoUlx+c
         l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556714; x=1707161514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ9m1/F9S8yFHzEc2XLsfrTvCTLg95PwiYcPzfrZs1Y=;
        b=htmQyFciiqM/yXnJ3Ku3uLflaLj3cuF164yHtmmcGwK+khuDkRtfGvIiDs6o18oiwC
         KN23I+lvB3eUMZVgzXlnfZlF6pSzH+wFG15a8voaOuUNMuQAcMOFD/sG8qKRvO4wpV4w
         o8T55CAnQ18W/lqYHd4F84uzkKpHyGqRzQnX0OZ+gjXqvQWcsbdMIPceFIZqd6lKQlcu
         0T2G48WlguF7OsxGSdrs3F7l+nziOLKX3kfuP59DitxopDiAosWGbSri6FF22dz+25js
         /RC9S1m+fEdyo0nTYcYYnkEy5PwN8xdKSzMah5Co72ZKWnyvbmmb7PPcpRxG8zM31Kyn
         iogA==
X-Gm-Message-State: AOJu0YwPt6p4eccONK5GXUJFIGsDRlR1ELUIlgtJjrdeBiq9kD/DfvP6
	g5CER4nQrcegk65xwY97iUZZ07ERMX5kCOo4JZ+ARQCotb4sjN7UFtUeJln37sYiQ4heQvA303f
	G3ZUBhh9/znZrQHKTplaKTk5LDQGWAcdG51sqCzdG65d+gIXz
X-Google-Smtp-Source: AGHT+IGlu3Tiw0qfV0S0tzXwqX/DkfK4vLT52WlR8EOqoCU/BIhR19RaJuUD1vdzsC5LVh4+FOq0hRyfxHc6Io8v9Jw=
X-Received: by 2002:a2e:a99e:0:b0:2cd:fafe:1893 with SMTP id
 x30-20020a2ea99e000000b002cdfafe1893mr5696137ljq.4.1706556709852; Mon, 29 Jan
 2024 11:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129174150.655088-1-dlechner@baylibre.com> <20240129174150.655088-3-dlechner@baylibre.com>
In-Reply-To: <20240129174150.655088-3-dlechner@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Jan 2024 13:31:38 -0600
Message-ID: <CAMknhBGEm6EOFf17xiYf0+h0JNS-NtfW3GnpsUc9e8PxCZ7tVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: don't use bool in FIELD_PREP
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:43=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Although this technically works, it is better to avoid using bool as
> a bit value.
>
> Fixes sparse warning:
>
>      drivers/iio/adc/ad7380.c:353:34: sparse: sparse: dubious: x & !y
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@i=
ntel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 44b8b18ab213..a4aa0db47720 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -350,7 +350,8 @@ static int ad7380_init(struct ad7380_state *st)
>         /* select internal or external reference voltage */
>         ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
>                                  AD7380_CONFIG1_REFSEL,
> -                                FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->=
vref));
> +                                FIELD_PREP(AD7380_CONFIG1_REFSEL,
> +                                           st->vref : 1 : 0));

Somehow managed to introduce a typo between testing and sending. :-(

Will send a v2 with the fix.

>         if (ret < 0)
>                 return ret;
>
> --
> 2.43.0
>

