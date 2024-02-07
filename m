Return-Path: <linux-kernel+bounces-56160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840E84C6D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D11288B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B92208BB;
	Wed,  7 Feb 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwvhrRfS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1649208B4;
	Wed,  7 Feb 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296723; cv=none; b=To9q8N2rbeUxxcC1RVxK4j5RRcGrOeTQCxMDR5PWoaMPfOCVZkkg2R8s+rVIvwOzVU4naj1ILolD56AI4DSzHwEQMBdjBpdCJqNhK0C4cPJCBXBtkjxPFGLkwiNYSKZGeaKg3Ys0wxwxr6q3TCfUrz0CIiMWy3NHY7QwVHNDzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296723; c=relaxed/simple;
	bh=xtxqiTXuDBirFx6NEaQvBC0NzUg8vJLy9EConsFO6rM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgHwUVhfia1MuuKHGux0xAxtL4O5grEYlnqNNDO/3kFkdGNu+97l7FklF4kN9TFM7vs150zTB5Y90EnjE5TvhjF85C0dOoDx8o+JT+o+fL2omBi5Cu9+8yTlFYuZEjjOs5sBEooK8WVnPvBuCrRYJT++pxoWInqnYiYtCnOslMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwvhrRfS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30f7c9574eso49766166b.0;
        Wed, 07 Feb 2024 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707296720; x=1707901520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=esE2h1nVkSVqHSvE+Z95Z0pvn32WS6+v2R6aUj+4MIk=;
        b=LwvhrRfSYwszDoPqQqpEKs38ecFP7Fpg4p+/+cPhOZTsPpZeS3LLrLJ/v2kpwqt0BB
         Te44yWPcIgSOlngegyeTERPQVRbvcAjve0AlhZmzYes2+JJDX3ENkIO2Por12K2FfwwV
         cwNQXxBueMfNVr3zZ0K4cWwom0WVRf5Z+K7ZLpFE1g3sH3PlJKK+2EfDMspeD5LhhWYV
         C8t3jNxQTQim4IEAArRb2Ua2P5xfTZRJCYodE3FWaiaoaZReXBUSRzW9v002ylEP0lSA
         7iqJcFrbUo+XXdAVpHe16v5daiOVlaufkYjYQawI8admxPKwiisOtSS8hPvd6HR5p3Hn
         0DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296720; x=1707901520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=esE2h1nVkSVqHSvE+Z95Z0pvn32WS6+v2R6aUj+4MIk=;
        b=XRxvkdH68L/1OKCzLgn5RTZF8i9i8/Jq/+YUQZ1iAMOXKiZwKIfmtzg73y+cpxHH8H
         ppF3VuN2M5+vh/qkeRhQr5VFImaPLML059YsgDElT+u46Mwlr40+HzwJx8RG+AhYtUqI
         B2JyWkuLNo/1NCEf8OpoxVFPpYAHdyeTgI4ZvHyVpp7/56y4qB3vaq89dsYUC/VhL7rg
         zyQRtfcfiOnrcbPG5eWMx3okCaMXlvV4JATdyTD/4/mstuy3tXbjz7uUf0ENbBV8eJ8g
         VB6PRO3oG3NA9a3OMcWk5cDl65N1EOhyBzZ9804QpUzAZdRNvhWoY81kVZ+SDIrhnA2z
         K5Yg==
X-Gm-Message-State: AOJu0YzlVIrfO/bjnTkWzjaJ3pJa53Ofm6h6ZZYHOgxAgAKuOCFBxuk5
	TwoKUwkEYkYqe0pXg4OO5f9n/sE8swwWrCQmIhnnx8C+M3LpB9CX
X-Google-Smtp-Source: AGHT+IEaj7zV6zJ+AJmCTjLy4JM5pqgb3fG+Rr3bhlMl8pG5g7ngHLFlygha5muv/ceg7OBCrJ99Ng==
X-Received: by 2002:a17:906:af14:b0:a36:fc06:6f7b with SMTP id lx20-20020a170906af1400b00a36fc066f7bmr3726567ejb.44.1707296719667;
        Wed, 07 Feb 2024 01:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaigS8/0B268hzEBsKAjyBzI5b74juO+4hkmnLQlGYjXfHV4CH9OTz1HSdsYGznaVZdnknVYdeCQfdcP1hSa8T77MoLsSc/tl0oVgf6QJ7oEiUSEdu2J2u8HvEH3Ad52O6vZ0zNbt3QLWprQp8HR3v22pqFWyWhNl19exsWruZNBc/r4hL+O3/ZwmSj8p7+lpb730wtiXeqSj4M3qbmqBLOwdGTZ+Gfbtj2YJzH7cHobryxw==
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709065f9500b00a385832f8d8sm515578eju.128.2024.02.07.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:05:19 -0800 (PST)
Message-ID: <70a4854e94cfd04b1a0ec9d3defe50ec56fc874f.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: adxl367: fix I2C FIFO data register
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 10:08:38 +0100
In-Reply-To: <20240207033657.206171-2-demonsingur@gmail.com>
References: <20240207033657.206171-1-demonsingur@gmail.com>
	 <20240207033657.206171-2-demonsingur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 05:36 +0200, Cosmin Tanislav wrote:
> As specified in the datasheet, the I2C FIFO data register is
> 0x18, not 0x42. 0x42 was used by mistake when adapting the
> ADXL372 driver.
>=20
> Fix this mistake.
>=20
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---

This needs a Fixes: tag. With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl367_i2c.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_=
i2c.c
> index b595fe94f3a3..62c74bdc0d77 100644
> --- a/drivers/iio/accel/adxl367_i2c.c
> +++ b/drivers/iio/accel/adxl367_i2c.c
> @@ -11,7 +11,7 @@
> =C2=A0
> =C2=A0#include "adxl367.h"
> =C2=A0
> -#define ADXL367_I2C_FIFO_DATA	0x42
> +#define ADXL367_I2C_FIFO_DATA	0x18
> =C2=A0
> =C2=A0struct adxl367_i2c_state {
> =C2=A0	struct regmap *regmap;


