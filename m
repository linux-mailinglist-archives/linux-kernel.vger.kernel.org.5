Return-Path: <linux-kernel+bounces-117035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50D88A670
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C386CC6F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C06E617;
	Mon, 25 Mar 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOWraMsf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9286D1A1;
	Mon, 25 Mar 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370751; cv=none; b=uQA71A45mlnkFNRWwzFI/1MkaMht+gOlAkLDAkx2YJuM5Bfd636QoKUYq9gJL6JvmTKv13yHbyF+kbc/K47m9pjGuHsmoSbXTYH47hc49/pR2F9fWROEv8vbheZOTAnOxocw4cbPSaftWzRTlog8B1CiD9q1UkanEZImkjpKaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370751; c=relaxed/simple;
	bh=ZziF1wRZF7EhrN6ygPWhxE5dY6tJWM2rg/5wYnZVgck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt1v7k9RHtuz0Rc1n4piwagIBPkllwmb5+ydjrjL0b7Nfz4VoBtPXDCJziISpAczX06A63WOb0geZDIDuLJbME6T8zjQXNwUH+qUwgMz82a2m0STAA8Xa8R+kKM+5L8rvdLLrKq8lJAIwZRyAWsji94m2XHKq5cfdL0rBOpsUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOWraMsf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83341E000B;
	Mon, 25 Mar 2024 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711370746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZziF1wRZF7EhrN6ygPWhxE5dY6tJWM2rg/5wYnZVgck=;
	b=gOWraMsfaOyNY3BvmuvwWgpgqmuqW0qlq15nInyFvgo05o8t7OSVPL5gUyKNLnvPExr/L5
	MlA90aWdO7REc9rMhwPApqU03oBt7bMyuEa8Pg6QGvQPCbizl4Peuys4axsyd6Ve8b7f/j
	Uajthkay40AWaJDc8b1KUTKS++S4sQzC5AYSmSoTa52q8FuN4AXhgh9asuQK+KQg6S1fnV
	nRSqyHGF2SpiDVAHRSvedzrOO1adgmwG7zZttvB0OfOkdCxcRKVzIeL905Izs+fAcuuPmM
	Hfdcga0inTk+xSuAT/zJP5R+UHCRV4pikPz7PxIHdoUDLIqzILiam7ok3rVIdQ==
Date: Mon, 25 Mar 2024 13:45:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Elad Nachman <enachman@marvell.com>, Taras Chornyi
 <taras.chornyi@plvision.eu>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "dkirjanov@suse.de" <dkirjanov@suse.de>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Message-ID: <20240325134537.1cc7560e@kmaincent-XPS-13-7390>
In-Reply-To: <6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
	<4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
	<BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
	<89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
	<BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
	<6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sun, 24 Mar 2024 16:25:28 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > > > Originally, the pain point for Kory was the rmmod + insmod re-probi=
ng
> > > > failure, Which is only fixed by the first two commits, so I see lit=
tle
> > > > point in submitting 3-5 alone, Without fixing Kory's problem. =20
> > >=20
> > > I thought Kory's problem was actually EPROBE_DEFER? The resources nee=
ded
> > > for the PoE are not available, so probing the switch needs to happen =
again
> > > later, when PoE can get the resources it needs. =20
> >=20
> > No, the PoE is the general high level application where he noted the
> > problem. There is no PoE code nor special PoE resources in the Prestera
> > driver. =20
>=20
> So here is K=C3=B6ry email:
>=20
> https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7=
390/T/#mb898bb2a4bf07776d79f1a19b6a8420716ecb4a3
>=20
> I don't see why the prestera needs to be involved in PoE itself. It is
> just a MAC. PoE happens much lower down in the network stack. Same as
> Prestera uses phylink, it does not need to know about the PHYs or the
> SFP modules, phylink manages them, not prestera.

Prestera is indeed not directly involved in PoE. I wrote a hack to be able =
to
get the PoE ports control, for testing my PoE patch series.

The aim in the future will be to add RJ45 port abstraction.
The Prestera will get the port abstraction which will get the PoE ports con=
trol.
The prestera driver then might receive an EPROBE_DEFER from it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

