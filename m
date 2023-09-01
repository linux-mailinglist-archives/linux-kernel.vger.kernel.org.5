Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADC79001D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjIAPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjIAPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3510EC;
        Fri,  1 Sep 2023 08:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15CFF61B0F;
        Fri,  1 Sep 2023 15:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE0C433C8;
        Fri,  1 Sep 2023 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693583146;
        bh=H6ARSJFoDsSPV83VjPgwPt2VOUG00bEhvrkCXa2AQZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4+FStK24nYpfln7ViuJUzT3AKUyEtRob7ObVtpW/ELbndiXKNs9pdTPGNlgmX8sd
         WTOsBjtlQ7HQfVFvrIrwx0QKaqS0gJgR/8sbelZHjcYX+o36d8AQkCNMVTuAs08ZtY
         0s6ij6QQtFw05kKhfSyLxuPfC7xG0aMOofHCD0ZUuFnH2PayV9ets4i5zSSIHP1I7W
         FZPeCIxCj4rwOrx1Sc9NZyfxBfUPvfkWPhNbTlAAnRLzSjn/tV1Lj5A7WzZgrrdmi9
         RcfcagLFe6XQNyoT+NrT0sl3QJ3EM25hmUXBbr4fNBS/+Y5yKOV0n646cHZWs3cn3g
         GB74H0xfcMofw==
Date:   Fri, 1 Sep 2023 16:45:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230901-likely-bucktooth-6d2d399f172d@spud>
References: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9rCByC659KURaw0t"
Content-Disposition: inline
In-Reply-To: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9rCByC659KURaw0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 09:07:27PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add the DT property 'infineon,en-pin-fixed-level' to
> indicated that the chip EN pin is at fixed level
> or left unconnected(has internal pull-down).
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

If there's another revision, please add some of the context as to why
the property is needed to the commit message. Otherwise, this looks okay
to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ----
> Changes in V5:
> - Update pin name to align with datasheet
> Changes in V4:
> - Update property name & description.
> - Update commit message.
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 50 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineo=
n,tda38640.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.=
yaml
> new file mode 100644
> index 000000000000..9eecfae5dfcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/infineon,tda38640.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Infineon TDA38640 Synchronous Buck Regulator with SVID and I2C
> +
> +maintainers:
> +  - Naresh Solanki <naresh.solanki@9elements.com>
> +
> +description: |
> +  The Infineon TDA38640 is a 40A Single-voltage Synchronous Buck
> +  Regulator with SVID and I2C designed for Industrial use.
> +
> +  Datasheet: https://www.infineon.com/dgdl/Infineon-TDA38640-0000-DataSh=
eet-v02_04-EN.pdf?fileId=3D8ac78c8c80027ecd018042f2337f00c9
> +
> +properties:
> +  compatible:
> +    enum:
> +      - infineon,tda38640
> +
> +  reg:
> +    maxItems: 1
> +
> +  infineon,en-pin-fixed-level:
> +    description:
> +      Indicates that the chip EN pin is at fixed level or left
> +      unconnected(has internal pull-down).
> +    type: boolean
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
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        tda38640@40 {
> +            compatible =3D "infineon,tda38640";
> +            reg =3D <0x40>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 40bc475ee7e1..86c7d34f63bf 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -151,8 +151,6 @@ properties:
>            - infineon,slb9645tt
>              # Infineon SLB9673 I2C TPM 2.0
>            - infineon,slb9673
> -            # Infineon TDA38640 Voltage Regulator
> -          - infineon,tda38640
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
>=20
> base-commit: 919a83d020a8dfa1411c1dc1cff23a833f0f5268
> --=20
> 2.41.0
>=20

--9rCByC659KURaw0t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPIHJQAKCRB4tDGHoIJi
0uLkAP94BgZ0S0sCuSI4UKEGvrRITGPitc4jESpy9pPyx3CC5AD+OzjWrn/ts6Ut
7J5jGY/iMVN+uDykI5p0VcjPhKvRDAc=
=sHr+
-----END PGP SIGNATURE-----

--9rCByC659KURaw0t--
