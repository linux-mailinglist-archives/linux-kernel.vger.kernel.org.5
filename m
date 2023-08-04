Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96777052C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjHDPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHDPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1249E5;
        Fri,  4 Aug 2023 08:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A3D662096;
        Fri,  4 Aug 2023 15:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2E9C433C8;
        Fri,  4 Aug 2023 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164120;
        bh=g530ErRoPbHPWkxCzst6RTK4AQ20MUM55oWKx67Ir20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nxt2TW/H8CicYGxtKYh5tylW6wOEpw6k8QKEnaSQK8wO183JlnaCLJhvZ4k/dnNlI
         YJQDaf/C2Y7PjM+x66439QIOjA5lGqN7c8yxd15alHPBf/yuSPKyJgaQUqWErH5HDJ
         ZrIRDXmnZo4sqnIHrwNxSAO72uVxNL3LaMSeVbTPgYV44pT8pQyPa/OLv/qAKlMm2u
         hbd6/I7cDkjahoeu+gJUXDrEARLnegdebY2nckHE/HU15hCgvf0ZD60sUr8M+eAbp2
         T7YswR6+cC/FSPOcZkpxxk18C5zuAatg9+s4RW1z2/AcFib8TGi+3DJsd8+sy4zCO4
         pobsbwKwQ/zYQ==
Date:   Fri, 4 Aug 2023 16:48:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add MAX6639
Message-ID: <20230804-tamper-numbness-0117bb53a921@spud>
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sN8NPFS9+3FUypYE"
Content-Disposition: inline
In-Reply-To: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sN8NPFS9+3FUypYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 04:43:59PM +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
>=20
> Add binding documentation for Maxim MAX6639 fan-speed controller.
>=20
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
> Changes in V3:
> - Update title
> - Add pulses-per-revolution, supplies & interrupts
> Changes in V2:
> - Update subject
> - Drop blank lines
> ---
>  .../bindings/hwmon/maxim,max6639.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b=
/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> new file mode 100644
> index 000000000000..b3292061ca58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX6639 Fan Controller
> +
> +maintainers:
> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
> +
> +description: |
> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, P=
WM
> +  fan-speed controller.  It monitors its own temperature and one external
> +  diode-connected transistor or the temperatures of two external diode-c=
onnected
> +  transistors, typically available in CPUs, FPGAs, or GPUs.

> +  fan-supply:
> +    description: Phandle to the regulator that provides power to the fan.

> +  pulses-per-revolution:
> +    description:
> +      Define the number of pulses per fan revolution for each tachometer
> +      input as an integer.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 2

Apologies if I am digging up old wounds here, since there was quite a
bit of back and forth on the last version, but these two newly added
properties look to be common with the "pwm-fan" and with
"adi,axi-fan-control". At what point should these live in a common
schema instead?

Otherwise, this looks okay to me, although I'll leave things to
Krzysztof since he had a lot to say about the previous version.

Thanks,
Conor.

--sN8NPFS9+3FUypYE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0d0wAKCRB4tDGHoIJi
0mH7AQDBInAjsrZfZac0XzETGrZ+PttnYaYh09UYHDLHd39geQD9GnXkAmCktfbd
YjgvCATLL8jElmPIYkCiFurNDe/w1w8=
=Aesl
-----END PGP SIGNATURE-----

--sN8NPFS9+3FUypYE--
