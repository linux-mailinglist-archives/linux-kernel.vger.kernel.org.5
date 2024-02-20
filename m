Return-Path: <linux-kernel+bounces-73336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D1E85C124
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1842831A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DEA79957;
	Tue, 20 Feb 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QIRKyTj8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDE76408;
	Tue, 20 Feb 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446040; cv=none; b=GomqaNvUapRm6vccni10ZzboKHZ2ABZXw33YY8bb2rbt2RFRLNtMjz6pDF44AMMiNKxSGsp5QYdp6LYSUSOTuoOK1JoXE7eaZQKDzrEvte8BGZbftPJKYCNoQkOTOpxb7FIirbpJWFNpfeHR6hW5GujHuZkzjnm5b5wARA0IelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446040; c=relaxed/simple;
	bh=8YQv7aLTPzzKaJ7jlQ5Sre4GQB/b020Pt6fSgtcM+TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGjOrXBGhdwMo5p4715CRlUoPoRVED6XpHlPnfAC2QYeVDaE6Q5G3KJ5kSJDEiqwfAYLKqm2nzdNJpFcUbaYxxQ4CwP9GVEiLhdZlvIT097MqBJWU74xuYAAhzg/qhMqxtwe9RZC3Rd5xmq+C7kgHnDEJTgrwAIM5xHITiIcGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QIRKyTj8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02E04240004;
	Tue, 20 Feb 2024 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708446035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXos02wI1NevLoKIn6UfDZ/DT2LVCxm0HsQrNIoS9qw=;
	b=QIRKyTj8c5fpAGiYJiASyDw9WoF4XtF3FZAOmveqKKYIkasIzidfU3JLHPT8/T0CCqli53
	s5q+RtSlnAko+igLmKgeVSTe1InW/gAuXXU6osKRWw1D7zjFLjZHBCsaYtt9+iiS2RFNkc
	XDKrd29uZEvN5CINymsS4Zn1pCw6dvf4VEEW4od3YFhqEvnJdoY62vYj9KMssIr2j5Q0VC
	NLn6VW/lc6vmI0E+Q3QLLYHwztna+ZFZZ5xVZu3W6WRINwqrbiZcyt94wPc9OIGpg/Qgqk
	JLLZ0DGExukFlycsPkRXfSLuH+CuGkTrEhhBx0F5FwkovvFw9jfH21NzYhyOUg==
Date: Tue, 20 Feb 2024 17:20:33 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY
 default timestamp to MAC
Message-ID: <20240220172033.556f321f@kmaincent-XPS-13-7390>
In-Reply-To: <ZdN9pPf3wXwE/9nX@shell.armlinux.org.uk>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
	<20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
	<87jzn4gtlv.fsf@nvidia.com>
	<20240219142936.62112d34@kmaincent-XPS-13-7390>
	<ZdN9pPf3wXwE/9nX@shell.armlinux.org.uk>
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

On Mon, 19 Feb 2024 16:11:16 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Feb 19, 2024 at 02:29:36PM +0100, K=C3=B6ry Maincent wrote:
> > On Fri, 16 Feb 2024 10:09:36 -0800
> > Rahul Rameshbabu <rrameshbabu@nvidia.com> wrote:
> >  =20
> > > On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent
> > > <kory.maincent@bootlin.com> wrote: =20
> > > > Change the API to select MAC default time stamping instead of the P=
HY.
> > > > Indeed the PHY is closer to the wire therefore theoretically it has=
 less
> > > > delay than the MAC timestamping but the reality is different. Due to
> > > > lower time stamping clock frequency, latency in the MDIO bus and no=
 PHC
> > > > hardware synchronization between different PHY, the PHY PTP is often
> > > > less precise than the MAC. The exception is for PHY designed specia=
lly
> > > > for PTP case but these devices are not very widespread. For not
> > > > breaking the compatibility default_timestamp flag has been introduc=
ed
> > > > in phy_device that is set by the phy driver to know we are using the
> > > > old API behavior.
> > > >
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---   =20
> > >=20
> > > Overall, I agree with the motivation and reasoning behind the patch. =
It
> > > takes dedicated effort to build a good phy timestamping mechanism, so
> > > this approach is good. I do have a question though. In this patch if =
we
> > > set the phy as the default timestamp mechanism, does that mean for ev=
en
> > > non-PTP applications, the phy will be used for timestamping when
> > > hardware timestamping is enabled? If so, I think this might need some
> > > thought because there are timing applications in general when a
> > > timestamp closest to the MAC layer would be best. =20
> >=20
> > This patch comes from a request from Russell due to incompatibility bet=
ween
> > MAC and PHY timestamping when both were supported.
> > https://lore.kernel.org/netdev/Y%2F4DZIDm1d74MuFJ@shell.armlinux.org.uk/
> >=20
> > His point was adding PTP support to a PHY driver would select timestamp
> > from it by default even if we had a better timestamp with the MAC which=
 is
> > often the case. This is an unwanted behavior.
> > https://lore.kernel.org/netdev/Y%2F6Cxf6EAAg22GOL@shell.armlinux.org.uk/
> >=20
> > In fact, with the new support of NDOs hwtstamp and the
> > dev_get/set_hwtstamp_phylib functions, alongside this series which make
> > timestamp selectable, changing the default timestamp may be not necessa=
ry
> > anymore.
> >=20
> > Russell any thought about it?  =20
>=20
> My position remains: in the case of Marvell PP2 network driver with a
> Marvell PHY, when we add PTP support for the Marvell PHYs (I have
> patches for it for years) then we must _not_ regress the existing
> setup where the PP2 timestamps are the default.

Yes, that's what I thought.
About the Marvell PHYs PTP support I have a few fixes on it, but we will
talk about it when this series gets merged.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

