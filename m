Return-Path: <linux-kernel+bounces-55005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A437584B627
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54620281EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB412F399;
	Tue,  6 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw2DzfVz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6412D15B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225421; cv=none; b=ecDyCWtpCuwLkcz2vA0istjmsQ+tVY5lQN5IIv/b+46MMII6QPHStw8VfaQGuNOmQPmNqWh3frw/9jSCTd6GStJtthow3taMWS09WbfaYo9VJ4IUuOBemZZ+6l9VHg1jqDBPrJPXHjgumnLvAe0mMZAgjfgIPQ7yzwN1GPD4l+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225421; c=relaxed/simple;
	bh=HXxhJVAyHx/W37xVN/24XsRqORi0igd6ghovLD/bGLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=A++2VFmujnDH8JSkKxTjnJv5YPjPgJmxEUipfJf48bja6exnOomCJnWP1ivIOfyX4cCY3bFJq9HiMnc9GeLJFFgew+tLDLdQj7IxSYRjSaMPnJpYPzgzbg/z/X9tma0vhgHevEUuKZBMY6X4Smu+d7tpeYRfNV8bKZPp2zGXeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw2DzfVz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0523fbc27so745638b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707225419; x=1707830219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su9eLQyozGoYwvsgPziPXxeHO+JNdUgx8LdusrIXvt0=;
        b=hw2DzfVzsNhpaCRlq8zOE6b9rINxCQAyGsvbOxbKrnouH9RBuDkbbLva0+ElSSV9oP
         DqOpdEcLlJOI/zbknWvO9t4R6I5OdNymHfQkCpXQYbOiplrdZK+/C6VWqdyZyuxW4O8+
         NMyk+RhXVRPvf9DbLc7F7wYx3nKotv+7641zDxxwmCBYzU0I7WSzIpbalnz9nngIYerD
         c7Ir7U2ylgbJ2UAciosJvYZZW/Z+MPchb3/QtHlCXrCLAxXCD4cGqqwDM6zhkmjLvWgT
         YU4UC3KdhP7Ee/omAVL9xsxEM/8CeduiBXuYMi6oLzpsiVP+7du6f0ERBpdEtAmO3+rI
         14fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225419; x=1707830219;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su9eLQyozGoYwvsgPziPXxeHO+JNdUgx8LdusrIXvt0=;
        b=EAbzu9C5y3um53LEB6OD7iYtB22jLHM/cxXmt7PYnZeIE0TlFIYW6gn+/61Vwwvdb6
         31PDGEMkS/ltgpDhi0GfTT2Llplo/K621zbTAO3UUiDe8P1RJKCFrX864GhESO1kx28s
         qUZvd4DCVqDfvZPbzjfFtn39Hbou+l5J2jEMpwP7Z+DA5Fk3qZzy+CM8BwfEf29xYV/V
         Rww3osxzVgH2/2iKoyTOQCeSC5o/iO2PGfS+Fp5NsxuyIeJ1uRP36CVqFinIlJKBsdRv
         JxjXCaJNSN3pfkEOKs/mj0guyGv1GkjFYyvEKOeDNnV3mqG0TrSbNGiESLGy/2bpQOYX
         vMlA==
X-Gm-Message-State: AOJu0Yykg3/lehMk+7khYhagPuKt2p8q+JkbT71oX6E8ygQQ30SOQGU3
	S1uaiDOuimWzAm50K6vwrqw6z5d3l5B4a9vGzNZKvmjMRiotK7eKfzaV3hW0t5X9eta+XRq6UIE
	r0GZRYN89EmRlam+qWPRM1MZ6GA==
X-Received: by 2002:aa7:98c9:0:b0:6dd:c1b4:2643 with SMTP id
 e9-20020aa798c9000000b006ddc1b42643mt1926605pfm.28.1707225419139; Tue, 06 Feb
 2024 05:16:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191808.998754-1-frut3k7@gmail.com> <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
In-Reply-To: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 14:16:47 +0100
Message-ID: <CAKEyCaBnxumU0otxbtzAqLqUN+n5+qwWuvfNGCJa=rCfzE=ibg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:37=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Feb 05, 2024 at 08:18:05PM +0100, Pawe=C5=82 Owoc wrote:
> > Add compatible string for Qualcomm spidev device (used for QCA4024).
>
> > --- a/drivers/spi/spidev.c
> > +++ b/drivers/spi/spidev.c
> > @@ -710,6 +710,7 @@ static const struct spi_device_id spidev_spi_ids[] =
=3D {
> >       { .name =3D "spi-authenta" },
> >       { .name =3D "em3581" },
> >       { .name =3D "si3210" },
> > +     { .name =3D "spidev" },
> >       {},
>
> Why?
>
> >       { .compatible =3D "lwn,bk4", .data =3D &spidev_of_check },
> >       { .compatible =3D "menlo,m53cpld", .data =3D &spidev_of_check },
> >       { .compatible =3D "micron,spi-authenta", .data =3D &spidev_of_che=
ck },
> > +     { .compatible =3D "qca,spidev", .data =3D &spidev_of_check },
>
> No, this needs to correspond to the hardware being controlled via spidev
> not to an implementation detail.  Any new compatibles also need to be
> documented.


The device for which I want to add compatibility is originally used in
the router and this is what the dts fragment looks like:

    spi@78b8000 {
      #address-cells =3D <0x01>;
      #size-cells =3D <0x00>;
      clock-names =3D "core\0iface";
      clocks =3D <0x03 0x5c 0x03 0x54>;
      compatible =3D "qcom,spi-qup-v2.2.1";
      cs-select =3D <0x02>;
      dma-names =3D "tx\0rx";
      dmas =3D <0x06 0x12 0x06 0x13>;
      interrupts =3D <0x00 0x62 0x00>;
      pinctrl-0 =3D <0x08>;
      pinctrl-names =3D "default";
      quartz-reset-gpio =3D <0x09 0x15 0x01>;
      reg =3D <0x78b8000 0x600>;
      spi-max-frequency =3D <0x2faf080>;
      status =3D "ok";

      spi@3 {
        compatible =3D "qca,spidev";
        reg =3D <0x00>;
        spi-max-frequency =3D <0x16e3600>;
      };
    };

The first part has already been added:
https://lore.kernel.org/all/20231123121324.1046164-1-robimarko@gmail.com/

According to this commit, Qualcomm use this compatibility:
https://github.com/dissent1/msm-2/commit/d6160218393552fea1b7973787f2bd154f=
870ee2

>
> I'm also missing patch 2 of this series so don't know what's going on
> there.


The second patch was sent only to the devicetree bindings project:
https://lore.kernel.org/all/20240205191828.998783-1-frut3k7@gmail.com/
It's probably done wrong...

