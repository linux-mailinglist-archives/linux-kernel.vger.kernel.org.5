Return-Path: <linux-kernel+bounces-164709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8488B8175
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B761C22ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2451A0AEE;
	Tue, 30 Apr 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW3c+N99"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F150287;
	Tue, 30 Apr 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509235; cv=none; b=QrKf00EARnLfzC4/EBBKGKqQToesVcj0y6RiSomaL6vZUxdod6nVVzW9ifzd8vP7pVOXygkBrtJX5zQ7yrIu4SZlxwIyW50NJKvyhJ0EB3Ng74cxSC7db17ToAyaEQHW/zXDJkVZycg2yU3IuVIM2jzF11NZck7cIXM+Q+QckhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509235; c=relaxed/simple;
	bh=kcoGDHSpvqAd9PfuCoNtfRvVdf2uMHUY2SdpJjNDwFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n16VTRZc6SrDDmP9h9M/kijorEPbTigEePVaN+l/OQfnwmh/PHlflERlMnInbbp6VGcRFXmHBDKaFbxVC61qioD+SehbvS+6oU/HzRxCNqCssUCbU1Ndq6fr3aHWWqYTOGTWMAm1yr2jKSWDTyUKwwb8B4PiJvDE7u4b5cMj7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW3c+N99; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5196fe87775so6881672e87.3;
        Tue, 30 Apr 2024 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714509232; x=1715114032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4iUwetf6OktDd6c6v6370iAXTjd5m8pEJ3+fHMgbhc=;
        b=UW3c+N99IFpSJqndRE0hRl3e/x09cOUuSsAuyoYe0b07P4EmPfYShbyNt6FO7YBgCU
         6bd6NaJOndFdYDOKlKR8dqr/Ck0kKBz5DYTb83mJh+WyuAVa63xRFBO/Dbz2bDS3yNqC
         kWzhgk7PxesA94WtuZAku9JmjXW1+86h10Cx5vE9WXbNIWG867ymsiT/1eo2SL6Jg6Tk
         xNDJIscNXPc8ci4btxF7w9jJ9C5gKOFXW9NyqOpq1SVELniangvmcZTKXqlAiqw+l3B/
         zyZ0ciAsZCEZyw3+2rNOJZ6ihTGTS1j5rVwON3B/anQTvmHFrex0ihxSuY4iPeSyncMa
         e3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509232; x=1715114032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4iUwetf6OktDd6c6v6370iAXTjd5m8pEJ3+fHMgbhc=;
        b=YHnYJv6G12VPRLoFTUJ3NsxW8ztZ0E+BCe9qElKb5nDk2RPDD6ZL8KP0NRDNHm8pRF
         tw4YXtwpH6lBpnpwKV1ELK/3nvWO/ds9LAgv/TgL0pq2W0vxiYi+wqjdPSyum13+GRpG
         S85bE6MMjex9qRNtsova4PcaZ2Sr216Fw62vYDVc1kuACCeCj/D/utWRa0YomeSKmQeN
         7xjcMGmGMT8qz3LE81LoEbBW7/8GaQL8Vpv+MOmOTMtk/f0AhLfdv5cqJhS3yt5TCxIU
         DJRcSCLdezfbNjVsnh9dC0UkEd/GMwz5yQkLJog7jSuyWL0EdF7V3jZeF8BbFRC+u8tk
         G/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVGGWAEeXsZgNvvTsP3HY/4JSSX342wL7USXNleeERrpTX5K32qNMqFSIM+HsGsG4+M1ibR4eepkkG4crS1ur+BLYcPf920NHUnyRi2/zf0Ml+Gk4l1AKrDEd3Mf08ON5BBRnRVC+wUjNS4B0je/TgDxEOoeOK8JbLIiajQ+pg82/fSiw==
X-Gm-Message-State: AOJu0Yz/jpZP8qOsDZapTZ0bhEyWVr3DpUyLIR9qV9ts3rs0gnjUYLro
	sqNmCxb3cRoWmEOEMUeKeN4hXf42kr/vJ0QlZjTAW734h5qxgrl/S9UvUlMdp3G6PIyy1BcTPh6
	bMdlGNWZ+6zRfE0XbX9GIwPDXrVg=
