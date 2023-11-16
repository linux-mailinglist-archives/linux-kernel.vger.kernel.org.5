Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39F7EE6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbjKPSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:34:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD251AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C348C433C8;
        Thu, 16 Nov 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700159660;
        bh=8EhJKo8rDeezKqxLzMDL7DCLOC6nqzPZCy8ff/Ayqe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxzYQgfX6q6Qrk30HeKvn5JTCTDM4xnC9E62Ky78pyXCsCpuwnhHWYNOLpqJeoS69
         jXrNYndJ1RNR0GrPzvtu4KF+txcfx6nxgKaaM/yebJ+PrZ4wTvQUdpo9CkKFR6aq9f
         liU+UUd76DmQahOVwgWLldkF3hUEc352EUWtArptO1Z7R7rk/ai32G/x0K5ui3Jvw/
         lB1kfJ3/YMyar+tzvnnBJGmr8j43nmyddwH5G+2pw6mriYvglmKOOwi1+igINbrv5O
         mOwuEcanj2bpiv0H8AEugX4oZ+ohKmJ/amHFUkQ28APHiNOW9NEfoGjC3kCYn6ynU8
         W30nira3eBMzQ==
Date:   Thu, 16 Nov 2023 18:34:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: honeywell,mprls0025pa.yaml: fix function numbering
Message-ID: <20231116-grudge-hankering-b7a71d831b93@squawk>
References: <20231116182443.7290-1-ak@it-klinger.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdaK5Truep84srtq"
Content-Disposition: inline
In-Reply-To: <20231116182443.7290-1-ak@it-klinger.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hdaK5Truep84srtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:24:43PM +0100, Andreas Klinger wrote:
> Fix wrongly documented numbering of transfer functions.
>=20
> Fixes: a765c985e696 ("dt-bindings: iio: pressure: Support Honeywell mprls=
0025pa sensor")
>

No blank line here.

> Suggested-by: Petre Rodan <petre.rodan@subdimension.ro>

This should be Reported-by.

> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/pressure/honeywell,mprls0025pa.yaml        | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr=
ls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mp=
rls0025pa.yaml
> index b31f8120f14e..61775eff1128 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025p=
a.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025p=
a.yaml
> @@ -64,9 +64,9 @@ properties:
>      description: |
>        Transfer function which defines the range of valid values delivere=
d by the
>        sensor.
> -      1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> -      2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> -      3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
> +      0 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
> +      1 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
> +      2 - C, 20% to 80% of 2^24 (3355443 .. 13421773)

I don't understand. These are arbitrary numbers in a dt-binding, why
does zero or one indexing make any difference here?
Can't you just fix up the driver to correctly map the dt-binding to
whatever needs to be written to registers in the hardware?

Cheers,
Conor.

>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
>    vdd-supply:
> --=20
> 2.39.2
>=20

--hdaK5Truep84srtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZgpQAKCRB4tDGHoIJi
0ro9AP41/miHXh7XhWfNmwyktMkO3qn/gHtMyuEiySwMJSiQygEA5W0rZahN92ag
PUp2JscwQiOwmt7fQzs1cJb7N8aOvgI=
=C+WP
-----END PGP SIGNATURE-----

--hdaK5Truep84srtq--
