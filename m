Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFC7EB5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjKNRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:40:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005CFF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8121AC433C8;
        Tue, 14 Nov 2023 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699983624;
        bh=z9PwBTSGVM1q27ATk+TMybFpQRzzSFtVdprhH4R8Ytk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPq+NIIdBj7YLws2oaM2krjeCUtZ8V97BQueGz5nDfeAhkmKi1uaZYlzsRhy5NHZi
         7bqwW0XHxgaJpVaRgO6JMzf9dKNS2PupqbmwnOHIEPs5MMedPu1wGSSO2w1e4fWRQ8
         tPQLX3t8fs2p+Te3m95wj0suqTypCdHLGWW4/x8ftNwXylBPvc/zXsmwF3vXFvA8Uy
         4BGyuCgWCPfUYDTk1TJ/e2eu+rjkZqcNFcdlILrzE/nWc3b2Ozrs2m75OG51ZbBapX
         5j7bpSe/UuErrJ7VwU+PfylJT8w2bJhqMbHbEJR1g8nbyUiH+rzjjiupwRF79scyVe
         jHCZj+Y4QXARQ==
Date:   Tue, 14 Nov 2023 17:40:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 2/5] dt-bindings: soc: sophgo: Add Sophgo syscon module
Message-ID: <20231114-timid-habitat-a06e52e59c9c@squawk>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
 <3c286171af30101b88f0aaf645fb0a7d5880ac0a.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7x2SPF0LZcIrRSv8"
Content-Disposition: inline
In-Reply-To: <3c286171af30101b88f0aaf645fb0a7d5880ac0a.1699879741.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7x2SPF0LZcIrRSv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 09:19:02PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add documentation to describe Sophgo System Controller Registers for
> SG2042.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../soc/sophgo/sophgo,sg2042-syscon.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,s=
g2042-syscon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-s=
yscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sys=
con.yaml
> new file mode 100644
> index 000000000000..829abede4fd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.y=
aml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 SoC system controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description:
> +  The Sophgo SG2042 SoC system controller provides register information =
such
> +  as offset, mask and shift to configure related modules.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-syscon
> +          - const: syscon

THere's only one option here, so the oneOf should be removed. Similarly,
since there's only one SoC, and it sounds like the next large sophgo
system is going to be using an entirely different core provider, I think
should just simplify this to a pair of "const:" entries.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@30010000 {
> +        compatible =3D "sophgo,sg2042-syscon", "syscon";
> +        reg =3D <0x30010000 0x1000>;
> +    };

Per my comments elsewhere, I think the clock controller should be a
child of this node, rather than an unrelated node, linked by a phandle.

Cheers,
Conor.

--7x2SPF0LZcIrRSv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOxAAAKCRB4tDGHoIJi
0iTVAP4xqsqRPb18xDpU2gdHBpqavoQRucplJdovfCUwjpJR5gD/cxDZbzW9yvV+
GQOC1Uef/4CbdqURfao9Zf5pzfrisgo=
=lwGH
-----END PGP SIGNATURE-----

--7x2SPF0LZcIrRSv8--
