Return-Path: <linux-kernel+bounces-92572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D46872261
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DAEB228B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60F127B4C;
	Tue,  5 Mar 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H25+wX40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68346126F02;
	Tue,  5 Mar 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651031; cv=none; b=gtJRKeVttmV1AvjmTnoT3tvG2HciSDoWw1CkRPMUdAJfTso/n0mFYXMXdJlUoSwoYybwMqq+eYh9YUpPPhc8NGQnxNJgVsG7bASugSBOjf+lbrHdzvOBLuHE7P8DEvXD5XDAj4Hps/k+9e37gOmwDmuL1eLlbT4Hm0idBFLVZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651031; c=relaxed/simple;
	bh=27+BJOW33H94LR/XIIVJMVaAXUoxZygcA3qpLGvJF24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNezikr7XiXXBy7cNonHVjFJjQBiJEJ0p9SJbl4XFXOQAkQQkEpvXLBab/UiMk6sg9Udp8h3s88P+2+7CAXdcTzPdj8QWWaFL2CDX6ZB2JZs5Yim1gu6heolqzL76uHxD/1lwBwKuouFaceQLB7ztQpzgGd4G6bBskcbHoGQDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H25+wX40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F54C43394;
	Tue,  5 Mar 2024 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709651031;
	bh=27+BJOW33H94LR/XIIVJMVaAXUoxZygcA3qpLGvJF24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H25+wX40QDVf7LQENEsoE+hzv6k+KxHFIJFJqewncfk3zIRbstB3rhpHi0ETdlw82
	 VEdCuqG0OxjAK6RRCJJ3dkpfXpR2Y4r0s7+eDhee5mPTBhdAhMXhhobllARcOFzmK6
	 1x4fjSBhTzY1OUUMu1jrrKWDm6yRWRd80z4mYzaSdsI+v0W63WpHbOcnBXPc6SbqFL
	 mWchheN01FGp1BksphhLEZ3QRJPR+WULQHOUUcHXRTFPauqoKMbLS8DOsPwbkkfj/U
	 KaRvyVlU+xGBOSlKIkEfmGJqSINj/MUjgm3tvYiSGJ2bw+bZ/E8eyKgvqZCGwU5Xxx
	 CYn643lXYGh+g==
Date: Tue, 5 Mar 2024 07:03:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20240305070349.5d1a8ff0@kernel.org>
In-Reply-To: <20240305100259.006b3137@kmaincent-XPS-13-7390>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-7-455611549f21@bootlin.com>
	<20240304184737.30cac57b@kernel.org>
	<20240305100259.006b3137@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 10:02:59 +0100 K=C3=B6ry Maincent wrote:
> On Mon, 4 Mar 2024 18:47:37 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > On Mon, 26 Feb 2024 14:39:58 +0100 Kory Maincent wrote: =20
> > > +static DEFINE_XARRAY_FLAGS(ptp_clocks_map, XA_FLAGS_LOCK_IRQ |
> > > XA_FLAGS_ALLOC);   =20
> >=20
> > Why _IRQ? anything on the fastpath hopefully has a pointer to the clock
> > already, I'd hope. And we often reserve ID 0 as invalid. =20
>=20
> To keep the same flag as IDA_INIT_FLAGS, I am not expert in xarray so I j=
ust
> keep it without questioning it. Do you think I should remove it?

Yes, I believe those defaults are just "to be safe".

> ID 0 was valid for phc. IMHO makes it invalid is not a good idea, it
> will change the phc id value for current board on the field.

Ah, right, let's keep it then. We'll have to use -1 as invalid.

> > BTW could be a standalone patch, Xarray conversion from IDA is an
> > improvement in itself. =20
>=20
> Indeed. Do you prefer this patch to be standalone?

May be a personal preference but I do feel like sending general
improvements separately from large new features makes the process=20
more smooth.