X-Google-Smtp-Source: AGHT+IHnLC/KbejKHWW+yQ4+q8FxBXyFA1l5qwN1YUn7hhxGGUDQwwW5CLG+lVTMyvKfMiCOb7xNYyMfERU/zNSbWsY=
X-Received: by 2002:a05:6512:4896:b0:51b:fe4b:da45 with SMTP id
 eq22-20020a056512489600b0051bfe4bda45mr334480lfb.38.1714509231821; Tue, 30
 Apr 2024 13:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430162946.589423-1-alisa.roman@analog.com> <20240430162946.589423-7-alisa.roman@analog.com>
In-Reply-To: <20240430162946.589423-7-alisa.roman@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Apr 2024 23:33:15 +0300
Message-ID: <CAHp75VcHa31nXwFwSJCnRvPTZ8K-5KBrM0jxAnyHh8jzPHE48Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com, 
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 7:30=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> dynamically configure them in the devicetree.
>
> Also modify config AD7192 description for better scaling.

..

> +static int ad7194_parse_channels(struct iio_dev *indio_dev)
> +{
> +       struct device *dev =3D indio_dev->dev.parent;
> +       struct iio_chan_spec *ad7194_channels;
> +       struct fwnode_handle *child;
> +       struct iio_chan_spec ad7194_chan =3D AD7193_CHANNEL(0, 0, 0);
> +       struct iio_chan_spec ad7194_chan_diff =3D AD7193_DIFF_CHANNEL(0, =
0, 0, 0);
> +       struct iio_chan_spec ad7194_chan_temp =3D AD719x_TEMP_CHANNEL(0, =
0);
> +       struct iio_chan_spec ad7194_chan_timestamp =3D IIO_CHAN_SOFT_TIME=
STAMP(0);
> +       unsigned int num_channels, index =3D 0;
> +       u32 ain[2];
> +       int ret;
> +
> +       num_channels =3D device_get_child_node_count(dev);
> +       if (num_channels > AD7194_CH_MAX_NR)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Too many channels: %u\n", num_chann=
els);
> +
> +       num_channels +=3D AD7194_CH_BASE_NR;
> +
> +       ad7194_channels =3D devm_kcalloc(dev, num_channels,
> +                                      sizeof(*ad7194_channels), GFP_KERN=
EL);
> +       if (!ad7194_channels)
> +               return -ENOMEM;
> +
> +       indio_dev->channels =3D ad7194_channels;
> +       indio_dev->num_channels =3D num_channels;
> +
> +       device_for_each_child_node(dev, child) {

You wanted _scoped version...

> +               ret =3D fwnode_property_read_u32_array(child, "diff-chann=
els",
> +                                                    ain, ARRAY_SIZE(ain)=
);
> +               if (ret =3D=3D 0) {
> +                       ret =3D ad7194_validate_ain_channel(dev, ain[0]);
> +                       if (ret)

..otherwise here is the reference count leakage.

> +                               return ret;
> +
> +                       ret =3D ad7194_validate_ain_channel(dev, ain[1]);
> +                       if (ret)

Or here.

> +                               return ret;
> +
> +                       *ad7194_channels =3D ad7194_chan_diff;
> +                       ad7194_channels->scan_index =3D index++;
> +                       ad7194_channels->channel =3D ain[0];
> +                       ad7194_channels->channel2 =3D ain[1];
> +                       ad7194_channels->address =3D AD7194_CH(ain[0], ai=
n[1]);
> +               } else {
> +                       ret =3D fwnode_property_read_u32(child, "single-c=
hannel",
> +                                                      &ain[0]);
> +                       if (ret) {
> +                               fwnode_handle_put(child);
> +                               return ret;
> +                       }
> +
> +                       ret =3D ad7194_validate_ain_channel(dev, ain[0]);
> +                       if (ret)

Or here.

> +                               return ret;
> +
> +                       *ad7194_channels =3D ad7194_chan;
> +                       ad7194_channels->scan_index =3D index++;
> +                       ad7194_channels->channel =3D ain[0];
> +                       ad7194_channels->address =3D AD7194_CH(ain[0], 0)=
;
> +               }
> +               ad7194_channels++;
> +       }
> +
> +       *ad7194_channels =3D ad7194_chan_temp;
> +       ad7194_channels->scan_index =3D index++;
> +       ad7194_channels->address =3D AD7194_CH_TEMP;
> +       ad7194_channels++;
> +
> +       *ad7194_channels =3D ad7194_chan_timestamp;
> +       ad7194_channels->scan_index =3D index;
> +
> +       return 0;
> +}

--=20
With Best Regards,
Andy Shevchenko

