Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830717ED19E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjKOUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbjKOUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:04:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8CAF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:03:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8DAC433C8;
        Wed, 15 Nov 2023 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700078636;
        bh=9gA1SSlMEsWjuei3UKMYBTh6Esefr+kPZMNw658qCGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZ96er5fDI3Hrb3A0NBZbCcphakUE0V2O2qg43+oZzgiIa190iQWAygYvFtYt1QC8
         sbjYuVb1iQRPw669JELGD3SJzo6klfKnjGTpDcgPowfMMfUD1jRn9b56m4RfFUHmrR
         J4dAnzVJqDmHxJSIU6f3tE7vagsHghIOw1iDi2Xjrfwd3AR5HHcKGeNYF/JyFJwiPr
         IzgmzR2FpqWPY4hOAMcumaCGcrPakgQS5MDiMs45aRGAWuvbx585BWY4diqDNPUMN6
         hcvimuhX3E6N2AO0g/RCBn2E5kFXlpCpI/oLs2pR6UedqeGyZ5DhULYrjcxZb0Blhp
         a/UTy5JDVGhEA==
Date:   Wed, 15 Nov 2023 20:03:53 +0000
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
Subject: Re: [PATCH v3 2/2] dt-bindings: perf: starfive: Add StarLink PMU
Message-ID: <20231115-landing-earflap-ed11982ac610@squawk>
References: <20231115033608.1597807-1-jisheng.teoh@starfivetech.com>
 <20231115033608.1597807-3-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HD0SkcLTdpU4AA/8"
Content-Disposition: inline
In-Reply-To: <20231115033608.1597807-3-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HD0SkcLTdpU4AA/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Nov 15, 2023 at 11:36:08AM +0800, Ji Sheng Teoh wrote:
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
> index 000000000000..a9426a7faeae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/starfive,starlink-pmu.yaml

btw, since you changed the compatible, the filename should have been
changed to match it.

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
> +    const: starfive,starlink-500-pmu

So this is not what I had in mind by a "device". I was looking for a
compatible representing an soc in which this IP had been integrated.
A soc-specific compatible, rather than something generic, is requirement
for devicetree - we don't want various integrations of this IP to all be
using a generic compatible when there may be subtle (or less subtle)
differences between integrations.

I'm trying to come up with the syntax for enforcing having two
compatibles with your current one as the fallback, but I have yet to
come up with the correct syntax for that that works correctly.

Hopefully by the time you get some feedback on the driver side of this
submission I will have a concrete suggestion for what to do here.

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

This label here is never used and should be dropped.

Cheers.
Conor.

> +            compatible =3D "starfive,starlink-500-pmu";
> +            reg =3D <0x0 0x12900000 0x0 0x10000>;
> +            interrupts =3D <34>;
> +        };
> +    };
> --=20
> 2.25.1
>=20

--HD0SkcLTdpU4AA/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVUkJQAKCRB4tDGHoIJi
0n3NAQD0knou/atomQF2Z85HnmH/aE8gajj97pHsdl855DMM9AEAv0JCQx/Icnxb
sWr3jQAML5n6hsxtgPM9lOA5D8h1NQQ=
=Cv0H
-----END PGP SIGNATURE-----

--HD0SkcLTdpU4AA/8--
