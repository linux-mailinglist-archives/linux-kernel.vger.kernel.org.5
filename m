Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052C803AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjLDQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjLDQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:56:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE639B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E04C433C7;
        Mon,  4 Dec 2023 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701708993;
        bh=D5PcLs9BN316KSze1BhRO6RD7xIMB0szQg4ZffMMN8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAOXWjDO6XOv0cg1GadByd7v+NDYHuW5TRXZX9bG+FS2mtGR0bfvhF4bpr+isNMHO
         AWbGJvBijrq08a/5BtEDOxSoE1es2l5QRS7FB3Jyx5P/xaj7Wh2fXRrJOc/T2BSXE0
         yfgoBlXh01A8nyij7r9xER797sp2xA6zvV2q+J6QNMLFqvPXCTXqkYnn9jLziZJHbM
         yo1f6Gp3eKbMr+f9pGE4/zPZgUrJuV8gjHznhGqHicv3qo9upzn25bfOJvzwwIGFf1
         4XA0o4mw1I7SGZ0eWtWofZPCkzyPBkd/estNYlvG4PROtSv4XGw2M3LJ8D8a0pYdQh
         iOOTNgSeVuPsA==
Date:   Mon, 4 Dec 2023 16:56:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231204-monorail-boxer-82c77526e764@spud>
References: <IA1PR20MB4953C912FC58C0D248976564BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49531ED1BCC00D6B265C2D10BB86A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231204-germproof-venue-6874ad902323@spud>
 <a1374b10-c012-4a3f-b56a-29ef4ca7e5f0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6hqP5zi5So06djGG"
Content-Disposition: inline
In-Reply-To: <a1374b10-c012-4a3f-b56a-29ef4ca7e5f0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6hqP5zi5So06djGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 05:39:09PM +0100, Daniel Lezcano wrote:
> On 04/12/2023 17:18, Conor Dooley wrote:
> > On Mon, Dec 04, 2023 at 05:51:08PM +0800, Inochi Amaoto wrote:
> > > The timer registers of aclint don't follow the clint layout and can
> > > be mapped on any different offset. As sg2042 uses separated timer
> > > and mswi for its clint, it should follow the aclint spec and have
> > > separated registers.
> > >=20
> > > The previous patch introduced a new type of T-HEAD aclint timer which
> > > has clint timer layout. Although it has the clint timer layout, it
> > > should follow the aclint spec and uses the separated mtime and mtimec=
mp
> > > regs. So a ABI change is needed to make the timer fit the aclint spec.
> > >=20
> > > To make T-HEAD aclint timer more closer to the aclint spec, use
> > > regs-names to represent the mtimecmp register, which can avoid hack
> > > for unsupport mtime register of T-HEAD aclint timer.
> > >=20
> > > Also, as T-HEAD aclint only supports mtimecmp, it is unnecessary to
> > > implement the whole aclint spec. To make this binding T-HEAD specific,
> > > only add reg-name for existed register. For details, see the discussi=
on
> > > in the last link.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT tim=
er")
> > > Link: https://lists.infradead.org/pipermail/opensbi/2023-October/0056=
93.html
> > > Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.ad=
oc
> > > Link: https://lore.kernel.org/all/IA1PR20MB4953F9D77FFC76A9D236922DBB=
B6A@IA1PR20MB4953.namprd20.prod.outlook.com/
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Although, I figure it is going to be me that ends up taking it.
>=20
> No, I should take it

Sweet, I'd rather you took it than it went via a DT tree :)

--6hqP5zi5So06djGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW4EuwAKCRB4tDGHoIJi
0hTjAP4tM5n9gfLQU1lJ0Hv69R4VUOG8+rLjdvR8xgY0rBXXzwD+IaYecvw2r2Rh
NH4geoV13/PTi2UQFDyJWbkslN9nsgM=
=ZI/Y
-----END PGP SIGNATURE-----

--6hqP5zi5So06djGG--
