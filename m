Return-Path: <linux-kernel+bounces-49323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D153F8468AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C2E1C25070
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F2199A1;
	Fri,  2 Feb 2024 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePjPqoU7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697018651;
	Fri,  2 Feb 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856984; cv=none; b=nBzH8SePGFexEhhspB/cSiPVDl1g1RbkrBUA00A4iWHF90CF0yKAF5ByPc0yOjOIdbw5dyNVP6A/VUNsvphhfF9lXs/KnHrm264i7nssglqs4kisokCuMTl9MqESEK2SiSv9rLuAANIzCGa1/Uh22VKZ3oKCQT2FKj13VYxR0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856984; c=relaxed/simple;
	bh=yF9yrQM09B6AL0xbJ9CSm6Z6IEul5mlZQooXaJJMHc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mga9zgY2vFKDxZBJ/mYZUkk2Rq+xAjDeY5l4sd9K6jrxsVm5rKilZxtEyoctZCmiKM2KvYoGM9sUxo4cHwd7b0X9vpdnR3MI5KLNOwv9TwCN0popjsYEjk9o8pOyxq5uwr+wsx9piWgz4/Wag4O9uonQrJD0mlYgst2AUU9JID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePjPqoU7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51124d86022so2826016e87.0;
        Thu, 01 Feb 2024 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856980; x=1707461780; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yF9yrQM09B6AL0xbJ9CSm6Z6IEul5mlZQooXaJJMHc0=;
        b=ePjPqoU7MXyZ1KiB4/ioc2KWNzihTLjUBNS3/h4ifSxwQnyCWtmQNBBZ812ilyfYTf
         TkcxmwaDdSkFwbRiROVrCO3TsDb9gaMvPh/oufTSbQW9Y+Er1tIEx/bd8KszqlngtwJm
         w4U00AsUTAModZPS8dszzwfNnojnA0emPx/o5VMlJtatQ1WzKlXwMTLkMuLjpg5pMCFB
         iVGeeD9a89eT0ZztNKTcGOZN4pE/E49BKfTlztxtJlhTBUG+r7gTSS9h5QhaAM2vqWcB
         sL7W4vxjLnQDmPKvzqqqxBK4cvOB/1ERAaK0DqvBANBVByyzc1KlOr9kXTECl2i++URi
         sSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856980; x=1707461780;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yF9yrQM09B6AL0xbJ9CSm6Z6IEul5mlZQooXaJJMHc0=;
        b=O2RYHqThC7GZeq1k11cY4Uc+rCtLhjqL7MxHE016aBB88PWOFttze71ahXTsB3tJZN
         tXLOLXoDGqdbBkg4/UlQ2UE/7WyHvq83fyHtW6/MLN3kWDc7CsQ5WtmH1wrR9sq5PiDc
         lYtsZ/tlo06hCbfoTulXrLAOz+nzbU+g4+kBcp89rkU/aU+eMg0Qj909r+9XF0Z3OUv7
         /yRo2edvrtagOnRJt8TkiBGdQaBB6pq8piTMK7eODwtqfciCsw+fTkYfbAy956BboyN8
         WmPnbQjRBYtz4LmDFoxEDdKeWGiuk6QwUmGpmDuuEnttjwr+0kfUOAEWoHfSWWrhmXMD
         fwww==
X-Gm-Message-State: AOJu0Yzv6F0wwAsrR0RPAkgpF2Ev9/M8CPNWpuB7VaSVklSqu50+piLb
	yuiGN29vf5o4MUcMbqyYeIDNgtaGcVIRLJlKc1d2QXwoaofzvOuG
X-Google-Smtp-Source: AGHT+IEl3yAqzStc3+PW0awcRE9AduCTTm9ZSV03Tn/uHsFOw+QySBOlR4m9Masr4btQRaKq63Q3RA==
X-Received: by 2002:ac2:5f9a:0:b0:511:3739:8471 with SMTP id r26-20020ac25f9a000000b0051137398471mr361742lfe.49.1706856979787;
        Thu, 01 Feb 2024 22:56:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbukDrfizC1VVj44cHLkyI3tlsYyErnrCRc4fILbxR+gCOX/B5jgg2ciR5ROuMoWo5JmrFHhIAqUiE6Ry9tYr5LrXPmBvSX8q4kvComZurEeRf3mirduZQB5ptHiYz5c5rn0KpvrsHveoTnmO6DXPLFk5aPw9e6d3po17AuSZPezoxE81iZ/bEQKQTe/E37lJQzGqOQQ35o6gM9f8Tw2l0gQ2MnSykhB9SyTUxU1VVi0ooshgByklHY43NB3lsww6HgeTNCm95CzXw97u5gZGKe0eux3tZ19YvY/ODLq3NDAt35o5cWstku7pqFQGBfpjDz7F1m9755cKrX50ZEl0ck82YJrjMc5cbfWobAvaW/5XWyK7L+123gjepBs3v6WdMLAoT/gD/vuSK23hQhl1/v/eJjQ==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c198b00b0040ef61dfd48sm1682247wmq.11.2024.02.01.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:56:19 -0800 (PST)
