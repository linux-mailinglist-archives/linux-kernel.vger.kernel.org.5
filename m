Return-Path: <linux-kernel+bounces-91951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FD8718E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3F01F239D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8154904;
	Tue,  5 Mar 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J0+RPNQo"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161750279;
	Tue,  5 Mar 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629392; cv=none; b=ptrM1pYrMYgT/iJIx5pWZrjUYBCQ956TSYAezL3APU1XH9EfZBAu3Gig0hgl2kbB+qTH+JTWZpM1fAFo/OVr3e8mQHW6SN+4L1MP8m9TdA5GKtyOq7NHNHdmNruRZWSO2jyw+j10xXbd5mAjzWx8CEvuyKezP6EkGDkezETzSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629392; c=relaxed/simple;
	bh=cNdEM8vfnnYOXnE1/pcVWlwHUFEK9a4YCyqrTtuWxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prQPrgRAM6dtmQDGEpaKb4NpnV1h1YBL5UU/ehX8uPTNsaR7rVCpaSDG0Mc1v/wVKtH72XzpQvcDoGjuJ8sAkRm0M0KizvPdC3Mr6HxGJTZbN8AFS1InQj0pifVZZcTSinDsF5gI0NjPDdbGj6f+4lgRtiSTMH1PWCIb6sqJU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J0+RPNQo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBBA41C0007;
	Tue,  5 Mar 2024 09:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709629381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNdEM8vfnnYOXnE1/pcVWlwHUFEK9a4YCyqrTtuWxqY=;
	b=J0+RPNQo0kcjTB3ttmpSW3fsCHfG2oBuLSV5YRYq7/iuchbARjyDkg63NdsGyVWILyMgkz
	/+xZmZBTTg2nh0ZujNTW6e6BO/JgjmlHuV3VLvCXXvEAz8cw2dFfIauAntKOcVjP9KoYLs
	W0IW5GwI73PadZElK0Gf5vVByQDUkAPA21sAkLCTHJJiZwe8VV0PDfS9NH8khrj7vrFFDq
	5bXy1HOqq4lTJDy77JYDC+PgLLwqsalcFOEfxvqzB5S/x4q2q0o5RT2hM4IwJ0cPS6MYDN
	krtZs2LQv3orKmyCJbzTxoTWTFil86eFX0R67KuVnMnrgIqMiZpH4r6C3K1wUA==
Date: Tue, 5 Mar 2024 10:02:59 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 07/13] ptp: Move from simple ida to xarray
Message-ID: <20240305100259.006b3137@kmaincent-XPS-13-7390>
In-Reply-To: <20240304184737.30cac57b@kernel.org>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-7-455611549f21@bootlin.com>
	<20240304184737.30cac57b@kernel.org>
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

On Mon, 4 Mar 2024 18:47:37 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 26 Feb 2024 14:39:58 +0100 Kory Maincent wrote:
> > +static DEFINE_XARRAY_FLAGS(ptp_clocks_map, XA_FLAGS_LOCK_IRQ |
> > XA_FLAGS_ALLOC); =20
>=20
> Why _IRQ? anything on the fastpath hopefully has a pointer to the clock
> already, I'd hope. And we often reserve ID 0 as invalid.

To keep the same flag as IDA_INIT_FLAGS, I am not expert in xarray so I just
keep it without questioning it. Do you think I should remove it?

ID 0 was valid for phc. IMHO makes it invalid is not a good idea, it
will change the phc id value for current board on the field.

>=20
> BTW could be a standalone patch, Xarray conversion from IDA is an
> improvement in itself.

Indeed. Do you prefer this patch to be standalone?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

