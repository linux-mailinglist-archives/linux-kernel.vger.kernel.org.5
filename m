Return-Path: <linux-kernel+bounces-63267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F5852D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277A81C27370
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D2335DB;
	Tue, 13 Feb 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNTT1rqc"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B82EB11;
	Tue, 13 Feb 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817841; cv=none; b=E3mgd41z5XOEBji8rh5BdoCJTsPfbLvEXncp/QJkJc7Qy0AnB2crKL0uo5NFSds0WRce7Q2bcILkGLM9b/HdfWbFKYhZh/dtzQTlk7iaSO8bg85V1BzNcIgjVKE9hUKz5s9hawMWsxKs17rhj7d/H18jSJJ4bt2PZdbuRfpiu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817841; c=relaxed/simple;
	bh=6BJAwxlKOz9qRg+AQZWq8lwpMqt/xl2ew65Cb1aNdSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYbqva2BbEt8pMUbhPTDg+m8l0VRrSSVQo6yXo8aPQTsolkXj+KAj17Ld0usI5iFJR1FnhK/GLyGjVOt6ROKQe0LXZcJdaLwwdJp/ER6N3W9Zt5Uh4qFSpJKtXLbFjTbngnmvA9PuaRuzx4nOHRwyEepwdgFJkAvsICkePd/33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNTT1rqc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so5379250a12.0;
        Tue, 13 Feb 2024 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707817837; x=1708422637; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=02Q7abfACIj5GpFrjTtMBvmCgtw5jU81SC8//k9tfeI=;
        b=fNTT1rqcX201wiDYSPXUcYLwolzPC5KsRMMrqbf/auaeAfXsBtVK240okZCVu/KMgW
         CijPyPA8YlH8LJTyRusc8RBrp0+XzEe9G3LfzaoVZ7kGICRI5X9+uc7fDIuVtv/vSWwY
         rYW7VSiIev1ZbtYWRsSF0hRJ+5wNo5NjWxwQzKfh8Bn3y9I5sVbZMcwxnrBPg88VfyAB
         GFgCGgO8Q806gZj3pukuAbI3+St8v4UNVmTO6Vlo9NQBPHocv+YK+8h0QVQB33O9sFvu
         mqBySqOpQeM5g/Xbg4sRiAohtF7C9M6D2ieHp5TktHwgrIkxHXPSE+f8mu+B3Bomw0z7
         N4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817837; x=1708422637;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02Q7abfACIj5GpFrjTtMBvmCgtw5jU81SC8//k9tfeI=;
        b=CmPeGCfThrVmGHMOlyVItmP7iN/nQg6jjKs/J4vTwHkOqdK4G8P7aFRwGYUqr4H1Vn
         LRd4KBRtG8ktpPHdBLT68G63fFYmNUw0N55PXWq4qLERLH9GCsJu6rDFOQUl7S7rW/1x
         ZkIsJSw3V7DP2jm5hBEXpMDRGiIRpewolXTZ9yu5FXW6fwhhYHzf0k1UJEn94ZpIhOqM
         gEn8gcVm/cuYZ9kMEwYB+mdLOfc3ZrGMdkqByyrT1EqtyTYhHQubzBDBQ7N+zecZyAag
         X4uYbJhMoDaA026fBAoTTz77JG65SUY2dPNdMrjgcEsOT5iw5y9BKXa0XJKVWj1h2YR5
         tXiA==
X-Forwarded-Encrypted: i=1; AJvYcCWeKhPwiFwhu4aoQTz1qgr2M3xqPPwyZcwfGinj7nrhSuQBi/LXIY2nSpZGcN+i7jyod378OfUAuJMfhyKEtKd7XIogcqUJY7K5G89d8D1Hj/RB+tzgd6soL9taopDJRsj1OM9XaXhptAEupNnO118tEiSgt3VB5nVeI8T1kt3EEbhW
X-Gm-Message-State: AOJu0Yyk8wv+roD5sQfmNcaZnnZFzGEQAOXjkAgD30DZsM+Mq1WAXQrq
	i8+XHx5ybKI7PThbPHxb3X7CxJi74Rzv5eQUbMqueE1ShYPZjICo
X-Google-Smtp-Source: AGHT+IGRIRAGN7HlQ2YL3Deo9ao65iE39g1lBXZFiJyiu8wwOB+r4smCrSfid72KhonwYf2dnDlcBQ==
X-Received: by 2002:a17:906:f2cb:b0:a3b:e975:c530 with SMTP id gz11-20020a170906f2cb00b00a3be975c530mr6234324ejb.51.1707817837303;
        Tue, 13 Feb 2024 01:50:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqB80o9R/NU62N2vMlE6LfVBR8z/D//hqbBM7lCJFqCG2bTdNYkG9NmP+M92CJeJjQZURrPST8hlFOXdxAixqTPKbFBmI6TnVpKJgm1exDOHK3I5E7v3qs/VYuOAYGtrs3pYdnQjBugujLlZfC4l7ZIvhAqmDacUWXeE4I5uEMBAJj7EEHge00eI7fdejaFYk5tmRO09wLscNs3cACWyffNPM1dZNaEQXW4wgs+BojO2hfVEZbK0c3ey6Yy+Q+hIdsznSCxXt3xeJEJFeAIRibUu081FHPHMPN0ldAM52jmd5qWYg403gEda1Z6AXm4itWlo2Vo/XyjkEpGfBasR+v5O37F96Xek7B9IuRS/VvUvrNOk2gXOxu8TmJf1hDncDhVvGvXFj/MnHWshhaMS+QX7NrMJytKGvDjoI5CIlddiTziQsTLeInP3/uouSmjkvkg1Vy+C4jJd/KbQKwci4Ydxlw4Ls3WU41di2wIgrakCCIaSEsZ+F8RiuClNHk/z9A/GoKuAU1gN27YNYziUa7
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1112913ejg.199.2024.02.13.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:50:37 -0800 (PST)
Message-ID: <92e7e0acf6d8746a07729924982acbfea777c468.camel@gmail.com>
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org
Date: Tue, 13 Feb 2024 10:53:56 +0100
In-Reply-To: <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
References: 
	<20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote:
> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.
>=20
> Internally, the SPI core will also call this function for each message
> if the peripheral driver did not explicitly call it. This is done to so
> that controller drivers don't have to have multiple code paths for
> optimized and non-optimized messages.
>=20
> A hook is provided for controller drivers to perform controller-specific
> optimizations.
>=20
> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> Link:
> https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@ma=
rtin.sperl.org/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 145 +++++++=
+++++++++++++++++++++++++++++++++++++++-
> -
> =C2=A0include/linux/spi/spi.h |=C2=A0 19 +++++++
> =C2=A02 files changed, 160 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c2b10e2c75f0..5bac215d7009 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2106,6 +2106,41 @@ struct spi_message *spi_get_next_queued_message(st=
ruct
> spi_controller *ctlr)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
> =C2=A0
> +/**
> + * __spi_unoptimize_message - shared implementation of
> spi_unoptimize_message()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 and spi_maybe_unoptimize_message()
> + * @msg: the message to unoptimize
> + *
> + * Periperhal drivers should use spi_unoptimize_message() and callers in=
side
> + * core should use spi_maybe_unoptimize_message() rather than calling th=
is
> + * function directly.
> + *
> + * It is not valid to call this on a message that is not currently optim=
ized.
> + */
> +static void __spi_unoptimize_message(struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr =3D msg->spi->controller;
> +
> +	if (ctlr->unoptimize_message)
> +		ctlr->unoptimize_message(msg);
> +
> +	msg->optimized =3D false;
> +	msg->opt_state =3D NULL;
> +}
> +
> +/**
> + * spi_maybe_unoptimize_message - unoptimize msg not managed by a periph=
eral
> + * @msg: the message to unoptimize
> + *
> + * This function is used to unoptimize a message if and only if it was
> + * optimized by the core (via spi_maybe_optimize_message()).
> + */
> +static void spi_maybe_unoptimize_message(struct spi_message *msg)
> +{
> +	if (!msg->pre_optimized && msg->optimized)
> +		__spi_unoptimize_message(msg);
> +}
> +
> =C2=A0/**
> =C2=A0 * spi_finalize_current_message() - the current message is complete
> =C2=A0 * @ctlr: the controller to return the message to
> @@ -2153,6 +2188,8 @@ void spi_finalize_current_message(struct spi_contro=
ller
> *ctlr)
> =C2=A0
> =C2=A0	mesg->prepared =3D false;
> =C2=A0
> +	spi_maybe_unoptimize_message(mesg);
> +
> =C2=A0	WRITE_ONCE(ctlr->cur_msg_incomplete, false);
> =C2=A0	smp_mb(); /* See __spi_pump_transfer_message()... */
> =C2=A0	if (READ_ONCE(ctlr->cur_msg_need_completion))
> @@ -4194,6 +4231,99 @@ static int __spi_validate(struct spi_device *spi,
> struct spi_message *message)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * __spi_optimize_message - shared implementation for spi_optimize_messa=
ge()
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 and spi_maybe_optimize_message()
> + * @spi: the device that will be used for the message
> + * @msg: the message to optimize
> + * @pre_optimized: whether the message is considered pre-optimized or no=
t
> + *
> + * Peripheral drivers will call spi_optimize_message() and the spi core =
will
> + * call spi_maybe_optimize_message() instead of calling this directly.
> + *
> + * It is not valid to call this on a message that has already been optim=
ized.
> + *
> + * Return: zero on success, else a negative error code
> + */
> +static int __spi_optimize_message(struct spi_device *spi,
> +				=C2=A0 struct spi_message *msg,
> +				=C2=A0 bool pre_optimized)
> +{
> +	struct spi_controller *ctlr =3D spi->controller;
> +	int ret;
> +
> +	ret =3D __spi_validate(spi, msg);
> +	if (ret)
> +		return ret;
> +
> +	if (ctlr->optimize_message) {
> +		ret =3D ctlr->optimize_message(msg);
> +		if (ret)
> +			return ret;
> +	}

Not really sure what are the spi core guarantees or what controllers should=
 be
expecting but I'll still ask :). Do we need to care about locking in here?
Mainly on the controller callback? For spi device related data I guess it's=
 up
to the peripheral driver not to do anything weird or to properly protect th=
e spi
message?

- Nuno S=C3=A1


