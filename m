Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B4804AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376339AbjLEG6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjLEG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:57:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD09FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:58:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66ECC433C8;
        Tue,  5 Dec 2023 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701759481;
        bh=zU7bTrxdpBYUmSDNAlUUH1oAlR/IAxzg27ffUEN0aqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2nj7YexWsNxGq1DW0G+3ScWUIilUHilBq/5ctjgR9pfK+8AbSPMb5Z4AOxi1s4s6
         j7Qy6xxw9Epswxmbxh6NDRdPu8JKiTg4vB/JdcJ32GWgjPHOOWH7MI4xfqv3RAPWKI
         Gk9WocRqObcfOlG9R840rGCtyoXnhEqxSPAyBJOcegTZMARz32V8t7M1hvHpR5pqer
         dv42RHxrXnzHdvuNOYirCcLiJFswHZMlWgLFZvdIYCJi0OxiRKyaq+oH+lQTkxQEX0
         X2fDC6nUBL+CqpI0Hci+a+Jsr8Nw28iVqoLbdue2UHEbMrc5hXnSJkDwIsVr0mtt+T
         PRb2rNZzFUnEg==
Date:   Tue, 5 Dec 2023 07:57:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <23livt5mcc64bb6lkeec2uxp5cyn4wfekwaj6wzrjnrkndvwgj@6tveqglqpr4v>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3drixbas2c643fb"
Content-Disposition: inline
In-Reply-To: <20231204182245.33683-2-afd@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3drixbas2c643fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 12:22:36PM -0600, Andrew Davis wrote:
> The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs from
> multiple vendors. Describe how the SGX GPU is integrated in these SoC,
> including register space and interrupts. Clocks, reset, and power domain
> information is SoC specific.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr.yaml  | 69 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 6 deletions(-)

I think it would be best to have a separate file for this, img,sgx.yaml
maybe?

Maxime


--y3drixbas2c643fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW7J9gAKCRDj7w1vZxhR
xeU2AP9mvBxXe/cJsKPcYEfxWRhpvRor2SswHRWF6NJUuqagJgEAibpTgY0sHnsx
bw4+3yY5CjgxLG+iw0A7d3xv1r1ZJwI=
=8RNH
-----END PGP SIGNATURE-----

--y3drixbas2c643fb--
