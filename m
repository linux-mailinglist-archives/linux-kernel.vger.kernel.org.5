Return-Path: <linux-kernel+bounces-147105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8A8A6F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC65F1F217AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7871130496;
	Tue, 16 Apr 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gPZKpztb"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD2130A76
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280734; cv=none; b=XR2ozElW4avb5X8rsXg7y3qBpIsU47xNTNOTf2QqWQADo1fGngZtpAwEnNotBajL2u+/wuIqcuyp131gfnACONmPljfb8Mk6YfZ5YVQAZ7nVy3kD/8ee/T+IWyqSWLgKtT+RP47jJY5fj4Ajqarkrnp1x3+OlhvxQ/FFMk8Pm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280734; c=relaxed/simple;
	bh=UMePqEyCmVfk7ZgwfylWZhfwuZ/2Cp18577seBEfpOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2oWtnHco/fjyq4rySPf8d7bSOOgj+bC5KAb6+LqHqGOyLQ1SC/ZB1AjLqdEGkgXRewTfpDcG53bJLit0TTJ30SSO2jS8Mu1zdOaZe/QIC416koRCQqmtDG451GsK31l8ue1/75p2B0REaxFMufVb6Tbc9yaBn5FS894C29vjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=gPZKpztb; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74435c428so4424784276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1713280732; x=1713885532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LXwJvrpu5XtyICEE51W/asLOgN0+jOQgk8lgWBDIns=;
        b=gPZKpztbTn/s11r81qqt2tyTphMvT+T2e0koU+F/1VPCYu6tmjhex1Sa8EUEbBPCDj
         BKsOQKz/pdVrM9eQiDeW7yQAHg0oiXM7mAdS7OrrE2WDoswdGlv5Ma03WPCm+xu2r0ya
         A0hJ1JdF2GoU58oVvcYP3hhPLex0FtS0lPp7zNvvj4ogW5kcs49bqfKd+K459sTiQW47
         2lD6LVS5vSUNd8BDrqmNmmWApovKGB0x6gcgSGWLOcve3hBehAhufPeryBrlGZTxmRL3
         T1yKG7n7idMYWjFY3NyzcOCPZXT8kytDD5iG48282QxbQbOEBiV8KnB4hRUfGJyT4a71
         c0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280732; x=1713885532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LXwJvrpu5XtyICEE51W/asLOgN0+jOQgk8lgWBDIns=;
        b=VA72BXrmSNJQsHWnl1BeMfRA0idImKwkpRCNMcj4z62LYY713FDT3QDFGCVW1VE1Ku
         X4d4MUFZznzPFQoLFG0VGEBCjkMD9jYv8tZXwNglv+UgrwQBdeCs/lGShzIroHVB6tc0
         UjZDuV+rWp/0AkI7TcBnmkfldkM45OBB7SvILxbvQlqCRYxMamQy6R5nlwmXSKyZ3k2P
         hwk+iHZxcEW3xV+TTPwnbJeGAcmP+g117tgIl3KEX9AZKh3NTKpQZJQjuNPZCvshx7Fa
         NhjvlD2YwQ3h909JyUpx4jPUL45AUlyxiE+1Vx6D5sIo/6khi4grkjW1ALnVtpKOodyB
         29eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qRW7FEZ9xG0Z2r/DvwIVe/fWxjTgwuCcZ5lU/LrMzwu9xCvCCIcP+LKEzoVHbmDh6ADI3RtZ/htCD44pURKtaK3ySPqMFBUYKVci
X-Gm-Message-State: AOJu0YzFKJYOMfwq6Foq3Dt8l/rgH0rgok0nY+ChAvr6X8DeZsbgOuAB
	cCDwEDSioqMfti5OD7GdcEyrYKLYfoTEwaRg+PLbTblzpvBNvcJzQNo6sU4k1l2TKvJ7rbyuXE8
	EFQs0RkzJJS20xRUtKFLDmg6FxT1k5jnERzXNBw==
X-Google-Smtp-Source: AGHT+IEM14BkgGATsXF6uCE5qYqegVtX765FkUZTIdAjRLYK8ynA4eYAf4JOqjfc0TInKcWDrTkiujQ4lABhn5Zwxug=
X-Received: by 2002:a05:6902:18c5:b0:dc6:d2d3:a57c with SMTP id
 ck5-20020a05690218c500b00dc6d2d3a57cmr14225747ybb.59.1713280732051; Tue, 16
 Apr 2024 08:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414203503.18402-1-git@luigi311.com> <20240414203503.18402-3-git@luigi311.com>
 <6041186.lOV4Wx5bFT@steina-w>
In-Reply-To: <6041186.lOV4Wx5bFT@steina-w>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 16 Apr 2024 16:18:35 +0100
Message-ID: <CAPY8ntDMFcNN_kcAd_VWDfPbJ2GAua-TbpyOqLJA-kYJPWz-6A@mail.gmail.com>
Subject: Re: [PATCH v4 02/25] media: i2c: imx258: Make image geometry meet
 sensor requirements
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-media@vger.kernel.org, git@luigi311.com, 
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	sakari.ailus@linux.intel.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pavel@ucw.cz, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander

