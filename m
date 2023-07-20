Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7975BA47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGTWI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGTWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6617186
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BCE161C37
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAAEC433C7;
        Thu, 20 Jul 2023 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689890932;
        bh=Z5s9oLlOTT+MLoGJ5I83fWvkRr0YoIV/xJy4YEJUgtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0XsLlQQATT/gwcGZUW2DUbvGbOilzbNnHvR4yU3t7nXjnpzgwle8lagwXaOH993P
         dNC+u9nKfZkC+Az6XPGRksZ+hDSHDJwq6WIo7s97j4A/sUN6tbV5ELf8ZVi+ADwyvQ
         /fTDctNQdflbUcnQnd5kSQtVbi/XiLHtI1V17PKCM0Farsaf2bfL2RbmZLtgY2249c
         SD3HCak7x86hAoe1XUjsQDTq/4jKmHG7Sh7GI7WhxgGZzWAZotqbWA9srxhGrH6/O+
         jWOau6Tnvi/WTonz6i0fF5kj1inLN1NcgJZn1X6++sBDF1RZD8aDYQt5FkIXit4J6K
         H8+mBM70ijQIA==
Date:   Thu, 20 Jul 2023 23:08:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
Message-ID: <20230720-bully-famine-dfc9a5e688ef@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org>
 <CAH2o1u6pMF3MN=oFBcs9kOf-nwnEYfD2Vv=89+DzUanV59R5dw@mail.gmail.com>
 <69800c58-2df8-25e5-09e0-c9929bae2193@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bcun5Y1HEGvpIqWO"
Content-Disposition: inline
In-Reply-To: <69800c58-2df8-25e5-09e0-c9929bae2193@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bcun5Y1HEGvpIqWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 11:37:50PM +0200, Krzysztof Kozlowski wrote:
> On 20/07/2023 20:30, Tomasz Jeznach wrote:

> >>> +#define sysfs_dev_to_iommu(dev) \
> >>> +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device, i=
ommu)
> >>> +
> >>> +static ssize_t address_show(struct device *dev,
> >>> +                         struct device_attribute *attr, char *buf)
> >>
> >>
> >> Where is the sysfs ABI documented?
> >>
> >=20
> > Sysfs for now is used only to expose selected IOMMU memory mapped
> > registers, with complete documentation in the RISC-V IOMMU Arch Spec
> > [1], and some comments in iommu-bits.h file.
> > LMK If it would be better to put a dedicated file documenting those
> > with the patch itself.
>=20
> I meant, you created new sysfs interface. Maybe I missed something in
> the patchset, but each new sysfs interface required documenting in
> Documentation/ABI/.

| expose selected IOMMU memory mapped registers

| Enable sysfs debug / visibility interface providing restricted
| access to hardware registers.

Documentation requirements of sysfs stuff aside, I'm not sure that we
even want a sysfs interface for this in the first place? Seems like, if
at all, this should be debugfs instead? Seems like the only use case for
it is debugging/development...

--bcun5Y1HEGvpIqWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLmwbwAKCRB4tDGHoIJi
0j3GAP4sKlFBg9b3mVUW8DI1uEli6p+U8QzmKoSPgvciU6lUXwEA/kTBkmBeUY/1
NthONKHle/tjSb9Hf+te2bjd72ZZGgM=
=lL8V
-----END PGP SIGNATURE-----

--bcun5Y1HEGvpIqWO--
