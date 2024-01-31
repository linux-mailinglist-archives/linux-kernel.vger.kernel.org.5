Return-Path: <linux-kernel+bounces-47056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2208448A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A25287FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0443FE2A;
	Wed, 31 Jan 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNqj7C2u"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8913EA9B;
	Wed, 31 Jan 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732275; cv=none; b=WkbZK+ke2ycMmTMbGT6+VfZYXa/GKSYEER3FvUV2Dvy1cM3K87BqNNCVQ76m+ToDW34HQ0Tawom8XQVo0dLM22RuxbEI+yCu7xSuWo75HOrPgLMGMtseWujHDUvBK3Axa6YB7Bd6CUJ3h0jsceGtZCmOUKUbPHbz1Mfj1hTRQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732275; c=relaxed/simple;
	bh=o4aiy10+fDl63wpHTMTWUdeIXhOIrgTQNnErR//DCa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQ6P/F/10d0asCSNlMsxsHoEzyK2g/hsbwXaR8MPWc2L7wPonXa8W/5tVFLdyx6Jle0zZNzYdB3hTXDajfiphP3T4IhxmlPOwyYszlsoiujBZZ2Oe2CDPVDncMw9Nwrt1n37nUNop7AaVTIl/1bkOs2x8yFohK1RpkiHR6PfR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNqj7C2u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a34c5ca2537so19474666b.0;
        Wed, 31 Jan 2024 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706732272; x=1707337072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3x+XA1EAM69Gx/EupL1JFa+ff5P92JTzUQLfIHSyz4=;
        b=jNqj7C2umhbQwYnppEXxjS+JktkmIh65SIcOTcACmuKgUkD554mp/8qoDr3xmNiDcK
         UlLen0VVAeguskRXqWmDHFsWJ6cC9KEL21YRvLMRtWYUFZ0dF86esxInVD8vhPbjPsdl
         YMZjb1zZIYEjJXqYMjSQf/jx1bo4VnZw0Im5Hzh7v4KXmMRwEDKTaU1+FjKivcpePsCm
         jsSdWuswKR5gT4JtjQgjVcd+W8pYemVl633gmHCa55LabHt3WIQNL/D4CFw1MMlb5vDM
         gvv86qAXYCRPvu/H9lExdGe1Iu2WII/eYQrn/pSTxA1yv1D70K2tt+em93swORvJOoXY
         P97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706732272; x=1707337072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3x+XA1EAM69Gx/EupL1JFa+ff5P92JTzUQLfIHSyz4=;
        b=o616j1q5ehiZrgH1IKYCQqkdzZyD5FWAsdISxdRHtzGkXM0RZnSa41cRUSk0QSRtNw
         sybKcA3vGLxuLJ31YkDQIKnBOWjDikX7WKIYKlA+nW8rCrp1uPDvHbSuXbzCOBYyYqgD
         Z2ffaj+3OLWhYygytiEoofImUbUr97K8YVwfbpDp8LX5Fm1QHpDF787nhstrY4WYwJ6b
         3MRx1T0jCuki34rsfA39fRDK83U+4Kfms+lEB7f6Z439E8LOBJ+KWVXcSHgkeD0STdlK
         cTXIEbvE8q0qj9D1tAR9ix9hqoifryp2vwQ+3x7KoRUDsp0uLcqztx5SsuQ24+ftF3Y8
         rm5w==
X-Gm-Message-State: AOJu0Yw7sL1usZZtUXzFZxScPdvzk3Wz6p8cYqwCiNrGu5kyylDFo1v3
	IVEere2ONCVJblvHVYoaz/nzda4EO3esbV7uGH5ziNyMFRtjhstJQy9J5hOWHGUgKUAprMlA9k1
	xd3c/Ylrdiqp+GYy3oHvuc558DAk=
X-Google-Smtp-Source: AGHT+IHXBrFCx5kQCeErdbREsugyHAfbuEbibVXq02hfcq1oPmsfcZZLGhX7hXPtFYvQEPMmWMEUtGyEiepFoY1c7mg=
X-Received: by 2002:a17:906:f2c6:b0:a35:85b7:560a with SMTP id
 gz6-20020a170906f2c600b00a3585b7560amr1946530ejb.46.1706732271649; Wed, 31
 Jan 2024 12:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-6-ckeepax@opensource.cirrus.com> <ZalahZkCrBm-BXwz@surfacebook.localdomain>
 <20240119114917.GB16899@ediswmail.ad.cirrus.com> <ZbpqPuDj/v07yZ5y@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZbpqPuDj/v07yZ5y@ediswmail9.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2024 22:17:15 +0200
Message-ID: <CAHp75Vda3nZn8KwqSRvKQL9oeH_PjTnDDPuQytJvTgb2_HDvBQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] spi: cs42l43: Add SPI controller support
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:41=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Fri, Jan 19, 2024 at 11:49:17AM +0000, Charles Keepax wrote:
> > On Thu, Jan 18, 2024 at 07:06:13PM +0200, andy.shevchenko@gmail.com wro=
te:
> > > Fri, Aug 04, 2023 at 11:46:01AM +0100, Charles Keepax kirjoitti:
> > > > +         while (buf < block) {
> > > > +                 const u8 *word =3D min(buf + sizeof(u32), block);
> > > > +                 int pad =3D (buf + sizeof(u32)) - word;
> > > > +
> > > > +                 while (buf < word) {
> > > > +                         val >>=3D BITS_PER_BYTE;
> > > > +                         val |=3D FIELD_PREP(GENMASK(31, 24), *buf=
);
> > > > +
> > > > +                         buf++;
> > > > +                 }
> > >
> > > Is this a reinvented way of get_unaligned_*() APIs?
> > >
> > > > +                 val >>=3D pad * BITS_PER_BYTE;
> > > > +
> > > > +                 regmap_write(regmap, CS42L43_TX_DATA, val);
> > > > +         }
> > >
> > > ...
> > >
> > > > +                 while (buf < word) {
> > > > +                         *buf =3D FIELD_GET(GENMASK(7, 0), val);
> > > > +
> > > > +                         val >>=3D BITS_PER_BYTE;
> > > > +                         buf++;
> > > > +                 }
> > >
> > > put_unaligned_*() ?
> > >
> >
> > Alas as it has been a while I have forgetten the exact context
> > here and this one will take a little more time. I will try to
> > find some spare time to work out if that would actual do the same
> > thing, I have a vague feeling there was something here.
> >
>
> Ok found some time to refresh my memory on this.
>
> The main issue here was as this is processing raw data for the
> SPI we shouldn't assume the data is a multiple of 4-bytes. You
> could write the code such that you used put_unaligned_le32 for
> most of the data and then special case the remainder, which would
> probably be slightly faster. But for the remainder you either end
> with the code here anyway or a special case for each of the cases
> 8,16,24 bits. So the code ends up looking much messier.
> Personally I am inclined to leave this unless performance on the
> SPI becomes a major issue.

Yes, the problem with the code is that it is a NIH existing API or patterns=
.
We have already in the IIO subsystem a pattern where there is a switch case
and put/get unaligned APIs per case. Perhaps this is what needs to be
factored out
for everybody.

https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ad4130.c#L47=
2

(some shorter variants)
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ltc2497.c#L6=
6
https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ad4130.c#L47=
2

Here is the abstraction for cameras, perhaps that's what ASoC might need.
drivers/media/v4l2-core/v4l2-cci.c.

> There is perhaps an argument for a comment in the code to explain
> this given it took me time to remember what was going on.

That's for sure.


--=20
With Best Regards,
Andy Shevchenko

