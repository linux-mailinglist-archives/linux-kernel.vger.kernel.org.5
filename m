Return-Path: <linux-kernel+bounces-34792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DB838781
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDE31C2282A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DDA5026B;
	Tue, 23 Jan 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ZdrT00"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5563611E;
	Tue, 23 Jan 2024 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991516; cv=none; b=O861rSgKYESw4gHmCRDvvniAPUlnTNWxTSLD7/9ab19lXiIEaf2nrYWaeL7siADbp6uhAck1aKgmZNPuVYemFq7whFq10XwaQDe8C8jLaWc59V9DQK0D2z4Y/2VExKA41gtSYMD8GACebrr7EaMRI0QvH9mAZzXvp+5iSq7fp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991516; c=relaxed/simple;
	bh=hKkJeIyQxJp17hHSYN2luEiqd63jZiE86WMV2UkbhiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu2XOeblgx0mRS7dTJ/8kncCQG2WGy3JS+7xoiQnigwjPJxckKT4D7b8PSN5BBIX+Dc435LBxeQEjF6IGIElWpQUtG36mv7b4LkNeeh+FOtU2dbl8qB3R05svAYlLzk1FGQd917JppOuVZ2UVFxc2/2skwVw+zi2fuA++dzDGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ZdrT00; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a293f2280c7so409459366b.1;
        Mon, 22 Jan 2024 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991512; x=1706596312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiegNsczaU/U+xs19FgETokvnebxdn1/j3gX8xGr8wk=;
        b=W8ZdrT00LlMV2uW04x+Zqbz0azFbPI+njKidQNPj3/tI8uOhvjnJjIoJV6DeJJvWJJ
         CAbDOQJpEFIoOEvWW6hsaiaaFatx3HfnwqoVd71fkXk7ob9yp3QNXu7nOX2Aiakunc10
         RfrA7ymtqRvcVxeZKwd/wTPFL+Fmz7vyyERaZONXkX9gOZ7Dvq124t17lzhWplPg2Slo
         3zbKgSxUUBq4Lk84VipbPuCBLZ/GSi6p3jnpqp53KIbDFABXoWNNvAW64NNc0W9LblPx
         TCaMveVENC4hVnMTH2Ts4rTwvkrRcEDcuCaRpLrHNh8Mn3F87G4UnitB2fP3IU+Uyxn+
         KRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991512; x=1706596312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiegNsczaU/U+xs19FgETokvnebxdn1/j3gX8xGr8wk=;
        b=cuM22YDb0rX9kseTum5hI8gQgZ6FDAov27PM0d9pH6JBiLzynL87BUo56uHpXzhkyM
         owLoVtBmbThr//CCwVLO2r12/6JTW51wthwsbvmNZGj2fjUAaAF+1N09V6aBm18vuDYI
         59UCY0kWnigZh71KfpEG0pUIWagEAL8MI/PT66ZA3GrFtE7Sxdcb6R9pg/ipY+8sfF0T
         R2aNwAwE93EwGXd+6Upr0UKhh8HQN9KCU+Ftx65I0f4p4nSL1UIyNRAe7J7i4W/2nCrF
         vuFMjXu8Pp8Bg900nmNw2MuXG+GmqdlaWT8+HY0m2oMzQy230wd9sm4nW90OFUSlMVC4
         I7JQ==
X-Gm-Message-State: AOJu0YzKkT2927HykjUgu9uZtswaw4BRet49umaAzEFD3tBPBomRREt2
	X7iOIe0GCKxH8U5O1SY7Zh5sfo0prgtcjWDym8Sh0a3bHCmrMsrTeF2Pd/4eDE7VKYo29ngaHqZ
	mF/WPABdCrAzfEwH9WdaH1+sMK04=
X-Google-Smtp-Source: AGHT+IH0aD3xHVclLbZ/H4ZUYjO3fWFMmmqZWeW5/xbnkp7PG+R1tbM/DjYGvO0K0W0BfhaQhU6Sv6vDvQBK9LN5oQc=
X-Received: by 2002:a17:907:a782:b0:a26:ee0d:1c02 with SMTP id
 vx2-20020a170907a78200b00a26ee0d1c02mr2034600ejc.39.1705991512469; Mon, 22
 Jan 2024 22:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122203502.3311520-1-linkmauve@linkmauve.fr>
 <20240122203502.3311520-2-linkmauve@linkmauve.fr> <c2963862-9d22-438a-8357-eccf14fead7d@linaro.org>
 <Za7npejeTD4i9y2h@desktop>
In-Reply-To: <Za7npejeTD4i9y2h@desktop>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 23 Jan 2024 10:31:41 +0400
Message-ID: <CABjd4YwM8wPGth=n97JRbaNCuPNRjs6uNUFVdRgu3_OAYQdxWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add the rk3588 thermal zones
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	=?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Christopher Obbard <chris.obbard@collabora.com>, Shreeya Patel <shreeya.patel@collabora.com>, 
	John Clark <inindev@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 2:09=E2=80=AFAM Emmanuel Gil Peyrot
<linkmauve@linkmauve.fr> wrote:
>
> On Mon, Jan 22, 2024 at 09:52:10PM +0100, Daniel Lezcano wrote:
> >
> > Hi Emmanuel,
>
> Hi Daniel,
>
> >
> > please sync up with Alexey Charkov (added in Cc) who is doing a similar
> > configuration [1] which was reviewed.
>
> Oh, I wasn=E2=80=99t aware of this work, it seems there is nothing this s=
eries
> add over Alexey=E2=80=99s so I will drop it.
>
> Is there a document tracking your upstreaming work?  I was planning on
> sending a series enabling the VEPU121 hardware encoders next, but if
> you=E2=80=99re also working on it I can drop it too (although I don=E2=80=
=99t see any
> series from a quick search).  I=E2=80=99ve now subscribed to the linux-ro=
ckchip
> mailing list so I shouldn=E2=80=99t miss any new series.

Hi Emmanuel!

I'm currently in a rather more ad-hoc contribution mode, so there is
no tracking document. Here are the things I have in the making:
 - Wire up the GPIO pin that drives WLAN enable signal in the M.2 key
E slot as an rfkill device to make WiFi modules usable on Rock 5B.
Applied locally, tested, submitted [1], not yet reviewed or applied
upstream
 - Add thermal zones managed by the TSADC to RK3588 (the series Daniel
referred to). Applied locally, tested, submitted [2], working on v3 to
incorporate the feedback
 - Wire up the PWM fan as an active cooling device managed by the
thermal code. Applied locally, tested, will submit as part of v3
thermal zones code
 - Add OPP data for CPUs on RK3588 to enable runtime CPU frequency
scaling. Applied locally, testing now, not yet submitted

I also wanted to wire up the display outputs for Rock 5B, given that
VOP support has been recently enabled on RK3588, but haven't yet
started on that one. I haven't touched the hardware encoders either,
so please go ahead with sending those :-)

Best regards,
Alexey

[1] https://lore.kernel.org/linux-rockchip/20240106202650.22310-1-alchark@g=
mail.com/
[2] https://lore.kernel.org/linux-rockchip/20240109192608.5981-1-alchark@gm=
ail.com/

