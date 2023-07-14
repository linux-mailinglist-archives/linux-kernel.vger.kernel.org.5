Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD32753A32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjGNLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjGNLwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8FA30CB;
        Fri, 14 Jul 2023 04:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3BE61C01;
        Fri, 14 Jul 2023 11:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A81EC433C8;
        Fri, 14 Jul 2023 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689335530;
        bh=DmeN79exEsvAJkYJDMMvtjBsg+ueHrWKD/Uu8Yhd95s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFgr2mIbpn5LNqHS9h3NzsCoyBKi3V2KXEm12VaSFzsIAt/Ou+NJQaiJDjs5qJGNj
         qD3XdXf3qAflXE6sVsXlVfbCVQoJf2N/fMyyM3oKy5EVlC9+bMcMnEVUcsJYelbk0R
         TcDR3gTCvxKdaC4oeXurBvlb3DCosJKfgSSW0M6vyJNO+9ZAVCPxStVKFHpnGLumJG
         JdaVa4AVGlF8AXCs1TjqoJOGbeDmfTjEKPw6/Vod1glWLKb13LWtxAlLP09uWoJ+Rn
         Dtj7SAvA0tJq9OFY6FX7xexEI+g0gKFLh4PirN/RNhi765CFK223rdSxLo8B1g1NOG
         PRVe4do9xGLHw==
Date:   Fri, 14 Jul 2023 12:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks
 and clock-names
Message-ID: <9891a7e3-0fce-4d05-8ead-3c0ed155d725@sirena.org.uk>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
 <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
 <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
 <20230713145724.GA3975811-robh@kernel.org>
 <df9de3d8-09da-2b80-b2b4-626cd92fe971@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="klm57L7u8qYMNEjf"
Content-Disposition: inline
In-Reply-To: <df9de3d8-09da-2b80-b2b4-626cd92fe971@starfivetech.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--klm57L7u8qYMNEjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 03:14:59PM +0800, William Qiu wrote:
> On 2023/7/13 22:57, Rob Herring wrote:

> > I suspect that PCLK and SSPCLK are tied to the same clock source. There=
=20
> > must be an SSPCLK because that is the one used to clock the SPI bus and=
=20
> > we need to know the frequency of it.

> After communicating with colleagues in SoC FE, I learned that PCLK and
> SSPCLK were homologous on JH7110. He said that SSPCLK would divide the
> frequency internally anyway, and there was no need for external part freq=
uency,
> so he directly gave them together.

> So, should I call this clock ssp_apb or keep it SSPCLK?

I'd expect this to be handled in the DTS for the SoC - connect both
clocks the binding requires to whatever the upstream clock is, it's not
clear to me that any binding change is required.

--klm57L7u8qYMNEjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxNuQACgkQJNaLcl1U
h9BFZgf9HdG+QzvFSo2OFGvw81HEFNCptH1B6hNOBEplLpmTioP2hTn7SE22nAoP
M8yy78/dMrerUMSs8l8nTWX2MvtyEhMPWrYi3vUyQhzDz1vPAj2ao4V/5zBD2P/s
xQ00phl+51kJqZ+YX5WXydz9G5EP+usoFq2i2R9ZNPgCm9Y9txRr3+CVOXQOBixW
dOFZYO+/6jfEoEOZyL1Ine5ggi4tD5Q9Q8zLMhS47XKv3me71twVFVxatUate6Cu
gg8tpmFVCiR63fSnrgbRunZjF7R2Ogfg3M7Pg5AUSiJjbMMPAnTKcZrIRM9q11sg
hZ+IpYQkDLUbk5g9cJlhw+cy1Y2egw==
=1P4J
-----END PGP SIGNATURE-----

--klm57L7u8qYMNEjf--
