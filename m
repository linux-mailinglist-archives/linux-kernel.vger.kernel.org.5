Return-Path: <linux-kernel+bounces-80754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AC866C18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83CC1F23C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C471CD11;
	Mon, 26 Feb 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDGRSOE8"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AB1CA81;
	Mon, 26 Feb 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935965; cv=none; b=sTmqdHIG3rMIb1NTFpbPIjmhirW9QTYRQxh7YnSeLGRS4JJKWnWFbw29MU89zNcH8ushlyZ8TqhS22prFyKE05kTCMH2TrgUTmenVP4nm1TPPPbTPSIPGnT3lXnCNJBjz5mMb693rFg1JtW9CzaHOqgxMQNt28qofPiNihBW94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935965; c=relaxed/simple;
	bh=8aEYoORsIwQSwWsOthBtc3VFHs8XMlL/TLNLBS9ZIII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGql63F4vE+Vo4mtFJILvQIKFuMFVS7CM7kaNkcAWi78IGydgxnV+61VNE6/KaX/qXODQE/QG/r0OzyPTaRuCTeKSG+gx1S6FmLzB08bULRt09mBIjRSAauSZLxq1w9koHYlMV7GW0WVUpjihR1ezasLQhQqK6GrLi4mbmMKnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDGRSOE8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ee69976c9so336991866b.0;
        Mon, 26 Feb 2024 00:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708935961; x=1709540761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ttUCqTABwqmssEUu9Ok4fCv5vcEs8kW80tdvfui/rs=;
        b=iDGRSOE8zP8zpWOmAFdLZuGAdoJr2SXOzNNUJy8Z+3Qv+IY77Sh/lEVN+A3AeCL3FA
         27HU9dCqJBHxtwZJT1XGCbza9WAZuI9MmeuwzAOQ5kRwz1LKcVtUENC+H3V0CuDo2t0m
         XlzqvAiLDpmqZ/k+qiUi1uGcMajRp3QvNXB6ZKTphsP1sUq4q25LZhST4Kj7WrsmBJgY
         AOWnf9/+LJwRbLTUnaoqSWz2HVtAMuzT8Jovuc24jR+9ygdSSk6Y6oEwQMCZYvFW2iFI
         774LBpZ3J4uhX8ES0FzGXkUQZHOR9FP70okQEebW7RA8sxkcXXm4O8XQRzYikxed1ijo
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935961; x=1709540761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ttUCqTABwqmssEUu9Ok4fCv5vcEs8kW80tdvfui/rs=;
        b=Rjn3fE3NgNg4inYLvg8eeGHesHLodH0GE0OKLU6E1hbGr4HTKvir6DusleWeRCo4UF
         EKivyEnc8I1pUZS+bspni7PrpiRzUqOdEd/0UJars+UhX2pg+uIvFnXBWMwTIfTuVnzV
         TkCdm+uIxUnyTC4AiMP2O6h800muILdQuqdoDw/NygrLTA/BGRedSNhTnSl0wdqmdkrA
         PaVcY/0yYFKWOzOK+IOLEAZTqdCuZWdmnMKSHNsUplti0GOI7WuiLGouk9UM3P5WaSR8
         UeX0tQNXiRlJdMFo8/7q4D+aW4aWslyiB+NUOfDvcAfEcYQe55NugaiOiRMIIM9UKG2r
         Y4OA==
X-Forwarded-Encrypted: i=1; AJvYcCWTLqljXtUcwwGRIfBmf5ePlZdY75t43wMg7WUlG91cFUcZpOF9Vf/UnQSErom7DWN6ul1NFzQPw3p97ErKTHBor01L+P45XGeih33HFjhfbFay8ZyR74hYyN10+IHYFjlVg+iDykul12PzH4BU7ylVbQoNV8Ui95zRNGTp+XJc0/WP/Q==
X-Gm-Message-State: AOJu0YwoSUSMir7pKuhH3vlOfr5f6Lw8Sa8toIy1h/vNlujs4MxNjkSZ
	xIhMZhEFkQUQDrSo9qMFYPgjjWyn8TUvWAHvEPx/oiO/np75I3Go
