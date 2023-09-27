Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECC7AFF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjI0I4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjI0I4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881CA3;
        Wed, 27 Sep 2023 01:56:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52132C433C7;
        Wed, 27 Sep 2023 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695805005;
        bh=Cao/bocpgqpFeJIKvW5opyJ4/rHkM9Gq7550IJgQQDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe6KTU7Sn8Hs0MapzvaEx7O/dKZhmloYikn5MDNsYhg/AbGi8CTbhVwZZZ/yV63TW
         NrJlCYAghT2nraItdlDQmhX/ERO/CfbOZE/aV1/fLY6QSvjprJ/7u9gKHHYRXAgliH
         inT6TzQzp1Gn1lFvUWMhqgM5FDzs3tsSOmLzXMHH0EsztxOsW36EGbeajGwKKU6vXQ
         rEP/i7/ACILKb0kmxJoWRyQt85wfUgXgaoT9OebJqq/h+sCXUzqyRNKbHB6HQ5/34i
         T6b9CEhgpMOZUlNJMC9+zyKjsTej6d0XbEcoS36VI12Lbk+H/wKPCK37tDXdzU5AEt
         hkDIHF7mctJ0Q==
Date:   Wed, 27 Sep 2023 10:56:42 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Message-ID: <ZRPuSidGd5zO6pXf@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NweErwwnK6vf4dVT"
Content-Disposition: inline
In-Reply-To: <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NweErwwnK6vf4dVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 10:08:17PM +0100, Fabrizio Castro wrote:
> The CSI IP found inside the Renesas RZ/V2M SoC can also work
> in SPI slave mode.
> When working in slave mode, the IP can make use of the SS
> (Slave Select) pin, with "low" as default active level.
> The active level of SS can be changed to "high" upon configuration.
> This patch adds two new properties, one to make use of the
> SS pin when in slave mode, and one to make the SS pin active high.

Please avoid the use of outdated terminology like this, prefer "device
mode" or similar.

> +  renesas,csi-ss:
> +    type: boolean
> +    description:
> +      Use CSI Slave Selection (SS) pin to enable transmission and reception when
> +      in slave mode.

When would this ever not be true when in device mode?

--NweErwwnK6vf4dVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT7kkACgkQJNaLcl1U
h9AMqgf/ZuFxoWKxQxzkjvFfE0DOLwBfbcS17S+hLEbttlrCE5+4EBd224qBeKYQ
iRQpyNVbPXfCJesuwKzplzK1EMJ3bmgtf2JksGIEwxchjCPEcAB3MakWimJyRfeN
CunfmZ6US/62Xg+X8ZTO2F9IYpwfxK2xcT2bwuF1iDNMaYuuH0ohYN8TyRJ1P/d6
2mrkBs367ZBYilYKWICHV3HxBy8HlkAqGG8v5HdoUd5CrJVCyUpuW9NVTbNerSru
XQhvx3DVdPzpBKDv+d7XPsAGD4UhbBBsUKyUsV8l15wgqBy/bzscRM5Qx6nhW4qA
2Ni1w+aITJRQnwtge9UPpruggz0cQA==
=aQdy
-----END PGP SIGNATURE-----

--NweErwwnK6vf4dVT--
