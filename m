Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703E7AEDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjIZNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjIZNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:07:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7910E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB807C433C8;
        Tue, 26 Sep 2023 13:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733648;
        bh=5rc5i2es81YW7XYGcv+4eO04vSryf/jxDeo73Pyc0GU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXCx1tZJPm8bVjmSHYmyX+R0db2sGn9Bq55705tXNbt/fH6/OPLlolFVhos8LHZeH
         g1m4BNrIKC+3bXSKJbXrALLn+8xD1ns1E1NpBxWbyjd1h2OuSIAFLEL0Qlc7BRJovp
         VYvWdMKxxPUlLlGw9Wym3Y1bHpgKYntoK5GUi/3sw/4aP4x6+9/jJAU5NJSbb6Pc60
         0q5JQRfhy+U1RfyamzOp2VqqbY1p96qQy2YMQFPwS/c2+86CYkYB9shEO6VzVs2rBT
         rVQtE05oPJilTT3TLNwjociEIvp6hGC0y/DExDmx+zdAqmu/05GyuX4W6q4vtOcQas
         ogh5itNIKPe8Q==
Date:   Tue, 26 Sep 2023 14:07:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm,coresight-cti: Drop type for 'cpu'
 property
Message-ID: <20230926-division-keenness-ca9463a79cff@spud>
References: <20230925220511.2026514-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tASJHawbsd/GK+ZX"
Content-Disposition: inline
In-Reply-To: <20230925220511.2026514-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tASJHawbsd/GK+ZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 05:05:05PM -0500, Rob Herring wrote:
> 'cpu' has been added as a single phandle type to dtschema, so drop the
> type here.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml=
 b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> index 6216cfb0a188..b9bdfc8969cd 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -92,7 +92,6 @@ properties:
>      maxItems: 1
> =20
>    cpu:
> -    $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Handle to cpu this device is associated with. This must appear in =
the
>        base cti node if compatible string arm,coresight-cti-v8-arch is us=
ed,
> --=20
> 2.40.1
>=20

--tASJHawbsd/GK+ZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLXiwAKCRB4tDGHoIJi
0niZAP9WQTRii5qf1y2AaTgiMyMjr5oFq4CCMGGix1TS8dQ1kAD/WZ5RtR5pZsdl
HMjYYIzCZR0pO5AU4hPh4Rk6Y54nMw8=
=7gcT
-----END PGP SIGNATURE-----

--tASJHawbsd/GK+ZX--
