Return-Path: <linux-kernel+bounces-37355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA183AEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F943285166
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE87E57F;
	Wed, 24 Jan 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZP+vhr00"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EE77638;
	Wed, 24 Jan 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114889; cv=none; b=aD/jhEFbdsKDTiGkJ64YD/S17lCq56fDvFgMA7EVLdWCNTu9A1BzatDEjBsV9O2lB4r0X7WnZOaeVqUmEYJayovkG8Drknnt4fObrx4hyIlMu06dG1Sg+l0JpaaNed9NlkU8uW26XbiVpIs2eykVSenVKfEMNp6HgDAi3ybP6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114889; c=relaxed/simple;
	bh=S7DJ3+JCBTXNJeT3R+rQ9rFrdxAQ0AW7yvX18psweRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUVchtMeWbz840I5O/FxxH5lXuIZAXGAB2BF6YYTkhn+ZQwYwZ+SmWBNyBhG+5ukidZRQFmsS52/lncD+m0BLW2kw7FI2zaGSePPIj3/gxkX0K+LTVFUL0xqNNJXCaWDWb/ZF2lJu4UeW/58dCpwBEHn8ASElL9UeeTHDHvkz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZP+vhr00; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 681F260006;
	Wed, 24 Jan 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706114884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hve7mVwzFpKlUFRjGUurQPnaxwP0/IowvX0am3el6Vc=;
	b=ZP+vhr00cn+7xRAMlu/e3C3oKegJdereg0UiMsYWIOFkp/kXdX7C0czffAtbcw0mCJvj9t
	4FXEo2tEHTcTX0O9CQshe8PJJu6j/DtBETUyDU1o3szcdZBVskVKrJ7CvCZKDPiKW03JUa
	PpJ7sJI0I4FuHwr53IMtFmqgd9zaZ2cq5KQjq63grYm4B2Wv3KZO94Q23IpGcoPqyo3dsv
	0XBizSKr+MDTD3LASFpdWYe1xEDep4L4ELywcImBWNXnLqc+MxbR/XFrXUjz8S6CCxeD7S
	DFhGCNOkUo7WgwV4YsrrYZd0n+MxTePiuUQsi8jn0necVuv6n8lHDwwo/G7sjw==
Date: Wed, 24 Jan 2024 17:48:02 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, Alexander Aring
 <alex.aring@gmail.com>, netdev@vger.kernel.org, "open list:IEEE 802.15.4
 SUBSYSTEM" <linux-wpan@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/10] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <20240124174802.0b5910a5@xps-13>
In-Reply-To: <45711bec-e0f3-43c2-b8f2-b9a55654710b@datenfreihafen.org>
References: <20240108181610.2697017-1-leitao@debian.org>
	<20240108181610.2697017-7-leitao@debian.org>
	<45711bec-e0f3-43c2-b8f2-b9a55654710b@datenfreihafen.org>
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

Hi,

stefan@datenfreihafen.org wrote on Tue, 9 Jan 2024 08:25:21 +0100:

> Hello.
>=20
> On 08.01.24 19:16, Breno Leitao wrote:
> > W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to ieee802154 modules.
> >=20
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   net/ieee802154/6lowpan/core.c | 1 +
> >   net/ieee802154/socket.c       | 1 +
> >   2 files changed, 2 insertions(+)
> >=20
> > diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/cor=
e.c
> > index 2c087b7f17c5..b88f6a96d961 100644
> > --- a/net/ieee802154/6lowpan/core.c
> > +++ b/net/ieee802154/6lowpan/core.c
> > @@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void) =20
> >   >   module_init(lowpan_init_module); =20
> >   module_exit(lowpan_cleanup_module);
> > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network=
 IEEE802154.4 core"); =20
>=20
> If we want to nitpick you could write it as IEEE 802.15.4.

Also agreed, can you please post an update?

Thanks,
Miqu=C3=A8l

