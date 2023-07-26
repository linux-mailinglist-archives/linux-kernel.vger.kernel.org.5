Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51AC763C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGZQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGZQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57B2118
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1067461BD2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF0CC433C8;
        Wed, 26 Jul 2023 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389498;
        bh=JIDm8LyfxJE7RRvIDFBtu2mHaYm7IVhXvOfm9XgAH7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVe0wYl0pfbTfi8Yk37HxVES1kUaLlRdVU18c+4qLYdbqDo0CkkW2g7EcfDSgzYPJ
         NA5avCass45oAveyV92sZS2dnLsCv9hYu2IOOxxERW6z5ffcDTqHWvqAeDNiO/w8o0
         2SEA6Xny8d1OJ9Bl8vFkUAxs9OSQjY2Huro5SATt91BAgNMvoY/b5Mfj+XsJWSNoTc
         UgE9m9/vfyW+G6CLZ1gO9WTA+yUUMyq0wyPKF7DpzWQ531qwanBBLIJlomoPdBhRuV
         LH4X32oE8eZxhEog8xelaNnyovVs45f739gtIVMaSsCEQupavG1K3g2SGwAzTXp3Al
         myPgA/ueGseJw==
Date:   Wed, 26 Jul 2023 17:38:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Alyssa Ross <hi@alyssa.is>, Li Zhengyu <lizhengyu3@huawei.com>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        kexec@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@suse.de>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v2 3/3] riscv/kexec: load initrd high in available memory
Message-ID: <20230726-busily-marsupial-504e9ff2d873@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4IjUavm2DX17Tscu"
Content-Disposition: inline
In-Reply-To: <67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4IjUavm2DX17Tscu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:54:01AM +0200, Petr Tesarik wrote:
> From: Torsten Duwe <duwe@suse.de>
>=20
> When initrd is loaded low, the secondary kernel fails like this:
>=20
>  INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region
>=20
> This initrd load address corresponds to the _end symbol, but the
> reservation is aligned on PMD_SIZE, as explained by a comment in
> setup_bootmem().
>=20
> It is technically possible to align the initrd load address accordingly,
> leaving a hole between the end of kernel and the initrd, but it is much
> simpler to allocate the initrd top-down.
>=20
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> Cc: stable@vger.kernel.org

Trying to align it might be worthwhile, but the simple fix makes sense
for now & w.r.t backporting.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--4IjUavm2DX17Tscu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFL9AAKCRB4tDGHoIJi
0kQrAQDAjVabAm/0oUxhkPidOB7m+J9yy16ms3S4tX5CRjFpMgEAwbU91VszeYbg
yTGfUV46zID+fbBShPEqsNSCrR3Qlgs=
=yUks
-----END PGP SIGNATURE-----

--4IjUavm2DX17Tscu--
