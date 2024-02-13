Return-Path: <linux-kernel+bounces-63692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FA853353
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDAC28B469
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501143AC7;
	Tue, 13 Feb 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs3vEq5j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942971DFEF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835111; cv=none; b=fWQvMvhSpIKWYXpTwEQOvpMLt+1PkpP9YHLeBCEo+siKc4YbfgIR92dwADb4sP5wCjnI+PUzsUmj0BtTUZ0MZGlgqKOG1DEU6tUPq8oHWq2mEBstJCpoXleaUB2PUAalLi/kLRMKzHFEdQ6Af3E1CswlzSHYnEuqd99scj65aWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835111; c=relaxed/simple;
	bh=HkvguROhQZsd+G1Vad6pse4NfKaAKlAN9DMRfmWV42w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA7CKj2mF1AD0Pml4CTwVrQC8DrVJDYC9XD7o4Uzv+LOgCQ1mNG45FnMTsPQzW59Nu2adyvfCes7gMkrI83FTK465fw8DtqTzDcaNJCswrGy+gCsUDxPx16z8tMKam033u401Blirc54GBpOiBs2vMrc8OKh+VU1fNBgths1dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs3vEq5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BCAC433C7;
	Tue, 13 Feb 2024 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835111;
	bh=HkvguROhQZsd+G1Vad6pse4NfKaAKlAN9DMRfmWV42w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rs3vEq5jaJJUcVta1XAt000rxNei7Z7El1SeVa5+xmwhCA1cWIIN+joeuftQEvAJw
	 FffjqghKAIeCdxQz5+B0PJJ1hm0k+IKNiv5S64Ic9CyYCOABmvqOgPAFSecWUdeGSV
	 5myfozbdyaEAlyGfkYU7PJLO5wmgBMgG/FURmPJBtsmih7oPOkEvkgnRhPfF7f7x9l
	 jJufEe/i9jdDfOU/luwOE34KBDE5M+9y/NM6kVRNmDrc08eYbvXhNPjusFGdc0BCMY
	 V9+KyYoEao1XB1ip7BjRgMFYQmwn+hT8aO8cw+qVQuQvkRWqiGE0ZBkzsjSo3GULvY
	 9pXC5nuCpPoig==
Date: Tue, 13 Feb 2024 15:38:28 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
	Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, 
	David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante
 GPU cores attached via PCI(e)
Message-ID: <7ejh5uoppa257ap64ps33wrtabn4iu6flf4fn5lqhuuhbtmpjj@25rqv7mnko5q>
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
 <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
 <jahydq72bqb27de2ijwwmdjh4ri326mxhfjn5pbvf7cqcpnauq@rw5hjdiroi5d>
 <ZcYGWEG8eqAiqqai@phenom.ffwll.local>
 <65qv24hhkmmy4haylh53muvz2xliejysc3uywq44pl3xx7rus4@ynyau4djposv>
 <67936300-7bfb-4f5e-9b80-ee339313fd61@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nw547t3zpoboj52w"
Content-Disposition: inline
In-Reply-To: <67936300-7bfb-4f5e-9b80-ee339313fd61@linux.dev>


--nw547t3zpoboj52w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:25:33AM +0800, Sui Jingfeng wrote:
> On 2024/2/9 23:15, Maxime Ripard wrote:
> > On Fri, Feb 09, 2024 at 12:02:48PM +0100, Daniel Vetter wrote:
> > > On Thu, Feb 08, 2024 at 04:27:02PM +0100, Maxime Ripard wrote:
> > > > On Wed, Feb 07, 2024 at 10:35:49AM +0100, Daniel Vetter wrote:
> > > > > On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
> > > > > > The component helper functions are the glue, which is used to b=
ind multiple
> > > > > > GPU cores to a virtual master platform device. Which is fine an=
d works well
> > > > > > for the SoCs who contains multiple GPU cores.
> > > > > >=20
> > > > > > The problem is that usperspace programs (such as X server and M=
esa) will
> > > > > > search the PCIe device to use if it is exist. In other words, u=
sperspace
> > > > > > programs open the PCIe device with higher priority. Creating a =
virtual
> > > > > > master platform device for PCI(e) GPUs is unnecessary, as the P=
CI device
> > > > > > has been created by the time drm/etnaviv is loaded.
> > > > > >=20
> > > > > > we create virtual platform devices as a representation for the =
vivante GPU
> > > > > > ip core. As all of subcomponent are attached via the PCIe maste=
r device,
> > > > > > we reflect this hardware layout by binding all of the virtual c=
hild to the
> > > > > > the real master.
> > > > > >=20
> > > > > > Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> > > > > Uh so my understanding is that drivers really shouldn't create pl=
atform
> > > > > devices of their own. For this case here I think the aux-bus fram=
ework is
> > > > > the right thing to use. Alternatively would be some infrastructur=
e where
> > > > > you feed a DT tree to driver core or pci subsystem and it instant=
iates it
> > > > > all for you correctly, and especially with hotunplug all done rig=
ht since
> > > > > this is pci now, not actually part of the soc that cannot be hotu=
nplugged.
> > > > I don't think we need intermediate platform devices at all. We just=
 need
> > > > to register our GPU against the PCI device and that's it. We don't =
need
> > > > a platform device, we don't need the component framework.
> > > Afaik that's what this series does. The component stuff is for the
> > > internal structure of the gpu ip, so that the same modular approach t=
hat
> > > works for arm-soc also works for pci chips.
> > But there should be a single PCI device, while we have multiple "DT"
> > devices, right? Or is there several PCI devices too on that PCI card?
>=20
>=20
> There is only a single PCI(e) device on that PCI(e) card, this single
> PCI(e) device is selected as the component master. All other Hardware IP
> blocks are shipped by the single PCI(e) master. It may includes Display
> controllers, GPUs, video decoders, HDMI display bridges hardware unit etc.
>=20
> But all of those Hardware IP share the same MMIO registers PCI BAR, this
> PCI BAR is a kind of PCI(e) MEM resource. It is a relative *big* chunk,
> as large as 32MB in address ranges for the JingJia Macro dGPU. Therefore,
> I break the whole registers memory(MMIO) resource into smaller pieces by
> creating platform device manually, manually created platform device is
> called as virtual child in this series.
>=20
> In short, we cut the whole into smaller piece, each smaller piece is a
> single hardware IP block, thus deserve a single device driver. We will
> have multiple platform devices if the dGPU contains multiple hardware
> IP block. On the driver side, we bind all of the scattered driver module
> with component.

That's kind of my point then. If there's a single device, there's no
need to create intermediate devices and use the component framework to
tie them all together. You can have a simpler approach where you create
a function that takes the memory area it operates on (and whatever
additional resource it needs: interrupt, clocks, etc.) and call that
directly from the PCIe device probe, and the MMIO device bind.

Maxime

--nw547t3zpoboj52w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZct+4wAKCRDj7w1vZxhR
xat4AP9e1PY52OcgTMPszeofC8fTKw5ic9bt51A2Zmj8FSz2NQEAv4IkzKOx/Ccz
KQP5HLb6qdwAWA0qWoszs8ZWUtAdAA0=
=WIP3
-----END PGP SIGNATURE-----

--nw547t3zpoboj52w--

