Return-Path: <linux-kernel+bounces-32338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B238835A65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C689B20BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9105B5684;
	Mon, 22 Jan 2024 05:38:55 +0000 (UTC)
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277875673;
	Mon, 22 Jan 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705901935; cv=none; b=JEs1mpUQAAW2l/TJucbpZTG/bpYKPuJ7Yjur8mMZlfij4JDP2KRvCpxZdo1JdHqEGZjY20i9Hl0yY3CUQwi1J+FYxNvu4MPt5ZaW/rEiGrcNrt6RggN3MTxG/wXawsTH0siEOMsQqV7NTRVygWPNy1Yybm2GlzoZPr1YObJFcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705901935; c=relaxed/simple;
	bh=1sisWpA0oLBoywGGJoqzMdCk3uVhcDAAv42idkjUAiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJihzt0lgHnsqSZkWcop2gCCzDV+Ls7GRd1NtruzrL8g3dvoEzkr3WbIbnRdfeMJ/YAUUekaP/wQRUec8aIVcMY6JuHhkEjuheAYk76hI7pnHpTn38PTI84kmlphZEbArZh9HiCdPaGijvzc65v8gcRugFF7pBq5ristN5FcqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id E1899C3F2A57;
	Mon, 22 Jan 2024 06:28:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl E1899C3F2A57
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,  Shawn Guo <shawnguo@kernel.org>,  Sascha
 Hauer <s.hauer@pengutronix.de>,  Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Sakari Ailus <sakari.ailus@linux.intel.com>,
  linux-arm-kernel@lists.infradead.org,  linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ar0521: fix spellos
In-Reply-To: <20240111043302.15641-1-rdunlap@infradead.org> (Randy Dunlap's
	message of "Wed, 10 Jan 2024 20:33:01 -0800")
References: <20240111043302.15641-1-rdunlap@infradead.org>
Sender: khalasa@piap.pl
Date: Mon, 22 Jan 2024 06:28:41 +0100
Message-ID: <m3y1ci543a.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist

Hi Randy,

Good catches, thanks for your work.

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix spelling mistakes as reported by codespell.

Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

> --- a/drivers/media/i2c/ar0521.c
> +++ b/drivers/media/i2c/ar0521.c
> @@ -314,7 +314,7 @@ static void ar0521_calc_pll(struct ar052
>          * In the clock tree:
>          * MIPI_CLK =3D PIXEL_CLOCK * bpp / 2 / 2
>          *
> -        * Generic pixel_rate to bus clock frequencey equation:
> +        * Generic pixel_rate to bus clock frequency equation:
>          * MIPI_CLK =3D V4L2_CID_PIXEL_RATE * bpp / lanes / 2
>          *
>          * From which we derive the PIXEL_CLOCK to use in the clock tree:
> @@ -327,7 +327,7 @@ static void ar0521_calc_pll(struct ar052
>          *
>          * TODO: in case we have less data lanes we have to reduce the de=
sired
>          * VCO not to exceed the limits specified by the datasheet and
> -        * consequentially reduce the obtained pixel clock.
> +        * consequently reduce the obtained pixel clock.
>          */
>         pixel_clock =3D AR0521_PIXEL_CLOCK_RATE * 2 / sensor->lane_count;
>         bpp =3D ar0521_code_to_bpp(sensor);
> @@ -806,7 +806,7 @@ static const struct initial_reg {
>         REGS(be(0x3F00),
>              be(0x0017),  /* 3F00: BM_T0 */
>              be(0x02DD),  /* 3F02: BM_T1 */
> -            /* 3F04: if Ana_gain less than 2, use noise_floor0, multipl =
*/
> +            /* 3F04: if Ana_gain less than 2, use noise_floor0, multiply=
 */
>              be(0x0020),
>              /* 3F06: if Ana_gain between 4 and 7, use noise_floor2 and */
>              be(0x0040),
>
>

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

