Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E35F79EBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbjIMPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjIMPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:02:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05900AF;
        Wed, 13 Sep 2023 08:02:44 -0700 (PDT)
Received: from mercury (dyndsl-091-248-208-175.ewe-ip-backbone.de [91.248.208.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27A936607326;
        Wed, 13 Sep 2023 16:02:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694617363;
        bh=Mr987lQ7RX7Mpx8E4S7W1u4g24PmSRwWpxK8RTK2Ldw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0/gHKlDXsv6JA/cl1vKUowyUnEHiXQYLoPM1Zeg+Y/1UP1z1mEmqi8gGzhcLP6q6
         cROzXAHzDteJ7zeFQMmMa+GlNgDtcnJKp3k9nbP61b2clzEa/Nny/g5CTgMydEuyre
         ogzmP6jaTjLv1Gmf0NcX3XrdJ7rJFgxqQo5R2eay/mPUNAkVVp8y/hu/vuubA5pJFh
         78tMZ+Kf5aqNHn089ep6MyDcndysI0GGZ+dxcpXjRb1GO7VSsz5Ckc4vtENIBgowXA
         fyqzO+otZb31msahdIS/nRhsR5pMDF4T8tJUIN8Hp1QpOF0pXnzuBgTlCIrrD2DQPX
         U1o/0Du3WSOxg==
Received: by mercury (Postfix, from userid 1000)
        id BC530106098A; Wed, 13 Sep 2023 17:02:40 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:02:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v2 2/3] dt-bindings: power: supply: Document
 Mitsumi MM8013 fuel gauge
Message-ID: <20230913150240.4nzkxu6pnxv65tv2@mercury.elektranox.org>
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
 <20230621-topic-mm8013-v2-2-9f1b41f4bc06@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxffqrwxy4s7q74c"
Content-Disposition: inline
In-Reply-To: <20230621-topic-mm8013-v2-2-9f1b41f4bc06@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fxffqrwxy4s7q74c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 23, 2023 at 04:36:14PM +0200, Konrad Dybcio wrote:
> The Mitsumi MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
> datasheet is available at [1]. Add bindings for this chip.
>=20
> [1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/power/supply/mitsumi,mm8013.yaml      | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm801=
3.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
> new file mode 100644
> index 000000000000..080fd44083ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mitsumi MM8013 fuel gauge
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +

allOf:
  - $ref: power-supply.yaml#

-- Sebastian

> +properties:
> +  compatible:
> +    const: mitsumi,mm8013
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fuel-gauge@55 {
> +        compatible =3D "mitsumi,mm8013";
> +        reg =3D <0x55>;
> +      };
> +    };
>=20
> --=20
> 2.42.0
>=20

--fxffqrwxy4s7q74c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUBzwcACgkQ2O7X88g7
+poQfg//aEug4AGvhTIulK7IlBjIM2qSfT76xGJwCsud4znJvqzvvYdOfWs8lBFm
WZLb8rkqwlA+jYk/rKKPwnZmDQmkhCcc4gEA526AFS6D2siRukHLccfjAnfPuPhG
CjWUoQG2/JWeIpOiA9n3YJFhnASLyq6pfpM7Y8BzzH3V7cLQwUcjy8hQNWM2r2Vp
tWJrYikFb3dHd0N2AXQSqaHt5qNAUItiWv2ogcNPfWlGhAUjsodpBIBSz9SDPPn6
y/UIpWB3pObYWidXOgvZBnwd5X5ZsfGvqZoV9xpE165PbJ9kCNlQzLnTSCoO6g8L
CIwhqppQbJ+yh5NcqVXcYzmAO3WfPZ8rS5PMS7WVV0dcDg4sqZhxRCqhgiZrIfAo
3+HPhbq70mtu7hvxEF+wl/03DpEEUCsQRLQl49ypMm25UQB2GpkLH5Ps0EMq80PI
MSHCMr90IccREB1O5Jkf4dtfWZ7gfD9k+uZN/LRTFwRwHSBms8rlrZmQbBO1/tDY
sfh1HNRXjDrSdKbM41BC2mRxc/NSFGJ1uO0M3qZ4vfk7t/5r7jU55vV3+kXJqLoJ
w3Fq5IHHKSgc25tSLwKFN/jghurPNBaDamvQ7OQgXpmz6r5xaB3m/bTaUo18bIW+
4m/1ZgP/+uYYnCgqsRYoEGD3CdJTFiUq8pgU5nxqZv24/dFqTx0=
=QHk4
-----END PGP SIGNATURE-----

--fxffqrwxy4s7q74c--
