Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B867DCA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjJaJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjJaJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:54:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FE91B4;
        Tue, 31 Oct 2023 02:53:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 772AE1BF206;
        Tue, 31 Oct 2023 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698746012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ChJmbwu9VOnS+POuHp63gRk5wbYb/ywo5ZD9wSaeEs=;
        b=JgjwshREE8Ep4u5oBUOhPDbbNTHxfx0Z0WE37PioXBaiJ9B/irqONtAXNFueoA0H8LSIk7
        W/QZH9YcMhG/mvGUa8ZNPCKR5HWzorw/ASJOBLiNw0jXToKCR9xKli6ZWK9T0cruBVWooh
        OCMN/24k2VgD0AKzf3Cm0O+mjGxRYzoaXYwftBXcOesV+CPwWG6wy+2Rxqqjhv0+txGObD
        E0Y4ZWcNNrHRROiMom3iaKwC85TkbRTsLmTRIEJWcf6iXDHZ3fEVtZ4HOTl4OsKY4SYfnv
        IQwB+IbERhT2lQRIK2SxM1Nc+22WSPOmoDpP7l5oXPJffTEgtkIyWVZyLwKy3w==
Date:   Tue, 31 Oct 2023 10:53:30 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v9 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZUDOmgmkIifE2w87@aptenodytes>
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
 <ad346052-ec62-4d68-903e-fccd7ad989bd@wanadoo.fr>
 <ZUDKAB+zQYS9aLpB@pc-70.home>
 <79231ec3-8da1-4c73-8f5b-efa445e6c35d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dYFHt+x1tKrOKW1+"
Content-Disposition: inline
In-Reply-To: <79231ec3-8da1-4c73-8f5b-efa445e6c35d@wanadoo.fr>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dYFHt+x1tKrOKW1+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 31 Oct 23, 10:46, Christophe JAILLET wrote:
> Le 31/10/2023 =C3=A0 10:33, Mehdi Djait a =C3=A9crit=C2=A0:
> > Hello Christophe,
> >=20
> > On Mon, Oct 30, 2023 at 01:47:17PM +0100, Christophe JAILLET wrote:
> > > > +	/* Create & register platform subdev. */
> > > > +	ret =3D cif_register_stream_vdev(cif_dev);
> > > > +	if (ret < 0)
> > > > +		goto err_unreg_media_dev;
> > > > +
> > > > +	ret =3D cif_subdev_notifier(cif_dev);
> > > > +	if (ret < 0) {
> > > > +		v4l2_err(&cif_dev->v4l2_dev,
> > > > +			 "Failed to register subdev notifier(%d)\n", ret);
> > > > +		cif_unregister_stream_vdev(cif_dev);
> > > > +		goto err_unreg_media_dev;
> > >=20
> > > Should there be another label with cif_unregister_stream_vdev(cif_dev=
); if
> > > an error occurs here?
> > >=20
> > > CJ
> >=20
> > cif_subdev_notifier() is the last function call in the probe with error
> > handling. So it will undo the last successful register:
> > cif_register_stream_vdev and use the goto to unregister the rest.
>=20
> Ah, I didn't see the cif_unregister_stream_vdev() call here.
> Sorry for the noise.
>=20
> >=20
> > I can add a label err_unreg_stream_vdev but it will be only used in the
> > error handling of cif_subdev_notifier() and I don't see the benefit.
>=20
> The main benefit is to be more consistent in the way the error path is
> written, and to be more future proof.

Indeed the fact that there is only a single user of the label is not a reas=
on
to avoid the label. As soon as you need to use labels/gotos for error handl=
ing,
you should do it for all steps involved and avoid mixing unregistration in =
the
error-checking condition and using a previous label.

Cheers,

Paul

>=20
> CJ
> >=20
> > --
> > Kind Regards
> > Mehdi Djait
> >=20
> > > > +	}
> > > > +
> > > > +	cif_set_default_format(cif_dev);
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +err_unreg_media_dev:
> > > > +	media_device_unregister(&cif_dev->media_dev);
> > > > +err_unreg_v4l2_dev:
> > > > +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> > > > +	return ret;
> > > > +}
> >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--dYFHt+x1tKrOKW1+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVAzpoACgkQ3cLmz3+f
v9Hw3Af+I1RiSM4LM+oLdDR2amN3CH8ODW0RSGGF7ynMWEsTPk0rceP6WGxD96ie
BnwJAudOqNLFhVdgTib8wfZnJqljpQG+0SeVpprlAHI7GooAZ0i3YywzfbrMhUnO
rRuCvdpl3aLAJ4kx05AMm0myRhNr8J69DjtADmQmaWWhXka1cWm6ZCZQLuBzHcv3
29AzkE7jXcFPmtDsJO/DbGI6b5/tYBcoOPYSJjiOYD3EI/fcoINv8DGRQY66vVaL
wbZpV72MdselOHkaGvnD1VCYVgvJ8ARfOSjpiwY6L59bM7+1aS4opnSEY3xf9nmS
YiARdyCLIQs3aHbuFCQVyUAMzs2doQ==
=/LT8
-----END PGP SIGNATURE-----

--dYFHt+x1tKrOKW1+--
