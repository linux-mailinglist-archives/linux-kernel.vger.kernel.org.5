Return-Path: <linux-kernel+bounces-166812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FFC8B9FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032191F21980
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09517107D;
	Thu,  2 May 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="jNoG++9d"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA516FF3E;
	Thu,  2 May 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672517; cv=none; b=s7ZvXE0mHqd01ldbEUrrYmczPpGOd2Obzh8NwnZobDN2r+oZ26LFWjE4e7zNNu/CUlGrSrKWErFPF7OIR0B2OucpoS7/nak7/jPCiOI8EyRHUFPX+Kzp3YPYPzIVquUU27MNpxby0Ezizc7pOBW1VloFAWCqNDrVIKfRDr9u8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672517; c=relaxed/simple;
	bh=1K0zpzWDx1VlMkjHNnUR/ux0fBt30bFy2746dQItwgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=hPk4ZxgrHbpZ4pHg0I9e0/iTFcCm6ojEToRSLOyRIERpldn8vVMOcgetd5It5hRhb+qNzzjRRsExc9ed7XxG2H9ETDoSLPKX5baxaQgm47uhVl4sb0w4XBpAIxSiGnDC6SXRJ8rX9r+kpusEEM4NjtePXbV2VuowSE2lsqrfLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=jNoG++9d; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Subject:To:
	From:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w4dn0Vter3zHEUtQucKoOeeLCpedNcU/NdXL21U7MNo=; b=jNoG++9dzY4xuhbzAtcgaalFfB
	gZWO6rFfvTu1BatteR2jPfb2FFBZq0kF5ITz+2z268bM+ZJesCbXSSjjfya76fJBH9oitqGLBF37o
	6V/0vuFwIQ1imwDBvV8gXDvzz5p9ad30Zsudo4bJwbbLRYJHLKV2kcvY4+LvikGTqq7Smhq3mqhr8
	6YflnjEBeyTjXP/sOXCwTRB1aFjUC4IowiU22mwehF772r05zrlqzpyKwvek/isFv7KfILhvnjSCO
	cGoE8vmxuwJWd3EwECV03xqic6iE635hi1orv0ijhX7bSzIh80jEHxZ2xrmhd7Ozkfvtq6HIpebNO
	x1o6SiDA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1s2ae6-000PKw-9Z; Thu, 02 May 2024 19:55:02 +0200
Received: from [185.213.155.203] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1s2ae5-00G3Lu-2G;
	Thu, 02 May 2024 19:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 May 2024 17:55:01 +0000
Message-Id: <D0ZCO8KL5AQF.21Q70S27P7F5Z@folker-schwesinger.de>
Cc: "Chukun Pan" <amadeus@jmu.edu.cn>, "Heiko Stuebner" <heiko@sntech.de>,
 "Conor Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: "Dragan Simic" <dsimic@manjaro.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
X-Mailer: aerc 0.17.0-122-g7b4c8f67eb5f
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
 <20240428123618.72170-3-amadeus@jmu.edu.cn>
 <D0X7UJELGST3.2IL1AFDJ89N07@folker-schwesinger.de>
 <ded928414323ef4be51f2575d00ba7d1@manjaro.org>
 <832d6c37-a6c5-4468-9a23-1637b2affb90@kwiboo.se>
 <afa32c669ded2d37a4c11a54f1fc05b0@manjaro.org>
In-Reply-To: <afa32c669ded2d37a4c11a54f1fc05b0@manjaro.org>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27263/Thu May  2 10:23:13 2024)

Hi Jonas and Dragan,

On Thu May 2, 2024 at 3:48 PM CEST, Dragan Simic wrote:
> >>>> [...]
> >>>> +&sdhci {
> >>>> +	bus-width =3D <8>;
> >>>> +	max-frequency =3D <200000000>;
> >>>> +	mmc-hs200-1_8v;
> >>>=20
> >>> Out of curiosity, does this board also support HS400? From a very=20
> >>> brief
> >>> look this board seems quite similar to Rock 4 series boards, that do
> >>> support HS400.
> >>=20
> >> In a word, no, unfortunately.  In more detail, the Rockchip RK3566
> >> and RK3568 SoCs support the eMMC modes up to and including HS200, but
> >> not the HS400 mode.
> >=20
> > The datasheet for RK3568 only mention HS200 mode, however, HS400 mode=
=20
> > is
> > working in U-Boot after adjusting tap number for transmit clock [1].
> > Linux may need similar adjustment to make HS400 mode work on RK3568.
> >=20
> > RK3566 that this board use only support HS200, as specified in=20
> > datasheet.
>
> Oh, that's very interesting, thanks for pointing it out!
>
> What makes me a bit worried about enabling the undocumented HS400 mode
> on the RK3568 is that neither the RK3568 Hardware Design Guide (HDG),
> version 1.2, [2] mentions HS400 support.  I mean, the RK3568 datasheet
> may be wrong about not mentioning HS400, but what are the chances for
> the RK3568 HDG to also be wrong there?
>
> In other words, maybe there are some hard-to-trigger hardware issues
> in the RK3568 that made the HS400 mode, although actually present in
> hardware, officially unsupported for the RK3568?  Maybe there's even
> some non-public errata from Rockchip, who knows.
>
> [1]=20
> https://source.denx.de/u-boot/u-boot/-/commit/5c053f3adc69eaf83645b5d44c6=
adbb2d49a3fa7
> [2] https://dl.xkwy2018.com/downloads/RK3568/RK356X/Hardware/

Interesting indeed! Thanks to both of you for the info and for providing
links to the U-Boot commit and design guide. Much appreciated!

