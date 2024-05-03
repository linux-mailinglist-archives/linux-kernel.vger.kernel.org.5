Return-Path: <linux-kernel+bounces-167421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815F8BA963
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E471F22278
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892E14F9D4;
	Fri,  3 May 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJab+Wqy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A714BFA8;
	Fri,  3 May 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727029; cv=none; b=oJslPSNhYXh5K5QO9nCohXRSopvcVbGJc72yEqwpI8DcaQ7vw2ZkEyFzMtfxI8JQdKWSxbKbZGHPUq+spuGoz1lbJW5c322isSpItk9bCOoJ5kQXA20BFIAMxJVi3qoeFNLXihtyZngQ0BzHzafnNPJRaKZq/mgdULHQu9ERoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727029; c=relaxed/simple;
	bh=Bk4Zza8EYRCRkedfcxu47DOvpBSaC6BwAnmuSeVosVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTQtBZVu9Pa2plx2FnOmeb78Pt7JofIwjOrpHOIp3Sy3lQaVLMEDQ6hXGs9oR17AtOkOlTiw5zubZU1S1ZTizlZJxA58VEk5mLxhGcvw8JhpKC+KP9RhNBJxhyOE8gE3XyIKgD9+fW2RO3LOVpFB7BWzDz4c5M0albH7j8whuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJab+Wqy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599a3b233cso22926266b.3;
        Fri, 03 May 2024 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714727025; x=1715331825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4y4vT9BTiV20HdXMjZF7RMcH0dJBgqS4NIhpx2HoEyU=;
        b=hJab+WqyqBHCJoinsrpuZjPDnYR8ga4Dnya7wPH0slGJTAQzXy3piAR18ggsfO5IKC
         XfZ2PzzqaguswCGaor6KNwH0k6z0G6XObShMSL/ha9Z8kyGsPEMh3RVIgSIhq0JmUuIP
         8FwNbQUTqO6BF3tLQF9zBFOT4DkpvOSHEwFaoze7N0CIFd4euKOdfyeycKUsEC3kqXC5
         +1NwsSHtt/Yc5vkwHGPGZ9aNRPsx9sorZOJewLxUVCSKvW7NtY6vvuQD0PcyKnHafHwt
         FIGnWQbaaA6pRWogPI4ybmQ8bzYS51+XBb6brykBtopLXo6j3ZAXO207KTuveblO2YCM
         ld9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727025; x=1715331825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4y4vT9BTiV20HdXMjZF7RMcH0dJBgqS4NIhpx2HoEyU=;
        b=F4En68/tyChp9G46WgIv4D/vWOnX0+Rm/4I3WhiG+BENqI0f+HhEBsrZWH7D+uCx6/
         hcq+WTvc2ZXs97C6iSQ7ySYa6c0PEQM2f/TggSlFhMPzE8ih9unOlmuY8QRuJ5JKlHVz
         1aSeTk/koE7uaL+O3qfC4fiKS+JwHyzWP4pIpab74aI70cXxDTc59SoHFOGKb/9iUi3S
         t1RLzqQ6QPhRT1hsINyMo0QXs0zsDFCgnsfyj03bIm0+tY5M6YdCeffXQh6YYQLmSjAC
         tjiYKg7GffQ1HFF4KBgJdrZZ+rm1UkM4wknIIgHPl3+ntRoHBQ8xShYpapbZ6vyKfIJr
         WOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWC4C67PwaI2++k80YJCwKdmsx1ENmfjPPdz/kp0/XsPMnny3FvewKKB7kRQdpEb10WKgsEJOcqsmaaaY/yJO8CGx4QC8pJI6Abxepq8Nyoyae5H83jjwSqOhN3t/cry6BGvPGF0LqCHiCey+1FqDDEoMFZygCRH79nMjwoiqJ82GtYcLPusJ3W9ePgKXUiHueUFalXcwziXCl3fdq+g==
