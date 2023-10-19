Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115417CF35D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJSIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjJSIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:55:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF217181;
        Thu, 19 Oct 2023 01:55:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69789C433C8;
        Thu, 19 Oct 2023 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697705724;
        bh=gwlgcQ3ZqyeFuGLncdKSOGMnNI0cOD810MBreEhi+TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uC7TqhGnUNd9QLr+ZDwKcbNn/09s1m/SZE5jgShNsWSpCzha/Mg2pmU2qn+iKBJvV
         175spQuQlBcmKSeSTj6ATSrykDAcdidoADKNqB8Gu0oLbzefD9HCGg7To1a1XRiCIu
         2Sy6Z8SYNnPtnhD4gmUDE+4zJsz82aJBJROKbMXTrs9xOcxsk+iVNfYkFSVm4xX3js
         hZrGQ8e/OqgOFkP+8aeZPWg6c084t8/yDfvKPsDzmJeRwjJ+U6XDIEfZqVy+rImaHP
         ksM19pQHmkDzO38FBOPFlmwQBmpaNPNCEV9wxxfnV6/QHZHq82H2QCo8v7qvOf0jQi
         GMvDs+dkCTIdg==
Date:   Thu, 19 Oct 2023 09:55:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Message-ID: <20231019-theme-clunky-f4a2e1d122e7@spud>
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o+iwHg08XNFzcdm3"
Content-Disposition: inline
In-Reply-To: <20231019-rematch-ethically-9d482ca4607e@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o+iwHg08XNFzcdm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 09:51:39AM +0100, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 06:34:37PM +1030, Subhajit Ghosh wrote:
> > Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
> > file and removing the other.
>=20
> > Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@=
linaro.org/
>=20
> "Yes, they look similar. I will combine them all in a single yaml file in
> the next revision. Thank you Krzysztof."
>=20
> Yet this is a follow-up patch, not a version 2. The original patches
> seem to not have been applied, so I am not sure why you didn't send a
> v2?

> > ---
> >  .../bindings/iio/light/avago,apds9300.yaml    | 35 ++++++++++++---
> >  .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
> >  2 files changed, 29 insertions(+), 50 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,a=
pds9960.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300=
=2Eyaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> > index 206af44f2c43..7826a1749fcd 100644
> > --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> > @@ -4,17 +4,26 @@
> >  $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: Avago APDS9300 ambient light sensor
> > +title: Avago Gesture, RGB, ALS and Proximity sensors
> > =20
> >  maintainers:
> >    - Jonathan Cameron <jic23@kernel.org>
> > +  - Matt Ranostay <matt.ranostay@konsulko.com>

Also:
<matt.ranostay@konsulko.com>: host aspmx.l.google.com said:
    550-5.1.1 The email account that you tried to reach does not exist.

--o+iwHg08XNFzcdm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTDu+AAKCRB4tDGHoIJi
0tM1AP9J/187nzeXOZeMBjJXBvsCk/bdcxHKOI8Ee9RtLaDCCgEA+a8TvoojE6Un
eEsrqDgO1U5PGqZlkiKhLw+x22TA+wo=
=Hpaq
-----END PGP SIGNATURE-----

--o+iwHg08XNFzcdm3--
