Return-Path: <linux-kernel+bounces-135091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA189BB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0610628326A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D83B298;
	Mon,  8 Apr 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAcVapht"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E883D0A3;
	Mon,  8 Apr 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566662; cv=none; b=uQPnehmyr+q7OrK/1/7M2FXJmofVAgBYxCiNB2bLU/awVynIQXV8IR/4p5G6qd8T+Sc67XVqqXZDixpbhJS52QiURobn2XcbBemQ4YrjkgAQp2iZ7GXi1x1AdujZ7qRmnz2yIdZ2cDmSxvmj7GIsvhufMtcO5tbpF5CXUKkma3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566662; c=relaxed/simple;
	bh=6V+epa7TzOtzk5CGJVqGQzkk+1k6KMJKZfDe9Cus5i8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5e47RoO9GJwdz3Ycy3GG/tZPbQ8wXHx3Lq4HMpMIkrkJ3eN+5ZV35msdLmk+kTyWc5efr0j5xVXX+aqmqrqig6G9aqectzxkJgUHrrsGMZnHzsOU6ANvgyGGaQfaYwrBiEy+LfxLArRWBv5zmSHRUtQwJhkA23Hty9I6taVl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAcVapht; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4644bde1d4so585173466b.3;
        Mon, 08 Apr 2024 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712566659; x=1713171459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiUggs5jab4+SSzWpqlJ6drsXKzM4ADU0MHUe8Oo5o8=;
        b=BAcVaphtsAJONk+pc5EDm62rxaioNvP9CPe1HC33B4RSf7Ycd+6GAXDVteb5tPDGXJ
         CmqHM94AHYf97ZK/oB4+aA79cyzbpr5KckIwtV4Bc//yHh7QM8Z+50tSflbLncovok9n
         /0v4ieF4AQBaPCYRy4vEZUuS6qotdoSQbGauB32xgbt3dAOKIrcpLVQerDPv7o1D56V2
         3TEEkQJaxXW4os15igguyK9Bg6XCJ570/WiaeiPikCzoPjaJurrvpyoKwekRHY8Ocjkm
         KcBL+54/N13O4k+/iqo2Mr4x625n2jwGjfbbfRNOA1YiGMOxDRMetm7bGC7QgwkbdHqu
         Coiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566659; x=1713171459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiUggs5jab4+SSzWpqlJ6drsXKzM4ADU0MHUe8Oo5o8=;
        b=uEgVhJQTT2QnmEtS6t2PJd9fhro350vuKnUfbbfG3Jtr6y1wU13b78bhZhFGn/4rs/
         UNxdmtT7mBnu6Q9h66KF2gpv3V+SjOL9WfT8VydnXKMsVln2gQRjV0hFO0q2TTzhgvLZ
         xGqOfaY2oD8kUwLhwKZoyI3GLCsrJVJZYNRw5jtDzwjjzHC9ObsfnXI/lEc+K+wz7Gtr
         7v39fiFXMWl3X4KBQC4Ff1KGxUsFn4vfShY2aDmYY2SEhsLjZxS51QWTu21hFE2nr+PS
         cwE8s9a2Ow8rBfTngWL0mp8EHRvgNPiCHpg1rSsLuXexiKpUmYRuOEJUS1+snevq5xpa
         unKg==
X-Forwarded-Encrypted: i=1; AJvYcCWkeQZ8brGkKhHIvWUj3siOVlB2hO80RbLBmQodTZGd47bVxD1OzGMYaQR/GmEYhsPFSSbOw688w6kVbBvV19qw/p46g5MnFuigdH/qwUPifr/uVvYuqF1Y80XL9T2xkMWVOeBrPlNb
X-Gm-Message-State: AOJu0YzzoaJjrTujaVD5IGSNEGmnPZEvXSlI90JxYDRk0qhA76j1gzXn
	dARp/kOmtxxNzyRHR46151GVMrCticG+5wsCRHpQF886uZ1PLnbD
X-Google-Smtp-Source: AGHT+IGiosmTjNAxUMKR1FmOV4Hy1OisGbfBCNJt/kU7OrqFGaTOCDkSjrmfDrfiJJ80CnPr5V+9jA==
X-Received: by 2002:a17:907:1c26:b0:a51:d7f3:324b with SMTP id nc38-20020a1709071c2600b00a51d7f3324bmr1179303ejc.66.1712566658905;
        Mon, 08 Apr 2024 01:57:38 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906134100b00a519ec0a965sm4138611ejb.49.2024.04.08.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:57:38 -0700 (PDT)
Message-ID: <e989d0ca1d3369d274af5651f340e28e4808e7e4.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jyoti Bhayana <jbhayana@google.com>, Chris Down <chris@chrisdown.name>,
 John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Mon, 08 Apr 2024 11:01:11 +0200
In-Reply-To: <20240406170717.31ab7e47@jic23-huawei>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
	 <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
	 <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
	 <Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
	 <20240406170717.31ab7e47@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 17:07 +0100, Jonathan Cameron wrote:
> On Thu, 4 Apr 2024 18:12:25 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Thu, Apr 04, 2024 at 04:58:27PM +0200, Nuno S=C3=A1 wrote:
> > > On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote:=C2=A0=20
> > > > On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:=C2=A0=20
> > > > > Using dev_errp_probe() to simplify the code.=C2=A0=20
> >=20
> > ...
> >=20
> > > > > +	if (IS_ERR(fwnode))
> > > > > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot get Firmware
> > > > > reference\n");=C2=A0=20
> > > >=20
> > > > ERR_CAST() seems quite good candidate to have here.
> > > >=20
> > > > 		return dev_errp_probe(dev, fwnode, "Cannot get Firmware
> > > > reference\n");
> > > >=20
> > > > (Assuming dev_errp_probe() magically understands that, note you may=
 have
> > > > it as
> > > > =C2=A0a macro and distinguish parameter type with _Generic() or so =
and behave
> > > > =C2=A0differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_m=
atch()
> > > > =C2=A0implementation, but also keep in mind that it doesn't disting=
uish
> > > > NULL/0,
> > > > there
> > > > =C2=A0is a patch available in the mailing list to fix that, though.=
)=C2=A0=20
> > >=20
> > > Do we care that much for going with that trouble?=C2=A0=20
> >=20
> > I don't think we do. We are not supposed to be called with ret =3D=3D 0=
/NULL.
> > That's why I pointed out to the current version.
> >=20
> > > I understand like this we go
> > > PTR_ERR() to then comeback to ERR_PTR() but this for probe() which is=
 not
> > > a
> > > fastpath. So perhaps we could just keep it simple?=C2=A0=20
> >=20
> > It's not about performance, it's about readability. See the difference
> > between
> > yours and mine.
> >=20
>=20
> You are suggesting making it transparently take an error ptr or an intege=
r?
> Whilst clever, I'm not seeing that as a good idea for readability /
> reviewability.
> I expect something that looks like a function to take the same parameters
> (other vargs)
> always.=C2=A0 _Generic messes with that.

> Maybe I just don't like to learn new things!=C2=A0 If consensus comes dow=
n in
> favour
> of _Generic trickery then I'll get used to it eventually.
>=20

Yeah, I agree with the above. Not fully convinced but for the ERR_CAST() ca=
se I
would very much prefer to have another explicit helper rather than hiding s=
tuff
in the same macro.

- Nuno S=C3=A1

