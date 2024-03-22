Return-Path: <linux-kernel+bounces-111060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97E886779
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843721F24AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97796125AB;
	Fri, 22 Mar 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1eE+UHY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B1101E3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092418; cv=none; b=foc+HY662N4zGmq4LYcuo+l8fFnZeD5luEUtph5nzXV44oJmw3He4tPHsmUJYAhSoIiMeDw3WQg9E+51boJKv4U/J2ctMkKAF0syIFTxMoETdGW6QEXAxIn+UuB+E5eSWAKAMrAh/ksxLHBR6IsSikIkBnQJWCArzSNU7hLMGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092418; c=relaxed/simple;
	bh=f1MZe03oX4WFNKsFlfCt/ESOoXp43Si1Hmggvi3r3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTb7jDGVPUXU6n1OPqyHOJ4EzUajbvWaZqcqgtsqzvJec03PV80/nkjQE6URIuiMWipkRpqnObM8d3X0KpIYK4ztWn/rrMAHYRvKAHmV9ePk4AszDfrICZIP/Umimm4bBS/8eqtIgP/c8ZSeX3ko8PV03nkZ8UKf5u871socCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1eE+UHY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FEE4240006;
	Fri, 22 Mar 2024 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711092408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQmTusbOmMSSaBgpQThp7ZrEL7/j9/5tVlOksabCb8Q=;
	b=L1eE+UHYcFgfKp4UM/EZy1mC62JIry3PzwRfcrdzi8oR5i6fprdcPe/L0xltrb6+jzRUL7
	j1tal/LT/rXn+AOAsubzJ5VBexbovqrD3vwqXeDReAPO0r4Vd1pYiUTHxybYduQeuqMaf0
	Ep34Tx8uCwYA4t+InzIZCYGP7S0w/qxLfdhlEpUFbryEajFnCIdm/nYZT1L+ohZjHwjVuj
	eEzmriTN3eIV7DbfgVDMwGa1OTUzYSk32MqvZEf6idF4F4WftzSEoyROjBx6qqpm6b0ibv
	quJXJk0WGynqzQvNjC8bHKZvTX692+XbjJaC1A7+I9PLYfkqZBnIM9KYM69vaw==
Date: Fri, 22 Mar 2024 08:26:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kobuk <m.kobuk@ispras.ru>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, Alexey
 Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH 2/2] phy: marvell: a3700-comphy: Fix hardcoded array
 size
Message-ID: <20240322082645.6c1d43b5@xps-13>
In-Reply-To: <20240321164734.49273-2-m.kobuk@ispras.ru>
References: <20240321164734.49273-1-m.kobuk@ispras.ru>
	<20240321164734.49273-2-m.kobuk@ispras.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mikhail,

m.kobuk@ispras.ru wrote on Thu, 21 Mar 2024 19:47:31 +0300:

> Replace hardcoded 'gbe_phy_init' array size by explicit one.
>=20
> Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native ke=
rnel implementation")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> ---
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/m=
arvell/phy-mvebu-a3700-comphy.c
> index 41162d7228c9..15bf10710de0 100644
> --- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> @@ -603,7 +603,7 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_co=
mphy_lane *lane,
>  	u16 val;
> =20
>  	fix_idx =3D 0;
> -	for (addr =3D 0; addr < 512; addr++) {
> +	for (addr =3D 0; addr < ARRAY_SIZE(gbe_phy_init); addr++) {
>  		/*
>  		 * All PHY register values are defined in full for 3.125Gbps
>  		 * SERDES speed. The values required for 1.25 Gbps are almost

512 is also used where gbe_phy_init is defined, so maybe it would be
worthe defining this size once and then use the definition in both
places.

Thanks, Miqu=C3=A8l

