Return-Path: <linux-kernel+bounces-20951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDA8287BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B211F242FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA43A1C0;
	Tue,  9 Jan 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLmdk8uF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C193987D;
	Tue,  9 Jan 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1795632a12.2;
        Tue, 09 Jan 2024 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809087; x=1705413887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FdF2es8VoiWkBREAs6JkFDoqFW7mv98jnDs4otx1ldo=;
        b=mLmdk8uFRGWvD0OoaYlt5vmUBwZyi6Y8B9YwgPAXCYl5j3QvnyOGJx4+L4O5vAPCzA
         rZP+6qxue61fKuxmAlpd7QdOxaZyV8MmyDujIXRyLXuX7iQ45t18RmSanjSesFtWdske
         rswqrM/otF19WIm/0vk9s6RTUDcnb9GmZ/qrNPKNbG3UKuEGqCBWAWV2gy9fcMkm2zUa
         fAFe5R+2AE7Rsk4DjKztlB/0XR1HQrBe1c3YYKEAH5izh1y7U5Lg9eR5DcMe9b1lNcZC
         6gvyCRORU5ly/kW5CNapQyQrNLQDiYO3FFf980PK1maXH4ytUqEVBtx3p6toc/rKJtvY
         epbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809087; x=1705413887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdF2es8VoiWkBREAs6JkFDoqFW7mv98jnDs4otx1ldo=;
        b=NmuV5ZuAEyeEsKE8HfxZcMsl7an85CIDAAR0owxKaC2V6fRVwfX5k3zyZjBitq15Ch
         +1hIIjbBFXnsM++ch3exph35PticVzpZN9TWhiujTc5VYcmDg5Apj+dqSX/8eJmPGeyO
         nzHuPloxC/aLY7K8mrpAp1tzOHcozdQ//Wyz5fNJv9OUPguSCIYv77lxgwucfOf8fgKY
         BabxhKwUBnSUvutC0TzOfit7YLRxYkz4Xdb8dHefOJ1oaoFy/tdTI1VJ1ra63+Y0Q/Xd
         IIkonfB7ZRJbwPqmRajyojx0rBjZnDaVNu28Ifb3gofRegWi8wxbYgbKXkKmxpBYO4sG
         0QOQ==
X-Gm-Message-State: AOJu0YyV0fb2hjUtDkDobfPCcBPwLORBR8xf89dMrym9p4RhhX+JPhKa
	uiZutvGNAq75mGcUE/YJ3Mw=
X-Google-Smtp-Source: AGHT+IHd/g6WN1znIUWVeU4eMncW0xXeTck1c84wqrrPeMBepd3FexOtg5oPHn/iR+FeQNKSGp+/ug==
X-Received: by 2002:a50:d516:0:b0:556:68ad:b511 with SMTP id u22-20020a50d516000000b0055668adb511mr3275958edi.16.1704809087293;
        Tue, 09 Jan 2024 06:04:47 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id b2-20020a056402138200b00554d6b46a3dsm989200edv.46.2024.01.09.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:04:47 -0800 (PST)
Message-ID: <d927b0b761eb7105d2193d9dca48f2c6df8868b7.camel@gmail.com>
Subject: Re: [PATCH] iio: core: use INDIO_ALL_BUFFER_MODES in
 iio_buffer_enabled()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Jan 2024 15:07:57 +0100
In-Reply-To: <20240108200647.3916681-1-dlechner@baylibre.com>
References: <20240108200647.3916681-1-dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 14:06 -0600, David Lechner wrote:
> This replaces use of individual buffer mode flags with
> INDIO_ALL_BUFFER_MODES in the iio_buffer_enabled() function.
>=20
> This simplifies the code and makes it robust in case of the addition of
> new buffer modes.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM,
Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-core.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index c77745b594bd..8855d377d710 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -210,9 +210,7 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_=
dev);
> =C2=A0
> -	return iio_dev_opaque->currentmode &
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (INDIO_BUFFER_HARDWARE | INDIO_BUF=
FER_SOFTWARE |
> -		INDIO_BUFFER_TRIGGERED);
> +	return iio_dev_opaque->currentmode & INDIO_ALL_BUFFER_MODES;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iio_buffer_enabled);
> =C2=A0


