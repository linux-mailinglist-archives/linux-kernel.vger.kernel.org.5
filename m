Return-Path: <linux-kernel+bounces-16879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77F6824552
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2EC1C221B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1FF249EF;
	Thu,  4 Jan 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LVH2ssle"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC08249EA;
	Thu,  4 Jan 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404Fl3sj102136;
	Thu, 4 Jan 2024 09:47:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704383224;
	bh=+wDPMal2JFqmEHxjTLF5FF7I5A08zwtXlvXw7cZv+2o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LVH2ssleKYyTlCkI7cebAfm8zdGXmB/9mhmstHFCbiWZY1ZMjSP4nQy3dYcfYw4eF
	 Q6rc3tvkaaKFu6afgbVG8dx+66pTSNUxVKwHji+vBYoBxf8Ejrk21WpFO7cDnUD9Qa
	 Ogt3fFD3cGi+LvV+jOaiChyy4eo3QRUOhAXLwdr4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404Fl3vw039813
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 09:47:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 09:47:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 09:47:03 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404Fl17V027185;
	Thu, 4 Jan 2024 09:47:02 -0600
Date: Thu, 4 Jan 2024 21:17:00 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>, <nm@ti.com>, <rogerq@kernel.org>
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uevnht663xq3g5db"
Content-Disposition: inline
In-Reply-To: <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--uevnht663xq3g5db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Jan 04, 2024 at 19:50:05 +0530, Jai Luthra wrote:
> Hi Javier, Greg,
>=20
> On Dec 14, 2023 at 17:29:08 +0100, Javier Carrasco wrote:
> > This series extends the patch update mechanism to support the tps6598x.
> >=20
> > Currently there is only support for the tps25750 part and some
> > conditional clauses are used to make a special case out of it. Now that
> > different parts support patch updates, a more general approach is
> > proposed.
> >=20
> > The update mechanism differs from the one required by tps25750 and it is
> > explained in the commit message as a summary of the application note in
> > that respect.
> >=20
> > Note that the series makes use of the TPS_SETUP_MS introduced in
> > commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
> > which is currently available in usb-next / usb-testing.
> >=20
> > A TPS65987D has been used to test this functionality with positive
> > results.
> >=20
> > Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> > ---
> > Changes in v2:
> > - Remove probe defeferring mechanism and expect the firmware to be
> >   available (Heikki Krogerus).
> > - Link to v1:=20
> > https://lore.kernel.org/r/20231207-tps6598x_update-v1-0-dc21b5301d91@wo=
lfvision.net
> >=20
>=20
> FYI, this series breaks boot for TI SK-AM62A and SK-AM62 which use=20
> TPS6598x as the USB-C PD chip.
>=20
> The platforms stopped booting since next-20240103 [1], and reverting=20
> this series [4] seems to fix the issue [2]
>=20
> Is there any change needed in the board device-tree [3] and bindings?
>=20
> We don't specify any firmware in the device-tree node, but seems like=20
> that is an assumption in this series. I tried reverting it (below=20
> change) but that did *not* help with the stuck boot.
>=20
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a956eb976906..fa3bd7349265 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1139,7 +1139,7 @@ static int tps6598x_apply_patch(struct tps6598x *tp=
s)
>         ret =3D device_property_read_string(tps->dev, "firmware-name",
>                                           &firmware_name);
>         if (ret)
> -               return ret;
> +               return 0;
>=20
>         ret =3D tps_request_firmware(tps, &fw);
>         if (ret)
>=20
>=20
> [1] https://linux.kernelci.org/soc/ti/job/next/kernel/next-20240103/plan/=
baseline-nfs/
> [2] https://gist.github.com/jailuthra/0c077176585e4df2f8b78f7784087865
> [3] https://gitlab.com/linux-kernel/linux-next/-/blob/master/arch/arm64/b=
oot/dts/ti/k3-am62a7-sk.dts#L305
> [4] https://github.com/jailuthra/linux/commits/next-20240103-tps6598-fix/

The following change seems to fix boot on SK-AM62A without reverting=20
this whole series:

------------------

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a956eb976906a5..8ba2aa05db519b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
 	return 0;
 }
=20
-static int tps6598x_reset(struct tps6598x *tps)
+static int tps25750_reset(struct tps6598x *tps)
 {
 	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
 }
=20
+static int tps6598x_reset(struct tps6598x *tps)
+{
+	return 0;
+}
+
 static int
 tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 {
@@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data =3D {
 	.trace_status =3D trace_tps25750_status,
 	.apply_patch =3D tps25750_apply_patch,
 	.init =3D tps25750_init,
-	.reset =3D tps6598x_reset,
+	.reset =3D tps25750_reset,
 };
=20
 static const struct of_device_id tps6598x_of_match[] =3D {

------------------

I am not an expert on this, will let you/others decide on what should be=20
the correct way to reset TPS6598x for patching without breaking this SK.


--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--uevnht663xq3g5db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWW0vQACgkQQ96R+SSa
cUXqqw//XYG4Dmw7aEG222Q3+DbYgxRkb6Fhb7vMmbGIx1e9q8+D4rLSj5u2KZWh
bM7Io5pCO0ghwv5hdI0cvEk4ZDMdx9aEgJTm3/B5DQz2ahBV81+L1ocD4RJR5mQv
I6MRFK2rvyWyNQnVcfhEkXzLNOSK9xE0vaLujH7a5ktcbKljmRo5ukDx6EtjzcUr
whYJTg0jdFaOijZOTKyqpOx0yYSuyHhxhaMRHX9WXyhlro6ggxhTDNLPB1JMfRQA
po3BR9AA77UHXCRU1mpV9GLKaB84W0rvm4PDILwaLN3mCEG2NdR4enlAEJ2bQShM
dXSSv3hnfnKcaBi8WtZ4Ucs219ocFU2PaLLN9YMq6S11UX9hfT/qHyaY6EMxpBZ2
1q111SZM9eHwr7kzFXLbrGEiEf6TMVPdkSAWjIi4iZJZX+izdpk5Nefj/CoTN1wL
bydwapSc141z+Ea7X2kKw18BB7ohMqdGCFxPuq1TeV9AKvZS2LhifEC68XhIKF4K
sbqR0RUqX52ZT78xGHp672Gj9ppLJSt0uV8u0+wZYN6A/1SbaUmnOYkDG3dCcPfg
38t463i3tmnRjhn2Z4TQz/MnsXNsixARYH4ziXnaLLqHzWQjVtse0gk/U8SkuCKo
0J6BONIUvNsEBoWLXSFh3HXc34gcK0uUdc5y9sn64uLZBO1AZVU=
=37WJ
-----END PGP SIGNATURE-----

--uevnht663xq3g5db--

