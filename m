Return-Path: <linux-kernel+bounces-134265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B189AFCD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD6B219DC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC0125DE;
	Sun,  7 Apr 2024 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cKvqVD4f"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAE107B3;
	Sun,  7 Apr 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479927; cv=none; b=LGPOnuTZvcsttPClF3qSfe9CHbX2+rS9mh8ZNaDznJ07/W4ZiaLiTOEkOs9aBXi9mj/pTMu/LQUWHatmzoEZQHFSlpdheoPsOLwXY4EBUHYUh+kyDelDRdqS1CIsCu+pOj0oj59Grtr0F52cxbqZrgZ9H1zGA2jnmfJ7jTJ61To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479927; c=relaxed/simple;
	bh=r7Qjy3TPkvWrgNpaqwL72EEpzX38+OfnnzqNs/akTiI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=MNOxBta7VAIsw7RxWWIaVxRyyfRkKoZJobsTACkPzld9Ho14KRjrXoCmT3MJ501xjQ4DEPRhs8kW3SElj9WEMJDDTIewAiQ2hNu1DM6sD7dF96mH6tHAHkV5eI/kV1s/pJjx6prAkPjxBxdUDa1mQGTtjClKbCr4qLa7u7857Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cKvqVD4f; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD23F667;
	Sun,  7 Apr 2024 10:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712479877;
	bh=r7Qjy3TPkvWrgNpaqwL72EEpzX38+OfnnzqNs/akTiI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cKvqVD4fP55q72BRHq73KArX6IoaIGtlakDzokDVlDNmdXEA/g0No7pvDzmnkBTXT
	 gII3jKfmZQlwvbwuy0uAS0Q89j6l2qiHdAfr2kRzrRSBhORCgiAZWLhNZjmpO+7RmH
	 ZRbt2rl1oera26jQbpR2dpxI5fx6gMnHl9Y9Gsjg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <803b0bd3-e615-41c1-888e-69b6ecca0b8a@luigi311.com>
References: <20240403150355.189229-1-git@luigi311.com> <20240403150355.189229-10-git@luigi311.com> <Zg2jvUDFnY83drlg@duo.ucw.cz> <803b0bd3-e615-41c1-888e-69b6ecca0b8a@luigi311.com>
Subject: Re: [PATCH v3 09/25] media: i2c: imx258: Add support for running on 2 CSI data lanes
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
To: Luis Garcia <git@luigi311.com>, Pavel Machek <pavel@ucw.cz>
Date: Sun, 07 Apr 2024 09:51:54 +0100
Message-ID: <171247991454.2374960.14379287208228554950@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Luis Garcia (2024-04-06 06:25:41)
> On 4/3/24 12:45, Pavel Machek wrote:
> > Hi!
> >=20
> >> +/*
> >> + * 4208x3120 @ 30 fps needs 1267Mbps/lane, 4 lanes.
> >> + * To avoid further computation of clock settings, adopt the same per
> >> + * lane data rate when using 2 lanes, thus allowing a maximum of 15fp=
s.
> >> + */
> >> +static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] =3D {
> >> +    { 0x0136, 0x13 },
> >> +    { 0x0137, 0x33 },
> >> +    { 0x0301, 0x0A },
> >> +    { 0x0303, 0x02 },
> >> +    { 0x0305, 0x03 },
> >> +    { 0x0306, 0x00 },
> >> +    { 0x0307, 0xC6 },
> >> +    { 0x0309, 0x0A },
> >> +    { 0x030B, 0x01 },
> >> +    { 0x030D, 0x02 },
> >> +    { 0x030E, 0x00 },
> >> +    { 0x030F, 0xD8 },
> >> +    { 0x0310, 0x00 },
> >> +
> >> +    { 0x0114, 0x01 },
> >> +    { 0x0820, 0x09 },
> >> +    { 0x0821, 0xa6 },
> >> +    { 0x0822, 0x66 },
> >> +    { 0x0823, 0x66 },
> >> +};
> >> +
> >> +static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] =3D {
> >>      { 0x0136, 0x13 },
> >>      { 0x0137, 0x33 },
> >>      { 0x0301, 0x05 },
> >=20
> > I wish we did not have to copy all the magic values like this.
> >=20
> > Best regards,
> >                                                               Pavel
> >                                                              =20
>=20
> no kidding, magic values everywhere.... it makes it annoying
> for me to move things around because they all start to look
> similar. Down the line we added in more defined names so its
> not as bad but still its bad lol.

This series converts the defines to names, which is great. It would have
been nicer if the series converted first, but I know the history here
means you have done the register naming on top of existing patches - so
I don't think there's a requirement to change the ordering now.

But I see new drivers coming in with register tables. I hope we can
start to apply more pressure to driver submitters to use higher quality
named register sets in the future, now that we have a greater precendent
of sensor drivers 'doing the right thing'.

Sets of tables like we have are basically a binary blob stored as ascii
and make maintainance far more difficult IMO.

Maybe I should hit send on my comments on the latest GalaxyCore driver
coming in that I hesitated on ...
--
Kieran

