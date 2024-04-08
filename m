Return-Path: <linux-kernel+bounces-135095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CD89BB19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB61F22738
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D93FB8D;
	Mon,  8 Apr 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEgNQ3Rt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143733BB22;
	Mon,  8 Apr 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566931; cv=none; b=pxHGHKs0DcJHgdFpm44p/lLAiAEC7C2pyjVFmeEaqD04VA51OjMdtVFGM8690apbtAx55/RUfz8GRGJFFRNmOJL/fDoLhCYnMeghUJHUXJUyDylUBpqkI2Bd3WAvz+er/SBO2fcMpyxN2g0ZwM9EoIYOgSLv8B/oKpocFUbVxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566931; c=relaxed/simple;
	bh=7VV0jGdXvYvmwftVVSl1G0fiatJCoVjKvd7HpTiJ0JM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7qpV/AXJ3dXjuRGAt7GTd1ixUMg5ga7b4DLmDkyfRynhZR5ceeWnn0jNdHejlAd/0pKoeIouCtMYWqxp4QKMESN2xkVtoVrz1tFVCDrAEtFoFwV41GbLgFnAkHVMb5wy8ygyAmem1jQ3jU2c4+C6r65vDaMrMkxax/Xi0VyYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEgNQ3Rt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d47ce662so4471663e87.1;
        Mon, 08 Apr 2024 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712566928; x=1713171728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Qdsh0d4hfPBGFN5vOtVBcqubXHngsXIt2VO3gViJqA=;
        b=IEgNQ3RtTGKU5yseFvEKDD6EcxPSUUz06ZD6rB4DKLgAXbp2it/ohT3z/w5zBeozqC
         5ug+Xg4Wa6gbeIamct5+wqVG0joVuPiIrwt1hT//BFc9+pMXGTSt7TBzYLRP1gC3uwyq
         AIo4mZapge6ySK6zrmKWtNrHEKOx2gfwHMVrOGPephE7f2ydha0OnpnM66wVct3P9hCW
         n3R/JpoDrn9l8/NjvrN5Dgc73FOk/3MfLVQvxp6iJITahJuY6z3KCGlHICWhx3RIYduC
         ZLx5oAcoeEO8oes0CpoyyKRl4uL25XKymwyYZuLEeu66Bb2prRmx2Exhlysz7XnuxJ3T
         /5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566928; x=1713171728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Qdsh0d4hfPBGFN5vOtVBcqubXHngsXIt2VO3gViJqA=;
        b=Ujeus0Zx6zLv95YlV0j88Sd9ZO+lJghG5/76irZrULS/ikPzhf6win95juC049JPot
         u1J0IDdsGtkAPk4yhrQPORis7JvqgpBaA8Ce5+88zq/T7oaNdUL5Ecwf6kha8h4PATMB
         BiDRl7RWwHh1qKvQz410m/0Z6zKhdBHBRQPkuuUwVZhME0hAu4fEX295nE+SqfzFNqW5
         iB0A+kfRyOCiRbOHLoFqdOF6ANWDLuucrTpuASPc7y9OTlTXc5J+G80mbHo2hpi6PPFe
         TcUtMnoY+EQ+b6/OKQXhpJdd8+YEL0GlpbCysPwZ/Ba8BUf5mom8isFyUWtAYk7y9ICx
         dWsg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Bk7zeXHU1zD6PU14u+k4m0L9F3nXsx/Zn90UwVnXG0xO2THOc1t1UEGjXLvPlyRvaGwapo63KWf1II2JfBvBc7DwnEVXG0F2rJNsHrBag+Mxc1ePdIKlVfpA97QfHdDuU93E1kGJ
X-Gm-Message-State: AOJu0Yx8ml45ngzdWNoJF/tYkc5nLZoirj8RVlJkAQFyLymzJeq0k7Lr
	ZqL8yx80SykeZWsV/jvJClC6UFyrFlm5k6GZGs7i+w0B8nHlqm1K
X-Google-Smtp-Source: AGHT+IEm59FOtvdu0BH6VqTsDXFQBTsbwNkhEZgSkr9j1F+KkgvMyk1/6ThJwaxOvCs1K1IZ/YJReg==
X-Received: by 2002:a05:6512:52b:b0:516:c1b9:316b with SMTP id o11-20020a056512052b00b00516c1b9316bmr6943381lfc.15.1712566927827;
        Mon, 08 Apr 2024 02:02:07 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709062b1700b00a51dd26f6dcsm544255ejg.51.2024.04.08.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:02:07 -0700 (PDT)
