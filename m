Return-Path: <linux-kernel+bounces-7112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EE81A1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BA41C24385
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F453E477;
	Wed, 20 Dec 2023 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CViwSprz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B463F8E1;
	Wed, 20 Dec 2023 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a234dc0984fso442338766b.0;
        Wed, 20 Dec 2023 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703084663; x=1703689463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+FfBqBNd0+Ooi87DUPeSIHsvlTqgIirN4trPwAQVew=;
        b=CViwSprzy3FYBf35xL3SpdAh3TEtzHqFjc5+ZnFQkYkFVJO/AYnvzhJzbgqKXy6h5d
         Na2RoOCC2Dov6cqnynLklYBPY8jbPYDOKui8Anp9502Ypfj8nS1eGAE1J0vOpif5IqaE
         cbIiYLI8hEL60czQBrIBQ95VlDpOL6aMg6xNRdQur1tTpmpSI72FMuqmC92tTn/K+B5T
         8LVTcf5efEh+mNPUhWhUhj0Jxf87WY609ZcQyUK1qJ6zU1ZRowWnzWCu9qlDhpJ3ecAA
         x22uSSANEYn9QIE9Z7aEDLTCpS8FW6/fKk41lgs2pR8QvRAj4mvWbOVQPy8oxfpA5wHq
         DECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084663; x=1703689463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+FfBqBNd0+Ooi87DUPeSIHsvlTqgIirN4trPwAQVew=;
        b=IVYLlYqZFuVVyZj5ezREm4OeTuPTreAkT3MPfYx9rG/o1HUTcHnFU7IY+Nn7KwEWwm
         VZVvS4LSjtksy0MzvH0GPE6qoe+dwcueUnKcX11J3zVCoNQWF2pDn6rNprmwKxsywaLR
         S0PvdyZDaUJWyO/LWnl6ThxH2Qm8686rEPAqDhdPowMZqaCzu6NV07icW3hZgwyeHP0S
         PhW50DfY9hi/w7b0dKwe7hb6i46A+nKk0/QZKi8jSMBoizCV65hnFmKuGOhXiJ7QyNyY
         ut0oYbTPv0DmuLrnAKDQuZYo//Q95wXTxCK7J9Q7xcSXA/7R9p8Qph02NLUNBWmVXnB2
         DAOg==
X-Gm-Message-State: AOJu0Yz3nZ4AwetJy5g46j+DI60ClAEoOlQb9I12sRjLR77z/JCCsRBy
	uIijP/kYvNGuph/Rv+xe3VVfvdAWezKPBVT39+Q=
X-Google-Smtp-Source: AGHT+IGSecUZu4w3duyPqW9S7Vlu90pXrxYFY71pYtYLpgbVv9CvDmKwXUd6vsk2nXx9FBMIGpCiBWqZTSbNMFjvplo=
X-Received: by 2002:a17:906:aac2:b0:a26:84d2:27e3 with SMTP id
 kt2-20020a170906aac200b00a2684d227e3mr1283414ejb.53.1703084663001; Wed, 20
 Dec 2023 07:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219231503.1506801-1-jekhor@gmail.com> <20231220145229.020abe62@jic23-huawei>
In-Reply-To: <20231220145229.020abe62@jic23-huawei>
From: Yauhen Kharuzhy <jekhor@gmail.com>
Date: Wed, 20 Dec 2023 17:04:11 +0200
Message-ID: <CAKWEGV50duj-TcKdQp1BtN_QgnBZyG0WgAqo8Y5UtCinqOAh_g@mail.gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 20 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 16:52, Jon=
athan Cameron <jic23@kernel.org>:
>
> On Wed, 20 Dec 2023 01:15:03 +0200
> Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> > After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-function
> > sensor devices") hub devices are claimed by hidraw driver in hid_connec=
t().
> > This causes stoppping of processing HID reports by hid core due to
> > optimization.
> >
> > In such case, the hid-sensor-custom driver cannot match a known custom
> > sensor in hid_sensor_custom_get_known() because it try to check custom
> > properties which weren't filled from the report because hid core didn't
> > parsed it.
> >
> > As result, custom sensors like hinge angle sensor and LISS sensors
> > don't work.
> >
> > Mark the sensor hub devices claimed by some driver to avoid hidraw-rela=
ted
> > optimizations.
> >
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Fixes tag?

Fixes: 666cf30a589a ("HID: sensor-hub: Allow multi-function sensor devices"=
)

>
> > ---
> >  drivers/hid/hid-sensor-hub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.=
c
> > index 2eba152e8b90..26e93a331a51 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device *hdev=
,
> >       }
> >       INIT_LIST_HEAD(&hdev->inputs);
> >
> > -     ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +     ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIV=
ER);
> >       if (ret) {
> >               hid_err(hdev, "hw start failed\n");
> >               return ret;
>


--=20
Yauhen Kharuzhy

