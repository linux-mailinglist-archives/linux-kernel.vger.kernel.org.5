Return-Path: <linux-kernel+bounces-71144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CE85A148
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF182826AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADD528DD5;
	Mon, 19 Feb 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ChvL16FM"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3F225D6;
	Mon, 19 Feb 2024 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339664; cv=none; b=GX712Bsbm4tQ7sBpeGVjTR6aBDBxOdYle9yVME+1Cfqb8NDQTell5OquzCzzMdkUPnC7Vv+7GcQdFuZ03DDM0F6S+pBUgRdjmPu4+oniKahrVNzAPC9FHcamiXRL6uCKObO5CH7o1KJoEqRsQwyo3aoWQWR2furySSpbetll9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339664; c=relaxed/simple;
	bh=IjD3KjlInPdC9j3gqlAjiWwXuf8HhsRsxG2eOie2kZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+cm/igvze+usi60LfFrCz16CRBLZ23FTN/s2NOnkD3K71961Lh5SAG7Sghq5n+Pi3IYTVGRvfj1FHq0gKuh7eqFaflPUwMc22+IkSxlqEpAPkAOTx/qTPIp4rovmKAlx2GflgfFLi8DdyPbJkdC/7AWECT0DNRVMvfhD3BXQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ChvL16FM; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B0D1C000F;
	Mon, 19 Feb 2024 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708339660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/8X8MqPF3pfDiFGXEDHHnwpDDYSllQCPO/MEgL1lXU=;
	b=ChvL16FM29AidITMPbL97+0a2Snuu4mSkwT2AR92JDYr+LEynE1KRbqFNsVuCey8MD+Nyq
	cQWGHhEfoF75UIQRIxWGaFrDAXCZVmK3oA4icyF2NNnUhNtQcrU+34ojHLrz/hjt6NOBSE
	RFRsiWbt1KZPUrb5xZpz02cdlrVgWlamHTXGF39P0vhxv+KzAY6IorbEIClBDSomIh52zX
	zcCtV4hqAS6CkXtiFoLOir8nu1LNYA/VDJ/n98UJALAaTyxzHMjfoC+9iRudkCHkjEgUAP
	u2CYcIWqJg6+/pgAz2wsYWMjG9oKRtZh9ieSdo58WNv1/DTf8uRSjgVoGuSeSg==
Date: Mon, 19 Feb 2024 11:47:37 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, linux-wpan@vger.kernel.org
 (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: Re: [PATCH net v2 2/7] net: fill in MODULE_DESCRIPTION()s for
 ieee802154/fakelb
Message-ID: <20240219114737.79eb9ff6@xps-13>
In-Reply-To: <20240214152741.670178-3-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
	<20240214152741.670178-3-leitao@debian.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Breno,

leitao@debian.org wrote on Wed, 14 Feb 2024 07:27:36 -0800:

> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the IEEE 802.15.4 loopback driver.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/ieee802154/fakelb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fak=
elb.c
> index 35e55f198e05..2930141d7dd2 100644
> --- a/drivers/net/ieee802154/fakelb.c
> +++ b/drivers/net/ieee802154/fakelb.c
> @@ -259,4 +259,5 @@ static __exit void fake_remove_module(void)
> =20
>  module_init(fakelb_init_module);
>  module_exit(fake_remove_module);
> +MODULE_DESCRIPTION("IEEE 802.15.4 loopback driver");
>  MODULE_LICENSE("GPL");


Thanks,
Miqu=C3=A8l

