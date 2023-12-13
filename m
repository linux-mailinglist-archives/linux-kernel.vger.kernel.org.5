Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9FD81172A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442283AbjLMPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442357AbjLMPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:34:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D61BD6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:33:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39377C433C8;
        Wed, 13 Dec 2023 15:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481586;
        bh=d7g/An6tj1meavK9KfeQnpMkp+2FDg23+65lC9a5QiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkYwO/fjoLD2gAZ2b3rLdvfKUYBIUfIj0u7GtXIEpv9XnMn/eeS09zwJH73Qc+vd0
         ZnrhcnsBekydmjRl67nJ8Yi0w69hKYTJlrd5WSUmCWw68ELifwovjCrXCpYk0c8U04
         xgLXYkjm1UzJjA9btEyrnq22OBEi2Mr4Qc7V4FgZUzdtAuA7XpzOH7Ia8uiGC2l/eH
         QJT8nEkg8Aj1rWg5w7LI4onIlYBeBOgQUS+vcNc7qlj7s83jCmIrZ88U9Snp0nZ7d3
         nu/NxI8zjYEN1IL/aA/2cI4dLkdg9FYwFXevnOvJKgJZu5HaAZBEPTii5XaJg7Mt9g
         5dlxyInpwqBKw==
Date:   Wed, 13 Dec 2023 15:32:54 +0000
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
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v5 07/16] RISC-V: Move T-Head PMU to CPU feature
 alternative framework
Message-ID: <20231213-embattled-makeshift-914c2dc0d678@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-8-peterlin@andestech.com>
 <20231213-prewar-poison-f2781b4a6e84@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SNv4aXwN7leT+bpI"
Content-Disposition: inline
In-Reply-To: <20231213-prewar-poison-f2781b4a6e84@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SNv4aXwN7leT+bpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:27:25PM +0000, Conor Dooley wrote:
> On Wed, Dec 13, 2023 at 03:02:52PM +0800, Yu Chien Peter Lin wrote:
> > The custom PMU extension aims to support perf event sampling prior
> > to the ratification of Sscofpmf. Instead of diverting the bits and
> > register reserved for future standard, a set of custom registers is
> > added.  Hence, we may consider it as a CPU feature rather than an
> > erratum.
> >=20
> > T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> > for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> > for proper functioning as of this commit.
> >=20
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I think it is also worth mentioning that the only SoC, to my knowledge,
that works with a mainline kernel, and supports the SBI PMU is the D1,
and only recently has the OpenSBI port for the SoC been fixed to
actually work correctly, and that has apparently not yet made it to
a release of OpenSBI, making the "damage" caused by requiring a DT
property for PMU support not all that bad since the firmware needs to be
changed anyway.

Thanks for your work on this,
Conor.

--SNv4aXwN7leT+bpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnOpgAKCRB4tDGHoIJi
0vFSAP4vVxuYhNOszazQh5QRosrPv3AJ+es7VDyK7fJJn7PemAEA00lcLHa8pVPg
zVv6tom5ELmLTpytrjK7gWjeiOgWggI=
=DW10
-----END PGP SIGNATURE-----

--SNv4aXwN7leT+bpI--
