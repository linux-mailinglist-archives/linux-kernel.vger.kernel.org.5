Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2F75B7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGTT1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGTT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662391724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCE5D61C06
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E19AC433C7;
        Thu, 20 Jul 2023 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689881230;
        bh=CJRKA7PTC+3zbSnVoUQ2xy4P4+PLWvmEQShLI/rDtV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8yO9TLNDF7CNnC7ooBnQhdcZv7jECBIpBkg8dGXL2dbZrB7KLTVSRNP8WKEqPWA/
         btuCB0gldrpM6+6synKmKyI5vLbRyF2EMIr0/YGZvqm0DfAQxroX35xShVf0Op1AXA
         mP/oe9dgXoobZy4Xsb9glE0/4a8EOOa35Sxqk2mVXXo+v2Q0ZVxSiEBuqCGjk9UaVR
         f4Wao2vkABbBWrVlNUQSlcuTDKku1qZPP6VdbJFlzKJyzcU2lvQaSpvPQvnS+xdVm+
         i0VydMJCcjjyBrlQ6LV5GU/1l5O4W50NQ/KhD/WpPCAKdoRRQwDmuD6faZ03dXgN1p
         TDEF3HyOesZkg==
Date:   Thu, 20 Jul 2023 20:27:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Message-ID: <20230720-charter-lustrous-061e7550ce7c@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <20230719-confront-grass-6d0eb304b94f@spud>
 <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uFR2qPiOGZh5u8nm"
Content-Disposition: inline
In-Reply-To: <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uFR2qPiOGZh5u8nm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 02:43:51PM -0700, Tomasz Jeznach wrote:
> On Wed, Jul 19, 2023 at 1:50=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:

> > Anyway, what I wanted to ask was whether it was valid to use the IOMMU
> > in a system if Ziommu is not present in whatever the ISA extension
> > communication mechanism is? Eg, riscv,isa or the ISA string property in
> > the ACPI tables.
> >
>=20
> Yes, this has been pointed out to me already. As far as I can recall,
> there was a discussion
> at some point to introduce those as Ziommu extensions, later agreeing
> not to call IOMMU
> using ISA string conventions.  Will remove remaining occurrences of
> Ziommu from the series.

Right, thanks for clearing that up. I got a bit confused :)

--uFR2qPiOGZh5u8nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLmKiQAKCRB4tDGHoIJi
0nKvAQCY4Qfl5o53tpBHorzaEf49d9BTMt+qWrTdweBVlIvXWwEAxSbe0KPPgv4y
zC/FdQ3GvKUVGBGv2E80c4D/boCv1gc=
=X54m
-----END PGP SIGNATURE-----

--uFR2qPiOGZh5u8nm--
