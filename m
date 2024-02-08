Return-Path: <linux-kernel+bounces-57380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801B84D7B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338441F23363
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43C1E897;
	Thu,  8 Feb 2024 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KorkT4J2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E51E496;
	Thu,  8 Feb 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357472; cv=none; b=Mqyj2lYKSwOPYV3GaJGNiAG51XPA0QduHxqr8FJvkgTjqIoaWSaFKPZV/YaqW4udUPjDd4HX5BVoWHF16l+q/CZF2x6Naj0hhoax+KC+J4LyWOPtD2MgLf8dAU7o41IWUgttQS7qTeLVPD1eFuuc+q46nEE5YyX7jqc8VVuEVMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357472; c=relaxed/simple;
	bh=bbYzQgidFTlMKAPLlA7znSNn2HIs3NcXLeDAyP10gdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sHJHETNB1oLZm9iOGgFZ5/Tnl1xdplCnnvmuxy7/T2UaoFMZpiMM0pxV8w+OU4k9DFSRgSnDvBJi147849Qz4V12Phh7yI/YTP1nd3F+O52N9ba1hxYUuL9RSXAmeX2DBO8xswiXhUdJnvotSEcYMBTxehUzdBQGE84KfYVZM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=KorkT4J2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707357467;
	bh=DW86THaytXEkTAbOBp6R/wY2SA3+Rg1m/cQoA7QROL0=;
	h=Date:From:To:Cc:Subject:From;
	b=KorkT4J2xayLgb40Puz0q3GxVOZsFMFJYZA5fCJqQKf1EZqJgJayULqnp0LlEHwxj
	 tgB8wH5vwSL+IVpfqbPeTRDXI/XArElinh0azfCSi1zdbIJiJ66mic0ulKOoObUCW6
	 BATFCxHR0HcrXuOD/j0V0nfroPQuUNz88uXGQk8DiWKq7ZpGiGuDB5vfcU8l1hLlIr
	 4wprpLqz715d385LexTFbbtQoHP0jystNzLFH0HD639QugUQKwttsBhFJcNZTWo/f8
	 ZUukwrSKo2B1dnAR1afQEBxrqkyJLxCtpkGX3yJ9+Wvl0fO43/s/U8iEo8OwujUaRV
	 f8RyWyu0RBNVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVg9Q0S3Wz4wcR;
	Thu,  8 Feb 2024 12:57:46 +1100 (AEDT)
Date: Thu, 8 Feb 2024 12:57:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, Armin Wolf
 <W_Armin@gmx.de>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drivers-x86 tree with Linus' tree
Message-ID: <20240208125744.300635a2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L45RS+xwNcMZCruS93bRmhB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/L45RS+xwNcMZCruS93bRmhB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/wmi.c

between commit:

  3ea7f59af8ff ("platform/x86: wmi: Decouple legacy WMI notify handlers fro=
m wmi_block_list")

from Linus' tree and commit:

  10fdfd13a359 ("platform: x86: wmi: make wmi_bus_type const")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/wmi.c
index 3c288e8f404b,5682c7de0394..000000000000
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@@ -221,18 -219,7 +221,18 @@@ static int wmidev_match_guid(struct dev
  	return 0;
  }
 =20
 +static int wmidev_match_notify_id(struct device *dev, const void *data)
 +{
 +	struct wmi_block *wblock =3D dev_to_wblock(dev);
 +	const u32 *notify_id =3D data;
 +
 +	if (wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *notify_id)
 +		return 1;
 +
 +	return 0;
 +}
 +
- static struct bus_type wmi_bus_type;
+ static const struct bus_type wmi_bus_type;
 =20
  static struct wmi_device *wmi_find_device_by_guid(const char *guid_string)
  {
@@@ -1233,20 -1179,30 +1233,19 @@@ static int wmi_notify_device(struct dev
  	if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *event))
  		return 0;
 =20
 -	/* If a driver is bound, then notify the driver. */
 -	if (test_bit(WMI_PROBED, &wblock->flags) && wblock->dev.dev.driver) {
 -		struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
 -		struct acpi_buffer evdata =3D { ACPI_ALLOCATE_BUFFER, NULL };
 -		acpi_status status;
 -
 -		if (!driver->no_notify_data) {
 -			status =3D get_event_data(wblock, &evdata);
 -			if (ACPI_FAILURE(status)) {
 -				dev_warn(&wblock->dev.dev, "failed to get event data\n");
 -				return -EIO;
 -			}
 -		}
 -
 -		if (driver->notify)
 -			driver->notify(&wblock->dev, evdata.pointer);
 -
 -		kfree(evdata.pointer);
 -	} else if (wblock->handler) {
 -		/* Legacy handler */
 -		wblock->handler(*event, wblock->handler_data);
 +	down_read(&wblock->notify_lock);
 +	/* The WMI driver notify handler conflicts with the legacy WMI handler.
 +	 * Because of this the WMI driver notify handler takes precedence.
 +	 */
 +	if (wblock->dev.dev.driver && wblock->driver_ready) {
 +		wmi_notify_driver(wblock);
 +	} else {
 +		if (wblock->handler)
 +			wblock->handler(*event, wblock->handler_data);
  	}
 +	up_read(&wblock->notify_lock);
 =20
- 	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
- 					dev_name(&wblock->dev.dev), *event, 0);
+ 	acpi_bus_generate_netlink_event("wmi", acpi_dev_name(wblock->acpi_device=
), *event, 0);
 =20
  	return -EBUSY;
  }

--Sig_/L45RS+xwNcMZCruS93bRmhB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXENRgACgkQAVBC80lX
0GzEEgf8Dyl8rHEpCWUNGGrkjvPOTpVQo5FQuA+KR786U9EhZ9RkST3TYU/3aO2U
xrM9uhWguibBnyz5OTF30RLVrwan5x5tPTYyX/jRKsW7RnskZhx2uW9hFYLKcNOE
LrqZbG9LL0QLFH0uZqambgcs912cFtRbB292rJ1VoACWXcFwkUZxLTDcmiStUqjn
hIzrBkvdr6qmE/iXpF33y1SkfXGkHTlWdPEx0Ls6bAGgZ4jrzxoSqNAb5FJva3h6
5oRhRGHECulULa7QLZ5s8fbAvJVwm5ljP792OZewK7F0ioYPRxmE+kaEWzyGI1D0
G018U4UCE4WGzuWkI0CcKu4TFRlebA==
=1nR3
-----END PGP SIGNATURE-----

--Sig_/L45RS+xwNcMZCruS93bRmhB--

