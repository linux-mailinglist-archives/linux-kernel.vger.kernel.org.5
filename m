Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9207CFC84
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjJSO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjJSO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:28:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B977181
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:28:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1DBC433C8;
        Thu, 19 Oct 2023 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697725727;
        bh=vrmCvzbkkBVSxXWM3SZHEqQqXmxnifCIGVOhub0zocA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSoIP1BvdZ+4pK32XX6bDu52py28olAPlSy2C1zHeWXO/zpTECaHzWH4A/NX9Mh15
         b1I7Z/k+aDZkHCHgp63m1dL7cbiFWjeD6omFbo7dV7Knf2jUfAnmVapMPJKnHS2Vva
         KEervM3AFGoVRIuAprZH1N5DApVKDRSgZZuVQ/GBomFTl6QMuRSDimtsm8UcVk1KYs
         iDcIIZ5yFZnFYH3HBJTPaoJfjuaOSK9v+bFT38ay4vLJdfvV5vi7EB0NHygZNDSYtU
         R3tR4CumlrVQ9Z7ciMMcEym65Rs8iwuydm4cVM2eJhVeq4syldPJ7I9KfNUpHJjsPz
         BKqP6zhWLyrVQ==
Date:   Thu, 19 Oct 2023 15:28:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     thomas.delev@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v2 0/2] w1: Add AXI 1-wire host driver for AMD
 programmable logic IP core
Message-ID: <20231019-dilation-monogamy-580b3be46638@spud>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231019142526.10592-1-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MgQN09eSoyCijghA"
Content-Disposition: inline
In-Reply-To: <20231019142526.10592-1-kris.chaplin@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MgQN09eSoyCijghA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 07:24:16AM -0700, Kris Chaplin wrote:
> Changes since v1:
>  Updated IP name and binding to axi-1wire-host and filenames to match
>  Comment pruning where operation obvious, additional comments where not
>  Unwrapped helper functions for register read/writes
>  Removed un-necessary device reset on fail to add device
>  Fixed duplicate clock disable in remove function
>  Move bus master structure to per instance
>  Improved hardware testing with multiple w1 instances
>=20
> Add a host driver to support the AMD 1-Wire programmable logic IP block.
> This block guarantees protocol timing for driving off-board devices such =
as thermal sensors, proms, etc.

btw, please do not send a vN as a response to the v(N-1) patchset. It
ends up hiding things in the depths of people's mailboxes that sort by
threads.

Cheers,
Conor.

>=20
> Kris Chaplin (2):
>   dt-bindings: w1: Add YAML DT schema for AMD AXI w1 host and
>     MAINTAINERS entry
>   w1: Add AXI 1-wire host driver for AMD programmable logic IP core
>=20
>  .../bindings/w1/amd,axi-1wire-host.yaml       |  44 ++
>  MAINTAINERS                                   |   8 +
>  drivers/w1/masters/Kconfig                    |  11 +
>  drivers/w1/masters/Makefile                   |   1 +
>  drivers/w1/masters/amd_axi_w1.c               | 395 ++++++++++++++++++
>  5 files changed, 459 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-ho=
st.yaml
>  create mode 100644 drivers/w1/masters/amd_axi_w1.c
>=20
> --=20
> 2.42.GIT
>=20

--MgQN09eSoyCijghA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTE9GwAKCRB4tDGHoIJi
0r3oAP4/hAJWtFGlfZ1oFX0R/zBl4H3FGxM0AOyERrzTlQgmvAD/amRWRevk1fWr
jByhe3brBXKMb/OxEUO+GZe+PFmoiQQ=
=8IRd
-----END PGP SIGNATURE-----

--MgQN09eSoyCijghA--
