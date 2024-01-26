Return-Path: <linux-kernel+bounces-40090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F8F83DA1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787F81C227D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04418EA8;
	Fri, 26 Jan 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8mD+afw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9D18B1B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271975; cv=none; b=SEDIxh+z56AADQ/hm4FDUELt1bOcHOelNkvvYssX7PuAb3nEjATjSGkQmNBwXrjyLEyzGd9I3xKbtus550ErxVqlOldYY8CKgnQOTKqN5jE6nkHb+R0Na80E1uLqzG2jrsLOv6SqxRpVFzv0ZFNRF/z7H5DfEzRq67osD9jbYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271975; c=relaxed/simple;
	bh=zILjTNi8K+qYGwusWH4yMUOSaDEkMO5YXXJnvLz1pr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYR4sWAE6es+WrXyf7K67nJkiP3bZAa4Qz/rReJS9GUiM7T5wuwksjFLBuE+q8tm06lMd2Ae565y8pc3fsG8nCqwtezOA4DxAYgQcl+pmXmrTytFFWvuIfLNG/6n+h03xOZwReZPW7J6TTwX97Vj7Q/EJVAcCNtU8JRs13bQZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8mD+afw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08268C433F1;
	Fri, 26 Jan 2024 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706271974;
	bh=zILjTNi8K+qYGwusWH4yMUOSaDEkMO5YXXJnvLz1pr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8mD+afwhPlrmu4OmOaYVqSF0jxr/aTomrLbnMhboSNjnyqKXcJuQwJSupF5i1DXT
	 XIfu8q/d8dbc2cE9II5CRWh/ZQRz9hggC767H36F6aouGDntUDeG10mnODj39TQOJR
	 3QtAh/HQPEQz5/1eANdMewMsyYVj3cMcxapHQQyzqPNrSFx/YgPJZSQedznrRYTUEb
	 /kViCzOHjNqa8e5isqAqfYdbGqbfUlfM0WTvxZyUmfMlZntN9GcYBm3Kq7P4lTNGSi
	 K+UO1O/AFd/EEkFDA5CM1hMJROoEHF4f204lKZPnmXYVSU+t8MebX3CsSUxz0uLpX/
	 /RrFCsgcq/yOQ==
Date: Fri, 26 Jan 2024 13:26:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	michal.simek@amd.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
Message-ID: <u5mngxudtdgy3vqkfbpgqng6tdahijnet2jtj345hrowbt47ce@t3e7hul45mr3>
References: <20240112234222.913138-1-anatoliy.klymenko@amd.com>
 <6jhwss2wego6yoo5mwmphwawhsj5bbj62gwrzcpapoixwkrkli@g4fbxdooopby>
 <20240117142343.GD17920@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lh6jggbrvte6mqp"
Content-Disposition: inline
In-Reply-To: <20240117142343.GD17920@pendragon.ideasonboard.com>


--5lh6jggbrvte6mqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 04:23:43PM +0200, Laurent Pinchart wrote:
> On Mon, Jan 15, 2024 at 09:28:39AM +0100, Maxime Ripard wrote:
> > On Fri, Jan 12, 2024 at 03:42:18PM -0800, Anatoliy Klymenko wrote:
> > > Patches 1/4,2/4,3/4 are minor fixes.
> > >=20
> > > DPSUB requires input live video format to be configured.
> > > Patch 4/4: The DP Subsystem requires the input live video format to be
> > > configured. In this patch we are assuming that the CRTC's bus format =
is fixed
> > > and comes from the device tree. This is a proposed solution, as there=
 are no api
> > > to query CRTC output bus format.
> > >=20
> > > Is this a good approach to go with?
> >=20
> > I guess you would need to expand a bit on what "live video input" is? Is
> > it some kind of mechanism to bypass memory and take your pixels straight
> > from a FIFO from another device, or something else?
>=20
> Yes and no.
>=20
> The DPSUB integrates DMA engines, a blending engine (two planes), and a
> DP encoder. The dpsub driver supports all of this, and creates a DRM
> device. The DP encoder hardware always takes its input data from the
> output of the blending engine.
>=20
> The blending engine can optionally take input data from a bus connected
> to the FPGA fabric, instead of taking it from the DPSUB internal DMA
> engines. When operating in that mode, the dpsub driver exposes the DP
> encoder as a bridge, and internally programs the blending engine to
> disable blending. Typically, the FPGA fabric will then contain a CRTC of
> some sort, with a driver that will acquire the DP encoder bridge as
> usually done.
>=20
> In this mode of operation, it is typical for the IP cores in FPGA fabric
> to be synthesized with a fixed format (as that saves resources), while
> the DPSUB supports multiple input formats.

Where is that CRTC driver? It's not clear to me why the format would
need to be in the device tree at all. Format negociation between the
CRTC and whatever comes next is already done in a number of drivers so
it would be useful to have that kind of API outside of the bridge
support.

> Bridge drivers in the upstream kernel work the other way around, with
> the bridge hardware supporting a limited set of formats, and the CRTC
> then being programmed with whatever the bridges chain needs. Here, the
> negotiation needs to go the other way around, as the CRTC is the
> limiting factor, not the bridge.

Sounds like there's something to rework in the API then?

Maxime

--5lh6jggbrvte6mqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbOk4wAKCRDj7w1vZxhR
xUHkAQCUlNiJ7Ynqb+0WDp6MdjbbBqiEISR9yTAhYDsOH7PrCwD/Qeh8kCS+fFoo
IjQNq7fGX5iQGxHN9Gtg2wwAZS2wOAU=
=YZlf
-----END PGP SIGNATURE-----

--5lh6jggbrvte6mqp--

