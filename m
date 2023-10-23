Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8317D3BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjJWQHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:07:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A8E9;
        Mon, 23 Oct 2023 09:06:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C272C433C9;
        Mon, 23 Oct 2023 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077218;
        bh=S6VMIhoVKsj2e7n62GkaiRTDJ8EPj3xrFNXOf/EI3g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYpDtb94XJDFXVmeIHBnQAYcWchRsElqnt/ALJtp2Nr9knWzV6ELe5NVhsPEEQTdy
         VXSIPOkSDdLEup7euvSldPwpVw1JI5QcflcunBcK3ARhshUrB9zvbOz8VUeA1klxLW
         BqBOvZ+zL3bibs4lmFSI8rwFEuJABaUEciz9oKA1e9YSAz9yLXoDYT80cVXulk84o6
         0gxlU/VLdGkroOQGCb/m4vYMzEyNuyI4dytoehPFtu535+AF1Qr9uU9Be9wkkB1NKE
         PM9hOBvnmDMx+Q951pglC1ZBfWmaDU2ZXNV+JDiGFyKtP8fD3dz8YtZHaJzMyNSQsY
         y1hgR/8EWvgzA==
Date:   Mon, 23 Oct 2023 17:06:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: adis16460: Add
 'spi-cs-inactive-delay-ns' property
Message-ID: <20231023-repost-coma-2f67ea8b95af@spud>
References: <20231023140534.704312-1-ramona.gradinariu@analog.com>
 <20231023140534.704312-4-ramona.gradinariu@analog.com>
 <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vq5WbrHhYg5Chr9o"
Content-Disposition: inline
In-Reply-To: <e97ac024cb2654507ed8f7af715f3604efefbdbb.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vq5WbrHhYg5Chr9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 04:27:48PM +0200, Nuno S=E1 wrote:
> On Mon, 2023-10-23 at 17:05 +0300, Ramona Gradinariu wrote:
> > The adis16460 device requires a stall time between SPI
> > transactions (during which the chip select is inactive),
> > with a minimum value equal to 16 microseconds.
> > This commit adds 'spi-cs-inactive-delay-ns' property, which should
> > indicate the stall time between consecutive SPI transactions.
> >=20
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > ---
> > changes in v2:
> > =A0- added default value
> > =A0- updated description
> > =A0- updated commit message
> > =A0.../devicetree/bindings/iio/imu/adi,adis16460.yaml=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 6 ++++++
> > =A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.ya=
ml
> > b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > index 4e43c80e5119..f10469b86ee0 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
> > @@ -25,6 +25,12 @@ properties:
> >=20
> > =A0=A0 spi-cpol: true
> >=20
> > +=A0 spi-cs-inactive-delay-ns:
> > +=A0=A0=A0 minimum: 16000
> > +=A0=A0=A0 default: 16000
> > +=A0=A0=A0 description:
> > +=A0=A0=A0=A0=A0 Indicates the stall time between consecutive SPI trans=
actions.
> > +
>=20
> You should drop the description...=20
>=20
> Also, give more time before posting a v2 so others get a chance to review=
 your
> patches. It's also better for you since you can gather more change reques=
ts.

Further, I don't see an answer to Krzysztof's question of why the stall
time would not just be set to 16,000 ns in the driver, based on the
compatible.

--Vq5WbrHhYg5Chr9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTaaHgAKCRB4tDGHoIJi
0hH3AQDXlI8mVw1mEWJZ4i6/O+ODetpJSdpxn2jwhPshD+QGfwEA6EW9738l8qsH
kUrRwUbbQgTOSkDwjPsDlOYFAholUQo=
=E9Go
-----END PGP SIGNATURE-----

--Vq5WbrHhYg5Chr9o--
