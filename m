Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C0800063
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjLAAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377465AbjLAAkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:40:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D944110C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:40:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE544C433C7;
        Fri,  1 Dec 2023 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701391214;
        bh=Bwi6rHBnTF4XvJJlKCsW+lAw3yuN1E/2bSWXjFUXBlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJWxdQjHwFwzN3MDNBVDR9RVIKZHH+ZYWbc+bsJ3IEuZxNsvfUAdPFaMh8SqqcEpe
         pGBa87uCh0j+Lv/eilOH/rMkvTe69hfhziRTHvL47PeiWR+/WFBiNvdN35yA7RHo6a
         eSto+KrCfTk37oNICO5zL0io4r/qCny2XTAgIqgrcXiovqvj7O25sK0Hg/xMFxuIFx
         94ZnLTXkFr3gYPVwFqJcYHNqqmcy4HtjQmHdCDtBpj48WK/YpokXA2x9ctnUeVqYTl
         ULUC/rQPetIL8xAghf3/VmAmfbSnztqMRVIpwaLCgwVYEc4F5LLhfYONb6qoTk/nHX
         7MagA3g4gefBg==
Date:   Fri, 1 Dec 2023 00:40:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Yu-Chien Peter Lin <peterlin@andestech.com>,
        Guo Ren <guoren@kernel.org>, acme@kernel.org,
        adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, heiko@sntech.de,
        irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
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
Subject: Re: [PATCH v4 09/13] dt-bindings: riscv: Add T-Head PMU extension
 description
Message-ID: <20231201-hatchback-lustily-a516298c3556@spud>
References: <20231130-isotope-runaround-9afb98579734@spud>
 <IA1PR20MB495378652B09B37E92D8BB04BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aS5JTpy0ABLKb+d2"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495378652B09B37E92D8BB04BB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aS5JTpy0ABLKb+d2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 07:11:31AM +0800, Inochi Amaoto wrote:
> >
> >On Thu, Nov 30, 2023 at 08:16:38PM +0800, Inochi Amaoto wrote:
> >>>
> >>> Hi Inochi,
> >>>
> >>> On Thu, Nov 30, 2023 at 04:29:22PM +0800, Inochi Amaoto wrote:
> >>>>>
> >>>>> Hi Guo Ren,
> >>>>>
> >>>>> On Thu, Nov 23, 2023 at 05:14:30AM +0800, Guo Ren wrote:
> >>>>>> On Wed, Nov 22, 2023 at 8:17=E2=80=AFPM Yu Chien Peter Lin
> >>>>>> <peterlin@andestech.com> wrote:
> >>>>>>>
> >>>>>>> Document the ISA string for T-Head performance monitor extension
> >>>>>>> which provides counter overflow interrupt mechanism.
> >>>>>>>
> >>>>>>> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> >>>>>>> ---
> >>>>>>> Changes v2 -> v3:
> >>>>>>>   - New patch
> >>>>>>> Changes v3 -> v4:
> >>>>>>>   - No change
> >>>>>>> ---
> >>>>>>>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++=
++
> >>>>>>>  1 file changed, 6 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.y=
aml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>>>>>> index c91ab0e46648..694efaea8fce 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>>>>>> @@ -258,5 +258,11 @@ properties:
> >>>>>>>              in commit 2e5236 ("Ztso is now ratified.") of the
> >>>>>>>              riscv-isa-manual.
> >>>>>>>
> >>>>>>> +        - const: xtheadpmu
> >>>>>>> +          description:
> >>>>>>> +            The T-Head performance monitor extension for counter=
 overflow. For more
> >>>>>>> +            details, see the chapter 12 in the Xuantie C906 user=
 manual.
> >>>>>>> +            https://github.com/T-head-Semi/openc906/tree/main/doc
> >>>>>>> +
> >>>>>>>  additionalProperties: true
> >>>>>>>  ...
> >>>>>>> --
> >>>>>>> 2.34.1
> >>>>>>>
> >>>>>> Reviewed-by: Guo Ren <guoren@kernel.org>
> >>>>>
> >>>>> Thanks for the review.
> >>>>> Would you share document about T-Head PMU?
> >>>>>
> >>>>
> >>>> Hi, Peter Lin:
> >>>>
> >>>> You can use the following two document to get all events:
> >>>> https://github.com/T-head-Semi/openc906/tree/main/doc
> >>>> https://github.com/T-head-Semi/openc910/tree/main/doc
> >>>>
> >>>> There are also some RTL code can describe these events:
> >>>> https://github.com/T-head-Semi/openc910/blob/e0c4ad8ec7f8c70f649d826=
ebd6c949086453272/C910_RTL_FACTORY/gen_rtl/pmu/rtl/ct_hpcp_top.v#L1123
> >>>> https://github.com/T-head-Semi/openc906/blob/af5614d72de7e5a4b8609c4=
27d2e20af1deb21c4/C906_RTL_FACTORY/gen_rtl/pmu/rtl/aq_hpcp_top.v#L543
> >>>>
> >>>> The perf events json can also be used as document, this is already
> >>>> applied (with more detailed explanation):
> >>>> https://lore.kernel.org/all/IA1PR20MB495325FCF603BAA841E29281BBBAA@I=
A1PR20MB4953.namprd20.prod.outlook.com/
> >>>
> >>> Thanks for reaching out!
> >>> The updated description will be:
> >>>
> >>> - const: xtheadpmu
> >>>  description:
> >>>    The T-Head performance monitor extension for counter overflow, as =
ratified
> >>>    in commit bd9206 ("Initial commit") of Xuantie C906 user manual.
> >>>    https://github.com/T-head-Semi/openc906/tree/main/doc
> >>>
> >>> Is it OK with you?
> >>>
> >>
> >> I suggest using perf event json as event description. The jsons provide
> >> more detailed explanation for these events than the user manual.
> >
> >Does the "perf event json" describe the registers and interrupt behaviou=
r?
> >
>=20
> It does not. IIRC, the linux just uses SBI as perf driver backend. So
> the registers and interrupt behaviour is primarily for SBI developer.

Interrupts and registers are the reason that this patch (and the rest of
the patchset) exists :)

> For registers and interrup detail, just reference the openc910 doc url
> (https://github.com/T-head-Semi/openc910/tree/main/doc) and the T-HEAD
> PMU driver in OpenSBI.

The former, sure. But I will not accept driver implementations as the
reference in this context.

Thanks,
Conor.

--aS5JTpy0ABLKb+d2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWkrYwAKCRB4tDGHoIJi
0pwIAPwK17iPJiDp9ipZS/utYpBvkvx0ll5v01jA4ntru7UxxQEA4aGN5NO3jlaA
IGvR1UvnavydACZeMLUy8t+jGSuPzAA=
=bY70
-----END PGP SIGNATURE-----

--aS5JTpy0ABLKb+d2--
