Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57667EB364
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjKNPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKNPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:21:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08E0124
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:21:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B4C433C9;
        Tue, 14 Nov 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699975311;
        bh=9wXjIVmd2uGE2frovOidRIeYLd6daeG69AXO48B0PYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puB7EAV32+9rjtUH1Q5vcxMKFwP1jZvLIynXVyfhDpc4Oj6zh0YiGEBIWZRToxIUa
         7sFT6q69A4TwRo2PWXUBuRnsZTvb8pS0WrfT1X8mjip4Nx747Gxusr80LXFzDmDnvZ
         vekW9CWIqf6y73Ogt84t9wBN6rbyGorLH2bxemhfnNk0X/CmwMHI5n9YIKrlNBghiH
         bkjPJLXO3/FTktfNDkAWMhGAeYoe+vKSuSAvf2JL6xzY3FMBpGf77Oe5VKZbsZV4kS
         4zemsEpdWoTDYP5OzGOwQSEy5eDKTPuSf6cdtoqnUlTw4lJKgld5rr5tKioItQ4YHW
         m9QXQio8nsB4A==
Date:   Tue, 14 Nov 2023 15:21:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231114-outweigh-sandbank-6bbdd7ea3286@squawk>
References: <MA0P287MB03326F420E96FE3198C81C21FEB2A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB4953EBB4DA58A7170D865B0CBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gYMgAIUgTJwv6z//"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953EBB4DA58A7170D865B0CBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gYMgAIUgTJwv6z//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:45:33AM +0800, Inochi Amaoto wrote:
> >On 2023/11/14 8:45, Inochi Amaoto wrote:
> >> The timer registers of aclint don't follow the clint layout and can
> >> be mapped on any different offset. As sg2042 uses separated timer
> >> and mswi for its clint, it should follow the aclint spec and have
> >> separated registers.
> >>
> >> The previous patch introduces a new type of T-HEAD aclint timer which
> >> has clint timer layout. Although the timer has the clint layout, it
> >> should follow the aclint spec and uses the separated mtime and mtimecmp
> >> regs. So a ABI change is needed to make the timer fit the aclint spec.
> >>
> >> To make T-HEAD aclint timer more closer to the aclint spec, use two re=
gs
> >> to represent the mtime and mtimecmp.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT time=
r")
> >> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/00569=
3.html
> >> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> >> ---
> >>   .../devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml  | 5 +++=
--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint=
-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mt=
imer.yaml
> >> index fbd235650e52..c3080962d902 100644
> >> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer=
=2Eyaml
> >> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer=
=2Eyaml
> >> @@ -17,7 +17,7 @@ properties:
> >>         - const: thead,c900-aclint-mtimer
> >>
> >>     reg:
> >> -    maxItems: 1
> >> +    maxItems: 2
> >
> >The first one is for mtime and the second one is for mtimecmp, right?
>=20
> Yes, that is right.
>=20
> >Recommend to add some comment in binding file to make it clear.
> >
>=20
> Thanks for your advice.

Sorry for not noticing that on v1 - you should indeed describe these in
the binding, by using the items property.

--gYMgAIUgTJwv6z//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVOQiAAKCRB4tDGHoIJi
0pX6AP0XJb92ui0Tkp9pTbUbFAmlVrtlYS0vPCDvHy6caTR3RgEAvzFeJR7FxdHm
a8rrW3n/yQZNKQXoucst7fvwoffvwwA=
=o9jC
-----END PGP SIGNATURE-----

--gYMgAIUgTJwv6z//--