Message-ID: <5264b2cddd5d3cbba5e9d5e55f8c7069347ec38b.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti
 Bhayana <jbhayana@google.com>, Chris Down <chris@chrisdown.name>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Mon, 08 Apr 2024 11:05:39 +0200
In-Reply-To: <7ejh2r6zcripnptn3nbw2sa3mlfyleg4qg74rryxlut3fysneg@kuqwo5z2l65n>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
	 <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
	 <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
	 <Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
	 <20240406170717.31ab7e47@jic23-huawei>
	 <7ejh2r6zcripnptn3nbw2sa3mlfyleg4qg74rryxlut3fysneg@kuqwo5z2l65n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 20:54 +0200, Andi Shyti wrote:
> Hi,
>=20
> On Sat, Apr 06, 2024 at 05:07:17PM +0100, Jonathan Cameron wrote:
> > On Thu, 4 Apr 2024 18:12:25 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >=20
> > > On Thu, Apr 04, 2024 at 04:58:27PM +0200, Nuno S=C3=A1 wrote:
> > > > On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote:=C2=A0=20
> > > > > On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:=C2=A0=
=20
> > > > > > Using dev_errp_probe() to simplify the code.=C2=A0=20
> > >=20
> > > ...
> > >=20
> > > > > > +	if (IS_ERR(fwnode))
> > > > > > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot get Firmware
> > > > > > reference\n");=C2=A0=20
> > > > >=20
> > > > > ERR_CAST() seems quite good candidate to have here.
> > > > >=20
> > > > > 		return dev_errp_probe(dev, fwnode, "Cannot get
> > > > > Firmware
> > > > > reference\n");
> > > > >=20
> > > > > (Assuming dev_errp_probe() magically understands that, note you m=
ay
> > > > > have it as
> > > > > =C2=A0a macro and distinguish parameter type with _Generic() or s=
o and
> > > > > behave
> > > > > =C2=A0differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid=
_match()
> > > > > =C2=A0implementation, but also keep in mind that it doesn't disti=
nguish
> > > > > NULL/0,
> > > > > there
> > > > > =C2=A0is a patch available in the mailing list to fix that, thoug=
h.)=C2=A0=20
> > > >=20
> > > > Do we care that much for going with that trouble?=C2=A0=20
> > >=20
> > > I don't think we do. We are not supposed to be called with ret =3D=3D=
 0/NULL.
> > > That's why I pointed out to the current version.
> > >=20
> > > > I understand like this we go
> > > > PTR_ERR() to then comeback to ERR_PTR() but this for probe() which =
is
> > > > not a
> > > > fastpath. So perhaps we could just keep it simple?=C2=A0=20
> > >=20
> > > It's not about performance, it's about readability. See the differenc=
e
> > > between
> > > yours and mine.
> > >=20
> >=20
> > You are suggesting making it transparently take an error ptr or an inte=
ger?
> > Whilst clever, I'm not seeing that as a good idea for readability /
> > reviewability.
> > I expect something that looks like a function to take the same paramete=
rs
> > (other vargs)
> > always.=C2=A0 _Generic messes with that.
> >=20
> > Maybe I just don't like to learn new things!=C2=A0 If consensus comes d=
own in
> > favour
> > of _Generic trickery then I'll get used to it eventually.
>=20
> the whole point of the dev_err_...() functions is to add trickery
> in order to reduce code and brackets.
>=20

I'm not sure I'm completely convinced on having more helpers but also no st=
rong
opinion tbh. But see below...

> The way I see this is to have a combination of functions:
>=20
> =C2=A0- takes integer, returns integer -> dev_err_probe()
> =C2=A0- takes integer, returns pointer -> dev_errp_probe() (or dev_err_pt=
r_probe())
> =C2=A0- takes pointer, return integer -> ? dev_ptr_err_probe()

This is pretty much all the dev_err_probe(dev, PTR_ERR(), ...) we already h=
ave
out there. Do we really want to have this variant?

> =C2=A0- takes pointer, returns pointer -> ? dev_ptr_probe()

dev_ptr_probe() misses to be clear about being an error and think this is p=
retty
much the ERR_CAST() case right? Maybe dev_err_cast_ptr_probe()? Or
dev_err_cast_probe()?

- Nuno S=C3=A1


