Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D957F7D360B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjJWMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjJWMEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54476E8;
        Mon, 23 Oct 2023 05:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42501C433C8;
        Mon, 23 Oct 2023 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698062644;
        bh=n/SYhgOy7PYoOMa/qRT/xqvF+V6QNHFqWYg+hu0aDj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MY2dbfASZER6tuIdGGsFhjcDL09IA9tXH1K2hRODqDJmoBwN1y9Pn+s7KPAjTz4yb
         9JPo8v456haLAbc55KVPK4k05l3EDrlzlGgCg7itvHppqavF+wM3J5IreBTFzbhIfB
         kLQ24DWYhW6tANl7QVCqPNxPNSeWuykvVc7skyKlqMhb6XeBov4DJsAUrTf0Zkyszr
         MzoffD2wL1QGU5T/xqwnIIQzr0YFM0MC/Nh0v2A2Bu5EYeYXfKE6DHwygsEIlmRIyw
         AequAVKeZ4TbiC3hjQRz+JPCvpgJpmIy7hm8buNLxBNK59ViC3AYScv2oHmO7kX0eE
         YXqYt+lr/L2RQ==
Date:   Mon, 23 Oct 2023 13:03:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com
Subject: Re: [PATCH v3 RESEND 10/13] dt-bindings: riscv: Add Andes PMU
 extension description
Message-ID: <20231023-spectacle-module-0516fb35995a@spud>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-11-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P1S9GHX9rhzdHs0r"
Content-Disposition: inline
In-Reply-To: <20231023004100.2663486-11-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P1S9GHX9rhzdHs0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 08:40:57AM +0800, Yu Chien Peter Lin wrote:
> Document the ISA string for Andes Technology performance monitor
> extension which provides counter overflow interrupt and mode
> filtering mechanisms.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v2 -> v3:
>   - New patch
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 5e9291d258d5..e0694e2adbc2 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -246,6 +246,13 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
> =20
> +        - const: xandespmu
> +          description:
> +            The Andes Technology performance monitor extension for count=
er overflow
> +            and privilege mode filtering. For more details, see Counter =
Related
> +            Registers in the AX45MP datasheet.
> +            https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf

Does/will this PMU function identically on the other CPUs that support it?
I assume the answer is yes.

Cheers,
Conor.

> +
>          - const: xtheadpmu
>            description:
>              The T-Head performance monitor extension for counter overflo=
w. For more
> --=20
> 2.34.1
>=20

--P1S9GHX9rhzdHs0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTZhKQAKCRB4tDGHoIJi
0q2MAP0VirheuKpWgXrPAEWaqZ66m6sp12MVuSOdCvU0US0f/AEA2BobNxX5Jk4Y
UqRJn9N7kWZtJAvcqBjJPvvs15wdpgc=
=/DQg
-----END PGP SIGNATURE-----

--P1S9GHX9rhzdHs0r--
