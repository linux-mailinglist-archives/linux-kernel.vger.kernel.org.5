Return-Path: <linux-kernel+bounces-123849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA5890ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C13A1C237B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3F8460;
	Fri, 29 Mar 2024 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY2YYAMi"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56B23A8;
	Fri, 29 Mar 2024 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670649; cv=none; b=uUJgfcNGWsk/QJWkC8FdHDF/c2wavSXtzZIT4maWEvrd/neqXhdVUKHV64+bVA77qV82bwdLt8CMOfWjxTDfHW20GfHSplVaro1JWEXhrS8CELyl0YdywRtg0IRLwxqa22FgRjRJG1LbL4YWoL2IrQa02meaTdjDax45bfhRhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670649; c=relaxed/simple;
	bh=djpBvSxFpgiKVso1vC8eoz/ew1HepMaOFxyaEXBkZ+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amLQiXZYtz+J+RFSivFzWN8WM+Bzl3tCSIhF18i+8sC94SoZdemedY3cXsWzpA0bkN7qE/K3yhcFWxfU6RyXjQQ/otATT8G4iKk3YzKBF3jqEtJU/nDu91cZc+1xTcp+cacuAPRetxBMFkywTsIbTO1T2n2uM82fJ0x1kDKLNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY2YYAMi; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0a1bd04eso17247187b3.1;
        Thu, 28 Mar 2024 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711670646; x=1712275446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKJflJe9SAvt41XpvEFgU1eczu3XFIziapyQDCRKyyM=;
        b=FY2YYAMim++bK/92SqLjDuF99hw/a6vjfI/WJTsE64TUb0xMFuMMQ8SzJGtfArN1vI
         Wu92lwq5nh2HXfXnznxcASUwLG8ha/Vkn4GFcZ+oBQk+kDRUv7O8V1Uam8zuOwtqihZC
         vDVtIZI6VSGF+TrZIQE6X23IN4asEd4FsKSjLiKjAYrsd4RlkYrAjDc+V9BRLWsfhYfw
         R6dAYKkWEIZWiFq7jQBjoLor7i1TKwYajsFXvu+6lGnq9UOR/2+/Md3S9rW2kSmBsHT2
         hLanPFfpdds1XZUVjycLQhqKGmXwb2wT7Re5/qrXaDN2g4bzWgYJayMhzRQmLhOrGXRD
         kH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670646; x=1712275446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKJflJe9SAvt41XpvEFgU1eczu3XFIziapyQDCRKyyM=;
        b=G/omOjXmh0BSqhybVFygPq/MBfYbRhtVAaSxHYgMKtZx+rSvLGNdpxXB+u+1Vo4Q8M
         c5PGIg67du3sQ+rdPtJLrkUjz1MXMS59vpmfBSUwAMLFQ6dSNGaK7zaGv4E1jN/gm/oA
         IHkblMBDhKI2UxAmid+4KntnRyX+aX8gJg0iMGqzSed76Z6iDv20CzpbnUSdxiUi8i00
         x/9UPQXdnl7yC144YEVI3xN5loenEd5a22HUecFKU4EQf6AYr8BTB1jeXgJ4ioXBzEI3
         PsP/RX0bdSeTx3G+ZcuExJpYEhuhkWrP5iPTPyhZzhquegD49J0tf8dB+n7u+ciaexdi
         KXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE9+sLaOZrGTRf6ZbJ8CqQII7ilNmK5QeNrktWK7udzoaU+pb2nW6pmJh2XOi4EcT7xzasmi7cHYVQmghElScEdhE0t1leNKIowZyRQQTfJAoT3uKpKDJ9l0PqvIjh4BYhapSgPDP0aLkrc2QJwQw8ndVsH97xJGBo1s3VGBIagAavfw==
X-Gm-Message-State: AOJu0YwVMlvzHNbsX09BdQW0VO3eYP0VXg0NuXdtSX/Edbgtg1K4gIGq
	lbSLTjAcUY+MAFRBQuMHFY+TyJF4yMOYdTa95Dmfm4LnGri/SpDg0vta/9AvwNh6wW6qnRW3kDj
	OV9/3SUdyoK4eAAEf3YRn7Sx55fw=
