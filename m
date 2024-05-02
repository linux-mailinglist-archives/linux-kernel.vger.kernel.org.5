Return-Path: <linux-kernel+bounces-166401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC88B9A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD931F218B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636465191;
	Thu,  2 May 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6IkPx42"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE363C7;
	Thu,  2 May 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649521; cv=none; b=d4XBp+fDHzkdxI19zN04v2HuoqS7sY8csLgZkNxg1poJMjJsUEpPoK2E725YC3QWqGi8QXM4q4lMiD4gzKNEve7Tz5+KFvuRUbPPrC0gpR9UjqPuUwoblKqjxRRhWYWAEShZPAR0gozU7Wy2LdTaWMoLY2t6mrxs/HNsH1bfwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649521; c=relaxed/simple;
	bh=7d8db+tuMLHa1Q6+B8yfKU6r6HwRAxZLZYsoHu+WPQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=keh1r2D2AsmIqTG0UFZV5kujVDM42jbJTUOJDLGPU93iCNw+RejYCjcomRzVTBUdfX6oJSGwHc0dpb/UCahlgvuvSA2E68ktohVCMlYQVZ+4OSm1YUw51lKZxKG6cRhCqG/g0bzGMOWtvhNuW46BKx1N+kihry2BMqpIkn83E/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6IkPx42; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a52223e004dso854825866b.2;
        Thu, 02 May 2024 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714649517; x=1715254317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hh6Bmu97EJ9uc9xiHA7rBDhMzG1LP4hfg+UEQHXFF0E=;
        b=B6IkPx42pG63A2YIPPPbaHRzXULbBX+vE/KdedeYhpJIZ7bu2EnhEGUokwn5klI5A/
         z0DKsMBSmyVElH8CaGiEUAKSGwLEmMM0dbt8og3gbxhOKMh/Ief8P/3sYnYoXny8Zh10
         db9o7IL84gq0wOcK9kEl4xF99iLXVz73ZGd8/TQy/ad9uxTtAWU7LrwAOuuZGt9Sdgnd
         wdB0vKBOs9yAYPo9LfEG4zXqS103gAKdcpFvo3AmtlRcNhmpSx4Xd7znCbDILa/+7fK9
         tHKcvRdl6aqqSSoMKQ3pzCZejh9X0FIffC3KjKrFE0nZV9JKl30nsc6W0XW9rAVbbTT6
         96sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649517; x=1715254317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hh6Bmu97EJ9uc9xiHA7rBDhMzG1LP4hfg+UEQHXFF0E=;
        b=YupHIAi31YT1bXpwyrsV4tT2RVSayVS4RBrHclVApwnRdQhtQdHxO8EGewOzFX8gTl
         mTtUvpq5KEGx+xR+uLHNhMd3KSyBs3Y5sqRi9gJ91QOhtr7o01wvJ4r2M9Tkee4yVhPQ
         gHvJ8U3XZS63fn/tlUVbQDFu8KZ7oQ9ZirIqT+zXwej1NQeFFmeLtLHUGcPtPeZW3Esj
         UfE+aM9rGYpQ41jjAYK89Xje10vCVIUHNoQ/uC9UxwbhOmoyZwjCTGef6JVlXgA8cpb4
         ZnBHPyvBTiJ70dtvMIM7DMi/hFl1ktBlL4rnOeTDV4UTl9LgoHibXswIeOarMD6Emq8e
         XAdw==
X-Forwarded-Encrypted: i=1; AJvYcCVIWnD/bHpq7F8c3wsWoeWt0vlVaoMIc4+RnuY0BLGPcJvCc0TQRRKrpYtfQRmA9WUKX5zuXjwoBD2+HIcOQRfRFeQdvK14oANM+p/bCLe0XjcZL/EkNBH24IVBlCu5uBH17ISL/eXpeDDQx6A6S1DIB+dxqvXsLiLmpsKsk8u5XFQbeZNy+N7r2yfCJ83/EM1cT9h6finJgLTs2gLHKw==
X-Gm-Message-State: AOJu0YyGdGAm+pAIYtH8miHLwYOSylfCAtlNrfhooLafahkGkU4Fk+/j
	oya+8sot6M8a6T7v4WLPbH/SXXjWO5Pm9uIBqXE9fpfNTmswLpWK
X-Google-Smtp-Source: AGHT+IFYbXcUy4uaWC/L1rSMhkEIGB1kzt+dzrBCbBz2iuN19fS6EoPJutoDDRqeUs3Rbj/VD36rDw==
X-Received: by 2002:a17:906:2695:b0:a52:5493:a0b9 with SMTP id t21-20020a170906269500b00a525493a0b9mr1552025ejc.39.1714649517198;
        Thu, 02 May 2024 04:31:57 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906278800b00a5264576138sm458290ejc.35.2024.05.02.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:31:56 -0700 (PDT)
Message-ID: <0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, "Gradinariu, Ramona"
	 <Ramona.Gradinariu@analog.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>, "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"conor+dt@kernel.org"
	 <conor+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	 <krzysztof.kozlowski+dt@linaro.org>, "robh@kernel.org" <robh@kernel.org>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>
Date: Thu, 02 May 2024 13:31:55 +0200
In-Reply-To: <20240429204027.3e47074a@jic23-huawei>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	 <20240423084210.191987-5-ramona.gradinariu@analog.com>
	 <20240428162555.3ddf31ea@jic23-huawei>
	 <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	 <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
	 <20240429204027.3e47074a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 20:40 +0100, Jonathan Cameron wrote:
