Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AB7EF478
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjKQOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjKQOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:30:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E3D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:30:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8170DC433C8;
        Fri, 17 Nov 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700231405;
        bh=Z5V1WAiAWbPaSydno6O9LOxlTlu6ntJKngism5iAvgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkJmHaOUf4gPzCUHJlnpPPneJsVwb+9w7Oq3B4aoBdzb9hqTULp1gHsctr16NaDk3
         +uxcGf1SvZGUJqjG3+l6aEitgeDkV4R02MbQFlIJSI4D/8ke6aqydvblKLzr3PT5Yq
         s62E7VMJrSTMPhUsxs3NPx1GPNy6zuNIRBFV0Hwf+KrfjCe1cWLXc5pu0Fgbi3nn0p
         wGi+n3xEQwQTEu2XHcRCZMxM6Zizowm8oFUWAzyzj6frG20WpKrRFAxmv4Yn4e41+5
         krUd/SRRzc6JlRojIoj4bM1URy9VRhTwm5XkVupayCaH3PmDCgC6m50TdmhpZ6EWg+
         By9k48Fh+024g==
Date:   Fri, 17 Nov 2023 14:30:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231117-kindred-manor-863549870bcd@spud>
References: <184ab92d-9246-43e4-a40d-465d51208585@linaro.org>
 <IA1PR20MB49532AF0A7C6DA5A2184B250BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Zw1o4HV3vYXGo0w"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532AF0A7C6DA5A2184B250BBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Zw1o4HV3vYXGo0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 08:30:21PM +0800, Inochi Amaoto wrote:
> >
> >On 17/11/2023 06:07, Inochi Amaoto wrote:
> >> The timer registers of aclint don't follow the clint layout and can
> >> be mapped on any different offset. As sg2042 uses separated timer
> >> and mswi for its clint, it should follow the aclint spec and have
> >> separated registers.
> >>
> >> The previous patch introduced a new type of T-HEAD aclint timer which
> >> has clint timer layout. Although it has the clint timer layout, it
> >> should follow the aclint spec and uses the separated mtime and mtimecmp
> >> regs. So a ABI change is needed to make the timer fit the aclint spec.
> >>
> >> To make T-HEAD aclint timer more closer to the aclint spec, use
> >> regs-names to represent the mtimecmp register, which can avoid hack
> >> for unsupport mtime register of T-HEAD aclint timer.
> >>
> >
> >I don't understand this reasoning. You had one entry, you still have one
> >entry. Adding reg-names (not regs-names) does not change it.
> >
>=20
> If no "reg-names", all the register of ACLINT should be defined. However,
> T-HEAD aclint timer of sg2042 only supports mtimecmp register. If no extra
> prompt is provided for the SBI, it will fail to recognize aclint timer
> registers when parsing the aclint node with one reg entry.
>=20
> There is another way to avoid this by using an empty entry to identify
> unsupported mtime, but Conor have already rejected this. See [1].
>=20
> Link: https://lore.kernel.org/all/20231114-skedaddle-precinct-66c8897227b=
b@squawk/ [1]

Perhaps you misunderstood my suggestion. I was looking for _both_
registers to be defined in the binding as well as adding reg-names as a
required property. Doing what you have here might work for your use
case, but does not make sense from a bindings point of view as there is
no way to describe the mtime register, should it exist in another SoC.

Cheers,
Conor

--4Zw1o4HV3vYXGo0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVd46AAKCRB4tDGHoIJi
0n79AQDFrauiidg4Z18gElGE0Gk9HHl1f4oB5rhwApCisLPPqgD/SIAWWeTdv3ff
XOmoNLUC/tzBk6stx6iBfT+MgLRvjgY=
=7L3W
-----END PGP SIGNATURE-----

--4Zw1o4HV3vYXGo0w--
