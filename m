Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C27FF16C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjK3OMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjK3OMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:12:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33C83
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:12:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9BAC433C9;
        Thu, 30 Nov 2023 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353546;
        bh=gnUxeKkoID9HtlwW7Bg+QT2RRbfa1Ffvooe93e+UvN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ms/Q+xg49iz1B7x1hT2OXYdQMt1Occ5j/fGR3h2INhjZM8Q9ba6+E7lU9G0JngoE+
         0WYiedeYXw08nLTHotnSZsv0QgTUtiT/YunvuIT2Ge55jBH6rK4bwYDMjrWoQ9nTGr
         tniF7KSlDuYQoCTiPMaq/lO+3F5e6FAQd2vrULac5jL5KS40TIwal0NBk+ARa5Ef3f
         +OOvkYIRGkzJ3GQdZUgPXLECq4m/WRbMcf98pPkQ7xXhxe96FGpfkllAN+5LHtFM/O
         9Y1L3nAXfx9vRHvVtaicUNvsXloaotFqOK2g6X6a3GFKGhFoCDRkJN54SRx3e/1n+R
         rhIh8cqjZ00rQ==
Date:   Thu, 30 Nov 2023 14:12:22 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v1 0/8] Add JH7100 errata and update device tree
Message-ID: <20231130-skating-shindig-af43058fc8ff@spud>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DIxgQWGILN1gqhN/"
Content-Disposition: inline
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIxgQWGILN1gqhN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:27:38AM +0100, Emil Renner Berthing wrote:
> Now that the driver for the SiFive cache controller supports manual
> flushing as non-standard cache operations[1] we can add an errata option
> for the StarFive JH7100 SoC and update the device tree with the cache
> controller, dedicated DMA pool and add MMC nodes for the SD-card and
> wifi.
>=20
> This series needs the following commit in [1] to work properly:
>=20
> 0d5701dc9cd6 ("soc: sifive: ccache: Add StarFive JH7100 support")
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/=
?h=3Driscv-soc-for-next

This stuff all seems fine to me. I'd like Palmer to take the first
patch, or I suppose I could take it alongside the cache driver changes
with an Ack.

Cheers,
Conor.

--DIxgQWGILN1gqhN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWiYRgAKCRB4tDGHoIJi
0j8DAQDhNWz+Dtv1MXNYLXnGGEpGqioe4VQcppSkxqT4jBRYyAEAzIavc2EF5QSx
Bp/TCSMaIs3yVz+KCTjKK4eFvPO8igA=
=0AEX
-----END PGP SIGNATURE-----

--DIxgQWGILN1gqhN/--
