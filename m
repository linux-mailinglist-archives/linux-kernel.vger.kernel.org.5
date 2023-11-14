Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6E7EB5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjKNR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:57:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B194
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:57:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB3C433C7;
        Tue, 14 Nov 2023 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699984638;
        bh=TA5MITJHC2T13fQnufVaK7/sIlajF1q5F1aF0YWeztQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+symr6MkA9aQtcw1bYamXK14WvN66KoLpemZUMdLpN8Qbn0Gd4LmHGlxICWnnK+I
         bLQSlMekeZ6g3DRpfnA5Cia2b0XOaEbBldtmYQ/3FY/F0rrGNEXKZZmePsxa7iZKVl
         oM81pFh3xQR35RdndIs+oxCDXQSopGzNfvf9oTOeqZ2bIGE856FGsoyVkToG+hdDc0
         e4HUi80KaAVnP5D5umNzo8s6fbiH7U/87nR9gpRv1e9UZ9q2IBs5QMkQJ7uFOnzHEe
         2V2gGdA9aW7NOqCvI6yX6qnThXGPCf7GizmMno6zzg54i1sFfRwMx39VjZNCcwWDBr
         21VwijL1bAl0Q==
Date:   Tue, 14 Nov 2023 17:57:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: perf: starfive: Add StarLink PMU
Message-ID: <20231114-policy-routing-8df2607e76cf@squawk>
References: <20231114021254.3009799-1-jisheng.teoh@starfivetech.com>
 <20231114021254.3009799-3-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GVUN6CsEXv0BSbNb"
Content-Disposition: inline
In-Reply-To: <20231114021254.3009799-3-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GVUN6CsEXv0BSbNb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 10:12:54AM +0800, Ji Sheng Teoh wrote:
> Add device tree binding for StarFive's StarLink PMU (Performance
> Monitor Unit).
>=20
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
>  .../bindings/perf/starfive,starlink-pmu.yaml  | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/starfive,starl=
ink-pmu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/perf/starfive,starlink-pmu=
=2Eyaml b/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> new file mode 100644
> index 000000000000..b164f6849055
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/starfive,starlink-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive StarLink PMU
> +
> +maintainers:
> +  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> +
> +description:
> +  StarFive's StarLink PMU integrates one or more CPU cores with a shared=
 L3
> +  memory system. The PMU support overflow interrupt, up to 16 programmab=
le
> +  64bit event counters, and an independent 64bit cycle counter.
> +  StarLink PMU is accessed via MMIO.
> +
> +properties:
> +  compatible:
> +    const: starfive,starlink-pmu

This compatible (in isolation) is far too generic. Please add a device
specific compatible for the device that has this PMU.

Thanks,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        l3_pmu: pmu@12900000 {
> +            compatible =3D "starfive,starlink-pmu";
> +            reg =3D <0x0 0x12900000 0x0 0x10000>;
> +            interrupts =3D <34>;
> +        };
> +    };
> --=20
> 2.25.1
>=20

--GVUN6CsEXv0BSbNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVO09wAKCRB4tDGHoIJi
0oKyAQDMGNLblbWwPrbf2IDZPlUbqUp3cf3FJJlST27PCfSlPAD3fxa4mjKlBXxF
rBGin84XnMj9T1tFSy1yt3KRXzJsCA==
=5OaB
-----END PGP SIGNATURE-----

--GVUN6CsEXv0BSbNb--