On Mon, 15 Apr 2024 at 07:25, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Sonntag, 14. April 2024, 22:34:40 CEST schrieb git@luigi311.com:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >
> > The output image is defined as being 4208x3118 pixels in size.
> > Y_ADD_STA register was set to 0, and Y_ADD_END to 3118, giving
> > 3119 lines total.
> >
> > The datasheet lists a requirement for Y_ADD_STA to be a multiple
> > of a power of 2 depending on binning/scaling mode (2 for full pixel,
> > 4 for x2-bin/scale, 8 for (x2-bin)+(x2-subsample) or x4-bin, or 16
> > for (x4-bin)+(x2-subsample)).
> > (Y_ADD_END =E2=80=93 Y_ADD_STA + 1) also has to be a similar power of 2=
.
> >
> > The current configuration for the full res modes breaks that second
> > requirement, and we can't increase Y_ADD_STA to 1 to retain exactly
> > the same field of view as that then breaks the first requirement.
> > For the binned modes, they are worse off as 3118 is not a multiple of
> > 4.
> >
> > Increase the main mode to 4208x3120 so that it is the same FOV as the
> > binned modes, with Y_ADD_STA at 0.
> > Fix Y_ADD_STA and Y_ADD_END for the binned modes so that they meet the
> > sensor requirements.
> >
> > This does change the Bayer order as the default configuration is for
> > H&V flips to be enabled, so readout is from Y_STA_END to Y_ADD_STA,
> > and this patch has changed Y_STA_END.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > Signed-off-by: Luis Garcia <git@luigi311.com>
> > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> > ---
> >  drivers/media/i2c/imx258.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > index 2dbafd21dd70..4a7048d834c6 100644
> > --- a/drivers/media/i2c/imx258.c
> > +++ b/drivers/media/i2c/imx258.c
> > [snip]
> > @@ -707,7 +707,7 @@ static int imx258_open(struct v4l2_subdev *sd, stru=
ct v4l2_subdev_fh *fh)
> >       /* Initialize try_fmt */
> >       try_fmt->width =3D supported_modes[0].width;
> >       try_fmt->height =3D supported_modes[0].height;
> > -     try_fmt->code =3D MEDIA_BUS_FMT_SGRBG10_1X10;
> > +     try_fmt->code =3D MEDIA_BUS_FMT_SBGGR10_1X10;
>
> Does someone have access to the data sheet? I am wondering how the
> arrangement of the pixel array is shown. I've the following (identical)
> array for these sensors:
> * imx290/imx327
> * imx219
> * imx415
>
> G B G B
> R G R G
> G B G B
> R G R G

Check the other 3 corners of your diagrams - they are not identical.

> Yet each driver configures a different bus format:
>
> * imx290.c: MEDIA_BUS_FMT_SRGGB10_1X10
> * imx415.c: MEDIA_BUS_FMT_SGBRG10_1X10
> * imx219.c: MEDIA_BUS_FMT_SRGGB10_1X10 (no flip)
>
> imx219 actually defines all 4 10 Bit Bayer patterns and the comment
> indicates this depends on how v or h flip is configured.
> Reading the commit message apparently the same is true for this driver.

Correct.

> Still this is confusing as I would have expected flipping to be disabled =
by
> default, expecting the same Bayer pattern order for all drivers. Can some=
one
> shed some light?

Comparing different families of sensors isn't really valid, and
manufacturers vary too.

imx290 is a Starvis sensor, and has an array of 1945x1109, so all 4
corners are red pixels. It crops an even number of pixels off the
array in the direction of readout, therefore always producing RGGB.

I don't have a datasheet for imx415. Whilst it is also a Starvis
sensor the product brief [1] says it is an array of 3864 x 2228, with
3864 x 2192 effective pixels, which implies it isn't doing the same as
imx290. However the current driver isn't changing the Bayer order
based on flip which contradicts that. Pass as to which is correct.
I can't answer why the default order is GBRG. Presumably the default
window mode used (it doesn't use X_START / Y_START registers) crops an
odd number of lines off the raw array, therefore starting on a GB row.

imx219 (Exmor R) and imx258 (Exmor RS) datasheets have an even number
of pixels in each direction in the array, and whilst the first pixel
read out in the default direction is red, the colours in the opposite
corner is blue, with green in the remaining corners. This is why the
Bayer order changes with flips.

Most Omnivision sensors I've encountered do the same as imx219/258,
whilst OnSemi sensors are the same as imx290. Drivers obviously have
to match whatever the hardware does.

  Dave

[1] https://www.sony-semicon.com/files/62/pdf/p-12_IMX415-AAQR_AAMR_Flyer.p=
df

> Best regards,
> Alexander
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

