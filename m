Return-Path: <linux-kernel+bounces-38783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8183C5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1C7293CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659DD74E25;
	Thu, 25 Jan 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EpvjCKwl"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED11D6EB60;
	Thu, 25 Jan 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194544; cv=none; b=TfHbjxJpzCMs1W4rnb/n9QJjsZIcM+dxCSYVf6nuH4n/dN5RLSJgM2u5RM94Yyr7EvQHN22yK3efh5hP7ziQIbhHQXEwT2i8ywy/u21yH/nbVBtuiCF/4rWiWd7q7EWZDkL43mLOSNE1HvH4vBKkAsTXFOGZEQoNro+DSE57UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194544; c=relaxed/simple;
	bh=JEbWPGJoVxXkCPlY2N2gRaepeDuuUIkTKLF49tTQ8bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhxmKCHqao9oEdaq2f3HCTswZaBHwZOo/XbScoKZsLnnVVDdNdH8nRYPZhHDvQ+gsXuypbJTnPnQR3dBIgKxVrW70x83xodBnOVBcZZVjqaakARFz8pkVx7JDk/JVTMsrxasmRJUUyXnd9MbTAFOciOFL8rVeifbB/9LXOQZH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EpvjCKwl; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B7C81C0005;
	Thu, 25 Jan 2024 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706194534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOXw2F4HOX1jsfGrMOQ0fTfoQB2N+gMMyWWg0nyWkCQ=;
	b=EpvjCKwl7Q8SwvFI8zqihspTA1z2XjgIEciir2R84jedLntJeaIpPrAtGz/Qr274VvwOod
	2hl4aMaOEpCVsNDuXE+xLf3FxiZyrWMZ18QR87NYWQSz8+OBjqg1BJ7vDA4es8EMu5CXXN
	WiukllJA6xWqE/MV9Td1Zg7jYkRDc6iPjLtQ7c+7K6x1esNzmgS1zpTuN7LfG/jWRcqNl+
	y16ujo1TA+dxaSrFhodt39POku+0thavXYL6jAd91LzY2k+xHOX/E+f9r1rn5kBgC72BMA
	QOugQRVz26gFWhGiGPVyeBn7a1VqGAjHLndluNhFI3S5c+0rGPVGS1pLA44tGw==
Date: Thu, 25 Jan 2024 15:55:32 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
 edumazet@google.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, weiwan@google.com, "open list:IEEE 802.15.4 SUBSYSTEM"
 <linux-wpan@vger.kernel.org>, "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 02/22] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <20240125155532.285a2bbd@xps-13>
In-Reply-To: <ZbIxYnEbFXi6NBMU@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
	<20240122184543.2501493-3-leitao@debian.org>
	<20240124175158.7c8b9490@xps-13>
	<ZbIxYnEbFXi6NBMU@gmail.com>
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

leitao@debian.org wrote on Thu, 25 Jan 2024 02:01:06 -0800:

> Hello Miqu=C3=A8l,
>=20
> On Wed, Jan 24, 2024 at 05:51:58PM +0100, Miquel Raynal wrote:
> > Hi Breno,
> >=20
> > leitao@debian.org wrote on Mon, 22 Jan 2024 10:45:23 -0800:
> >  =20
> > > W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION=
().
> > > Add descriptions to ieee802154 modules.
> > >=20
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org> =20
> >=20
> > I just see the v2 now. Please use "v2" in your commit title using -v or
> > git-format-patch. =20
>=20
> Sorry, I am not sure I followed what you meant.  I've sent the v2, which
> contains the 'v2' _tag_:

I believe *this* is a v2 because you fixed your initial patch,
following Stefan's suggestion.

Anyway, it's fine for me to merge this patch through net directly (I
don't know if net maintainers want W=3D1 fixes to go through net or
net-next) so:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

