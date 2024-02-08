Return-Path: <linux-kernel+bounces-58283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1784E408
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5372A1C2224B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBF7B3FB;
	Thu,  8 Feb 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpSojsJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21779940
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406026; cv=none; b=tgiJtrny+4fkRxtnVCdrnTogh2+bwlyMMKSqs6X0rurvPuFnuq+QkGBPctckJlUq0CdQlxuJgRUCj4Utm7nDOJUNMX3T8haWnudyriTXpY+8RClTE8kW6Ti2gIXOZHEaJcm9JZa6TS6otgJpajWb/N/L9mtcABB9Y7+ktrAJo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406026; c=relaxed/simple;
	bh=GBu1L6Qu6+/4Qs9Yi/qh0tgbEXDDN4laJMxWZ9C7Tuw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr9V/n4ni0ueKJFb3TjJqI7CQ3/2kki9HS9ox1PsvWuZsKTyiv7sb9b7P33Zn0n06DyYqiiutPC/eou2Utu0sOLfu6P+abZ/sTRp/1ebZyx11/H00SynYJ7uiohfWlnmbQk337mIRyTvCkRTqklyVwU8DTPgOt/KjI7nlqwNCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpSojsJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D658C433F1;
	Thu,  8 Feb 2024 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707406025;
	bh=GBu1L6Qu6+/4Qs9Yi/qh0tgbEXDDN4laJMxWZ9C7Tuw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=DpSojsJnuqSoDLLtz5HK1cI35wvGFwc6kia7Ruvlv52ZvyBZehSLKVCtSTZJvhXL/
	 4rKpJHKIbdhORWx/69Qu0qHD/berxtS3XM2MS9LF6ZJoXYf1Psso1rw0+2g5i8EpUX
	 z06HMKBh7H8wAuj/+uUSWhxjs7cCZCHehJQCtet5B6MD+Fr6zLA4uhOExt0AigpBXR
	 pZ+Sd3adi3ClHhGQdlq1SIYQTgHN0GbHsn1qYSfZipi2tOkTRgv69KEe31+LYbYtjq
	 cxcG8pt97G/bGraJxVWAnkbvHcoPTakriO+3QhMhkcdmpwZQSJjqztUqfZo2KcyrRP
	 qmVIWuJzu2naw==
Date: Thu, 8 Feb 2024 16:27:02 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante
 GPU cores attached via PCI(e)
Message-ID: <jahydq72bqb27de2ijwwmdjh4ri326mxhfjn5pbvf7cqcpnauq@rw5hjdiroi5d>
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
 <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwkb76o32yktfxzj"
Content-Disposition: inline
In-Reply-To: <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>


--hwkb76o32yktfxzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 10:35:49AM +0100, Daniel Vetter wrote:
> On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
> > The component helper functions are the glue, which is used to bind mult=
iple
> > GPU cores to a virtual master platform device. Which is fine and works =
well
> > for the SoCs who contains multiple GPU cores.
> >=20
> > The problem is that usperspace programs (such as X server and Mesa) will
> > search the PCIe device to use if it is exist. In other words, usperspace
> > programs open the PCIe device with higher priority. Creating a virtual
> > master platform device for PCI(e) GPUs is unnecessary, as the PCI device
> > has been created by the time drm/etnaviv is loaded.
> >=20
> > we create virtual platform devices as a representation for the vivante =
GPU
> > ip core. As all of subcomponent are attached via the PCIe master device,
> > we reflect this hardware layout by binding all of the virtual child to =
the
> > the real master.
> >=20
> > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>=20
> Uh so my understanding is that drivers really shouldn't create platform
> devices of their own. For this case here I think the aux-bus framework is
> the right thing to use. Alternatively would be some infrastructure where
> you feed a DT tree to driver core or pci subsystem and it instantiates it
> all for you correctly, and especially with hotunplug all done right since
> this is pci now, not actually part of the soc that cannot be hotunplugged.

I don't think we need intermediate platform devices at all. We just need
to register our GPU against the PCI device and that's it. We don't need
a platform device, we don't need the component framework.

> I think I've seen some other pci devices from arm soc designs that would
> benefit from this too, so lifting this logic into a pci function would
> make sense imo.

Nouveau supports both iirc.

Maxime

--hwkb76o32yktfxzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcTyxgAKCRDj7w1vZxhR
xU/nAP9mow5guLkslcBCvuv6TFgr11GyScivYWuSXZHgYNZLnQD/eAOxy+J5YgcC
XBGxRyLQK9yYcpBQobofgQYNz6vOkgg=
=GQu8
-----END PGP SIGNATURE-----

--hwkb76o32yktfxzj--

