Return-Path: <linux-kernel+bounces-105610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA3B87E175
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A372814E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23861643D;
	Mon, 18 Mar 2024 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cssq6esS"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1210A34;
	Mon, 18 Mar 2024 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710723776; cv=none; b=ZbO0V5my40AXe8aPhRFiEFpyUuUnSIw+eN6Orm5DTFvYLBSa5TUBzUSA9lXLu64ij32a0+7rBxkTAV048eDFwunUE7tCcKghh5BwLtfnILtaZxSXJKI2a6saLvAB+5BqQyMaU7mJ5fgV4ZrkB7Ol+UmyGIYBOm5V1340EBg6HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710723776; c=relaxed/simple;
	bh=HYnHpQ5WS0uOZQHvof4CAA2amkH1vlLsf73xj39b0HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpDfPqPVO+zo2WU3qYNHcQoQHdJiOJHD6cTS8YDxh/BZIrdUbwFERcTSKPAWvxlHonUI+MB96I7Q59hshOEv5MlwOl5SQbEwtaNpQp2i2j16puXHfFb4/5QvQaYudw+poarmfNYi5pHGSARm09A6l+7c9gQgwwlRV5rfhca9YTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cssq6esS; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-366c26bd8cbso1547505ab.3;
        Sun, 17 Mar 2024 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710723773; x=1711328573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q057OV69lTu4ctPYW4hfEX8QoC9FK779RSSG++bu6xM=;
        b=Cssq6esS1N+VWLMHk20uOXb+pF4jtsJwzHyLHWAxOvZseU/zbAa0OQtstXtgpAaw/Q
         +/91SbV6dmANz8ekGQLb3X5mf6YsWCFtBoKSVRfA+C9yOlpnsfo6SGZWfFF4lnt7PNsn
         JsUPMHz3gEYxDfp4/kmEGk+m7cLp0u+bTkKYeKA7Gagv3P9r3OdUSe1sFmg945Jkc8iu
         wVbdG8VsO1h4j+SzjFRiRdjAvY/R6C629pv6c1wkIhr0JDVtb/0rZ/SCMY0xGOCCnlj9
         vOcXyi7uVlHedbqRLOk8kOJQVpfW5fX5R4zs2NggdNIY6rW/40OHmlDzVLRbgkJOtG4F
         hkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710723773; x=1711328573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q057OV69lTu4ctPYW4hfEX8QoC9FK779RSSG++bu6xM=;
        b=efKpc/EUZBCbDSqRG9w9DbwTFkMgY15BQFmIv9OwQyh49YumljynoHGD0qAAXBBts2
         8tNjjAtQKLm07aJk/304cUbPCDaZBwQT63c/0MQ9XTSpRWLisfEkSXGXvXmfNQs7KtLQ
         r54g31E+CgsrNV0FOvb1a9FjocU31ZPUHoQG24N/nS7tGjovNmw1/O0AG3luiYKnppMk
         gp9PDx+ahEs/1KpLBLBUR4+5lc433Sfi2N6PAHrmQy694mfgMubonAYJHWal/7CCgHUj
         e1jS+fBZalblhGw8HFY+A460H+G+zsCXYU5ZmYVa9FZdlHwFhVcMF4ES3g92cHJskmtP
         UIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJJaa083qH9Tafad2j/BYVtiEjWi/se37E32HSaq7P8zVvvihRu2d1O/6Y2j0YrHctOVc0wXhbQqTPhHVPxTqLFhTiGBWoIlwVYs2Q8i/SjsxvH3K0YOkYkxx9bEWIqyvzgjm8mTqCkJq2B6Pycw7jnK6PPM8/rU2rVAuZ4+0gouH6MTEhR2vM9+P+S8oyjTjE+AWwUVhINqDEcwiA80JJ
X-Gm-Message-State: AOJu0YwZkQIhN3q/Q+oinJujzJW+VA6rBcGHXStD3xLJUUFduH7z+BHJ
	NJB7s2xDrK2/AaORPsZ7Mb8RG6aCMf6LEsALVzex0+vrinvkb8zmPr3tcsTj3OoQlZGdxlYwF3a
	drypsS4j0emVhbxNVM1+FGYIfiS4=
