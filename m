Return-Path: <linux-kernel+bounces-161840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285838B520E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7D280DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95C13FE7;
	Mon, 29 Apr 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILkP7k7U"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFD134BE;
	Mon, 29 Apr 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374824; cv=none; b=QcB7gGjkComIGkkK+qUkiqVPK2BymbRggbGtgSAbMzTwrMbgc3ksbeijMdu8tPSeaen+opaDuPgX/K+1MoYvRUs1+X2m9IT/avM/9GPzXyVkbfNbdlOKdTR00lPpasslswHtOyJLDZ4oUK8oOnYMPO5SpF36lx/PDKAQbrpdGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374824; c=relaxed/simple;
	bh=+hqrct1glvL58HkQZQ62f7MQqOS2zEStZd8S2vqKT2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUKj58IfnotxCfLIpWe4xI+FdQaKoB/vSKfR4E9gElzKvOdcFl8ozoC0O91dwVJQjIa0ra6dpEf8qN0QfEyL7k/BadSV+k43Oy4XH+5AkOIvkh+XGkW/ZzLYIruUyZJR1mN2AYn17YpFC/g/QX+s/7rzohGTt9clW9Ib8pASBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILkP7k7U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so27963375e9.0;
        Mon, 29 Apr 2024 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714374821; x=1714979621; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hqrct1glvL58HkQZQ62f7MQqOS2zEStZd8S2vqKT2A=;
        b=ILkP7k7Uq6hw9+PRDnk+1gbzT2LG6/1GGl6mq6GxhiAkcsY9FfkRFQuAL4heHIDDmn
         CIesBEU9dJgSBpkkdOnvRqrbpU/aQ6tGgzkouSEo/U0vbFoLEs/3DSY+9bgEhjOcODFk
         C7LUtfgvjO/vQHKTFElWNw7emV6ELvAjCspisUJEoMhpYwwx0xbxTs672ZGBjTHrTBat
         YJ7vXL3Yn6fsmrbni4o1xeQBEI12VgYf3gpE/ILcoUyTS4nAQzloXLnKXY4iSp1ttenw
         jH3Bnigr7m9hzwnR2VNZL26rGlHc6xnM0pJYidXRqZAzjk2zJfdh15ADontBtDB2buGQ
         r92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714374821; x=1714979621;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hqrct1glvL58HkQZQ62f7MQqOS2zEStZd8S2vqKT2A=;
        b=Omx0A2NRJuS3kzWM7IOxNLVdrmu8Q020JiF2sRa+idUUWYD4V0vCEDSNjLh0a3+Ilt
         nlXXVDeSxLLX8PV+rLudHYIiZ/RGwptsgPzMH8ndn24vN70/yHJ6z/B2UjQnG8Zyi4UV
         yydZ4hlQFnYnVKJNZMa7NHzNWnUFGTXQiHeBspR9sYYhcWKAeAYTSB5ZEMkQEf2wxI6f
         XjIpm48kKVc8OaMbTtnu5huxBR6mzthJ2Vk0URuUdvaTGKMnn/Qj17pEnfJdqwbfILlf
         XxxDu01kX638NuFwBPYik2greqYDTxHW9scE6D7wDB+5XQOUSylgaaaXpRc+qH4G32YS
         T/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeEsM01ye77CWolQ/YV6dMYbeqKEXkujlRuLaPH3TKT3+gMn2s49G4srdNggqh2mlHNUjGMAkDBuG1TX0NPMPcTKdwHoUQKLuVP5R7PGsHMLyt6FJrrW41PsZDAgWydh6aE+oikWCa
X-Gm-Message-State: AOJu0Yy4k7ViP0779JMhnq7ZrEk1NiA+X/X9ZVVQEEHoI2peGBwPdegy
	GHhB8yGU3E2SwBd4lU9AIRWl8Mc5tJZ5+dwXtYsUOPz5Qh/6033C
