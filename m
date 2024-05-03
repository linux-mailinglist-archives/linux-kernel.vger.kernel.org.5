Return-Path: <linux-kernel+bounces-167272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A884A8BA6DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D6F1F2297A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437F139D07;
	Fri,  3 May 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL6b+I2x"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21E1C6BD;
	Fri,  3 May 2024 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716354; cv=none; b=L3Us9d+vLrBF7G0jvJM313O14C0Rp/WMyLD2l7o305/xGN4LPUKJ2fxPHvySJJfcbKAKxlvT51qb1GigTM6lM/rtSnyEF5VHb8wOT1BiQ5e/D0TPwnsujkp0A3bxTxfI2uL7R7l9J1FnOowlbJSUAe/i4Qp5z4PtWn4X8KOD4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716354; c=relaxed/simple;
	bh=IED0Mb4+EQ6v9Aq9vamv4bae3ZiGogC6cVMeVsbizCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikMqBu+3xbBYHTl2n9/LLOONZsq01AdaIWmrbtzftjf40jUoqT2r5fjktayZ7p08CFQmMx+7bfdSUc3U5Ds3jZfiMOfj2DgAdqKXZbLYDDVr9nhD+ochRKw5xMbvyBrxS40AHyAaL2HZPbCSWlfYLoJVNWrImRNk9rh+GiZkdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL6b+I2x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so10817502e87.1;
        Thu, 02 May 2024 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714716350; x=1715321150; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IED0Mb4+EQ6v9Aq9vamv4bae3ZiGogC6cVMeVsbizCw=;
        b=OL6b+I2xT70fTDCzw0i3NThG/KT7tokIPnjyta9UxrA2tthAbSfULZFlLHPwjaP/1P
         6rtMTVdjwK0e+qWZ3n2qNjIxrfwZlrLeTDouK36Q3XUEQIn+aICzP3A99Kt72/pdP5gT
         vA6+o8e6wy64njNTOCr7tVjlrzWvswqfIlyWsEgUFRWfQSZstg9Tn750U20FdRkSf7Ka
         UaZH4b/TSZMPHvgRAwGwbaOu+l2FE8qY4zoU7floDExBmooVk0gpPaYTgpldA0FNPmnS
         +rvEM+NK+tjHsrplzJ1/+1inaZud02MdxRgn3qU6SCPfObSpKmUxgT1VhNmYDRe0N/kb
         bEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714716350; x=1715321150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IED0Mb4+EQ6v9Aq9vamv4bae3ZiGogC6cVMeVsbizCw=;
        b=lTuk1nYQeqP9bQde4aPOfDaYlRY3u/9kR2t76dfg03WZjHuGteIW1f/ITa1ajmFCho
         Zli7S5smNzvqwpYV61DofkHyYXwVL5v+k+w2aIppFjCX8BpVgLFgs4dt9WF9MuNMSu5y
         8R4aQhYoCnU7XtxokKEM59MO6Rw2N8T7ZG81o2GfLBGGlh+D84zg2TAzz6qGCQypiBOO
         3Qs4m1InkrZaxWsQvsJ7aSNfSeOMZBoUxQYJZG0qMVkAwHcgd+SugNooEMiW2TInVl2E
         KhkD+WwAP7Kd3xJka8nOG7cq0aTySphDNWD6qFDHAAqT66yC0t5FX5xiBPgfHZGH3Y4Z
         L+XA==
X-Forwarded-Encrypted: i=1; AJvYcCUqeGIQA4jSML3TMTF/3y48FxwaNswcGLBXH2F1fV4mgPcV/5aeUR2bjAOrkUxoPzvdUPr6CA2bWAb6qo7H09LWccx0+lEfHcAzHy16zGznBi5D4s8YRqO6gzsbl4ylfTGoPFylQHokn29249hB1FGhjRFQY31baWk3C/Lc9RXCPXCBWHfoz5I8DWcONd4xk4KMVNm/V+/RS+tAXQEy+w==
X-Gm-Message-State: AOJu0Yyd+z2xh8nrC+UrJEBtiaCvQaGjDDGfcBSGMS3t6OWjBeBkcgv5
	jtgvwMRP6l+3jOx1WGkVRRanfgVynipSqWow564EQZ1hGAB0Rfjo
X-Google-Smtp-Source: AGHT+IFGWUGbdgJBUGuCHPkwxmdfd90qIxlR6Q7hcnO+AXxWFVafsV0BRCA3Ok7qBxY4X2kDGeheDA==
X-Received: by 2002:a05:6512:715:b0:51f:315c:75e0 with SMTP id b21-20020a056512071500b0051f315c75e0mr894419lfs.44.1714716350101;
        Thu, 02 May 2024 23:05:50 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060e9600b00a5887833da8sm1328554ejf.81.2024.05.02.23.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 23:05:49 -0700 (PDT)