X-Google-Smtp-Source: AGHT+IHfZDix/7vs3eLadAmGpaat3fXEVGE5oqibwXpzt5hRoNLjvHxb0Sk87Iw4q5y1UDLbp4H3Rg==
X-Received: by 2002:a17:906:140f:b0:a3f:c932:9c67 with SMTP id p15-20020a170906140f00b00a3fc9329c67mr4078407ejc.68.1708935960718;
        Mon, 26 Feb 2024 00:26:00 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a43389c8a1asm1057465ejc.113.2024.02.26.00.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:26:00 -0800 (PST)
Message-ID: <2dbc4a0faaef7f4b7d1cd7d46c75e30fb563b227.camel@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: amplifiers: hmc425a: add support for
 LTC6373 Instrumentation Amplifier
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Date: Mon, 26 Feb 2024 09:25:59 +0100
In-Reply-To: <20240224175448.484ccd10@jic23-huawei>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	 <20240220153553.2432-6-mitrutzceclan@gmail.com>
	 <c92c4c71f433c7375588e832d3c084a50190a1b5.camel@gmail.com>
	 <20240224175448.484ccd10@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-24 at 17:54 +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 14:23:51 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2024-02-20 at 17:34 +0200, Dumitru Ceclan wrote:
> > > This adds support for LTC6373 36 V Fully-Differential Programmable-Ga=
in
> > > Instrumentation Amplifier with 25 pA Input Bias Current.
> > > The user can program the gain to one of seven available settings thro=
ugh
> > > a 3-bit parallel interface (A2 to A0).
> > >=20
> > > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > > ---=C2=A0=20
> >=20
> > Just one minor comment. With that:
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > > =C2=A0drivers/iio/amplifiers/hmc425a.c | 124 ++++++++++++++++++++++++=
++++++-
> > > =C2=A01 file changed, 120 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/amplifiers/hmc425a.c
> > > b/drivers/iio/amplifiers/hmc425a.c
> > > index 77872e2dfdfe..50c86c2d28d7 100644
> > > --- a/drivers/iio/amplifiers/hmc425a.c
> > > +++ b/drivers/iio/amplifiers/hmc425a.c
> > > @@ -2,9 +2,10 @@
> > > =C2=A0/*
> > > =C2=A0 * HMC425A and similar Gain Amplifiers
> > > =C2=A0 *
> > > - * Copyright 2020 Analog Devices Inc.
> > > + * Copyright 2020, 2024 Analog Devices Inc.
> > > =C2=A0 */=C2=A0=20
> >=20
> > ...
> >=20
> > >=20
> > > =C2=A0
> > > +static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> > > +{
> > > +	struct hmc425a_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	return sysfs_emit(buf, "%d\n", st->powerdown);=C2=A0=20
> >=20
> > Well, in theory the read should also be protected with the lock...
>=20
> Only reason I can think of for that is potential read tearing.
> If that happens on a bool we are going to be in a mess so I think this
> is in practice fine without, though paranoia might suggest locking.

Yeah, also mentioned it for correctness. I mean, in theory, read_once() sho=
uld be
more that enough in here but I often find that too much for using in "simpl=
e" drivers
where a lock is surely easier to understand for someone reading the code.

Now, about your bool comment, I used to think like that until I saw the LF =
rcu
mentorship video from Paul. I'm fairly sure he comes up with some "crazy" p=
ossibility
about the CPU/compiler screwing you even on a char (IIRC, he was also argui=
ng about
not using read_once() on a bool).

Now, practically speaking, I tend to agree that for the archs we care this =
will
likely never be an issue but yeah, not 100% correct kernel code IMO.

- Nuno S=C3=A1