X-Gm-Message-State: AOJu0YyJEEcFk8RW8KSFkYTyQLafiUP52+yHBHDiNQ2TINGKPMEFKr1k
	N6wNeMxPPnBXDLxrjziDPOHueVazqIJPzf/Qj/T14OSbClg3Vkbr
X-Google-Smtp-Source: AGHT+IG5O9deX+SF26zkZv/YFJnDvgFDFjmcCOtWlSq7rEN9c4LyKQXLDiEk3UovXPRzh0a7NTLGTQ==
X-Received: by 2002:a50:bb06:0:b0:56e:3088:49a with SMTP id y6-20020a50bb06000000b0056e3088049amr1439112ede.37.1714727024930;
        Fri, 03 May 2024 02:03:44 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402195400b005725c56b35bsm1474991edz.71.2024.05.03.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:03:44 -0700 (PDT)
Message-ID: <928971b3b62a04144e1661ef6585264668efc447.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: jic23@kernel.org, Ramona.Gradinariu@analog.com,
 ramona.bolboaca13@gmail.com,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org,  linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, corbet@lwn.net,  conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,  Nuno.Sa@analog.com
Date: Fri, 03 May 2024 11:07:23 +0200
In-Reply-To: <20240503094113.00001879@Huawei.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	 <20240423084210.191987-5-ramona.gradinariu@analog.com>
	 <20240428162555.3ddf31ea@jic23-huawei>
	 <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	 <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
	 <20240429204027.3e47074a@jic23-huawei>
	 <0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
	 <20240502201408.216575e4@jic23-huawei>
	 <0df8386e74cbdfaaaf35a4bc59326151b863ae4c.camel@gmail.com>
	 <20240503094113.00001879@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 09:42 +0100, Jonathan Cameron wrote:
> On Fri, 03 May 2024 08:09:29 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> Resend as the to / cc entries were garbled. No idea why!
>=20
> > On Thu, 2024-05-02 at 20:14 +0100, Jonathan Cameron wrote:
> > > On Thu, 02 May 2024 13:31:55 +0200
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > On Mon, 2024-04-29 at 20:40 +0100, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > On Mon, 29 Apr 2024 13:17:42 +0000
> > > > > "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > > -----Original Message-----
> > > > > > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > > > > > Sent: Monday, April 29, 2024 10:59 AM
> > > > > > > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > > > > > > <ramona.bolboaca13@gmail.com>
> > > > > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > > > > > linux-
> > > > > > > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.n=
et;
> > > > > > > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > > > robh@kernel.org;
> > > > > > > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > > > > > > <Nuno.Sa@analog.com>
> > > > > > > Subject: Re: [PATCH 4/5] iio: adis16480: add support for
> > > > > > > adis16545/7
> > > > > > > families
> > > > > > >=20
> > > > > > > [External]
> > > > > > >=20
> > > > > > > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > > > > > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > The ADIS16545 and ADIS16547 are a complete inertial syste=
m
> > > > > > > > > that
> > > > > > > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > > > > > > The serial peripheral interface (SPI) and register struct=
ure
> > > > > > > > > provide a
> > > > > > > > > simple interface for data collection and configuration
> > > > > > > > > control.
> > > > > > > > >=20
> > > > > > > > > These devices are similar to the ones already supported i=
n the
> > > > > > > > > driver,
> > > > > > > > > with changes in the scales, timings and the max spi speed=
 in
