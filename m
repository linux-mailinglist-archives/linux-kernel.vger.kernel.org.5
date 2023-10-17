Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302EC7CC107
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjJQKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjJQKus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:50:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08473EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:50:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B60C433C7;
        Tue, 17 Oct 2023 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697539846;
        bh=NBELIU9z6fKP618YgdgGGrhepP3TPqeWVx6XGPhGX5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mm8Z5V0KH1hwDvZFYpv+Ys3I2IW2+5A4lAXvPqyj9l9IOZIBR+hjFi3u9DPjRZpL9
         jRL2mCDvS349NfbJX2CRsfAU7iOTQRqGa3dq02fmq3IVa9AfvT8Swa+c2eO88Jr6b8
         /2LCm3veEjFqVScUlrzSObyaKGz7LBCd5tjFe7CSER/DSQ8SayiOQAQygOrJiBz1uI
         7a5lCcwoFTc0B1Tg1gw1ZfWOzsLNdtLQXnWM/7SeJNPKSNP1S3iHpldgWCAIx4MVTK
         rN89kmUEPbBDjoHr5fln/ZY3lamJhqnBQDCVskuEPDV/Sh7i+sCk2I68lqpe7p+yoR
         Hn8sRHzlxfbLQ==
Date:   Tue, 17 Oct 2023 11:50:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: tas5805m: Disallow undefined
 properties
Message-ID: <20231017-blinking-barricade-9e068a5fc602@spud>
References: <20231016155547.2973853-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3VQsOoHMH3HTVwq6"
Content-Disposition: inline
In-Reply-To: <20231016155547.2973853-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VQsOoHMH3HTVwq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:55:47AM -0500, Rob Herring wrote:
> Device specific bindings should not allow undefined properties. This is
> accomplished in json-schema with 'additionalProperties: false'.
>=20
> Examples should be last in the schema, so move additionalProperties up
> while we're here.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/sound/tas5805m.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/tas5805m.yaml b/Docu=
mentation/devicetree/bindings/sound/tas5805m.yaml
> index 63edf52f061c..12c41974274e 100644
> --- a/Documentation/devicetree/bindings/sound/tas5805m.yaml
> +++ b/Documentation/devicetree/bindings/sound/tas5805m.yaml
> @@ -37,6 +37,8 @@ properties:
>        generated from TI's PPC3 tool.
>      $ref: /schemas/types.yaml#/definitions/string
> =20
> +additionalProperties: false
> +
>  examples:
>    - |
>      i2c {
> @@ -52,5 +54,4 @@ examples:
>                  ti,dsp-config-name =3D "mono_pbtl_48khz";
>          };
>      };
> -
> -additionalProperties: true
> +...
> --=20
> 2.42.0
>=20
>=20

--3VQsOoHMH3HTVwq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS5m/QAKCRB4tDGHoIJi
0gcEAQCmHmcARE1lTJsuZHsKJ56ZGHCns14vOpQXsWwK4mvBXQD9GYNa6EuBgPv3
bunLUdSkx2aJXu0YguhXOE/JBMSVjgs=
=PYZq
-----END PGP SIGNATURE-----

--3VQsOoHMH3HTVwq6--
