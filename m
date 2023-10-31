Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8E7DD82F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbjJaWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346399AbjJaWV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:21:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561AF1;
        Tue, 31 Oct 2023 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698790912;
        bh=0/iPY9kfJQM8rbXhWaLusL0GvM6vvu0c3dVC6j6qNj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IEzlh71NsWa2rj/5JbwIjqIYOpY7MtPiciRQteFGYAgzu8wZqznHpLFExbwhl73Fn
         F16kSYzGZ9OspPNKHc6jpELCUFoRDcEzfTtl1w01w5A1q2RT8UOX2LRTRYmxwKKUYP
         MBSPQFVwg+qbFr8rtFcCddnacycseUcKrvpVPgMacYT3/LHbWT18bhZcqVnlx/M7cu
         E/Ar5slSzhr0pWrxFSCRpxc9fUDTefba37v/Bz2em+UW66afVaR0DOO6N8i/QdM2I+
         kp+eaao3xlNHB1P7VRmwpWBgTPZSontr9vF3hArPXyI8vE3VaVCS2NPKoV56mr0MOX
         XABL4VQCcVSPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKl3y69ffz4wd2;
        Wed,  1 Nov 2023 09:21:50 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 09:21:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231101092146.4a19a00b@canb.auug.org.au>
In-Reply-To: <20231009123118.4487a0e1@canb.auug.org.au>
References: <20231009123118.4487a0e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sxYwLbzN=Mwr0xwm9iz+GEP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sxYwLbzN=Mwr0xwm9iz+GEP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 9 Oct 2023 12:31:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the block tree got conflicts in:
>=20
>   arch/alpha/kernel/syscalls/syscall.tbl
>   arch/arm/tools/syscall.tbl
>   arch/arm64/include/asm/unistd.h
>   arch/arm64/include/asm/unistd32.h
>   arch/m68k/kernel/syscalls/syscall.tbl
>   arch/microblaze/kernel/syscalls/syscall.tbl
>   arch/mips/kernel/syscalls/syscall_n32.tbl
>   arch/mips/kernel/syscalls/syscall_n64.tbl
>   arch/mips/kernel/syscalls/syscall_o32.tbl
>   arch/parisc/kernel/syscalls/syscall.tbl
>   arch/powerpc/kernel/syscalls/syscall.tbl
>   arch/s390/kernel/syscalls/syscall.tbl
>   arch/sh/kernel/syscalls/syscall.tbl
>   arch/sparc/kernel/syscalls/syscall.tbl
>   arch/x86/entry/syscalls/syscall_32.tbl
>   arch/xtensa/kernel/syscalls/syscall.tbl
>   include/uapi/asm-generic/unistd.h
>=20
> between commits:
>=20
>   2fd0ebad27bc ("arch: Reserve map_shadow_stack() syscall number for all =
architectures")
>=20
> from the asm-generic tree and commits:
>=20
>   9f6c532f59b2 ("futex: Add sys_futex_wake()")
>   cb8c4312afca ("futex: Add sys_futex_wait()")
>   0f4b5f972216 ("futex: Add sys_futex_requeue()")
>=20
> from the block tree.

This is now a conflict between the asm-generic tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/sxYwLbzN=Mwr0xwm9iz+GEP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBffoACgkQAVBC80lX
0Gx64Af9F7cnAyFeN33QuudhqVUezl/iiPmRkNuVGJS1bTjuFpG6dMaw/HT/MLP+
FpWn5ticga8cLeUGvuy70EuVGk0weR9gWqUyeUKOChtpF+dDD3seDXe/MC6qj7Du
Tml4TPI+b3oCKHZQRHi+MAjkZUJPIAWJH4WUplS9QKhA+mj7vnN9pLxT1rgZRgrO
Sx6/DRKGwq8cZYqsWhIshWN0Lw3d1UaebgmrrznOe2U3f1zhWeXruoxvMLy54gR+
/LY6brcXZgfQJONKe2OUdoIL+nJlj+jjZBfBN8ai91RfDaYpYDG1QYNAbQHqW5R6
6Tej+g+Mm7gs/SVd68QOPMTIZfm7YA==
=d2a7
-----END PGP SIGNATURE-----

--Sig_/sxYwLbzN=Mwr0xwm9iz+GEP--