> > > > > > > > > burst
> > > > > > > > > mode.
> > > > > > > > > Also, they support delta angle and delta velocity reading=
s in
> > > > > > > > > burst
> > > > > > > > > mode, for which support was added in the trigger handler.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > What is Nuno's relationship to this patch?=C2=A0 You are au=
thor and
> > > > > > > > the
> > > > > > > > sender
> > > > > > > > which is fine, but in that case you need to make Nuno's
> > > > > > > > involvement
> > > > > > > > explicit.
> > > > > > > > Perhaps a Co-developed-by or similar is appropriate?
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > Signed-off-by: Ramona Gradinariu
> > > > > > > > > <ramona.gradinariu@analog.com>=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > A few comments inline.=C2=A0 Biggest one is I'd like a clea=
r
> > > > > > > > statement of
> > > > > > > > why you
> > > > > > > > can't do a burst of one type, then a burst of other.=C2=A0 =
My guess
> > > > > > > > is
> > > > > > > > that the
> > > > > > > > transition is very time consuming?=C2=A0 If so, that is fin=
e, but you
> > > > > > > > should be
> > > > > > > > able
> > > > > > > > to let available_scan_masks handle the disjoint channel
> > > > > > > > sets.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > Yeah, the burst message is a special spi transfer that brings=
 you
> > > > > > > all
> > > > > > > of the
> > > > > > > channels data at once but for the accel/gyro you need to
> > > > > > > explicitly
> > > > > > > configure
> > > > > > > the chip to either give you the "normal vs "delta" readings. =
Re-
> > > > > > > configuring the
> > > > > > > chip and then do another burst would destroy performance I th=
ink.
> > > > > > > We
> > > > > > > could
> > > > > > > do
> > > > > > > the manual readings as we do in adis16475 for chips not suppo=
rting
> > > > > > > burst32.
> > > > > > > But
> > > > > > > in the burst32 case those manual readings should be minimal w=
hile
> > > > > > > in
> > > > > > > here we
> > > > > > > could have to do 6 of them which could also be very time
> > > > > > > consuming...
> > > > > > >=20
> > > > > > > Now, why we don't use available_scan_masks is something I can=
't
> > > > > > > really
> > > > > > > remember
> > > > > > > but this implementation goes in line with what we have in the
> > > > > > > adis16475
> > > > > > > driver.
> > > > > > >=20
> > > > > > > - Nuno S=C3=A1
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > Thank you Nuno for all the additional explanations.
> > > > > > Regarding the use of available_scan_masks, the idea is to have =
any
> > > > > > possible
> > > > > > combination for accel, gyro, temp and timestamp channels or del=
ta
> > > > > > angle,
> > > > > > delta=20
> > > > > > velocity, temp and=C2=A0 timestamp channels. There are a lot of
> > > > > > combinations
> > > > > > for=20
> > > > > > this and it does not seem like a good idea to write them all
> > > > > > manually.
> > > > > > That is=20
> > > > > > why adis16480_update_scan_mode is used for checking the correct
> > > > > > channels
> > > > > > selection.=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > If you are using bursts, the data is getting read anyway - which =
is
> > > > > the
> > > > > main
> > > > > cost here. The real question becomes what are you actually saving=
 by
> > > > > supporting all
> > > > > the combinations of the the two subsets of channels in the pollfu=
nc?
> > > > > Currently you have to pick the channels out and repack them, if
> > > > > pushing
> > > > > them all
> > > > > looks to me like a mempcy and a single value being set
> > > > > (unconditionally).=C2=A0=C2=A0=20
> > > > =C2=A0=20
> > > > > Then it's a question of what the overhead of the channel demux in=
 the
> > > > > core
> > > > > is.
> > > > > What you pass out of the driver via iio_push_to_buffers*()
> > > > > is not what ends up in the buffer if you allow the IIO core to do=
 data
> > > > > demuxing
> > > > > for you - that is enabled by providing available_scan_masks.=C2=
=A0 At
> > > > > buffer
> > > > > start up the demux code computes a fairly optimal set of copies t=
o
> > > > > repack
> > > > > the incoming data to match with what channels the consumer (here
> > > > > probably
> > > > > the kfifo on the way to userspace) is expecting.
> > > > >=20
> > > > > That demux adds a small overhead but it should be small as long
> > > > > as the channels wanted aren't pathological (i.e. every other one)=
.
> > > > >=20
> > > > > Advantage is the driver ends up simpler and in the common case of=
 turn
