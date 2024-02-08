Return-Path: <linux-kernel+bounces-58138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A221884E1D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF49289B95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BC763E7;
	Thu,  8 Feb 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAgQpn/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E277621;
	Thu,  8 Feb 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398144; cv=none; b=XGgF8QhMk30ywY+Ik03lRi/QMnMjm7SBA6plkfJnRiaarkE6TiK55Cnzu64pzS2Wm1sAgmFZetuJmI9yIRQHqiH3uXijKXyiFpsOZSoJG/fe6M7Lf2HDJ4qY+OtOYLkKA5LtGL8mAkv1S2lPwPiS2xrCgsZueZg+HllDwTnmK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398144; c=relaxed/simple;
	bh=KFgrJViWvgwiOzgjsLdG7QKsqaf3QTYl4byPlFWT/Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhZPFmvsAnuhAmRfv+ggNXJGSMc3rnxOHjdL+rtsOP8aGRzrsk5yd8ggZHZDrVtOwJ1OTIc7pZo/RkwoaDH/OfnSrAq2rMJ4S6+oJPsOW4mjOUojoCYpXNGaKEqlIO2SEORFPar+ObkbAF3S98y7B+MyvOAZs9gg4Q0cNVHCKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAgQpn/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45069C433F1;
	Thu,  8 Feb 2024 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707398143;
	bh=KFgrJViWvgwiOzgjsLdG7QKsqaf3QTYl4byPlFWT/Zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAgQpn/02Ce0EuLcjlfLihZIB3OhExW3yYI8rOXdBEBFBEiFNhpcpNjRXoLKLec/Z
	 7XOdn9o3BD4e/HgeolBNIahh/GIxR6aPxlY7l69VyRkKSPLuBBfyM4HQEGlpb4zLkH
	 2nl6mp7YVjznZgaothn67LBqjFWnwc/sBr9CMYRjlc8lmIMI+rQdz2/Ke7ab0Fo5YL
	 bjmo7wczvwJ2S7dUPLZxjA/U0mgrX1gzLvg6YFkMoWjexmYxKsF29sfWx1jxzx7nEy
	 sEN/9kSbwebiTRm1RscPABaTywqQeksYvBjeJSn/YZhEkIkd+s323tQjo0QKJNMUoV
	 2OOt2K+oQMLQw==
Date: Thu, 8 Feb 2024 14:15:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	amd-gfx@lists.freedesktop.org, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Melissa Wen <mwen@igalia.com>, Dave Airlie <airlied@redhat.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: Re: [PATCH v4 1/3] drm: Add drm_get_acpi_edid() helper
Message-ID: <ysm2e3vczov7z7vezmexe35fjnkhsakud3elsgggedhk2lknlz@cx7j44y354db>
References: <20240207224429.104625-1-mario.limonciello@amd.com>
 <20240207224429.104625-2-mario.limonciello@amd.com>
 <87y1bvb7ns.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wuwkuftvercgjsvr"
Content-Disposition: inline
In-Reply-To: <87y1bvb7ns.fsf@intel.com>


--wuwkuftvercgjsvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 11:57:11AM +0200, Jani Nikula wrote:
> On Wed, 07 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> > Some manufacturers have intentionally put an EDID that differs from
> > the EDID on the internal panel on laptops.  Drivers can call this
> > helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/Kconfig    |  5 +++
> >  drivers/gpu/drm/drm_edid.c | 77 ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     |  1 +
> >  3 files changed, 83 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 6ec33d36f3a4..ec2bb71e8b36 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -21,6 +21,11 @@ menuconfig DRM
> >  	select KCMP
> >  	select VIDEO_CMDLINE
> >  	select VIDEO_NOMODESET
> > +	select ACPI_VIDEO if ACPI
> > +	select BACKLIGHT_CLASS_DEVICE if ACPI
> > +	select INPUT if ACPI
> > +	select X86_PLATFORM_DEVICES if ACPI && X86
> > +	select ACPI_WMI if ACPI && X86
>=20
> I think I'll defer to drm maintainers on whether this is okay or
> something to be avoided.
>=20
>=20
> >  	help
> >  	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
> >  	  introduced in XFree86 4.0. If you say Y here, you need to select
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 923c4423151c..c649b4f9fd8e 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -28,6 +28,7 @@
> >   * DEALINGS IN THE SOFTWARE.
> >   */
> > =20
> > +#include <acpi/video.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/cec.h>
> >  #include <linux/hdmi.h>
> > @@ -2188,6 +2189,49 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsig=
ned int block, size_t len)
> >  	return ret =3D=3D xfers ? 0 : -1;
> >  }
> > =20
> > +/**
> > + * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
> > + * @data: struct drm_device
> > + * @buf: EDID data buffer to be filled
> > + * @block: 128 byte EDID block to start fetching from
> > + * @len: EDID data buffer length to fetch
> > + *
> > + * Try to fetch EDID information by calling acpi_video_get_edid() func=
tion.
> > + *
> > + * Return: 0 on success or error code on failure.
> > + */
> > +static int
> > +drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t=
 len)
