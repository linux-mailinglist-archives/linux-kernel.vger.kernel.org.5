Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BE8116EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442045AbjLMPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442184AbjLMPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:31:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBE358B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:27:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF6CC433C7;
        Wed, 13 Dec 2023 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481256;
        bh=GwC9beP1ZtHS6nJCGyO7jEKsu1mwjiMJgVNMTsy1Ks0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pB1wmD1H5k4eUMa3eMWOpaiXH2CEzZbEGWVtAw8BWDZslmG4E31qLvtQ+Aj9fAgaN
         Em8i13DUbC/Y5UiOVi8WMmEHynRSF6uKag1V0bVdlB1c4em9HW4rPtnqmt8W0UaGu1
         rGFLFLK/BDA4PGAxkH9ZDy32YKiRy6b8adWSXZeYofHoXYylvDiEEnXu7w9cDf4r/r
         Rsq6ZvDWbV+KmsTgI4SQrsDHQo0vqvDyrP067y19dWebJEacztjqjFxLPfBKJaRylL
         wuWOpmsNLO78Tg2rWtZfGB003DrP9+6xTmdwC5O2Nj9OT5qX897/VEogfhdLgMRB5d
         ol3p8E8sQOW6A==
Date:   Wed, 13 Dec 2023 15:27:25 +0000
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
Message-ID: <20231213-prewar-poison-f2781b4a6e84@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-8-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6EDO+odeQnJiNPoS"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-8-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6EDO+odeQnJiNPoS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:02:52PM +0800, Yu Chien Peter Lin wrote:
> The custom PMU extension aims to support perf event sampling prior
> to the ratification of Sscofpmf. Instead of diverting the bits and
> register reserved for future standard, a set of custom registers is
> added.  Hence, we may consider it as a CPU feature rather than an
> erratum.
>=20
> T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
> for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
> for proper functioning as of this commit.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--6EDO+odeQnJiNPoS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnNXQAKCRB4tDGHoIJi
0owVAQCDfvO17i3JMSLu4ZZtfXLzMJWq4FB1/1qravLNyzJJvgEAi3b0Zqg0JhQ4
v8v858Iyqz0gSua8loF9qO9ppCpUpgQ=
=cK86
-----END PGP SIGNATURE-----

--6EDO+odeQnJiNPoS--