X-Google-Smtp-Source: AGHT+IFlFhEAYhnFnzioGqw5/Gv70sk9qhgM4Wl2R6HpJ1WZROvfK65Qip2q7Mnm20GidITcmlwHMYLp4exODvQYFww=
X-Received: by 2002:a81:488f:0:b0:607:9102:c1b0 with SMTP id
 v137-20020a81488f000000b006079102c1b0mr1063365ywa.43.1711670646241; Thu, 28
 Mar 2024 17:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327220320.15509-1-l.rubusch@gmail.com> <20240327220320.15509-2-l.rubusch@gmail.com>
 <20240328133720.7dfd46b0@jic23-huawei>
In-Reply-To: <20240328133720.7dfd46b0@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 29 Mar 2024 01:03:29 +0100
Message-ID: <CAFXKEHaPcbRMVJTWW0Atg37jqb97JBdPoSmm3gAZEO1Q=SZm9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] iio: accel: adxl345: Make data_range obsolete
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:37=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 27 Mar 2024 22:03:14 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Replace write() data_format by regmap_update_bits(), because bus specif=
ic
> > pre-configuration may have happened before on the same register. For
> > further updates to the data_format register then bus pre-configuration
> > needs to be masked out.
> >
> > Remove the data_range field from the struct adxl345_data, because it is
> > not used anymore.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 8bd30a23e..35df5e372 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -37,7 +37,15 @@
> >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> >  #define ADXL345_POWER_CTL_STANDBY    0x00
> >
> > +#define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g range =
*/
> > +#define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (MSB) mo=
de */
> >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolutio=
n */
> > +#define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7) /* Enable a self t=
est */
> > +#define ADXL345_DATA_FORMAT_MSK              (ADXL345_DATA_FORMAT_RANG=
E | \
> > +                                      ADXL345_DATA_FORMAT_JUSTIFY |  \
> > +                                      ADXL345_DATA_FORMAT_FULL_RES | \
> > +                                      ADXL345_DATA_FORMAT_SELF_TEST)
> This needs renaming.  It's not a mask of everything in the register, or
> even just of everything related to format.
>
> Actually I'd just not have this definition.  Use the build up value
> from all the submasks at the call site.  Then we are just making it clear
> only a subset of fields are being cleared.
>
I understand this solution was not very useful. I'm not sure, I
understood you correctly. Please have a look into v6 if this matches
your comment.
Now, I remove the mask, instead I use a local variable in core's
probe() for the update mask. I added a comment. Nevertheless, I keep
the used flags for FORMAT_DATA. Does this go into the direction of
using the build up value from the submasks at the call site?

> Jonathan
>
> > +
> >  #define ADXL345_DATA_FORMAT_2G               0
> >  #define ADXL345_DATA_FORMAT_4G               1
> >  #define ADXL345_DATA_FORMAT_8G               2
> > @@ -48,7 +56,6 @@
> >  struct adxl345_data {
> >       const struct adxl345_chip_info *info;
> >       struct regmap *regmap;
> > -     u8 data_range;
> >  };
> >
> >  #define ADXL345_CHANNEL(index, axis) {                                =
       \
> > @@ -218,15 +225,14 @@ int adxl345_core_probe(struct device *dev, struct=
 regmap *regmap)
> >
> >       data =3D iio_priv(indio_dev);
> >       data->regmap =3D regmap;
> > -     /* Enable full-resolution mode */
> > -     data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> >       data->info =3D device_get_match_data(dev);
> >       if (!data->info)
> >               return -ENODEV;
> >
> > -     ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > -                        data->data_range);
> > -     if (ret < 0)
> > +     /* Enable full-resolution mode */
> > +     ret =3D regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> > +                              ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FO=
RMAT_FULL_RES);
> > +     if (ret)
> >               return dev_err_probe(dev, ret, "Failed to set data range\=
n");
> >
> >       indio_dev->name =3D data->info->name;
>

