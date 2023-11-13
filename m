Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFD77EA40B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjKMTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjKMTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:53:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996C1198A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:53:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B413DC433C9;
        Mon, 13 Nov 2023 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699905180;
        bh=ffLcDRGqnUdm0yatIQP+KftLtw8Kq854UisLinpCfkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rks3S6dZ+7Jjp4tXAycU1iqgHBCErzgrQVDxCo/cZU5shwg2hEgTJXJUeXaeLFyni
         +CVDX2NiHzYtD20ed6jtswkVpDqmglEmqUdpM5oohrdvWku/nzYSgG20l/Piy70n7B
         NB5rmdA5VNxDBJpiqP6X2PhaLbSfswQuIvMf0p9QLDoQEOz5324ZwgDJfdXZmrezwU
         44iZP1NTiGvAdWPMM6476hnynjk40o/M7OEoNLOeQvDnJz5qw4U/wSUvMt1TzwSRw+
         aDEeoHZcsUvSyMsL6zCHaFdOgkHF1C+YltwZzPUwQ9oJUI9FWKr0HvVULJfsqs3hud
         gsm6TGvm1ArIw==
Date:   Mon, 13 Nov 2023 19:52:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Peter Yin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Message-ID: <20231113-zesty-utilize-10ffeb80cb80@squawk>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w0GpC5z66S9rvkCL"
Content-Disposition: inline
In-Reply-To: <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w0GpC5z66S9rvkCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
> Add a device tree bindings for mp5990 device.
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor,

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 7680c8a9b4ad..eb83ab4c02ee 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -123,6 +123,8 @@ properties:
>            - mps,mp2888
>              # Monolithic Power Systems Inc. multi-phase controller mp2975
>            - mps,mp2975
> +            # Monolithic Power Systems Inc. multi-phase hot-swap control=
ler mp5990
> +          - mps,mp5990
>              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>            - honeywell,hi6130
>              # IBM Common Form Factor Power Supply Versions (all versions)
> --=20
> 2.25.1
>=20

--w0GpC5z66S9rvkCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVJ+lgAKCRB4tDGHoIJi
0v2OAP9c9NGnaiv1W+5gqKFFbzEC35fZg8gCBlYC3BjyLfEsyQD/YNq8VwQytXuA
Dp6g72fS9OCud1M5ffI7sbMNw+//lwE=
=dQgz
-----END PGP SIGNATURE-----

--w0GpC5z66S9rvkCL--
