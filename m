Return-Path: <linux-kernel+bounces-74779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E185D9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F81C23178
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298779DAB;
	Wed, 21 Feb 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKfEiYj/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723F53816;
	Wed, 21 Feb 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521835; cv=none; b=CPTEOxBYySQa98PBii3MIYEGmWGO3h8QyRudNxcmQU1GHlLc03m0eEZm0Daz2Uq+FkwjnoUmm0nvCIbpdKzlTX4/u+rDWDJmqptld5KTjUcvxjkUTIQmakkZWEcwTcPBKo0gLxtWZTcJkX7FJcobiobhplDkWLhiV5znaF80H9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521835; c=relaxed/simple;
	bh=7cyNJ515me6l3XFmqj5aB+dIDuK/5jXCgnSutXO+HsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCUMTHPW3Sq4P/2DHiJNp3L79Fc2WYbn0WQF/WDq7SlFNGOn0+8IX3H4+bA06A9iBhrpXbnqx6rfG0YxmXs04XWD8FIR3s4R56snyRKYrA9UtLBCe5sqkHAIDPTt6jd1uv2bFJqnKP/KaylCLdSxs1NjKVY6R+4d9he1WENpGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKfEiYj/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so75104866b.2;
        Wed, 21 Feb 2024 05:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521832; x=1709126632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYHh7SiHeNTNK2tXpyXWlj0JF7DBAfbrFEvAlcv1JZ8=;
        b=KKfEiYj/QJRTVhmKA8HztfLGKEHSkgiCMrd/qhQeP5AzKXTdrUUgo1l61WmDvRXxI0
         EjabUoeYJEDELifGMaP2xVhsDYXRBfxKkgcCLGeMWzrqnrwm3STqQrkfUhk64/NMkN4j
         joZBdiadolhsrHQhquMbpRsa+YeaMMntCCNcJrolN4skNgcmoxOVJRJya//3rrOVe5zU
         3L+1rA982cma1GQ7/KHZlq1Z8TJfi7N0LgonOv3/Sua4K4xy0dSe+3vATqk7Eoj9DC0m
         7r273HLMME9SfH7g/dmMTs/TlXDHSfb/UHdjSoCxUoU7R82In+VD5qtWT8XdquYkSqJx
         AGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521832; x=1709126632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYHh7SiHeNTNK2tXpyXWlj0JF7DBAfbrFEvAlcv1JZ8=;
        b=MpDBuZNNNFtBQQrtUGIsuxSxRmRA2Z1A6jv19UvfIgNgPcjoCB/9FD7XBXrTmKRD74
         36XPJ7+/He1r1sk+juxgo/oDvUO8V3akNgZyZKc+ccp8F22P9T4MsFSUFmpJWpQeu00c
         Bcipvi1evsvETnmga4lCOyQcEwbrQNaWPz4r2/DscXa72ginNj4HXs0WWKP2iSYfDP/G
         8vAbvAj+p+GGGW4NEVxM8ODqN+rCBkr9r+isnyROe0fZzC1QLVhMtSDHOrnCHhq/iGiv
         6lKCbn4QP/0J2S/LtRcmE4ipkaR78E6Db0HCXKM2FSaCBQkNk0nH7DE1Pb3l4ribiatd
         1c3A==
X-Forwarded-Encrypted: i=1; AJvYcCWYlvHMhiw9hEER2WZXzT4ndGJFNZyG8PZPh+F5xoUn1jP1uxDlbRqn16jXf9lFjHocNJMi3cnWzkLqydNtbRU+zZOXZdThyyvdUI1zgXWfajrNPyRZpYwZq0Dfei5SR/E+JakCykssPKbupAwLIoFEti1BIE5QUvmtKE1X0KoC4Q9zRQ==
X-Gm-Message-State: AOJu0YzD4azQurbRn/tnpxo3cgWE1PuZzToiivbqira0Nu3xj1WOxiU6
	UiXSGLrAcjHOc483Fxs9OODkLE/SL6GJHmb2gPWOiTTJ6nllSzcn
X-Google-Smtp-Source: AGHT+IGV6fsUIv4DXC3rekvSLt61Ux/puLB88XNo2FdXL4dpAuVGpy8ZBFyDqHuYlLeYX4XBP6bEDg==
X-Received: by 2002:a17:906:abcf:b0:a3f:2ffd:c683 with SMTP id kq15-20020a170906abcf00b00a3f2ffdc683mr1533014ejb.62.1708521831730;
        Wed, 21 Feb 2024 05:23:51 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id lx16-20020a170906af1000b00a3e67585addsm3688229ejb.130.2024.02.21.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:23:51 -0800 (PST)
Message-ID: <c92c4c71f433c7375588e832d3c084a50190a1b5.camel@gmail.com>
Subject: Re: [PATCH v5 5/5] iio: amplifiers: hmc425a: add support for
 LTC6373 Instrumentation Amplifier
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Date: Wed, 21 Feb 2024 14:23:51 +0100
In-Reply-To: <20240220153553.2432-6-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	 <20240220153553.2432-6-mitrutzceclan@gmail.com>
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
> This adds support for LTC6373 36 V Fully-Differential Programmable-Gain
> Instrumentation Amplifier with 25 pA Input Bias Current.
> The user can program the gain to one of seven available settings through
> a 3-bit parallel interface (A2 to A0).
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Just one minor comment. With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/amplifiers/hmc425a.c | 124 ++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 120 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hm=
c425a.c
> index 77872e2dfdfe..50c86c2d28d7 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -2,9 +2,10 @@
> =C2=A0/*
> =C2=A0 * HMC425A and similar Gain Amplifiers
> =C2=A0 *
> - * Copyright 2020 Analog Devices Inc.
> + * Copyright 2020, 2024 Analog Devices Inc.
> =C2=A0 */

..

>=20
> =C2=A0
> +static ssize_t ltc6373_read_powerdown(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> +{
> +	struct hmc425a_state *st =3D iio_priv(indio_dev);
> +
> +	return sysfs_emit(buf, "%d\n", st->powerdown);

Well, in theory the read should also be protected with the lock...

- Nuno S=C3=A1