> > +{
> > +	struct drm_device *ddev =3D data;
> > +	struct acpi_device *acpidev =3D ACPI_COMPANION(ddev->dev);
> > +	unsigned char start =3D block * EDID_LENGTH;
> > +	void *edid;
> > +	int r;
> > +
> > +	if (!acpidev)
> > +		return -ENODEV;
> > +
> > +	/* fetch the entire edid from BIOS */
> > +	r =3D acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> > +	if (r < 0) {
> > +		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
> > +		return -EINVAL;
> > +	}
> > +	if (len > r || start > r || start + len > r) {
> > +		r =3D -EINVAL;
> > +		goto cleanup;
> > +	}
> > +
> > +	memcpy(buf, edid + start, len);
> > +	r =3D 0;
> > +
> > +cleanup:
> > +	kfree(edid);
> > +
> > +	return r;
> > +}
> > +
> >  static void connector_bad_edid(struct drm_connector *connector,
> >  			       const struct edid *edid, int num_blocks)
> >  {
> > @@ -2643,6 +2687,39 @@ struct edid *drm_get_edid(struct drm_connector *=
connector,
> >  }
> >  EXPORT_SYMBOL(drm_get_edid);
> > =20
> > +/**
> > + * drm_get_acpi_edid - get EDID data, if available
>=20
> I'd prefer all the new EDID API to be named drm_edid_*. Makes a clean
> break from the old API, and is more consistent.
>=20
> So perhaps drm_edid_read_acpi() to be in line with all the other struct
> drm_edid based EDID reading functions.
>=20
> > + * @connector: connector we're probing
> > + *
> > + * Use the BIOS to attempt to grab EDID data if possible.
> > + *
> > + * The returned pointer must be freed using drm_edid_free().
> > + *
> > + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> > + */
> > +const struct drm_edid *drm_get_acpi_edid(struct drm_connector *connect=
or)
> > +{
> > +	const struct drm_edid *drm_edid;
> > +
> > +	switch (connector->connector_type) {
> > +	case DRM_MODE_CONNECTOR_LVDS:
> > +	case DRM_MODE_CONNECTOR_eDP:
> > +		break;
> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	if (connector->force =3D=3D DRM_FORCE_OFF)
> > +		return NULL;
> > +
> > +	drm_edid =3D drm_edid_read_custom(connector, drm_do_probe_acpi_edid, =
connector->dev);
> > +
> > +	/* Note: Do *not* call connector updates here. */
> > +
> > +	return drm_edid;
> > +}
> > +EXPORT_SYMBOL(drm_get_acpi_edid);

Why shouldn't we use the BIOS/UEFI to retrieve them if it's available?

I guess what I'm asking is why should we make this an exported function
that drivers would have to call explicitly, instead of just making it
part of the usual EDID retrieval interface.

Maxime

--wuwkuftvercgjsvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcTT/AAKCRDj7w1vZxhR
xWUaAQD6cN2OZLS2on0CdvI61erefZfBVEzfJKIbzj+zTy36EgD/Tp/fQ9Ez18hY
ZDmNNTVz7c/J4H5FwzAHoiHDwQDEJQE=
=/woU
-----END PGP SIGNATURE-----

--wuwkuftvercgjsvr--