Message-ID: <0df8386e74cbdfaaaf35a4bc59326151b863ae4c.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>, Ramona Gradinariu
	 <ramona.bolboaca13@gmail.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>, "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
 "conor+dt@kernel.org"
	 <conor+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	 <krzysztof.kozlowski+dt@linaro.org>, "robh@kernel.org" <robh@kernel.org>, 
 "Sa, Nuno" <Nuno.Sa@analog.com>
Date: Fri, 03 May 2024 08:09:29 +0200
In-Reply-To: <20240502201408.216575e4@jic23-huawei>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	 <20240423084210.191987-5-ramona.gradinariu@analog.com>
	 <20240428162555.3ddf31ea@jic23-huawei>
	 <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	 <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
	 <20240429204027.3e47074a@jic23-huawei>
	 <0e13f8b643bb7afcc7c4f0d62741cf9fda66c1e0.camel@gmail.com>
	 <20240502201408.216575e4@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 20:14 +0100, Jonathan Cameron wrote:
> On Thu, 02 May 2024 13:31:55 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-04-29 at 20:40 +0100, Jonathan Cameron wrote:
> > > On Mon, 29 Apr 2024 13:17:42 +0000
> > > "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:
> > > =C2=A0=20
> > > > > -----Original Message-----
> > > > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > > > Sent: Monday, April 29, 2024 10:59 AM
> > > > > To: Jonathan Cameron <jic23@kernel.org>; Ramona Gradinariu
> > > > > <ramona.bolboaca13@gmail.com>
> > > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; linu=
x-
> > > > > doc@vger.kernel.org; devicetree@vger.kernel.org; corbet@lwn.net;
> > > > > conor+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > > robh@kernel.org;
> > > > > Gradinariu, Ramona <Ramona.Gradinariu@analog.com>; Sa, Nuno
> > > > > <Nuno.Sa@analog.com>
> > > > > Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis1654=
5/7
> > > > > families
> > > > >=20
> > > > > [External]
> > > > >=20
> > > > > On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:=C2=A0=
=C2=A0=C2=A0=20
> > > > > > On Tue, 23 Apr 2024 11:42:09 +0300
> > > > > > Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
> > > > > > =C2=A0=C2=A0=20
> > > > > > > The ADIS16545 and ADIS16547 are a complete inertial system th=
at
> > > > > > > includes a triaxis gyroscope and a triaxis accelerometer.
> > > > > > > The serial peripheral interface (SPI) and register structure
> > > > > > > provide a
> > > > > > > simple interface for data collection and configuration contro=
l.
> > > > > > >=20
> > > > > > > These devices are similar to the ones already supported in th=
e
> > > > > > > driver,
> > > > > > > with changes in the scales, timings and the max spi speed in =
burst
> > > > > > > mode.
> > > > > > > Also, they support delta angle and delta velocity readings in
> > > > > > > burst
> > > > > > > mode, for which support was added in the trigger handler.
> > > > > > >=20
> > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>=C2=A0=C2=A0=
=C2=A0=20
> > > > > >=20
> > > > > > What is Nuno's relationship to this patch?=C2=A0 You are author=
 and the
> > > > > > sender
> > > > > > which is fine, but in that case you need to make Nuno's involve=
ment
> > > > > > explicit.
> > > > > > Perhaps a Co-developed-by or similar is appropriate?
> > > > > > =C2=A0=C2=A0=20
> > > > > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.co=
m>=C2=A0=C2=A0=C2=A0
> > > > > > A few comments inline.=C2=A0 Biggest one is I'd like a clear st=
atement of
> > > > > > why you
> > > > > > can't do a burst of one type, then a burst of other.=C2=A0 My g=
uess is
> > > > > > that the
> > > > > > transition is very time consuming?=C2=A0 If so, that is fine, b=
ut you
> > > > > > should be
> > > > > > able
> > > > > > to let available_scan_masks handle the disjoint channel sets.=
=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > Yeah, the burst message is a special spi transfer that brings you=
 all
> > > > > of the
> > > > > channels data at once but for the accel/gyro you need to explicit=
ly
> > > > > configure
> > > > > the chip to either give you the "normal vs "delta" readings. Re-
> > > > > configuring the
> > > > > chip and then do another burst would destroy performance I think.=
 We
> > > > > could
> > > > > do
> > > > > the manual readings as we do in adis16475 for chips not supportin=
g
> > > > > burst32.
> > > > > But
> > > > > in the burst32 case those manual readings should be minimal while=
 in
