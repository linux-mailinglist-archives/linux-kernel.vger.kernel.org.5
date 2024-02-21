Return-Path: <linux-kernel+bounces-74759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976285D8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26432829EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BA69DE7;
	Wed, 21 Feb 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjWDYUHC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7053816;
	Wed, 21 Feb 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521183; cv=none; b=Xu3sFtCHFGXg/2Z+GRgcYP9kKWLXOxDpgzsvW1GwIt6ZGWbRQYp6tAQfaaA6gO9+GkdBCFAxzvkl6/J7uPiqre2pGj8/aaX52P/O4DMvLbRbQIChX9iegKGCt9zqZBAYMDr569yIZXMBqihWG7pmJGRWUxChinGmTFoKhRdNMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521183; c=relaxed/simple;
	bh=KunTxxna1aiCdY/QesGCilJ5cAZGaSIJTXU8hotw8PI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mmWg72d7adjh55oJa6mld3X38BfWh0uIlzB/EVpZOg5Erc2u4rmTaII8jVX+TjESwL5kheOPsV+Vfq2mehJf8ai3FpM/NLLtej5KPvsdeC0HEOV9ZfAqbzcuMd4KhGTUKmTkZRZ2ntsnNB77AkNApQQU8TMxKAQHMr04BxZBSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjWDYUHC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso789726366b.1;
        Wed, 21 Feb 2024 05:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521180; x=1709125980; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DGiW/+uERhIOL2iU6zJc45gx4LT9deQYjGR/s3besiM=;
        b=HjWDYUHCbfNh93o72Vqumx8vROVWiXg4IOav7noX3HkF+t/Yim+h/o0JVvBgouB3T5
         J4yEycYgbM5nJQt/GCTTs8iuXzKooBYGgRUeIAEwcIDoZX4sxhRJO08C64orF/Ru7XHQ
         9R965iPmLGrOS/85Ip6Y1WY/+qZ2GgZ8azepxlLx7VCZCq6Rm3RvQuPXYyRCbaJsuaIn
         7pgoTWTO/No7K4YQCMqo9r4U7xyzf2SgsHAHVgM4Qf/90M3sCevESd7gKHy1fd+ctnCi
         w1UYHZYuIRdUz+NcO8R95CggETnDVQy18bkHizlhaYxq3hB8Cj7MBU7NnRc7mHjXY5xq
         OKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521180; x=1709125980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGiW/+uERhIOL2iU6zJc45gx4LT9deQYjGR/s3besiM=;
        b=eVJBC3bqwq1hsraURWBEqVjkC9sb/z/yv5QCjsGtb0CTniYVJ6W236fmmKoqiwiLll
         3hzLsv4cZ73rGHq5bFVxm6cK13nfARGC5/eAZrzUDDKoVx4s+CIhAkbLJg060j8m55Ia
         v8bRE1ZkrztDDDswz8YdXe3qWEpDyhcmX8oD7u16hHnHijr14uF2crjGf/sjAzxQtjSV
         5Ejmt/keusvHyDDxtszOpy0XoFZm7W9p5stRQMT6muU/j+xInYBO0LEGA5gQTB3PCrRP
         ENcaQWxi7He107tk3N2h2hegUOhxtLBREvH/T7g3d4xU8rQ5LMspvSZ0N7hwzdv1hUfy
         Q62Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEd7PGTIju0hz4HbU85FmEqRhb6CgglyB+4WTncQU0RxKylk27xa9uo+uJClESTh9iwdzWGyFQ/tdTEu33K7VZxtb6jsfpOpFsHLW2glOzWBohWDLgoUW+EH1nVsKGsVbkE4dWw0M0j7bTFsv0lGdacCEvXzMnsgzuMBj3ad8hiRdVYg==
X-Gm-Message-State: AOJu0YzR8FkVRPTphPOnOXH6ZJxK2c0Flat5cLHwQ4pV6EynzR4U6mHc
	pNheDPSFs3As0UYMq7tbkbGZHtQ9FBXYOkCItanLUUzA68bGHFmG
