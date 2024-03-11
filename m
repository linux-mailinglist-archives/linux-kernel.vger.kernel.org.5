Return-Path: <linux-kernel+bounces-98805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1D6877FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8DCB22301
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2F3CF79;
	Mon, 11 Mar 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dloQrcOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7793BBCC;
	Mon, 11 Mar 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159027; cv=none; b=lnksPT3VkwrTqh/h7AWuik7lUSFTWJtwwST2k/ArSR7b2rZoagGgJ/tnwlZwl/85w8T4ga/iPZ7PhGDoQiMhrb59+zzJfMtTbWfo2ecI8Su17uusMuV0CKLMb/5tCjgZzEhu4yqLeUO4+rSv+ifd3MU3x0YseDd3CPldm4pvEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159027; c=relaxed/simple;
	bh=9qWXx17ikIntTOyse8M12B0v0qduGm1iZ4PJfXmIpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb5oxme09c4blzuI/XfiXBV7NLdQCb4hSGLV0CSWqYuwFppuDKSPBUaceBddp1FL12iz07oyY2SCXJq3LYNTpN4DBPS6VafL2CEUOoyVGT4sOeHV+embMy7M4kLbe/a7pMSgpIa/1iWcxJwYH6XeBZKWCjwNobfHngC2lDYiz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dloQrcOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2D8C433F1;
	Mon, 11 Mar 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710159027;
	bh=9qWXx17ikIntTOyse8M12B0v0qduGm1iZ4PJfXmIpkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dloQrcOnr8miZHkrYFRdr5F7iIWOqYnML3SiUDjAyIRIfEp74WSTrMeaCuFPWn8N5
	 oc9CoE+pbo01kVwBvHz7N0Ustnz8sE0pCzoFbo0pZ68bcsddndteBAcKlYBJrSGhla
	 20AQ7DRDlEiPyjRrgeHvd1V/WjDmT6uUP/+bc1oBw35Y5ibYw1WL58XdPZW6HHn9nX
	 mVSs54f6e/rIyvFTzqPvOwRtwbtfL/ZHWLp8S6RT2ghUBll8o1ve7N7z7WlxVe5/ai
	 gmwF13/wOcomvgulTJJs/+uu1/ov805xXRDvQjNUGAb7ym4DF4p1TNZdmV2Ntn/cV4
	 30AxntOEULiqA==
Date: Mon, 11 Mar 2024 13:10:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Document requirements for driver-specific KMS props
 in new drivers
Message-ID: <20240311-nostalgic-tungsten-warthog-c4c561@houat>
References: <20240229202833.198691-1-sebastian.wick@redhat.com>
 <20240306-hulking-funky-fox-b9581b@houat>
 <20240306165009.GB11561@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axw6wumxavhxptqy"
Content-Disposition: inline
In-Reply-To: <20240306165009.GB11561@toolbox>


--axw6wumxavhxptqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Wed, Mar 06, 2024 at 05:50:09PM +0100, Sebastian Wick wrote:
> On Wed, Mar 06, 2024 at 03:14:15PM +0100, Maxime Ripard wrote:
> > On Thu, Feb 29, 2024 at 09:28:31PM +0100, Sebastian Wick wrote:
> > > When extending support for a driver-specific KMS property to addition=
al
> > > drivers, we should apply all the requirements for new properties and
> > > make sure the semantics are the same and documented.
> > >=20
> > > Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> > > ---
> > >  Documentation/gpu/drm-kms.rst | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-km=
s.rst
> > > index 13d3627d8bc0..afa10a28035f 100644
> > > --- a/Documentation/gpu/drm-kms.rst
> > > +++ b/Documentation/gpu/drm-kms.rst
> > > @@ -496,6 +496,11 @@ addition to the one mentioned above:
> > > =20
> > >  * An IGT test must be submitted where reasonable.
> > > =20
> > > +For historical reasons, non-standard, driver-specific properties exi=
st. If a KMS
> > > +driver wants to add support for one of those properties, the require=
ments for
> > > +new properties apply where possible. Additionally, the documented be=
havior must
> > > +match the de facto semantics of the existing property to ensure comp=
atibility.
> > > +
> >=20
> > I'm conflicted about this one, really.
> >=20
> > On one hand, yeah, it's definitely reasonable and something we would
> > want on the long run.
> >=20
> > But on the other hand, a driver getting its technical debt worked on for
> > free by anyone but its developpers doesn't seem fair to me.
>=20
> Most of the work would have to be done for a new property as well. The
> only additional work is then documenting the de-facto semantics and
> moving the existing driver-specific code to the core.

Sure, I think part of the problem with the Broadcast RGB property was
also that it hasn't been reviewed by anyone when it was submitted for
vc4.

> Would it help if we spell out that the developers of the driver-specific
> property shall help with both tasks?

Yes, that's a good idea, and we should probably require that the
maintainers of the driver that first added that property ack the
"standardization" work too.

> > Also, I assume this is in reaction to the discussion we had on the
> > Broadcast RGB property. We used in vc4 precisely because there was some
> > userspace code to deal with it and we could just reuse it, and it was
> > documented. So the requirements were met already.
>=20
> It was not in drm core and the behavior was not documented properly at
> least.
>=20
> Either way, with Broadcast RGB we were already in a bad situation
> because it was implemented by 2 drivers independently. This is what I
> want to avoid in the first place. The cleanup afterwards (thank you!)
> just exposed the problem.

Actually, I just found out there's three, the third one not being
compatible at all with the other two:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/gma500/cdv_d=
evice.c#L471

I'll send a patch to figure that one out once the rest will be merged.

Maxime

--axw6wumxavhxptqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZe70rwAKCRDj7w1vZxhR
xQxYAP9q1SJBPEiMwDRctpVhP8hqW4wSqfU9lWtFR0RFBytb2QEAhtpGLd/0R/wf
65kAq73rt4zUgIctaaBFIM6jbgbl4Qs=
=V+zm
-----END PGP SIGNATURE-----

--axw6wumxavhxptqy--