X-Google-Smtp-Source: AGHT+IHsnOgDmNCZDHXtkTu23Oi6Kkv6U6smYB4eXQYcS48Rr+6Ht7ybUGYjW3UEpoXwMQOT/fjbHA==
X-Received: by 2002:a05:600c:458b:b0:41c:ab7:fa22 with SMTP id r11-20020a05600c458b00b0041c0ab7fa22mr3191722wmo.5.1714374820550;
        Mon, 29 Apr 2024 00:13:40 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5084000000b0034c6077c625sm7581519wrt.29.2024.04.29.00.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:13:40 -0700 (PDT)
Message-ID: <9d1ac78951439bbcdc2f294713f55ee34e30f84e.camel@gmail.com>
Subject: Re: [PATCH 0/3] iio: cleanup masklength usage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Date: Mon, 29 Apr 2024 09:17:18 +0200
In-Reply-To: <20240428142343.5067c898@jic23-huawei>
References: 
	<20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
	 <2630ef8c8363b4fa772a2ff2c95cf115ad3c509d.camel@gmail.com>
	 <CAMknhBGQB4MC8ejEs_uLgb=iKehXkoetgHjZnCvCKQbuua5kfA@mail.gmail.com>
	 <20240428142343.5067c898@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 14:23 +0100, Jonathan Cameron wrote:
> On Fri, 26 Apr 2024 10:26:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On Fri, Apr 26, 2024 at 2:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote:
> > >=20
> > > On Thu, 2024-04-25 at 10:03 -0500, David Lechner wrote:=C2=A0=20
> > > > While working on other patches I noticed that a few drivers are set=
ting
> > > > the masklength field of struct iio_dev even though it is marked as
> > > > [INTERN]. It looks like maybe this was not always the case, but we =
can
> > > > safely clean it up now without breaking anything.
> > > >=20
> > > > ---
> > > > David Lechner (3):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7266: don't set maskleng=
th
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: mxs-lradc-adc: don't set m=
asklength
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: initialize masklength a=
ccumulator to 0
> > > >=20
> > > > =C2=A0drivers/iio/adc/ad7266.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1 -
> > > > =C2=A0drivers/iio/adc/mxs-lradc-adc.c=C2=A0=C2=A0 | 1 -
> > > > =C2=A0drivers/iio/industrialio-buffer.c | 2 +-
> > > > =C2=A03 files changed, 1 insertion(+), 3 deletions(-)
> > > > ---
> > > > base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> > > > change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901
> > > > =C2=A0
> > >=20
> > > Hi David,
> > >=20
> > > Nice cleanup. The patches look good to me but there's one thing missi=
ng
> > > :). As you
> > > correctly noted, the field should be internal to the IIO core and dri=
vers
> > > should not
> > > touch it. Hence, you need to make sure not driver is using it so we c=
an
> > > move it into
> > > struct iio_dev_opaque [1]. That's the place all the intern fields sho=
uld,
> > > eventually,
> > > end up.
> > >=20
> > > Now, quite some drivers in the trigger handler will read the maskleng=
th
> > > for looping
> > > with for_each_set_bit(). Hence, the straight thing would be an helper=
 to
> > > get it.
> > > Maybe there's a clever way...
> > >=20
> > > I know this is more work than what you had in mind but I think it sho=
uld
> > > be fairly
> > > simple (hopefully) and since you started it :), maybe we can get the =
whole
> > > thing done
> > > and remove another [INTERN] member from the iio_dev struct.
> > >=20
> > > [1]:
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio-=
opaque.h#L42
> > >=20
> > > - Nuno S=C3=A1=C2=A0=20
> >=20
> > Sounds like fun. :-p
> >=20
> > I will look into it.
>=20
> I think this one might be miss marked as [INTERN]. It should be constant =
from
> the driver
> point of view, but given active_scan_masks is meant to be visible to the
> driver,
> it's length should probably be as well.
>=20

Yeah, that did crossed my mind. I guess we should just make it [DRIVER] the=
n
(likely with RO statement).

> Sure every driver should be able to trivially work this out for themselve=
s,
> but
> do we care about stopping them using this?
>=20
> It might be worth some nice iterator wrappers with names like
> iio_for_each_active_channel() though I'd expect those to still be accessi=
ng
> these

That looks like a good idea. It would make it more clear that member is not=
 to
be directly accessed.

- Nuno S=C3=9Fa


