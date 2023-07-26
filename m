Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917F8763C91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjGZQeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGZQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194BC2707
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C2961BBD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 16:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57627C433C7;
        Wed, 26 Jul 2023 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389235;
        bh=qu98mFypzryfpNaKpoZ+to2I3RSD5K9vRrssyVUA0yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D54mej26YFHACyW3/VOA+ZMi36bsP/fou7ZveiThS03CWvwwpJN/kdUnKqSNHiFJP
         FKS9xAVPUOTubYpjQIKpjkfmAuQtTpL5Aqakr9L257D1bsF/6THKz4UC9x0P16oMRB
         9oPeimDouzi9q/Wo3+554QvmYQNKafyxGrnYBjCq0UICUO4Hh8BkYSHnM93w0hJyt0
         WRmeAWylRa/zCCPNi3AzeeM6zGzeTYuR2aA9KQMN9cTtJj+9bZrcjmVG+udwROFsIs
         4S6p/YUV5CCDWmweF5n1kRHjgdPpCZd/+j0cpig9S0pQCdhtdds1c800KpH6GH1k4u
         hh/OCaAABboWg==
Date:   Wed, 26 Jul 2023 17:33:49 +0100
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
Subject: Re: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and
 its dependencies
Message-ID: <20230726-excavate-swoosh-424ede98f63d@spud>
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
 <2832b3e5ac781a0c0ade9d77b15a80e7f2fb4ab2.1690365011.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Yc8XiDptGjnzByY"
Content-Disposition: inline
In-Reply-To: <2832b3e5ac781a0c0ade9d77b15a80e7f2fb4ab2.1690365011.git.petr.tesarik.ext@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Yc8XiDptGjnzByY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:54:00AM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>=20
> Linking with this object file makes kexec_file_load(2) fail because of
> multiple unknown relocation types:
>=20
> - R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
> - R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()
>=20
> All this hassle is needed for one single call to memcmp() from
> verify_sha256_digest() to compare 32 bytes of SHA256 checksum.
>=20
> Simply replace this memcmp() call with an explicit loop over those 32 byt=
es
> and remove the need to link with string.o and all the other object files
> that provide undefined symbols from that object file.
>=20
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>

This version keeps the automation happy,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--1Yc8XiDptGjnzByY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFK7AAKCRB4tDGHoIJi
0nywAP45WUTUj6aGAMM66t2i6LtknIHriZ5AtX22HuqEfK8W3gD45i6hU1k0jKxD
iBzfCHatNLhnBRoYTPRflCChJJDBAA==
=pFZE
-----END PGP SIGNATURE-----

--1Yc8XiDptGjnzByY--
