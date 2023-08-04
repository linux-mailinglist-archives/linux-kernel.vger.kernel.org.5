Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013117704B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHDP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjHDP3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CC55A8;
        Fri,  4 Aug 2023 08:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA7B56207B;
        Fri,  4 Aug 2023 15:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E616C433CC;
        Fri,  4 Aug 2023 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162912;
        bh=56zoPeM/CV8ihxlnw5WYA8d04D9FlMkTeWO4Tsa8NqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrgCRcnaZajvRqDBsuL2DRhZQ4Qb/xMJjIgluxRWXeW4Zf7Yixf2tRDJXBRNweKZ1
         QlOAvCLPMlpuATurkOyOdTpUxsK5KrrJFdLji93N6B+H8OJugV7Kjqv52z8/oFvOkJ
         MUJAW5HysFgFOyfHqtjGXNptDxWpQa/01+lSmQSeZlTqbYkDRQi4SlZLsC3K1ly8Ja
         mb7wr1pI3XtZR/98pCVPrJroOG92sCnKsHLnP51N3IXriHe1LpRbVk9W+u7sEk+qFG
         Nh4wM2qnd4WackmUgbvVVbTknyDqDBo7NTsQqkvvpXyN1qCot2SFoA7CYNp8mFlk+8
         dcxw7IAMGx5Bw==
Date:   Fri, 4 Aug 2023 16:28:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Adding support for Microchip MCP3564 ADC family
Message-ID: <20230804-doze-confining-edf4f50d736d@spud>
References: <20230804142820.89593-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="69mBrM4Ph1nZWzIB"
Content-Disposition: inline
In-Reply-To: <20230804142820.89593-1-marius.cristea@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69mBrM4Ph1nZWzIB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 05:28:18PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> Adding support for Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface. This driver covers the following =
part
> numbers:
>  - MCP3561, MCP3562, MCP3564, MCP3561R, MCP3562R, MCP3564R,
>  - MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R and MCP3464R.
>=20
> Differences related to previous patch:
> v3:
> - fix review comments:
>   - fix and update the device tree bindings
>   - enable "auto_zeroing_ref_enable" attribute only
>     when internal reference is used
>   - remove unused headers
>   - fix comments (kernel-docs)
>   - remove scan_type
>   - replace "extend_name" with read_label
>   - print label for each channel (label could be added into the dt)
>   - add comment to explain the maximum channels numbers
>   - add protection around critical region

>   - fallback compatible in device tree to deal with some newer part number

The compatibles are all still in an enum in the binding with no
fallbacks. Did you forget to commit this?

Thanks,
Conor.

>  =20
> - Open questions:
>   - whether or not to add a spi-mux type of thing to deal with the part n=
umber
>     address in case there are multiple devices connected to the same chip
>     select.
>   - discussion related to the "custom property". Last time around a conse=
nsus
>     wasn't reached.=20

--69mBrM4Ph1nZWzIB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0ZHAAKCRB4tDGHoIJi
0mUTAP46a8eRFu3rukoDmNmwgNsOmobBPRGPtSnMPkJ2r8SheAD/W9l5IqLR9bCU
8r04SbrY9ic7HyKnNjjRj6HQTQXQfwc=
=sF9v
-----END PGP SIGNATURE-----

--69mBrM4Ph1nZWzIB--
