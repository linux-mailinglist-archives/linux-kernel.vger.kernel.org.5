Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11E763C85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGZQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjGZQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01D26A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E6961BC2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBA9C433C9;
        Wed, 26 Jul 2023 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389012;
        bh=CtseXuR2b1gVCty2ACeXPRH8foj3zXYwQxfeGFmkA/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7p6VPuvvuD4zq0VgCKzv1nfUo1r+C/5JO/YzgpyxyhVKS8CjHWLPbzDNV+b0uJnF
         xNxdBkZ00dTkU7T9LlfRbMLSjvEkliC9c4/eBx3rR/WrVcL2c/Xt+T2WrTeK7RDucA
         m6awjWW7Fy/tI70vU2BuXXtwv8QBv6DASpYoc6/f03bjKRBneGusMGuc+5iyLhCRmh
         rSfPUPMRzAuE5JETF9+6rZf/c1faIowogzHv2u8F2yKE6tqcKaBHBNnbbu6TDjEOFx
         BuFSBsnvrutziUtHalQlKn94hsuf/+217Qz9j877L6hPV8IPnQA4aXpjP6CBMGCpBK
         8+FnCRwD9K8tg==
Date:   Wed, 26 Jul 2023 17:30:06 +0100
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
Subject: Re: [PATCH v2 1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation
 type
Message-ID: <20230726-cough-vitamins-ec47ba6d611d@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <b046b164af8efd33bbdb7d4003273bdf9196a5b0.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UIaLJjVO8+XCunHJ"
Content-Disposition: inline
In-Reply-To: <b046b164af8efd33bbdb7d4003273bdf9196a5b0.1690365011.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UIaLJjVO8+XCunHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:53:59AM +0200, Petr Tesarik wrote:
> From: Torsten Duwe <duwe@suse.de>
>=20
> R_RISCV_CALL has been deprecated and replaced by R_RISCV_CALL_PLT. See En=
um
> 18-19 in Table 3. Relocation types here:
>=20
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-el=
f.adoc
>=20
> It was deprecated in ("Deprecated R_RISCV_CALL, prefer R_RISCV_CALL_PLT"):
>=20
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced85018d7=
a0ec17023c9389cbd70b1dbc1b0

Ideally, these would be Link: tags, but that's certainly not worth a
respin. This looks fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--UIaLJjVO8+XCunHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFKDgAKCRB4tDGHoIJi
0rBWAPwI4gbOKalorI6lw3HBpf/e4X6L62YHnlNEGDK38uD65AEA5D9m3ptjNQ8P
V8EYRqN4eqO+PK+WLVbRvH37sXghRgw=
=lYlX
-----END PGP SIGNATURE-----

--UIaLJjVO8+XCunHJ--
