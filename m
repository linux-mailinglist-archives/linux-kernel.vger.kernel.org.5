Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF07AF6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjIZXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjIZXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:15:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA226AC;
        Tue, 26 Sep 2023 15:17:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B3AC433C8;
        Tue, 26 Sep 2023 22:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695766673;
        bh=jM+4vSpJHaRXg07Z7KrKc7vyluCBVHubT/JfLBd7uJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kc/hFG+ZzO6/FpPjFZdgI0da37hdu+tQ3EvR26cYtMtSkOYhkGWKQ52gWQti8z3IA
         9TcCAfPgaddkB3Dw39wfMLMuP9lMYux3y8meu16uSTSYi4oz9WHCjZiBLNTdVfJwFV
         yh4ELT7CJY5ZONGxvfHW4atlnVYRZ5kfrEE5GFpZ17S9O9G3vGVh3SLHh9fxxQPKIT
         gUk/1T0xnwr1Kt2WwB4BboaMFhJOGECMQq3xoFcrk5l25wpCAZTk9EE5FN3CEjBLen
         waf6KKFW2ftMW2BHy12kfYhJpRwaHXOH4Q7cOJAWPa7br1hvpaQ+UHepUxg/ruOFwe
         VjCwBju/XFGiQ==
Date:   Tue, 26 Sep 2023 23:17:49 +0100
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
Subject: Re: [PATCH 1/2] input: generalize the Imagis touchscreen driver
Message-ID: <20230926-vintage-grout-799136a47c7c@spud>
References: <20230926173531.18715-1-balejk@matfyz.cz>
 <20230926173531.18715-2-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PjgKNhhDJZlXjpVF"
Content-Disposition: inline
In-Reply-To: <20230926173531.18715-2-balejk@matfyz.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PjgKNhhDJZlXjpVF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 07:35:23PM +0200, Karel Balej wrote:
> This driver should work with other Imagis ICs of the IST30**C series.
> Make that more apparent.
>=20
> Co-developed-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  ...gis,ist3038c.yaml =3D> imagis,ist30xxc.yaml} |  2 +-

>  MAINTAINERS                                   |  2 +-
>  drivers/input/touchscreen/Kconfig             |  4 +-
>  drivers/input/touchscreen/imagis.c            | 86 +++++++++++--------
>  4 files changed, 52 insertions(+), 42 deletions(-)
>  rename Documentation/devicetree/bindings/input/touchscreen/{imagis,ist30=
38c.yaml =3D> imagis,ist30xxc.yaml} (99%)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st30xxc.yaml
> similarity index 99%
> rename from Documentation/devicetree/bindings/input/touchscreen/imagis,is=
t3038c.yaml
> rename to Documentation/devicetree/bindings/input/touchscreen/imagis,ist3=
0xxc.yaml

This rename is pointless.

--PjgKNhhDJZlXjpVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRNYjQAKCRB4tDGHoIJi
0gdyAQCU/gktStdJ+AzCkyQXhLQXG1HNvCxRijBMtmWRybjsWQEA8ExO1zDuRfsI
ci51TnrAQ9roac4P3LgJInZ9cgjGXAE=
=RCwE
-----END PGP SIGNATURE-----

--PjgKNhhDJZlXjpVF--
