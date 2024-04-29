Return-Path: <linux-kernel+bounces-161888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281038B52BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EBD281EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460E16419;
	Mon, 29 Apr 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIcFffME"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B46134BF;
	Mon, 29 Apr 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377488; cv=none; b=XOqd87Zrxi10ZYHMw4qi5yfs/Rcgo3A4w1LL+gFYW5gUVltyoQ6zlih51O22O8fm1Tnq2pGirkWQRbA/nMLYYv6ZZtp+b1KxbgR1YZRypb7iBYv2hD9XLPqICEzJ7a8bT7mqODpHkjpGULJIi7Tq/WL1AAgs1ZVCb/UKCyY73Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377488; c=relaxed/simple;
	bh=xYM2yXWnRhqySCaj8k34zqA1nOe3QZmh3OR/nz2Lfss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y+a1SxCGCM7j89kPg2aSmbCGbRhosWxd8HBAYgP2q4s9BWcsOfwO1efTGzI2fe9W8dv2lEQdXCUKcVPCSWos0cEuUrKm2fa3kmXW/AN28ilwk7LcD/POq21Hhu7JFO+i1BO4pMyDeDLOJB0C6pLNfpE+3W8i5+qCVTt5+V+T5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIcFffME; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso23261875e9.0;
        Mon, 29 Apr 2024 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714377485; x=1714982285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xYM2yXWnRhqySCaj8k34zqA1nOe3QZmh3OR/nz2Lfss=;
        b=YIcFffMEYRPDlYaxvtquul+IbmqRUsE6J4yvtU7trJmU7vKOu+bDq80uQj8R9P+Dbw
         +o5ilkUmTaEy3c8zdBO4WvVxM7Ul634TIosTRqieLWXF9LZh8mnc+qhGU7JwJYIdtXSt
         GfiHGodRjr3+QHz7SaAeLp2B1r1L86RL4CbHINtMAOe7+LfoaXfvNbC1UiySfx2ZlN1k
         rDyrL3MWgTQ75fS4f7O4HzXH8uSWc5CY2zrL7ss2jW2ROBhL0IFspjeyNloQqIFb92ig
         4O5Cy9M/yZc4V8DLY230z3Yks2Oa+rT5+c55DBrql8ah/SzdFxbT/LssrJTXvs87t8AW
         dWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377485; x=1714982285;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYM2yXWnRhqySCaj8k34zqA1nOe3QZmh3OR/nz2Lfss=;
        b=RR1e9efHxbaaf6ih96nhZjuQ2Nl5OqjWqKDdd04fgLQgjzbq4hW2/S9UP8EXat1FFf
         eAOHSz0jnA3VuE+BSxZe4zKplug1CQ1KD0tew54PPg/NY/HzLjhMCSYLKW3F+qN7oqww
         tsooMr1eSW835zlit4B+N3dvMB7kBbBiNGjEKP29MbPKCds2lro4WXEyKVHaK9Dy1IfD
         0456aqQGAT8kcGi2KpVuTRIXmkZ4QUewzJR/VRMPmEkjZkpMhfTl/KKJJp0aVp8cSOe0
         wvICyTT2/4mTnBm7zl/1xE70Lx8BB2PNBQdxFthCUjbfTpnAzHciclJUr3BDLRTSHBFq
         gN9w==
X-Forwarded-Encrypted: i=1; AJvYcCXcUzQTXosWvUBuTIIXFDSbiZ3OebIZDrVZKtpAGZbYe2LGB5/jHvLny3/b8ZNe5wXSvlrxAL32PiO3sMVSlkfB68eqXqRMEhKYrzGt51iK6RA1w4P2Gaa6puntokWUSDjsQZT7TUrAS7B1j2kKbH7QJx3GIzBaiZqSCRdQvgYftg==
X-Gm-Message-State: AOJu0YzW4mhK9bf33vqN/5HJrZ0FhNmEdOTn4dDDNiVn959Vvj8axOxD
	hMddIwaJlJq1gLsb1112As8u0g7qynCnbwzfiUAYSsBWU/rmcExs
X-Google-Smtp-Source: AGHT+IHUXWkWmSGPpEjYl3wk64uAdREH56IKk99xgzW0ANzW0yF5B6m46aVyp4rUqYCBMTndgimAVA==
X-Received: by 2002:a05:600c:3507:b0:41c:13f6:1ee1 with SMTP id h7-20020a05600c350700b0041c13f61ee1mr2877367wmq.4.1714377484714;
        Mon, 29 Apr 2024 00:58:04 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm32010568wms.20.2024.04.29.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:58:04 -0700 (PDT)
Message-ID: <51bb337457b6deab93bb1cc3652d8168763f6aa1.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Ramona Gradinariu
	 <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Date: Mon, 29 Apr 2024 10:01:42 +0200
In-Reply-To: <20240428162555.3ddf31ea@jic23-huawei>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	 <20240423084210.191987-5-ramona.gradinariu@analog.com>
	 <20240428162555.3ddf31ea@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 16:25 +0100, Jonathan Cameron wrote:
> On Tue, 23 Apr 2024 11:42:09 +0300
> Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:
>=20
> > The ADIS16545 and ADIS16547 are a complete inertial system that
> > includes a triaxis gyroscope and a triaxis accelerometer.
> > The serial peripheral interface (SPI) and register structure provide a
> > simple interface for data collection and configuration control.
> >=20
> > These devices are similar to the ones already supported in the driver,
> > with changes in the scales, timings and the max spi speed in burst
> > mode.
> > Also, they support delta angle and delta velocity readings in burst
> > mode, for which support was added in the trigger handler.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> What is Nuno's relationship to this patch?=C2=A0 You are author and the s=
ender
> which is fine, but in that case you need to make Nuno's involvement expli=
cit.
> Perhaps a Co-developed-by or similar is appropriate?
>=20

Ah and regarding this is that I guess Ramona just modified my internal patc=
hes
adding support for these parts long ago (when they were not public yet). No=
t
sure how much did she changed but a Co-developed-by looks the way to go...

- Nuno S=C3=A1
>=20


