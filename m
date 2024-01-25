Return-Path: <linux-kernel+bounces-38456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598D83C028
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D491C20EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34947F50;
	Thu, 25 Jan 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp3rJLDC"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3224B52;
	Thu, 25 Jan 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179573; cv=none; b=IID5BxqVCqN8KUACmsBef6HNVA7I51igiG4rqB6tm+RnXDXBBwyE8qKBlY7LXAONG/LY0Artdj9uSpSS1Pf4fIM+JqVSpHZBk1wFBs3rNuSIqXAdC7koasc3GWenp/0v3BT9NCZ8jaZCqOu7V85tjnTDd6H657ZCDDY+DcwXB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179573; c=relaxed/simple;
	bh=T4KbaGa4I3/ArUbnVuhotCp6UuXKBebXUkOu4YXAWTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GdyYGkkYXYZzKW4VDalLGggwpsBdtvI7ZITqT7bQ1YA8oY/rgqtVjZRHVv71v5HgG5V6EwP0v7ZAFICQkNSTfKNMIBxFfy0pfKOO6RQkFEez3lCyYmlU5FOp8IsiGJ7OW+2wieNy4xau6dbN4NHg92RZQrwGE65uRE22nTiq8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp3rJLDC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30ed6dbdadso235604866b.1;
        Thu, 25 Jan 2024 02:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706179570; x=1706784370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjMvfTbRqWbP5YBJ9OcGAqttPOoukFPvsBKHDlQzSEg=;
        b=Pp3rJLDCz4tcHPiPbd660Fo4jShICMShJShfVlQz+8LlplFSTjiMQi3taYimIqpjPf
         qK8jcwNH1qir6BaQhTw7H5m1hFOND1x4rAhKsMJIC6i4CXgMW2qEF7ezMTnJjo0Awp0b
         23eNNTUwVbFmjytJNJVO/wrBB+2il0d0lihwhep30z/iBiENu5Wc3DHIU1m4DAXZPokZ
         8750oQ/dOSmpsqDnqcg/g932VgR71+ZhQNIvb7liY41p+Rj83FZv6ERi2hGQB5wlIYSh
         eg9mtF0x6lwnY7EspR6lHUM/hd0JQ1YGBJHsLqTx3nZiebCwukcx03TVCl0kDUQi2Ahp
         jA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706179570; x=1706784370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjMvfTbRqWbP5YBJ9OcGAqttPOoukFPvsBKHDlQzSEg=;
        b=HNpXK2fzMdPjeOWHvTL5H6vzTfX6Zqk8BnX2iJ65bkPd6yJohu3aSyvMd0R36WFESb
         xQX2jR5V5NnD5posK6L7Td/D+edOBUGtcT8i84ry4UVLWA7XnVTtfb7jJjKNXk0L5yfs
         VbhEW69DT1/9vUbEtfW8KNLbsHcpFqHJxGXVTLH6UTEs/EHMu95AZvUg9nHxRrZZIhPq
         9D4M5vVZQrFFj/DsclzZGmLZXpsUHot8P0X/o0VGgqzBzjnQp9Z0mgGSzZiFvBcd3v1e
         e9sNvE8DyC4+7JNeQ97L8E9w/JqFeaGxe1kYE9Cq7ufOH4/IQ3NeNZ+arHM16ytSb/zh
         7+VA==
X-Gm-Message-State: AOJu0YxdZrYW7bcJ6FduIJSW2g6iSr0pApo94YGJvhEgR4D9if2HtMvC
	AVxkPey+Vwv0LywM6oZVC4xTRSbNMSQtRudoHnGTdAQ+ecVrocDE
X-Google-Smtp-Source: AGHT+IHsWSNyjDObd8W5fW6CkFUp4Chj6qYaZ1I1bunPgAEg7W36Q2pk60KYgFTt9nedMS/QRVowmA==
X-Received: by 2002:a17:906:2797:b0:a30:cbc3:f46 with SMTP id j23-20020a170906279700b00a30cbc30f46mr409836ejc.56.1706179570242;
        Thu, 25 Jan 2024 02:46:10 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00a2dbc664e2asm888960ejg.89.2024.01.25.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:46:09 -0800 (PST)
Message-ID: <0a98e54735cc2a97f393eef6b1cdaf27c946d10e.camel@gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc3020: fix temperature offset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 11:49:25 +0100
In-Reply-To: <20240125102641.3850938-1-dima.fedrau@gmail.com>
References: <20240125102641.3850938-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dimitri,

On Thu, 2024-01-25 at 11:26 +0100, Dimitri Fedrau wrote:
> The temperature offset should be negative according to the datasheet.
> Adding a minus to the existing offset results in correct temperature
> calculations.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---

This is a fix. You're missing a Fixes: tag in your commit message.
git log --grep=3D"Fixes:" should give you some examples...

With that, feel free to add:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/humidity/hdc3020.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index 4e3311170725..ed70415512f6 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0		if (chan->type !=3D IIO_TEMP)
> =C2=A0			return -EINVAL;
> =C2=A0
> -		*val =3D 16852;
> +		*val =3D -16852;
> =C2=A0		return IIO_VAL_INT;
> =C2=A0
> =C2=A0	default:


