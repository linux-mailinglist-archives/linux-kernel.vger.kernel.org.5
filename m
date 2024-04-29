Return-Path: <linux-kernel+bounces-161884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0D8B52AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123F81C20B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5315E97;
	Mon, 29 Apr 2024 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0b2J07E"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA78EED4;
	Mon, 29 Apr 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377306; cv=none; b=R5Uq92SNtWI0/PjD78Hn/x+j1hmhkzg0Up/ReHnA2xXCXccnbCAk1csDk+3OYrY1Y+bR2W/c9nuGmISBH30JVtnGLkVoB7cw84+G/WhCTu526P2BFfxlbEVBw8hhxELAvqyxJ4Q+6YQTI4zv+I1RUTfYBmB1njhQlVHxI/kfERw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377306; c=relaxed/simple;
	bh=tiKshYUIgU+C4Jc8N+hBsmNQ/hFvFexXKDmBYginrA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tbD6sI9+KOfmDilU7A8YJgasJGMZrvkDYeobAfsu6oEBCOAeSOseefQixRlkWQ5V+gYKfzFM753FWyx+mOD1PU1nOXQa1LlPuuyyVs/TrS8eoYlB3yZivh/ZdGqx+9XqH0p5wirGmAherOBRGkECOnTUivgGvWWjV2OEWHQjZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0b2J07E; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34c0f5f5cd0so3329397f8f.2;
        Mon, 29 Apr 2024 00:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714377303; x=1714982103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tiKshYUIgU+C4Jc8N+hBsmNQ/hFvFexXKDmBYginrA0=;
        b=m0b2J07E5PTjff6MrdcAzfx2aX4vwVjCH8BZM970tQhtt15VNhuaEXi/lqhbvjmCim
         4vaMwL/vkCEoIUhhkzf7F8z5u4YTYikRow3PeStEPsQ0fmIod/FfJMCqRfG275+qbxSm
         2eMfOjfLTr8FleQXG5CqFZI6lMStS4xRoqtTdoBAs6aL4TLb1tKDk7I1Kf7F2wy1E3Rm
         XfIiCVaU/xewKZY6CRuWeYFWOWUNr/6cM0G/zvh24TK5nR4ZpVQHT5BWb2d091XevFWP
         ecGNbypBfZBOqviPVUj7UsoWs7k3fYF2PP0ny3Ppv7XcLV3RX11bHmlksntK04Rn667r
         jU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714377303; x=1714982103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tiKshYUIgU+C4Jc8N+hBsmNQ/hFvFexXKDmBYginrA0=;
        b=KlnqI4YnF5SZZacnBq+yTFwsfA/LVGjGoIBQqNc0n1PTgQ+cL9jRuyxcfUu56uuO46
         prug8LrLZxjKgR3cTwg6UlbWjDsiHQNh3/X3pv2yqm+owNhXtQmU+hVVuwFaxGkvk9XA
         dTTuIh43gG4hEALD/1Jc4XFtab9xnf/IOgLux0zA4bVlINXocgDwLleYKgHVV/oMm03o
         TLGgLFajJnd+KYmTP5PZxpDBJ/qPiDyJt6Gnpg4/fnerjw3qCZ8eiw/Y9txBVILu1V43
         SItXDXF44Jc7N3lBElhb63z0gBjgYfQ3yfukCgeBubkjGlAnH2kM1+8/AxFBednPpkAQ
         +KwA==
X-Forwarded-Encrypted: i=1; AJvYcCXOCsCgPcs2LgSbwVscTU4RSzcCGrYUr8IuSwxxf8p8a7BwMz4uzPXAHiZJJxDSEpd1SpK5kogEOk5xdCrMa1dcgHchejII0nJlj45vYZ3cNKNzzskk04EEq8xGFvzLuuH8xUpWeFVk2C9M0ihnRn+ZRq/IEVZ4FHt4yxuqu24JpQ==
X-Gm-Message-State: AOJu0YzPkealz2TtPT8Iw5Ro3V6H/0B1W+jyBxMGolFJMwkcOH6dNx8f
	JhlWQUNUalgEES34Wi2K96S72UxUpaFxp3vbzSTVkFZazk4iTQy+L0aRsaoNH/8=
X-Google-Smtp-Source: AGHT+IE1t/q4f+QGWHixnNA2MQJglgBMGgcEo52I+k0yP1J/yswyQvKvQcaKnXxVRdS5zUr48uGRCA==
X-Received: by 2002:a05:6000:1ac8:b0:34d:a9:6642 with SMTP id i8-20020a0560001ac800b0034d00a96642mr2166868wry.28.1714377303111;
        Mon, 29 Apr 2024 00:55:03 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b0034c6b368aecsm7480380wrd.26.2024.04.29.00.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:55:02 -0700 (PDT)
Message-ID: <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Ramona Gradinariu
	 <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Date: Mon, 29 Apr 2024 09:58:40 +0200
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
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> A few comments inline.=C2=A0 Biggest one is I'd like a clear statement of=
 why you
> can't do a burst of one type, then a burst of other.=C2=A0 My guess is th=
at the
> transition is very time consuming?=C2=A0 If so, that is fine, but you sho=
uld be
> able
> to let available_scan_masks handle the disjoint channel sets.

Yeah, the burst message is a special spi transfer that brings you all of th=
e
channels data at once but for the accel/gyro you need to explicitly configu=
re
the chip to either give you the "normal vs "delta" readings. Re-configuring=
 the
chip and then do another burst would destroy performance I think. We could =
do
the manual readings as we do in adis16475 for chips not supporting burst32.=
 But
in the burst32 case those manual readings should be minimal while in here w=
e
could have to do 6 of them which could also be very time consuming...

Now, why we don't use available_scan_masks is something I can't really reme=
mber
but this implementation goes in line with what we have in the adis16475 dri=
ver.

- Nuno S=C3=A1