Message-ID: <4fae04008c6d4abadd89463d376cfd7c4d98675e.camel@gmail.com>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,  "linux@roeck-us.net"
 <linux@roeck-us.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>
Cc: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hwmon@vger.kernel.org"
	 <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>
Date: Fri, 02 Feb 2024 07:56:18 +0100
In-Reply-To: <c69ab341-468a-4bca-96b7-793342c421a7@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
	 <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
	 <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
	 <170c8d6b-3246-493f-8cd9-6ac580cabc28@alliedtelesis.co.nz>
	 <84827fd6461c9650443608e33afe9eb011793656.camel@gmail.com>
	 <c69ab341-468a-4bca-96b7-793342c421a7@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-02 at 00:28 +0000, Chris Packham wrote:
>=20
> On 29/01/24 20:55, Nuno S=C3=A1 wrote:
> > On Mon, 2024-01-29 at 03:28 +0000, Chris Packham wrote:
> > > On 26/01/24 20:51, Nuno S=C3=A1 wrote:
> > > > On Fri, 2024-01-26 at 02:22 +0000, Chris Packham wrote:
> > > > > Hi All,
> > > > >=20
> > > > > On 4/04/23 03:43, Ibrahim Tilki wrote:
> > > > > > changelog:
> > > > > > since v5:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: add enum value "2" to au=
x-voltage-chargable
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: remove adi,trickle-diode=
-enable
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: change description of tr=
ickle-resistor-ohms
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: reorder as in example sc=
hema
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - parse "wakeup-source" when irq not r=
equested
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - remove limitation on max31328 irq an=
d clokout
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - remove error and warning messages du=
ring trickle charger setup
> > > > > >=20
> > > > > > since v4:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: remove interrupt names.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: add description for "int=
errupts" property
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: replace deprecated prope=
rty "trickle-diode-disable"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by "aux-voltag=
e-chargeable"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: add new property "adi,tr=
ickle-diode-enable"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: remove "wakeup-source"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - use clear_bit instead of __clear_bit
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - use devm_of_clk_add_hw_provider inst=
ead of of_clk_add_provider
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - use chip_desc pointer as driver data=
 instead of enum.
> > > > > >=20
> > > > > > since v3:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - add "break" to fix warning: unannota=
ted fall-through
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reported-by: kernel test r=
obot <lkp@intel.com>
> > > > > >=20
> > > > > > since v2:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: update title and descrip=
tion
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - dt-binding: remove last example
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - drop watchdog support
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - support reading 12Hr format instead =
of forcing 24hr at probe time
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - use "tm_year % 100" instead of range=
 check
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 - refactor max313xx_init for readabili=
ty
> > > > > >=20
> > > > > > Ibrahim Tilki (2):
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 drivers: rtc: add max313xx series rtc =
driver
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: rtc: add max313xx RTCs
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 .../devicetree/bindings/rtc/adi,max313xx.yam=
l |=C2=A0 144 +++
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/rtc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 =
+
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/rtc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> > > > > > =C2=A0=C2=A0=C2=A0 drivers/rtc/rtc-max313xx.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1053
> > > > > > +++++++++++++++++
> > > > > > =C2=A0=C2=A0=C2=A0 4 files changed, 1209 insertions(+)
> > > > > > =C2=A0=C2=A0=C2=A0 create mode 100644
> > > > > > Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > > > > > =C2=A0=C2=A0=C2=A0 create mode 100644 drivers/rtc/rtc-max313xx.=
c
> > > > > What happened to this series in the end? It kind of went off my r=
adar
> > > > > and I forgot about it.
> > > > >=20
> > > > > We've been carrying a version of these changes in our local tree =
for a
> > > > > while (and using it quite happily I should add).
> > > > >=20
> > > > Hi Chris,
> > > >=20
> > > > Also not sure.... In the meantime Ibrahim left ADI so if this is no=
t in
> > > > shape to
> > > > be merged he won't be able to re-spin. If there's a need for a re-s=
pin,
> > > > please
> > > > let me know so I can see internally if there's someone who can cont=
inue this
> > > > work. I would do it myself if I had the HW.
> > > I've got a board with a max31331 so I can test that. I don't have any=
 of
> > > the interrupts hooked up so I won't be able to test that. Looks like
> > > there was some outstanding discussion around the trickle-charge
> > > devicetree properties so I'd need to figure out what was wanted there=
.
> > > I'll try to pick up the last series from the mailing list and go from=
 there.
>=20
> I see that in the meantime Antoniu has landed a max31335 driver. Does=20
> anyone know off-hand how close the max31335 is to the other max313xx=20
> variants? Should I leave them separate or attempt to integrate the two.
>=20

Hi Chris,

I did not looked into the devices datasheets but typically, if the register=
 map is
close enough we should try to integrate them in the same driver.

Thanks for continuing this work btw!
- Nuno Sa

