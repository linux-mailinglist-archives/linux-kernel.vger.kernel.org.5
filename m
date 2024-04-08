Return-Path: <linux-kernel+bounces-135035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C489BA39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1FB222C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED531A85;
	Mon,  8 Apr 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCgs3AYs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD638FA7;
	Mon,  8 Apr 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564873; cv=none; b=kMT4P2diWVgte5cGPHHNy4hy8t8DgZ2Z4+r77qqXyDP0NYGxDAAbEKF2EK4MIKFd140B6lLWs1pedAzYjz7Eo/+zmYYJZs1QShwg7+Sv7V6IWql7j4zVQQu41KgRs25bxvE6i6NSm0g+G12G5LEdzRGe+EgP6r1ufPcjqrVTnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564873; c=relaxed/simple;
	bh=iDRZ7NACy/T0uhiXZjIuXu3NxT/V6Mg0k8eu2ro0ehM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DktipVVl20DTMawM7GbbiF6bGPnIA9kq/QVvFz/LWjLLfhUkSb6VjU94lOF9xdptpvjtL7K4TJof4qMu39RDCes+u4w67XT2mtjFdbyLy3bPuVAVunn3+QVpASYRG2jYSWrKpk+mCsCyG7/IxiB1rh9FdYfRHJXUicyawpB3A3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCgs3AYs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46a7208eedso606526366b.0;
        Mon, 08 Apr 2024 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712564870; x=1713169670; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDRZ7NACy/T0uhiXZjIuXu3NxT/V6Mg0k8eu2ro0ehM=;
        b=KCgs3AYsklV3+jlY5WOBBM3eC9FaLZ970jZsdH1PdnsYFlezqFYbB1aWD+SH/+pHiz
         cpuhPyGyNQxQ7RMl4YwjsCi+sVHcX94BOeMKlr5Y1M2MNZfCCfIfYhFH7KOcdiXFW2vw
         1C7MMjTVbBwSoqfuxPwNX9hMlMEEpWbJaERlo7iFhXpdmUgJJSOLSxjiWYwS3XGEOqv4
         npvDqlocUoLkz2Od++vdK2mDyflskHL+3S0G5sF5D2cWP9oxGxZdHoHGOvYSFMrOeHpt
         VwrIwa7sd/Xn1vA2FRTWrBZzQJowp0lvlwQgIY/yKLBgu8xqSOQbwX6l9KffHUK+STJS
         iyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564870; x=1713169670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDRZ7NACy/T0uhiXZjIuXu3NxT/V6Mg0k8eu2ro0ehM=;
        b=LFP0pAKJPkQTLu0BqMuNVc5E3voU75J4Vi0Y2KWBVBZPQiJIITX3O4tH9VEh468Qaq
         iq5bHxa4zBFNUIeQ8Ql3ioHjBwgKY7EkGNIshG7lUtOxMLgeNOpxwJtPcWPVB/1mN84I
         u8y0Zz/KFEODZnSDidAu7hP5XUtxCq8U9dlnxI/UFBawVfSNuXbQeB3UjQkQrMv4sJ6F
         eoxv812Uf9/5BLJBg8BaeAwpLLMA2NLDo8gqOZvwV3TaVmwe6MhKHP3iG1X8n0UyvTcz
         tklRO40yZELEQbHMdeNnkCo21T/orxiMAhV1a/CQr+GFGvZtCmoTKZ8/t3c2KzYiLdD0
         Rd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE6vbeJE8wFTgclqzWk9ydrRUaElo4MIa+iBSz7fxv85h7739jKQfF/mbCw6fvRV70vqdJmJhaprrGlZZiiV6SAvxHf9+Cwzy3
X-Gm-Message-State: AOJu0YxgY0kBXgs7mLil5+PJ1DebVZecrP4WzNKKNXET4HMn0DurtccB
	eZiy6in6OWZB9KCbvBbQ/eDBCUVr7RxK/35T7sdmNqLuC2OvciNO
X-Google-Smtp-Source: AGHT+IHg5+lrP7tvoC+ALMJ4gdEovq3a1kuvBB+v2TYMUycN77t34ozFlvzlLhjogKeEl+Oztg8+Lg==
X-Received: by 2002:a17:907:7293:b0:a51:aebf:7e4c with SMTP id dt19-20020a170907729300b00a51aebf7e4cmr5655739ejc.9.1712564869512;
        Mon, 08 Apr 2024 01:27:49 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709066d9500b00a4dacd6b8b3sm4159224ejt.68.2024.04.08.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:27:49 -0700 (PDT)
Message-ID: <b6c6700d924916dd09afd2878321a7c87b8e922d.camel@gmail.com>
Subject: Re: [PATCH v1] iio: adc: ad_sigma_delta: Clear pending interrupts
 before enable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Date: Mon, 08 Apr 2024 10:31:21 +0200
In-Reply-To: <20240406171728.16170b48@jic23-huawei>
References: <20240404175126.110208-1-markus.burri@mt.com>
	 <20240406171728.16170b48@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 17:17 +0100, Jonathan Cameron wrote:
> On Thu,=C2=A0 4 Apr 2024 19:51:26 +0200
> Markus Burri <markus.burri@mt.com> wrote:
>=20
> Hi Markus,
>=20
>=20
> > For device will enable and disable irq contiously like AD7195,
> > it use DOUT/RDY pin for both SPI transfer and data ready.
> > It will disable irq during SPI transfer, and re-eanble irq after SPI
> > transfer.
> > That may cause irq status bit set to 1 during spi transfer.
>=20
> Superficially that sounds like it might be an irq driver bug to me...
> Or just possibly an irq chip doing lazy disabling?

Yes, this sounds odd as we are already explicitly disabling lazy disabling:

https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/ad_sigma_del=
ta.c#L589

>=20
> >=20
> > When the active condition has been detected, the corresponding bit
> > remains set until cleared by software. Status flags are cleared
> > by writing a 1 to the corresponding bit position.
> >=20
> > Signed-off-by: Markus Burri <markus.burri@mt.com>
>=20
> I'll need an appropriate ADI ack for this one.
>=20

Yeah, I wanted to reply to this one Friday but then completely forgot. I ca=
n't
really ack this one. I would need some insights from someone with more core=
 IRQ
knowledge. But...

> It seems highly unusual to be calling a generic irqchip related function =
in a
> driver (there are no other such users).=C2=A0 So this seems unlikely to b=
e
> the right fix for this particular problem.
>=20

Yes, and this (I think) would not even fix (if a fix is needed) this for al=
l
irqchips which to me already sounds not the way to go.

- Nuno S=C3=A1
>=20