> On Mon, 29 Apr 2024 13:17:42 +0000
> "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > Sent: Monday, April 29, 2024 10:59 AM
> > > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > > <ramona.bolboaca13@gmail.com>
> > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; linux-
> > > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.net;
> > > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; robh@kernel.o=
rg;
> > > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > > <Nuno.Sa@analog.com>
> > > Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 =
families
> > >=20
> > > [External]
> > >=20
> > > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:=C2=A0=20
> > > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > > =C2=A0
> > > > > The ADIS16545 and ADIS16547 are a complete inertial system that
> > > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > > The serial peripheral interface (SPI) and register structure prov=
ide a
> > > > > simple interface for data collection and configuration control.
> > > > >=20
> > > > > These devices are similar to the ones already supported in the dr=
iver,
> > > > > with changes in the scales, timings and the max spi speed in burs=
t
> > > > > mode.
> > > > > Also, they support delta angle and delta velocity readings in bur=
st
> > > > > mode, for which support was added in the trigger handler.
> > > > >=20
> > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0=20
> > > >=20
> > > > What is Nuno's relationship to this patch?=C2=A0 You are author and=
 the sender
> > > > which is fine, but in that case you need to make Nuno's involvement=
 explicit.
> > > > Perhaps a Co-developed-by or similar is appropriate?
> > > > =C2=A0
> > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>=
=C2=A0=20
> > > > A few comments inline.=C2=A0 Biggest one is I'd like a clear statem=
ent of why you
> > > > can't do a burst of one type, then a burst of other.=C2=A0 My guess=
 is that the
> > > > transition is very time consuming?=C2=A0 If so, that is fine, but y=
ou should be
> > > > able
> > > > to let available_scan_masks handle the disjoint channel sets.=C2=A0=
=20
> > >=20
> > > Yeah, the burst message is a special spi transfer that brings you all=
 of the
> > > channels data at once but for the accel/gyro you need to explicitly c=
onfigure
> > > the chip to either give you the "normal vs "delta" readings. Re-confi=
guring the
> > > chip and then do another burst would destroy performance I think. We =
could
> > > do
> > > the manual readings as we do in adis16475 for chips not supporting bu=
rst32.
> > > But
> > > in the burst32 case those manual readings should be minimal while in =
here we
> > > could have to do 6 of them which could also be very time consuming...
> > >=20
> > > Now, why we don't use available_scan_masks is something I can't reall=
y
> > > remember
> > > but this implementation goes in line with what we have in the adis164=
75
> > > driver.
> > >=20
> > > - Nuno S=C3=A1
> > > =C2=A0=20
> >=20
> > Thank you Nuno for all the additional explanations.
> > Regarding the use of available_scan_masks, the idea is to have any poss=
ible
> > combination for accel, gyro, temp and timestamp channels or delta angle=
, delta=20
> > velocity, temp and=C2=A0 timestamp channels. There are a lot of combina=
tions for=20
> > this and it does not seem like a good idea to write them all manually. =
That is=20
> > why adis16480_update_scan_mode is used for checking the correct channel=
s=20
> > selection.
>=20
> If you are using bursts, the data is getting read anyway - which is the m=
ain
> cost here. The real question becomes what are you actually saving by supp=
orting all
> the combinations of the the two subsets of channels in the pollfunc?
> Currently you have to pick the channels out and repack them, if pushing t=
hem all
> looks to me like a mempcy and a single value being set (unconditionally).

> Then it's a question of what the overhead of the channel demux in the cor=
e is.
> What you pass out of the driver via iio_push_to_buffers*()
> is not what ends up in the buffer if you allow the IIO core to do data de=
muxing
> for you - that is enabled by providing available_scan_masks.=C2=A0 At buf=
fer
> start up the demux code computes a fairly optimal set of copies to repack
> the incoming data to match with what channels the consumer (here probably
> the kfifo on the way to userspace) is expecting.
>=20
> That demux adds a small overhead but it should be small as long
> as the channels wanted aren't pathological (i.e. every other one).
>=20
> Advantage is the driver ends up simpler and in the common case of turn
> on all the channels (why else did you buy a device with those measurement=
s
> if you didn't want them!) the demux is zerocopy so effectively free which
> is not going to be the case for the bitmap walk and element copy in the
> driver.
>=20

Maybe my younger me was smarter but reading again the validation of the sca=
n mask
code (when available_scan_masks is available), I'm not sure why we're not u=
sing them.
I think that having one mask with delta values + temperature and another on=
e with
normal + temperature would be enough for what we want in here. The code in
adis16480_update_scan_mode() could then be simpler I think.

Now, what I'm still not following is the straight memcpy(). I may be missin=
g
something but the demux code only appears to kick in when we have compound =
masks
resulting of multiple buffers being enabled. So I'm not seeing how we can g=
et away
without picking the channels and place them correctly in the buffer passed =
to IIO?
What we could do in the future (for a similar device) is to maybe have a fa=
stpath in
the handler. Something like:

if (bitmap_full(scan_mask, masklength)) {
	memcpy(iio_buff, burst + data_off, size);
	goto push_to_iio;
}

Right now we would always have to do some "manual" work as the temperature =
scan index
does not match the position on the received burst data.

Some devices with the burst32 (which I think do not exist in this driver) w=
ould also
make the plain memcpy() harder.

- Nuno S=C3=A1


