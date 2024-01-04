Return-Path: <linux-kernel+bounces-16614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D25824137
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43729B21678
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1621369;
	Thu,  4 Jan 2024 12:02:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41421366
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLMQP-0004kv-8t; Thu, 04 Jan 2024 13:02:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLMQM-000KsV-Aw; Thu, 04 Jan 2024 13:02:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLMQM-003Xuh-0p;
	Thu, 04 Jan 2024 13:02:10 +0100
Date: Thu, 4 Jan 2024 13:02:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Lubomir Rintel <lkundrak@v3.sk>, 
	"zhang.songyi" <zhang.songyi@zte.com.cn>, soc@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC RESEND] soc: pxa: ssp: Cast to enum pxa_ssp_type
 instead of int
Message-ID: <ymq7tp3ps4grmmo6o7txpk2sswb2mzxoaplu7lih2xbmbtp6np@b6ycr5wmmbcc>
References: <20240103210604.16877-1-duje.mihanovic@skole.hr>
 <rj7ijuyy47jrffi6sk7wikqo3rnutz2swkdrznyegalylacawz@jdncegf3elct>
 <2295d860-44cf-4816-8a1a-54274974302f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yn4ddbhj4j5os74o"
Content-Disposition: inline
In-Reply-To: <2295d860-44cf-4816-8a1a-54274974302f@app.fastmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--yn4ddbhj4j5os74o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Thu, Jan 04, 2024 at 11:03:41AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 4, 2024, at 10:08, Uwe Kleine-K=C3=B6nig wrote:
> > [adding lakml to Cc for wider audience]
> >
> > On Wed, Jan 03, 2024 at 10:06:03PM +0100, Duje Mihanovi=C4=87 wrote:
> >> On ARM64 platforms, id->data is a 64-bit value and casting it to a
> >> 32-bit integer causes build errors. Cast it to the corresponding enum
> >> instead.
> >>=20
> >> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> >> ---
> >> This patch is necessary for my Marvell PXA1908 series to compile succe=
ssfully
> >> with allyesconfig:
> >> https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@sk=
ole.hr/
> >> ---
> >>  drivers/soc/pxa/ssp.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
> >> index a1e8a07f7275..e2ffd8fd7e13 100644
> >> --- a/drivers/soc/pxa/ssp.c
> >> +++ b/drivers/soc/pxa/ssp.c
> >> @@ -152,11 +152,11 @@ static int pxa_ssp_probe(struct platform_device =
*pdev)
> >>  	if (dev->of_node) {
> >>  		const struct of_device_id *id =3D
> >>  			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
> >> -		ssp->type =3D (int) id->data;
> >> +		ssp->type =3D (enum pxa_ssp_type) id->data;
> >
> > I wonder if this is a long-term fix. The error that the compiler throws
> > is:
> >
> > 	drivers/soc/pxa/ssp.c:155:29: error: cast from pointer to integer of=
=20
> > different size [-Werror=3Dpointer-to-int-cast]
> > 	  155 |                 ssp->type =3D (int) id->data;
> > 	      |                             ^
> >
> > enum pxa_ssp_type is an integer type, too, and its width could be
> > smaller than 64 bit, too.
>=20
> I would just change the cast to (uintptr_t), which is what we
> have elsewhere.
>=20
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_device=
table.h
> > index f458469c5ce5..fbe16089e4bb 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -283,7 +283,10 @@ struct of_device_id {
> >  	char	name[32];
> >  	char	type[32];
> >  	char	compatible[128];
> > -	const void *data;
> > +	union {
> > +		const void *data;
> > +		kernel_ulong_t driver_data;
> > +	};
> >  };
> >=20
> >  /* VIO */
> >
> > For this driver the change would be nice, as several casts can be
> > dropped.
>=20
> I think this is a nice idea in general, but I would keep
> it separate from the bugfix, as we might want to do this on
> a wider scale, or run into problems.

Sure, I didn't intend to put the diff into a commit as is.

Before doing that change it would probably be sensible to check how this
field is used, I guess most drivers use an integer value and not a
pointer there. Also while touching that making the same change with the
same names for the other *_id structs might be nice. Currently we have
(from include/linux/mod_devicetable.h):

	pci_device_id		kernel_ulong_t driver_data
	ieee1394_device_id	kernel_ulong_t driver_data
	usb_device_id		kernel_ulong_t driver_info
	hid_device_id		kernel_ulong_t driver_data
	ccw_device_id		kernel_ulong_t driver_info
	ap_device_id		kernel_ulong_t driver_info
	css_device_id		kernel_ulong_t driver_data
	acpi_device_id		kernel_ulong_t driver_data
	pnp_device_id		kernel_ulong_t driver_data
	pnp_card_device_id	kernel_ulong_t driver_data
	serio_device_id		-
	hda_device_id		unsigned long driver_data
	sdw_device_id		kernel_ulong_t driver_data
	of_device_id		const void *data
	vio_device_id		-
	pcmcia_device_id	kernel_ulong_t driver_info
	input_device_id		kernel_ulong_t driver_info
	eisa_device_id		kernel_ulong_t driver_data
	parisc_device_id	-
	sdio_device_id		kernel_ulong_t driver_data
	ssb_device_id		-
	bcma_device_id		-
	virtio_device_id	-
	hv_vmbus_device_id	kernel_ulong_t driver_data
	rpmsg_device_id		kernel_ulong_t driver_data
	i2c_device_id		kernel_ulong_t driver_data
	pci_epf_device_id	kernel_ulong_t driver_data
	i3c_device_id		const void *data
	spi_device_id		kernel_ulong_t driver_data
	slim_device_id		-
	apr_device_id		kernel_ulong_t driver_data
	spmi_device_id		kernel_ulong_t driver_data
	dmi_system_id		void *driver_data
	platform_device_id	kernel_ulong_t driver_data
	mdio_device_id		-
	zorro_device_id		kernel_ulong_t driver_data
	isapnp_device_id	kernel_ulong_t driver_data
	amba_id			void *data
	mips_cdmm_device_id	-
	x86_cpu_id		kernel_ulong_t driver_data
	ipack_device_id		-
	mei_cl_device_id	kernel_ulong_t driver_info
	rio_device_id		-
	mcb_device_id		kernel_ulong_t driver_data
	ulpi_device_id		kernel_ulong_t driver_data
	fsl_mc_device_id	-
	tb_service_id		kernel_ulong_t driver_data
	typec_device_id		kernel_ulong_t driver_data
	tee_client_device_id	-
	wmi_device_id		const void *context
	mhi_device_id		kernel_ulong_t driver_data
	auxiliary_device_id	kernel_ulong_t driver_data
	ssam_device_id		kernel_ulong_t driver_data
	dfl_device_id		kernel_ulong_t driver_data
	ishtp_device_id		kernel_ulong_t driver_data
	cdx_device_id		-
	vchiq_device_id		-

Note driver_data vs driver_info which is probably not worth to unify.

> In particular, removing tons of casts to (kernel_ulong_t)
> in other subsystems is probably more valuable than removing
> casts to (void *) for of_device_id, since kernel_ulong_t
> is particularly confusing, with a definition that is
> completely unrelated to the similarly named __kernel_ulong_t.

I'll add that to my list of ideas for big projects :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yn4ddbhj4j5os74o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWWnkEACgkQj4D7WH0S
/k4rvQgAi6v2FzpEUwI/EBd+PS4DuV2QZih24QLKcD2m1n7gA67cvmeQv/ACLUr1
Hm4av92zXr7OPwuQDZihJtCknVljzYJpJbs5Y03cLw7gb45mMrVQh5dqo1JX28+F
yNr9dZl3AOHwEY1mA9uwxbxVK9YgaCTnRPGzOwZZ5LAX2I94/eQXZI5iC1nb754k
zz4dH6tDtpbPd36byIwCY7ePrhoDo8J4euCQRKlY/L8F1HNuIVEoeUgMPYYXE0yY
ifxdAZqV8t2dUAILIBTqRZ/gjZ+B9OmxcuAeuyK2/d4oprpO1UcTWiUqteodgCmW
W5OhxOuf9IAsmOM1I4J3rwmGJ7lDsw==
=HWXa
-----END PGP SIGNATURE-----

--yn4ddbhj4j5os74o--