> > > > > here we
> > > > > could have to do 6 of them which could also be very time consumin=
g...
> > > > >=20
> > > > > Now, why we don't use available_scan_masks is something I can't r=
eally
> > > > > remember
> > > > > but this implementation goes in line with what we have in the
> > > > > adis16475
> > > > > driver.
> > > > >=20
> > > > > - Nuno S=C3=A1
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Thank you Nuno for all the additional explanations.
> > > > Regarding the use of available_scan_masks, the idea is to have any
> > > > possible
> > > > combination for accel, gyro, temp and timestamp channels or delta a=
ngle,
> > > > delta=20
> > > > velocity, temp and=C2=A0 timestamp channels. There are a lot of com=
binations
> > > > for=20
> > > > this and it does not seem like a good idea to write them all manual=
ly.
> > > > That is=20
> > > > why adis16480_update_scan_mode is used for checking the correct cha=
nnels
> > > > selection.=C2=A0=20
> > >=20
> > > If you are using bursts, the data is getting read anyway - which is t=
he
> > > main
> > > cost here. The real question becomes what are you actually saving by
> > > supporting all
> > > the combinations of the the two subsets of channels in the pollfunc?
> > > Currently you have to pick the channels out and repack them, if pushi=
ng
> > > them all
> > > looks to me like a mempcy and a single value being set (unconditional=
ly).=C2=A0
> >=20
> > > Then it's a question of what the overhead of the channel demux in the=
 core
> > > is.
> > > What you pass out of the driver via iio_push_to_buffers*()
> > > is not what ends up in the buffer if you allow the IIO core to do dat=
a
> > > demuxing
> > > for you - that is enabled by providing available_scan_masks.=C2=A0 At=
 buffer
> > > start up the demux code computes a fairly optimal set of copies to re=
pack
> > > the incoming data to match with what channels the consumer (here prob=
ably
> > > the kfifo on the way to userspace) is expecting.
> > >=20
> > > That demux adds a small overhead but it should be small as long
> > > as the channels wanted aren't pathological (i.e. every other one).
> > >=20
> > > Advantage is the driver ends up simpler and in the common case of tur=
n
> > > on all the channels (why else did you buy a device with those measure=
ments
> > > if you didn't want them!) the demux is zerocopy so effectively free w=
hich
> > > is not going to be the case for the bitmap walk and element copy in t=
he
> > > driver.
> > > =C2=A0=20
> >=20
> > Maybe my younger me was smarter but reading again the validation of the=
 scan
> > mask
> > code (when available_scan_masks is available), I'm not sure why we're n=
ot
> > using them.
> > I think that having one mask with delta values + temperature and anothe=
r one
> > with
> > normal + temperature would be enough for what we want in here. The code=
 in
> > adis16480_update_scan_mode() could then be simpler I think.
> >=20
> > Now, what I'm still not following is the straight memcpy(). I may be mi=
ssing
> > something but the demux code only appears to kick in when we have compo=
und
> > masks
> > resulting of multiple buffers being enabled. So I'm not seeing how we c=
an
> > get away
> > without picking the channels and place them correctly in the buffer pas=
sed
> > to IIO?
>=20
> It runs whenever the enabled mask requested (the channels that are enable=
d) is
> different from the active_scan_mask. It only sends channels in one
> direction if there is only one user but it only sends the ones enabled by=
 that
> consumer.
> It's called unconditionally from iio_enable_buffers()
>=20
> That iterates over all enabled buffers (often there is only 1)
>=20
> and then checks if the active scan mask is the same as the one for this
> buffer.
> https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrialio=
-buffer.c#L1006
>=20
> The setup for whether to find a superset from available_scan_masks is her=
e
> https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/iio/industrialio=
-buffer.c#L928
>=20
> Key is that if it happens to match, then we don't actually do anything in=
 the
> demux.
> It just gets passed straight on through.=C2=A0 That does the fast path yo=
u mention
> below.

Ahh got it... May failure was not realizing that iio_scan_mask_match() retu=
rns
the available masks so I was assuming that the bitmap_equal() check would o=
nly
differ when multiple buffers are enabled.

Oh well, I think then this should work... I'm not sure it will be more
performant for the case where we don't enable all the channels because the =
demux
is a linked list which is far from being a performance friend (maybe we can=
 do
some trials with something like xarray...). Still, for this to work the buf=
fer
we pass into IIO has to be bigger than it needs to be (so bigger memset())
because, AFAIU, we will have to pass on all the scan elements and, as I sai=
d,
the burst data will either have delta or normal measurements (not both). I =
guess
the code will still look simpler so if there's no visible difference in
performance I'm fine with the change. I guess Ramona can give it a try to s=
ee
how it looks like.

- Nuno S=C3=A1
>=20


