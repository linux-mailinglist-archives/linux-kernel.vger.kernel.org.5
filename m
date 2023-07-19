Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797A75A02E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGSUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGSUui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3401FE1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21ECB61821
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB975C433C8;
        Wed, 19 Jul 2023 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799800;
        bh=Y8XiusgINQG98IO04NdyvglLi4HqlEdF2bPF6Yofwfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9h5hXCJgQFf0j2oLtEq7ifgxpDpBRU4+S+GE6zru1iDxEVD+bpJOCzueY1fguqxX
         TKcjhRnSDBt9yrLt/fD3mc+stzDsI9eJn+yFGkYciYNpviQeBWWUn4rT0XLtLFjn6d
         ux3lC0WjMBlYsuXfjeWTBeygRhzcQIeo2KRRcvPRyMZSnEFOmOFY8VJBlBNWzDofhr
         o/1H46qxwmeq3GvjaTMRGb74RzjzIWvgB/+bmmNZqpnJOcoqbVaGwlqHZ126Zsjmrg
         +Ji3MKgb4wDSSMM0TLPgt8BFt3zL/ybNzMxNXF0/PUUqmio2C4fdatKRKOu6Zdk8LQ
         SlDY1dk5oCj8A==
Date:   Wed, 19 Jul 2023 21:49:55 +0100
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
Message-ID: <20230719-confront-grass-6d0eb304b94f@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="84pc7Ec13y+mZhcJ"
Content-Disposition: inline
In-Reply-To: <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84pc7Ec13y+mZhcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tomasz,

On Wed, Jul 19, 2023 at 12:33:45PM -0700, Tomasz Jeznach wrote:
> The patch introduces skeleton IOMMU device driver implementation as defin=
ed
> by RISC-V IOMMU Architecture Specification, Version 1.0 [1], with minimal=
 support
> for pass-through mapping, basic initialization and bindings for platform =
and PCIe
> hardware implementations.
>=20
> Series of patches following specification evolution has been reorganized =
to provide
> functional separation of implemented blocks, compliant with ratified spec=
ification.
>=20
> This and following patch series includes code contributed by: Nick Kossif=
idis
> <mick@ics.forth.gr> (iommu-platform device, number of specification clari=
fication
> and bugfixes and readability improvements), Sebastien Boeuf <seb@rivosinc=
=2Ecom> (page
> table creation, ATS/PGR flow).
>=20
> Complete history can be found at the maintainer's repository branch [2].
>=20
> Device driver enables RISC-V 32/64 support for memory translation for DMA=
 capable
> PCI and platform devices, multilevel device directory table, process dire=
ctory,
> shared virtual address support, wired and message signaled interrupt for =
translation
> I/O fault, page request interface and command processing.
>=20
> Matching RISCV-V IOMMU device emulation implementation is available for Q=
EMU project,
> along with educational device extensions for PASID ATS/PRI support [3].

This commit message reads like a cover letter IMO. At whatever point
you send a v2, could you re-write this focusing on what is done in the
patch itself?

Also, since I am not going to reply to any of these iommu driver patches
in a meaningful capacity, please run checkpatch.pl on your work. There
are well over 100 style etc complaints that it has highlighted. Sparse
has also gone a bit nuts, with many warnings along the lines of:
drivers/iommu/riscv/iommu.c:1568:29: warning: incorrect type in assignment =
(different base types)
drivers/iommu/riscv/iommu.c:1568:29:    expected unsigned long long [userty=
pe] iohgatp
drivers/iommu/riscv/iommu.c:1568:29:    got restricted __le64 [usertype]

I can provide you the full list when the patchwork automation has run
through the series.

Anyway, what I wanted to ask was whether it was valid to use the IOMMU
in a system if Ziommu is not present in whatever the ISA extension
communication mechanism is? Eg, riscv,isa or the ISA string property in
the ACPI tables.

Thanks,
Conor.

> References:
>  - [1] https://github.com/riscv-non-isa/riscv-iommu
>  - [2] https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
>  - [3] https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu

FYI, we have the Link: tag/trailer for this.


--84pc7Ec13y+mZhcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLhMcwAKCRB4tDGHoIJi
0lIfAP9uPwBu+e/C+/ZsygvppSSP9x3v8vUZ8yHHUidL/6sOCwD/f6sSZh1Cj6wv
5tIrbH5HWVcSsflIwaoP6uRCLLneIAw=
=c5fj
-----END PGP SIGNATURE-----

--84pc7Ec13y+mZhcJ--