X-Google-Smtp-Source: AGHT+IHgOcsuxrqW0t2XLKTOIxiWENVYN+gYwOfy3XkeKLpBv3+o5PftE+g10QYy+oHEGt9JsF/LRFsWvEdocg826T0=
X-Received: by 2002:a05:6e02:11a5:b0:366:95be:fdc6 with SMTP id
 5-20020a056e0211a500b0036695befdc6mr9347885ilj.28.1710723773618; Sun, 17 Mar
 2024 18:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
 <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
 <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
 <37e11daa-c24e-45b2-a22d-769693fd2038@roeck-us.net> <a93e2971-cafc-480b-b439-f42ed0838660@hatter.bewilderbeest.net>
In-Reply-To: <a93e2971-cafc-480b-b439-f42ed0838660@hatter.bewilderbeest.net>
From: Ban Feng <baneric926@gmail.com>
Date: Mon, 18 Mar 2024 09:02:42 +0800
Message-ID: <CALz278b7BeGoYunqh1Rs91N81sEnU_RDox3urqTb9CFX0ic5_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Guenter and Zev,

If there's no concern about supporting nct7362 in nct7363 driver,
I'll add it to the of_device_id and i2c_device_id table in v5.

Thanks,
Ban

On Wed, Mar 13, 2024 at 8:21=E2=80=AFAM Zev Weiss <zev@bewilderbeest.net> w=
rote:
>
> On Tue, Mar 12, 2024 at 04:58:12PM PDT, Guenter Roeck wrote:
> >On 3/12/24 16:18, Zev Weiss wrote:
> >>On Wed, Mar 06, 2024 at 11:35:31PM PST, Ban Feng wrote:
> >>>Hi Zev,
> >>>
> >>>On Sat, Mar 2, 2024 at 4:19=E2=80=AFPM Zev Weiss <zev@bewilderbeest.ne=
t> wrote:
> >>>>
> >>>>On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
> >>>>>From: Ban Feng <kcfeng0@nuvoton.com>
> >>>>>
> >>>>>NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
> >>>>>
> >>>>>Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >>>>>---
> >>
> >><snip>
> >>
> >>>>>+
> >>>>>+static const struct of_device_id nct7363_of_match[] =3D {
> >>>>>+      { .compatible =3D "nuvoton,nct7363" },
> >>>>
> >>>>As far as I can see from the code in this driver, it looks like this
> >>>>driver should also be compatible with the nct7362; shall we add the I=
D
> >>>>table entry for it now?  (Though I only have a datasheet for the
> >>>>nct7362, not the nct7363, so I don't know exactly how they differ.)
> >>>
> >>>As far as I know, the difference between these two ICs is 0x2A~0x2C
> >>>Fading LED for 7362, and 0x2A Watchdog Timer for 7363.
> >>>In my v1 patch, I indeed add the nct7362 to the ID table, however,
> >>>this makes it more complicated and our datasheet isn't public yet.
> >>>I think maybe supporting more chips will be done in the future, but no=
t now.
> >>>
> >>
> >>If the only differences are in features the driver doesn't utilize, I'm=
 not clear on how it adds any complexity.  As far as I'm aware, neither dat=
asheet is public (NCT7363 nor NCT7362), so if we're going to have a public =
driver for one, why not also do so for the other?  It's a single additional=
 line -- and furthermore, having made that change and tested it out, I can =
report that the driver seems to work just fine on NCT7362 hardware as well.
> >>
> >
> >"if we're going to have a public driver for one, why not also do so for =
the other"
> >
> >If you are trying to say that there should be two separate drivers, sorr=
y, that
> >would be absolutely unacceptable.
> >
>
> Sorry if that was unclear -- it was very much *not* my intent to suggest
> adding a separate driver, merely that we make the nct7363 driver also
> support the nct7362.
>
>
> Zev
>

