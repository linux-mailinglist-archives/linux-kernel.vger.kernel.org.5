Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66A576D4F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjHBRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjHBRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BEC1735;
        Wed,  2 Aug 2023 10:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179B561A41;
        Wed,  2 Aug 2023 17:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39522C433C7;
        Wed,  2 Aug 2023 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690996737;
        bh=1bs5fAM+RgwhOoYuMXjxSteSlIzHxQlTrE/hEJz35s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFMrGcadzeAB7Am7LXjRf//SwRph7sh+o/I56xAeE2y+O9NqVIVtgU+dK+YotbrQs
         RhvDgRNMYN/N1Eu+yo0I60FCvY5nXSCojcYeotzFskq4WUgGsr97sFysmdTcMyZePj
         t70OfGPCUpyP+g5+LnsX1MOjPan0+9MLWGA9ZKwgLWuc6a8YfBtV918w08xSqQSCVS
         XnyZ6y9ByyWDwQ8cAXQ99aho4IdhpKnqtWMVgrV43BXUydY+uV2EgfFa7qigEG6xUv
         dMeyOR00ZClxuyx//nBTSpSL/StwxBLtvwS21AAt7VTmfHH3PO5SuHJVfYv3b9TWs+
         jkU0SeaQ24D2g==
Date:   Wed, 2 Aug 2023 18:18:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 01/15] RISC-V: Add riscv_get_intc_hartid() function
Message-ID: <20230802-recharger-chuck-6ace9f1157ac@spud>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-2-apatel@ventanamicro.com>
 <20230802-b0c478839e55890385d98f31@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FOD65xhEHS8tTgmj"
Content-Disposition: inline
In-Reply-To: <20230802-b0c478839e55890385d98f31@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FOD65xhEHS8tTgmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 08:09:18PM +0300, Andrew Jones wrote:
> On Wed, Aug 02, 2023 at 08:30:04PM +0530, Anup Patel wrote:
> > We add a common riscv_get_intc_hartid() which help device drivers to
> > get hartid of the HART associated with a INTC (i.e. local interrupt
> > controller) fwnode. This new function is more generic compared to
> > the existing riscv_of_parent_hartid() function hence we also replace
> > use of riscv_of_parent_hartid() with riscv_get_intc_hartid().
> >=20
> > Also, while we are here let us update riscv_of_parent_hartid() to
> > always return the hartid irrespective whether the CPU/HART DT node
> > is disabled or not.
>=20
> This change should probably be a separate patch with its own
> justification in its commit message.

Yeah, it certainly needs a justification, not just an "oh, btw I did
this". It also invalidates the comment above the function, so that
would need to be changed too.

> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index a2fc952318e9..c3eaa8a55bbe 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -81,21 +81,35 @@ int riscv_early_of_processor_hartid(struct device_n=
ode *node, unsigned long *har
> >   * To achieve this, we walk up the DT tree until we find an active
                                                                 ^^^^^^

> >   * RISC-V core (HART) node and extract the cpuid from it.
> >   */
> > -int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid)
> > +static int riscv_of_parent_hartid(struct device_node *node,

--FOD65xhEHS8tTgmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMqP+wAKCRB4tDGHoIJi
0lh3AQC3eFBSnuEsujkdYBVsE92Pc2O1XtCda+1HBQsxZ2KZIwEA1jFJa2D09Z7n
38T7/YEAvBKqPBgLCeE8Z74ZqqunaAM=
=uU6c
-----END PGP SIGNATURE-----

--FOD65xhEHS8tTgmj--