X-Google-Smtp-Source: AGHT+IE563IydXRsYWsSc8T4NQLOzAxnuYOFLbTP/CB0Gl8VNY1LxSSY0clwcJY3Gz6AYomSPpKtPA==
X-Received: by 2002:a17:906:1d14:b0:a3d:ce2c:b06a with SMTP id n20-20020a1709061d1400b00a3dce2cb06amr10714233ejh.22.1708521179456;
        Wed, 21 Feb 2024 05:12:59 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id r12-20020a170906704c00b00a3d932d8fa7sm4979551ejj.183.2024.02.21.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:12:59 -0800 (PST)
Message-ID: <c3c66cff6b712ff38fa56af0c99d8956974a7b6c.camel@gmail.com>
Subject: Re: [PATCH v5 3/5] iio: amplifiers: hmc425a: move conversion logic
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Date: Wed, 21 Feb 2024 14:12:58 +0100
In-Reply-To: <20240220153553.2432-2-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	 <20240220153553.2432-2-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 17:34 +0200, Dumitru Ceclan wrote:
> Move gain-dB<->code conversion logic from read_raw and write_raw to
> chip_info callbacks.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/amplifiers/hmc425a.c | 126 ++++++++++++++++++++--------=
---
> =C2=A01 file changed, 83 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hm=
c425a.c
> index ed4d72922696..13e018a59637 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -34,6 +34,9 @@ struct hmc425a_chip_info {
> =C2=A0	int				gain_min;
> =C2=A0	int				gain_max;
> =C2=A0	int				default_gain;
> +
> +	int				(*gain_dB_to_code)(int gain, int *code);
> +	int				(*code_to_gain_dB)(int code, int *val, int
> *val2);
> =C2=A0};
> =C2=A0
> =C2=A0struct hmc425a_state {
> @@ -44,6 +47,74 @@ struct hmc425a_state {
> =C2=A0	u32	gain;
> =C2=A0};
> =C2=A0
> +static int gain_dB_to_code(struct hmc425a_state *st, int val, int val2, =
int *code)
> +{
> +	struct hmc425a_chip_info *inf =3D st->chip_info;
> +	int gain;
> +
> +	if (val < 0)
> +		gain =3D (val * 1000) - (val2 / 1000);
> +	else
> +		gain =3D (val * 1000) + (val2 / 1000);
> +
> +	if (gain > inf->gain_max || gain < inf->gain_min)
> +		return -EINVAL;
> +
> +	return st->chip_info->gain_dB_to_code(gain, code);
> +}
> +
> +static int hmc425a_gain_dB_to_code(int gain, int *code)
> +{
> +	*code =3D ~((abs(gain) / 500) & 0x3F);
> +	return 0;
> +}
> +
> +static int hmc540s_gain_dB_to_code(int gain, int *code)
> +{
> +	*code =3D ~((abs(gain) / 1000) & 0xF);
> +	return 0;
> +}
> +
> +static int adrf5740_gain_dB_to_code(int gain, int *code)
> +{
> +	int temp =3D (abs(gain) / 2000) & 0xF;
> +
> +	/* Bit [0-3]: 2dB 4dB 8dB 8dB */
> +	*code =3D temp & BIT(3) ? temp | BIT(2) : temp;
> +	return 0;
> +}
> +
> +static int code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2=
)
> +{
> +	return st->chip_info->code_to_gain_dB(st->gain, val, val2);
> +}
> +
> +static int hmc425a_code_to_gain_dB(int code, int *val, int *val2)
> +{
> +	*val =3D (~code * -500) / 1000;
> +	*val2 =3D ((~code * -500) % 1000) * 1000;
> +	return 0;
> +}
> +
> +static int hmc540s_code_to_gain_dB(int code, int *val, int *val2)
> +{
> +	*val =3D (~code * -1000) / 1000;
> +	*val2 =3D ((~code * -1000) % 1000) * 1000;
> +	return 0;
> +}
> +
> +static int adrf5740_code_to_gain_dB(int code, int *val, int *val2)
> +{
> +	/*
> +	 * Bit [0-3]: 2dB 4dB 8dB 8dB
> +	 * When BIT(3) is set, unset BIT(2) and use 3 as double the place value
> +	 */
> +	code =3D code & BIT(3) ? code & ~BIT(2) : code;
> +	*val =3D (code * -2000) / 1000;
> +	*val2 =3D ((code * -2000) % 1000) * 1000;
> +	return 0;
> +}
> +
> =C2=A0static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
> =C2=A0{
> =C2=A0	struct hmc425a_state *st =3D iio_priv(indio_dev);
> @@ -61,30 +132,14 @@ static int hmc425a_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int *val2, long m)
> =C2=A0{
> =C2=A0	struct hmc425a_state *st =3D iio_priv(indio_dev);
> -	int code, gain =3D 0;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_HARDWAREGAIN:
> -		code =3D st->gain;
> -
> -		switch (st->type) {
> -		case ID_HMC425A:
> -			gain =3D ~code * -500;
> -			break;
> -		case ID_HMC540S:
> -			gain =3D ~code * -1000;
> +		ret =3D code_to_gain_dB(st, val, val2);
> +		if (ret)
> =C2=A0			break;
> -		case ID_ADRF5740:
> -			code =3D code & BIT(3) ? code & ~BIT(2) : code;
> -			gain =3D code * -2000;
> -			break;
> -		}
> -
> -		*val =3D gain / 1000;
> -		*val2 =3D (gain % 1000) * 1000;
> -
> =C2=A0		ret =3D IIO_VAL_INT_PLUS_MICRO_DB;
> =C2=A0		break;
> =C2=A0	default:
> @@ -100,36 +155,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_=
dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 int val2, long mask)
> =C2=A0{
> =C2=A0	struct hmc425a_state *st =3D iio_priv(indio_dev);
> -	struct hmc425a_chip_info *inf =3D st->chip_info;
> -	int code =3D 0, gain;
> -	int ret;
> -
> -	if (val < 0)
> -		gain =3D (val * 1000) - (val2 / 1000);
> -	else
> -		gain =3D (val * 1000) + (val2 / 1000);
> -
> -	if (gain > inf->gain_max || gain < inf->gain_min)
> -		return -EINVAL;
> -
> -	switch (st->type) {
> -	case ID_HMC425A:
> -		code =3D ~((abs(gain) / 500) & 0x3F);
> -		break;
> -	case ID_HMC540S:
> -		code =3D ~((abs(gain) / 1000) & 0xF);
> -		break;
> -	case ID_ADRF5740:
> -		code =3D (abs(gain) / 2000) & 0xF;
> -		code =3D code & BIT(3) ? code | BIT(2) : code;
> -		break;
> -	}
> +	int code =3D 0, ret;
> =C2=A0
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0	switch (mask) {
> =C2=A0	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret =3D gain_dB_to_code(st, val, val2, &code);
> +		if (ret)
> +			break;
> =C2=A0		st->gain =3D code;
> -
> =C2=A0		ret =3D hmc425a_write(indio_dev, st->gain);
> =C2=A0		break;
> =C2=A0	default:
> @@ -189,6 +223,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl=
[] =3D {
> =C2=A0		.gain_min =3D -31500,
> =C2=A0		.gain_max =3D 0,
> =C2=A0		.default_gain =3D -0x40, /* set default gain -31.5db*/
> +		.gain_dB_to_code =3D hmc425a_gain_dB_to_code,
> +		.code_to_gain_dB =3D hmc425a_code_to_gain_dB,
> =C2=A0	},
> =C2=A0	[ID_HMC540S] =3D {
> =C2=A0		.name =3D "hmc540s",
> @@ -198,6 +234,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl=
[] =3D {
> =C2=A0		.gain_min =3D -15000,
> =C2=A0		.gain_max =3D 0,
> =C2=A0		.default_gain =3D -0x10, /* set default gain -15.0db*/
> +		.gain_dB_to_code =3D hmc540s_gain_dB_to_code,
> +		.code_to_gain_dB =3D hmc540s_code_to_gain_dB,
> =C2=A0	},
> =C2=A0	[ID_ADRF5740] =3D {
> =C2=A0		.name =3D "adrf5740",
> @@ -207,6 +245,8 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl=
[] =3D {
> =C2=A0		.gain_min =3D -22000,
> =C2=A0		.gain_max =3D 0,
> =C2=A0		.default_gain =3D 0xF, /* set default gain -22.0db*/
> +		.gain_dB_to_code =3D adrf5740_gain_dB_to_code,
> +		.code_to_gain_dB =3D adrf5740_code_to_gain_dB,
> =C2=A0	},
> =C2=A0};
> =C2=A0


