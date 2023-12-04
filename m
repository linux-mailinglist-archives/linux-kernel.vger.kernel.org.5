Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89DA803EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjLDT7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjLDT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:59:47 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EBC4;
        Mon,  4 Dec 2023 11:59:52 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 2EBD128EE6F;
        Mon,  4 Dec 2023 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701719991;
        bh=+nDCKIJsNn3sdyyepy9COQh7EZ5oRjjTsJna287/22o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MD8ZZlFKvtWImQs7JJwrKccj+k60ADAYaEZ7WIw77iFiNWTb+l4QyeYz/AB9vjvI+
         c/yESpc6WACDK1juAlgg9Bo2IR8LlL0DDogJpo0htY0W6HGaUCQeD9Jz24/4/hVKZ+
         1ofZCbE9OELvU31DSTWaMS4Ly2deAvBofsl3Hsyk=
Date:   Mon, 4 Dec 2023 21:59:49 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZW4vtQrmgUu29dP6@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
 <ZWtWAPcJTNrD9wgv@sunspire>
 <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0roFwDt5J5hwuJL+"
Content-Disposition: inline
In-Reply-To: <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0roFwDt5J5hwuJL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

On Mon, Dec 04, 2023 at 02:57:33PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 02, 2023 at 06:06:24PM +0200, Petre Rodan wrote:
> > On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > > > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > > >=20
> > > > 437:  ret =3D device_property_read_string(dev, "honeywell,pressure-=
triplet",
> > > > 					&triplet);
> > > > [..]
> > > > 455:	ret =3D match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > > > 						triplet);
> > > > 		if (ret < 0)
> > > > 			return dev_err_probe(dev, -EINVAL,
> > > > 				"honeywell,pressure-triplet is invalid\n");
> > > >=20
> > > > 		hsc->pmin =3D hsc_range_config[ret].pmin;
> > > > 		hsc->pmax =3D hsc_range_config[ret].pmax;
> > > >=20
> > > > triplet is got via device_property_read_string(), is there some oth=
er property
> > > > function I should be using?
> > >=20
> > > I think I mentioned that API, but for your convenience
> > > device_property_match_property_string().
> >=20
> > one of us is not sync-ed with 6.7.0-rc3 :)
>=20
> No, one of us is not synced with subsystem "for-next", which in this case
> is IIO "togreg" (IIRC) and it definitely has the above mentioned API.

v7 still contains the match_string().
that is the API available in -current (6.7.0-rcx), which is the version you
asked me to use a few weeks back.

whenever your new API call will be merged (6.8+ according to your email exc=
hange
with Jonathan) into -current I will provide a patch.

best regards,
peter

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>=20

--=20
petre rodan

--0roFwDt5J5hwuJL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmVuL7UACgkQzyaZmYRO
fzB4xxAAg4++c2EfVeyasAxqVyaxt0/cEt/RDdKBiDUwn4NyAhTdDWslAzGbTssB
K1Kcp9IwHVjLJ59Rgni3z2jlTbMQmpxAfYdMYfCgK6C0LfcRVIqdW+E1DzrZMkJA
dQ2folIi3VBciFDNm6uezx1mX5qtpUYL5jgkOdxwP62K4VrFUHPz1UmCxEbZFIZj
9ZHnkZQnp+teHbKl/CI3LFpOerzN3IOOtqqeWoy1i+c/wERq2JsIDgVZUjcmHPaW
rShXD1Zfc3tEApzb0oqiboxVOHM5iQTZUwngR7trZrPoJFd6gns4FPv1xRTx//fL
unkhZM7nqk83OUxuWnGx0JMya/gBNUSe/JxTQCiqALLwjYt//ApsXkiZetkaGL8J
m27ELfYtC0eLjRHYS1tNRs07EO0JRMZxuhKoc4YUMfAnp4EkzFYF7h3foxhnTZrH
Wk3pT3wmAhr6YIeHSFetJfcXacFnqxvKTHPFzd3XgJFdMJMuO/UJdknYl1vSCqSM
ZoVPKugLgiWvCdLxr8etH3vIqdsoMvYlpmGRI6xNSVYftg98UBsY2KBmGwApl1xt
d260zwVVxB49DgsjSRL4zXsysciw+QdJI1MF5djEMblR34f/owfjeGybGhGn3MR6
w09EzwEJkLiTanx8PxLKTCmWOblXtfFcPrfSy0YfVH6iJQHwsb8=
=aQ99
-----END PGP SIGNATURE-----

--0roFwDt5J5hwuJL+--
