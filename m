Return-Path: <linux-kernel+bounces-159619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC3C8B3125
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628E81F242EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017C13C685;
	Fri, 26 Apr 2024 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Qy5qk3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9C13C67F;
	Fri, 26 Apr 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115598; cv=none; b=PFXP+pPAhVVXYzep1OwQBzeQ3XVhQyqBgRxKrh6ViytEz6/XYqT6NVLlCNEiSiChL/NqRWrB7hUXTRGmuJtiKEy0PdpNdh70J5KOoKchqMfCljobXcgJAsnB1pXkvSYjwz0YzIKrDY5TJhZ3HwixwtpFDLLtbEq3GIFCOePAOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115598; c=relaxed/simple;
	bh=rOzcluYKG2hrpYV20L/nT3C1eaey2DRuJJlwnc12FaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAeLdUiQBaFGHExGYl2ZezZz9YXG5IHFXfI0dmtAFR04r3uP5YhXvIg9Ji+4rDxaCePEHhpz3dCGsOc1zS7sA0M0GL1p/kCvIFFfh8cixJs+BnYaQmmoPjnHoU1SOyhAo1f7obw6jSuKUvNuE9A5Jkg83wts5+EgZ7paovK327o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8Qy5qk3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b869326daso2367835e9.0;
        Fri, 26 Apr 2024 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714115594; x=1714720394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOzcluYKG2hrpYV20L/nT3C1eaey2DRuJJlwnc12FaY=;
        b=R8Qy5qk3Bw0aoY3WDiTx9Y8qEmza/mBlhRp+Y9SjWpqdQWb+Ly1ff7NN0wGT6FOuZa
         LXX8DKQlfifQHm0X1mAjO8OwWARG4A5jleUyzDVd7A/lom5j3lVPQAAAhAZCb9Py+K/J
         jkwGV0PZJlVXyUVdR0gWZ/Ir5TAiCMRnAr62JWHs83KcAcoXbSUQjjT+bn5hbUg3Y/27
         Z6vrxOKpe8nLb5wcOZvtY9hEOw2VT714U5OElDoYucxwus0kjcYDaDIOGp4nfHH7mUPj
         D2filwiKv5NP7Ij3cLQ0Ok3rR8hEqOzSwYF9A99oBzTikVCGd7244/36HdMpzaUw24UZ
         Xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115594; x=1714720394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOzcluYKG2hrpYV20L/nT3C1eaey2DRuJJlwnc12FaY=;
        b=bYfU8IzNVSkR6zcMfBzAkSh8b2gpP5TVbv82IeX/rzYMks3DYRJs9Uuq1MsXXRbCpF
         32k+ryEaY7tnkZVELg+4VaY4y4ySfzKW0pipTrqKboWtUd/sYGS7X/cQY/wex7zWQu5j
         WsTPzzbV+BHHpX/1GM3JWoqFR/3fpQgmq3Hs6QA6YIqKjGFobC3RIzPoF3y6m+h4Z4Aa
         hl40cVsjAc3cM7nwn2tpRsgfvLFXH9gomm+MUscepJiTiKAl5r85OpWxKlS/yducylaX
         CVlsX9q9oZ2Vh5rHDbUlZzN71ZSEnj+TTWqgLASvp6PGRSre2HDbkGKrgfNCnwicoFvS
         nuNA==
X-Forwarded-Encrypted: i=1; AJvYcCW0n8V6felIAEE1jogN8QuZ2bvbt0wln5RC55D/fbpNNkPngOYijTQd19tguzSXh73/XZmQSqs4vV/PiLW1CqmTAEOEyD2Td7QZuXmFDjveDrdoC+lNH049gqjRFsihVWDNn2q3nd0U
X-Gm-Message-State: AOJu0Yw1xJ94RjZSLOx1IDr2xqoMA9sQa4Hu22pkP6m9Il24M6MRH5iL
	NNg+dSXUspCSGXxvitJTr6Jb32xqAajs5dI41SZW4wl6tRinpe5+
X-Google-Smtp-Source: AGHT+IELlRH0sOWJdCsZIYCDl7Yx1dPCBTVH9urrSlrGNcaa6bxDZs6XhcNcgT5jQ3DLLvUE/MRRMg==
X-Received: by 2002:a05:600c:3553:b0:418:d6f2:a97a with SMTP id i19-20020a05600c355300b00418d6f2a97amr1481428wmq.13.1714115594183;
        Fri, 26 Apr 2024 00:13:14 -0700 (PDT)
Received: from ?IPv6:2001:a61:3481:2201:6106:96db:d27b:d2c2? ([2001:a61:3481:2201:6106:96db:d27b:d2c2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm33449748wmq.15.2024.04.26.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:13:13 -0700 (PDT)
Message-ID: <2630ef8c8363b4fa772a2ff2c95cf115ad3c509d.camel@gmail.com>
Subject: Re: [PATCH 0/3] iio: cleanup masklength usage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Date: Fri, 26 Apr 2024 09:13:13 +0200
In-Reply-To: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
References: 
	<20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 10:03 -0500, David Lechner wrote:
> While working on other patches I noticed that a few drivers are setting
> the masklength field of struct iio_dev even though it is marked as
> [INTERN]. It looks like maybe this was not always the case, but we can
> safely clean it up now without breaking anything.
>=20
> ---
> David Lechner (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7266: don't set masklength
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: mxs-lradc-adc: don't set masklen=
gth
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: buffer: initialize masklength accumul=
ator to 0
>=20
> =C2=A0drivers/iio/adc/ad7266.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/iio/adc/mxs-lradc-adc.c=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/iio/industrialio-buffer.c | 2 +-
> =C2=A03 files changed, 1 insertion(+), 3 deletions(-)
> ---
> base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901
>=20

Hi David,

Nice cleanup. The patches look good to me but there's one thing missing :).=
 As you
correctly noted, the field should be internal to the IIO core and drivers s=
hould not
touch it. Hence, you need to make sure not driver is using it so we can mov=
e it into
struct iio_dev_opaque [1]. That's the place all the intern fields should, e=
ventually,
end up.

Now, quite some drivers in the trigger handler will read the masklength for=
 looping
with for_each_set_bit(). Hence, the straight thing would be an helper to ge=
t it.
Maybe there's a clever way...

I know this is more work than what you had in mind but I think it should be=
 fairly
simple (hopefully) and since you started it :), maybe we can get the whole =
thing done
and remove another [INTERN] member from the iio_dev struct.

[1]: https://elixir.bootlin.com/linux/latest/source/include/linux/iio/iio-o=
paque.h#L42

- Nuno S=C3=A1