> > > > > on all the channels (why else did you buy a device with those
> > > > > measurements
> > > > > if you didn't want them!) the demux is zerocopy so effectively fr=
ee
> > > > > which
> > > > > is not going to be the case for the bitmap walk and element copy =
in
> > > > > the
> > > > > driver.
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Maybe my younger me was smarter but reading again the validation of=
 the
> > > > scan
> > > > mask
> > > > code (when available_scan_masks is available), I'm not sure why we'=
re
> > > > not
> > > > using them.
> > > > I think that having one mask with delta values + temperature and an=
other
> > > > one
> > > > with
> > > > normal + temperature would be enough for what we want in here. The =
code
> > > > in
> > > > adis16480_update_scan_mode() could then be simpler I think.
> > > >=20
> > > > Now, what I'm still not following is the straight memcpy(). I may b=
e
> > > > missing
> > > > something but the demux code only appears to kick in when we have
> > > > compound
> > > > masks
> > > > resulting of multiple buffers being enabled. So I'm not seeing how =
we
> > > > can
> > > > get away
> > > > without picking the channels and place them correctly in the buffer
> > > > passed
> > > > to IIO?=C2=A0=20
> > >=20
> > > It runs whenever the enabled mask requested (the channels that are
> > > enabled) is
> > > different from the active_scan_mask. It only sends channels in one
> > > direction if there is only one user but it only sends the ones enable=
d by
> > > that
> > > consumer.
> > > It's called unconditionally from iio_enable_buffers()
> > >=20
> > > That iterates over all enabled buffers (often there is only 1)
> > >=20
> > > and then checks if the active scan mask is the same as the one for th=
is
> > > buffer.
> > > https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industri=
alio-buffer.c#L1006
> > >=20
> > > The setup for whether to find a superset from available_scan_masks is=
 here
> > > https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industri=
alio-buffer.c#L928
> > >=20
> > > Key is that if it happens to match, then we don't actually do anythin=
g in
> > > the
> > > demux.
> > > It just gets passed straight on through.=C2=A0 That does the fast pat=
h you
> > > mention
> > > below.=C2=A0=20
> >=20
> > Ahh got it... May failure was not realizing that iio_scan_mask_match()
> > returns
> > the available masks so I was assuming that the bitmap_equal() check wou=
ld
> > only
> > differ when multiple buffers are enabled.
> >=20
> > Oh well, I think then this should work... I'm not sure it will be more
> > performant for the case where we don't enable all the channels because =
the
> > demux
> > is a linked list which is far from being a performance friend (maybe we=
 can
> > do
> > some trials with something like xarray...). Still, for this to work the
> > buffer
> > we pass into IIO has to be bigger than it needs to be (so bigger memset=
())
> > because, AFAIU, we will have to pass on all the scan elements and, as I
> > said,
> > the burst data will either have delta or normal measurements (not both)=
 I
> > guess
> > the code will still look simpler so if there's no visible difference in
> > performance I'm fine with the change. I guess Ramona can give it a try =
to
> > see
> > how it looks like.
>=20
> Would be interesting to look at the performance of that code, but the
> real question is what channels do users typically enabled. If they enable=
d
> a full set (and I suspect most do) then that code doesn't nothing at all.
>=20

The only channel that makes me doubt is the temperature one but yeah, I wou=
ld
also expect  most users just enable them all...

> Original thinking was that the non common case didn't really matter much.
> If it is worth optimizing I'd suggest a double pass (or cheat - see later=
)
> 1st pass works out number of elements, 2nd just saves them in a nice
> linear array.=C2=A0 It's typically small however, so maybe just allocate =
a linear
> array big enough for the worst case.
>=20

Yeah, linear array should also be fine and likely simpler. Maybe if I'm bor=
ed at
some point I'll run some experiments :)

- Nuno S=C3=A1

