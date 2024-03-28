Return-Path: <linux-kernel+bounces-122996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2518900D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF601F25AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD781ABE;
	Thu, 28 Mar 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlQ1qYjw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C697E576;
	Thu, 28 Mar 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633968; cv=none; b=ZpxPGMrrOogq9xCj0XjNZ69TSgR393aTFf1JyyQxKZZ+KkprpSAEVIIQQJw95xCFU2TKeBkT4dE4DZDLsm8BQTOw2uVfhCdN8YtyLZuEIwRk8xdulWt4j1EGybAXE8w0dLwmtOgQb21UoHrnmnR1UFXhhZuN3Wh4iInB12El+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633968; c=relaxed/simple;
	bh=1aPjyoXqmFxLfK6o+5iZel4+zDjnpr9bD3BghFXePn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuHsrfbps4+AtfjJ/wxbh1Bm5WWktRYl4njL6P3qjcPr1zZghwycDa22Ha/E64z0cIWyiDq4P/ijM74KCKL3L2zvg0xgGRqgMCo2qY1LezY/Y3K7AH3WZc1GTLmmi+/eNo5B+XWlrgufQxZ3yXW5gIFEp50CRCcwTwQuR5GvYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlQ1qYjw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a467d8efe78so119237866b.3;
        Thu, 28 Mar 2024 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633964; x=1712238764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzaEWnUOwAlG7dJRIzF1qLENohK2A9mrRih4ZTj2DJY=;
        b=jlQ1qYjwm6USRhdgklsUPFiussJkRv/hnpba7UY/tyljcI9OKk9UMT+0eMBgXUGvrt
         kcuvJVcMehDGAHs5yZ3PdKjByYn/amtfMhpHJa2inlZ6lCNzX4PRRaTValgDiMfOb+VF
         nG+AkT3+Mg34Y4FpEOq91+OPenM3D9t1d4LHQxkcz70Rk6a7wKC4dbH/dyqiQ4zQFmGg
         45XZo6nAm2WVHv5ruv+gz6UIai8TbQbTNjcYDq9BL8s0OhH4F8KGZHNAFzruKxNyiKw1
         gsBGGgVt8ExBuN4iawqwJ/4QD2F3w74UByBWARCyVeqsBM2lYESWPnpLXW+1DPE/NnTT
         YyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633964; x=1712238764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzaEWnUOwAlG7dJRIzF1qLENohK2A9mrRih4ZTj2DJY=;
        b=fKoXPUx4Mnv81dEIPFwuVvnBmhgFUeBbrSiAIuMJFucDnd5J/VN79lkgfESlCBL4hm
         Jtiv8Y1FG6a2nvpoSSoXwkmLn3JHuvyjf/4mAbMNYlHh2LlDVQzewazdtTRgxglJd9nM
         jT8XsA0Rguz2NmjRO8PEoVpQi6f/1myyDqiuL7JoW09ckIr6DIe9vJnDu38nYBK1usgT
         5BzlmGsEUzkwSGdA/j693V5T1sGE4rLPsIx0766KN2oaIOyYmmZbX9pZM7diSJbiMgQS
         5Jtbcn5o9d2EZcBQCtZf49I/HB/yMCB8zlYsRxDW7Qq4XQAag+25TIyNck9f7QvM35rj
         33uw==
X-Forwarded-Encrypted: i=1; AJvYcCWHbu6aVLzGaRer8PlYbRI/33rqrfu/SHz+gb1IpoKqjCXFvyR0mwHNsAE2arPc1jmAU83cEOB0ZVz1WA5QpXhiBX/MMtvSDGRqxUslR3LB0rYzxNali80XDe8Dfz07XdQBt5509CHD
X-Gm-Message-State: AOJu0Yx65IO9LZPcw2aLlTSGHJx7pGCjPAfqE3lOcC+95OyMAtjqAgLm
	H3pOei6OPxmPS39VKI0VSTLJhyFcCk+W2xFRl+otak9yYm9DdEUM
X-Google-Smtp-Source: AGHT+IHjIbBVxTsKxHOyi9aLa7fb+eKUlD7d5l5hLW76KyIoVNxG75GiAjx3gTFkW95dm/1ZrsJC3g==
X-Received: by 2002:a17:906:7854:b0:a4e:26a:6558 with SMTP id p20-20020a170906785400b00a4e026a6558mr1758497ejm.24.1711633964122;
        Thu, 28 Mar 2024 06:52:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id n7-20020a170906840700b00a46caa13e67sm776638ejx.105.2024.03.28.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:52:43 -0700 (PDT)
Message-ID: <3db9a68c6f71a67d95d25886fdc708de6269adc2.camel@gmail.com>
Subject: Re: [PATCH][next] iio: addac: ad74115: remove redundant if statement
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Jonathan Cameron <jic23@kernel.org>,
  linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 28 Mar 2024 14:52:43 +0100
In-Reply-To: <20240328112211.761618-1-colin.i.king@gmail.com>
References: <20240328112211.761618-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Colin,

Thanks for your patch...

On Thu, 2024-03-28 at 11:22 +0000, Colin Ian King wrote:
> The if statement is redundant because the variable i being
> assigned in the statement is never read afterwards. Remove it.
>=20
> Cleans up clang scan build warning:
> drivers/iio/addac/ad74115.c:570:3: warning: Value stored to 'i'
> is never read [deadcode.DeadStores]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> =C2=A0drivers/iio/addac/ad74115.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index e6bc5eb3788d..d31d4adb017e 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -566,9 +566,6 @@ static int ad74115_set_comp_debounce(struct ad74115_s=
tate *st,
> unsigned int val)
> =C2=A0		if (val <=3D ad74115_debounce_tbl[i])
> =C2=A0			break;
> =C2=A0
> -	if (i =3D=3D len)
> -		i =3D len - 1;
> -

Hmm, this change is clearly good but I think we're actually missing the pro=
per fix in
here. I'm being lazy and not checking the datasheet and Cosmin can further =
comment.
But I'm fairly sure that the intent of the code is actually to use i in the=
 call to
regmap_update_bits(). I mean if we look at the mask AD74115_DIN_DEBOUNCE_MA=
SK and the
possible values of val...

- Nuno S=C3=A1


