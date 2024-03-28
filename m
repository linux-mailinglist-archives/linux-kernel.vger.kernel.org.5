Return-Path: <linux-kernel+bounces-122828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2CB88FE09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD97B24441
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174237E583;
	Thu, 28 Mar 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl4v05Tl"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A587D408
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625122; cv=none; b=Xk0LxyKySOvjBGukm+xZ56TkHAnpnDVla80rhfH2DcxADsLBla2IlbvBTJGTpINRah83Ym7Y6WRn3FrEY0W+imG7nzk3z5v7blQm/oyUjITqwa3LBKiBeceHYFSO7NSHmjTyZmzp2WJSQtMS+mIBV15ycySMdPZi1M9vFwtxvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625122; c=relaxed/simple;
	bh=ReqiZMaFal2HmdF6yojPFU7SFMvwR9W/4on1lxJ2DGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qh7CBY5aDa9OnxGqm+b6tqbcQTeWvS1fyjPrDZVGeOy1Il6FJoZA1xxMxkNvQQEyfLSSnLj7oDjzyOCfisVv+YhXM6mKIdrn+jtzrhf7vLPJBTElaimYR6Ztf8k7Gsteq8D99Z/x7hL5upBQBnIjXuWt8V6qFij9NH+ayLbZrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl4v05Tl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ececeb19eso442836f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711625118; x=1712229918; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReqiZMaFal2HmdF6yojPFU7SFMvwR9W/4on1lxJ2DGw=;
        b=Gl4v05TlhyNcfw9H1Geb1CYBTPBwT4w/BxsNU1ictJUL/Ff5HUSWQwVg7pPIWwd83B
         P4c5Q1mh3sJThmVFkm0PRAbE+FULQGwNpirD93K+peixut7ycgzAiLMj33wxKiGuv0fx
         N5yebskEyH8ynkSpG4/82N/r5VLqSutuKfUHFbJO1FEoHZ/rCT3tMBZ5xxZJTLwwYD04
         Jb0vAqrKOVyFHgyMQGaJahZ2TZMKlUS06F0FJ7nluUqeCJxiO1zsC2un7ikdMZQqWezZ
         YhBeNrTduWhsYkzkbM0496hPDHG/4IvWIY2Bg1WjhXkkBre11rF7POkuWqMzXFLjaEj5
         x2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625118; x=1712229918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReqiZMaFal2HmdF6yojPFU7SFMvwR9W/4on1lxJ2DGw=;
        b=LNtgc3d1c3r4MVUFlD00oKecaKnBLdqyULpht2k8/RXLoYf05JiCvkNQMGiwgjVTzP
         rT0RirS3bAg7GpQZD+jq+x0P2qTrmH+qiJWs4PVGluO2o2zG+RnTmvP8RaPUAbaczHEJ
         cBjC1IYsScVXjuuycyzG7Q4+P/7kqqel1/4L0gOvgzRj4c18E18N9ABblLKQdgoVSflR
         CNKRh76J5JBtY8yIsQevP2BMEBwwDYJWWsjccE9IA5sKOSqJ7HO80N0acYrHiRWZvQaH
         RJ7VHJ4MMDm4+0godvamZwWDMu/lxo/2c7YUP86llRus5k9mK9fQU3sWfriroJqMpPBx
         72Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4pp2k+ZHdsyTa0B3jggrUaSth8rr4LLXwkcEmkXVSMSk0tR+afWyC1yTW+gBxat62J/6MIor5Qk5Hv0lgAQ+cLpdPKPmAVqQZ15+
X-Gm-Message-State: AOJu0Yy8y3y4n7ZBBMgDmeybbv/KwoA6xwzsK+cm4OEFb4gqyWH1ZMfM
	r8GqaZJP4rrHxFGYdSPp5oQK9LRre1tWLB9CYRh+0i+5JD/C5Komp//J24SmgcY=
X-Google-Smtp-Source: AGHT+IG3rpM6+1a4KBV63oMIbrPS8hANggXGrZwGuY0lneIQs2DVnJVdpWA4J7EbAZOyKm7IfBsIkg==
X-Received: by 2002:adf:ce11:0:b0:33d:5fa6:79bf with SMTP id p17-20020adfce11000000b0033d5fa679bfmr1750674wrn.71.1711625117639;
        Thu, 28 Mar 2024 04:25:17 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341e2738eb4sm1512382wrb.95.2024.03.28.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:25:17 -0700 (PDT)
Message-ID: <ed636c3e3dbd733b7135f0609e070c7afa8e673f.camel@linaro.org>
Subject: Re: [PATCH v2 2/3] clk: samsung: gs101: propagate PERIC1 USI SPI
 clock rate
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, s.nawrocki@samsung.com, 
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 semen.protsenko@linaro.org, linux-clk@vger.kernel.org,
 jaewon02.kim@samsung.com
Date: Thu, 28 Mar 2024 11:25:16 +0000
In-Reply-To: <20240326172813.801470-3-tudor.ambarus@linaro.org>
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
	 <20240326172813.801470-3-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 17:28 +0000, Tudor Ambarus wrote:
> When SPI transfer is being prepared, the spi-s3c64xx driver will call
> clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
> is a gate (leaf) clock, so it must propagate the rate change up the
> clock tree, so that corresponding MUX/DIV clocks can actually change
> their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
> all USI instances in GS101 PERIC1: USI{0, 9, 10, 11, 12, 13}. This change
> involves the following clocks:
>=20
> PERIC1 USI*:
>=20
> =C2=A0=C2=A0=C2=A0 Clock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Div range=C2=A0=C2=A0=
=C2=A0 MUX Selection
> =C2=A0=C2=A0=C2=A0 ------------------------------------------------------=
-------------
> =C2=A0=C2=A0=C2=A0 gout_peric1_peric1_top0_ipclk_*=C2=A0=C2=A0=C2=A0 -=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 dout_peric1_usi*_usi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /1..16=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 mout_peric1_usi*_usi_user=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 {24.5 MHz, 400 MHz}
>=20
> With input clock of 400 MHz this scheme provides the following IPCLK
> rate range, for each USI block:
>=20
> =C2=A0=C2=A0=C2=A0 PERIC1 USI*:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.5 M=
Hz ... 400 MHz
>=20
> Accounting for internal /4 divider in SPI blocks, and because the max
> SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:
>=20
> =C2=A0=C2=A0=C2=A0 PERIC1 USI_SPI*:=C2=A0=C2=A0 384 KHz ... 49.9 MHz
>=20
> Which shall be fine for the applications of the SPI bus.
>=20
> Note that with this we allow the reparenting of the MUX_USIx clocks to
> OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
> reparenting of a MUX_USI clock corresponds to a single instance of the
> USI IP. The datasheet mentions OSCCLK just in the low-power mode
> context, but the downstream driver reparents too the MUX_USI clocks to
> OSCCLK. Follow the downstream driver and do the same.
>=20
> Fixes: 63b4bd1259d9 ("clk: samsung: gs101: add support for cmu_peric1")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


