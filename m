Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187D7AF6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjIZXRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjIZXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:15:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2EB1662E;
        Tue, 26 Sep 2023 15:16:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFE8C4167D;
        Tue, 26 Sep 2023 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695766612;
        bh=fCjol8JlYphz+jtI2CFpld5H0xOC1ErZJz1agW/LrQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDfzAX/Y7eYDNQEYsaTOIcQbyrUKT8cMZ+qVhy7KfVJh6o8BU9sj8AsMQrFgJeNTC
         9Z0CaES8EnJdjpGZ64ixPRglRlw+afKOAjSzTW1BGHxp1yFEHZW5IwYiur5txYy/Sk
         FQYXn5v1j4L/JcBLfgH3KCpg8cSI9N3/tOxLLXZkafu19Ufq8WJAKSFqaMuIlooSJ5
         EldAdIGgHZsk1I70IQCXuWF8lLFPLAaqUdc1xzQgZDZDFwHpMk1lmis3sUpWjAcIje
         myli+CM71h1BaMrsFgJfNiP5FVI/AnWWWQZNNUuRuI/d/bqqFg0gWzAKz3vFgp7aUs
         BrpY67bp8hv+Q==
Date:   Tue, 26 Sep 2023 23:16:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 0/2] input: Imagis: add support for the IST3032C
 touchscreen
Message-ID: <20230926-scrooge-footpad-141ab10bc24e@spud>
References: <20230926173531.18715-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KY81PpXWkzI89d0P"
Content-Disposition: inline
In-Reply-To: <20230926173531.18715-1-balejk@matfyz.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KY81PpXWkzI89d0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 07:35:22PM +0200, Karel Balej wrote:
> This patch series extends the Imagis driver to support the IST3032C
> touchscreen, which is used for instance with the samsung,coreprimevelte
> smartphone, with which this was tested. To use it with this model
> however, the regulator driver needs to be ported first. Support for this
> smartphone is not yet in-tree, upstreaming is ongoing at [1].
>=20
> [1] https://lore.kernel.org/all/20230812-pxa1908-lkml-v5-0-a5d51937ee34@s=
kole.hr/

For both patches, changes to dt-bindings need to be in their own
patches & not bundled with drivers.

>=20
> Karel Balej (2):
>   input: generalize the Imagis touchscreen driver
>   input: Imagis: add support for the IST3032C touchscreen
>=20
>  ...gis,ist3038c.yaml =3D> imagis,ist30xxc.yaml} |  3 +-
>  MAINTAINERS                                   |  2 +-
>  drivers/input/touchscreen/Kconfig             |  4 +-
>  drivers/input/touchscreen/imagis.c            | 99 ++++++++++++-------
>  4 files changed, 66 insertions(+), 42 deletions(-)
>  rename Documentation/devicetree/bindings/input/touchscreen/{imagis,ist30=
38c.yaml =3D> imagis,ist30xxc.yaml} (97%)
>=20
> --=20
> 2.42.0
>=20

--KY81PpXWkzI89d0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRNYUAAKCRB4tDGHoIJi
0h0+AP4mq1/TXgnfvOXedfd8whbw430eMWkQ2OJeMzaV+zL0DAEA5tmsbi0b7+um
VkrqGJn8r7ZG4dO5GAmDndoEbMNNIAg=
=wi52
-----END PGP SIGNATURE-----

--KY81PpXWkzI89d0P--
