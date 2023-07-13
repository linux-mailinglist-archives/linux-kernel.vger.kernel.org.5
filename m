Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E75752429
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGMNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGMNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F911FD6;
        Thu, 13 Jul 2023 06:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253786153D;
        Thu, 13 Jul 2023 13:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EBEC433C8;
        Thu, 13 Jul 2023 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256108;
        bh=aVFkOdZiMIHWVq2IMmFdy8HY77pkeHTrC64KlWEXfQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW+LnXsT5S4/XdZXg2Un2kQeTTXap5cG0rVSxTcMqCwnkZ0VH8wOYZviKW3+Pw+dG
         GhtNrnE6pF7HU9UMRkgLvopDXWUio5yGWcLNuswitR9UtV0gLLm6fO476wfyzWhljU
         npDfKMQI4bRV8cmJAxvIUSCgsBCCKQMWiOGBHTWDxtk4M3taVPmmDVbV0KtK5dwP3l
         6tFJ30y5QT/TC/UYTn/fFWAyYoSKwudLuYkP26lFQrARkZvKVk9medyApVYoObHSBD
         fokyi0gTpieaRBqWTl77Uqq1ULCOjWl0SKnWtdZ7aZRENhGDj/+bLwYAhnmVk1wX27
         FroSouUHpSbWA==
Date:   Thu, 13 Jul 2023 14:48:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks
 and clock-names
Message-ID: <5ef17d53-460c-4281-a241-1622a24bac5b@sirena.org.uk>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
 <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
 <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dpyDkCLVucMmtixK"
Content-Disposition: inline
In-Reply-To: <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dpyDkCLVucMmtixK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 02:39:19PM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 14:28, Mark Brown wrote:
> > On Thu, Jul 13, 2023 at 05:00:14PM +0800, William Qiu wrote:

> >> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
> >> so there add minItems whose value is equal to 1. Other platforms do not
> >> have this constraint.

> > Presumably this means that this is some variant of the usual pl022 IP,

> Hm, in such case this could mean we need dedicated compatible.

Yes, indeed.

--dpyDkCLVucMmtixK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwAKYACgkQJNaLcl1U
h9BpEgf9EY0uJQAMe4MnptnRo7jvpMoIHgFT017s7FDsYZ5NJtmMdV+t/R0nQUg/
gVRSsP2/f4GMNQokTmIV0RlLIQMBS7CrTlds5WQ31ok7G9fdsTEv/n5BWikmbCuH
nFlnrUws6Ag7LUsFR0rFdL/uq/zbFOAMzykz5YLuEXVpdSb9OoPJQOrEBQk6asui
bmhE12NziQo0hSVP1pLaUxOz8RLw6PqJUBHp8QFQ+5N7dXgtp6ALRHEWftboRZiX
+RFT/oUiscAXFtGDobmLvCHkPSCbLflxkaXuYUSdZP9AStWND38s9uFV6OE9O2hZ
U1BGVb2xUcGVvWdal9BSvSnAHxYS4w==
=sgri
-----END PGP SIGNATURE-----

--dpyDkCLVucMmtixK--
