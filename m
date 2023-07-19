Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37210759F99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FC189
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9530B61802
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378A0C433C7;
        Wed, 19 Jul 2023 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798163;
        bh=+TuQPa0/6AKwb7VKvotz3kL95KrA4s7VS8/HsfyxKhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHJOppq/snFQmNDnAt58PcMQxBI7nTrHH/pQraw523/4bxYkDkg8WyzLdVDGI4JfC
         gGPwJN3r2Umnr/c+EhyVkKUedoJaUkAuhTcSiuHM16vBYryCxBAMvC6rkw/KNpi35s
         X5pcrUqrmnnS80jHmT08JI7XTChugLPK/0QAsiFzQNyg3e8Swq+X+80DJ3NRG+Vpfk
         h3L9awqrsGJA8JgQ71bdVOV3hi/gwanv7fdtJXX5o3/6gmiWbcjeM483v71/m8mQxp
         AWyHw3J04bWXj6wUDU4vCqnP3ieplhs+YLzucVxl77cYpHiK0HDegIBKVe5EmpEBLY
         Yn1JZuallQe2g==
Date:   Wed, 19 Jul 2023 21:22:37 +0100
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
Subject: Re: [PATCH 02/11] RISC-V: arch/riscv/config: enable RISC-V IOMMU
 support
Message-ID: <20230719-marbled-drivable-804aacbafee2@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZC9b2YYOk1fPhC2j"
Content-Disposition: inline
In-Reply-To: <961d125558137f7cb960de65e5f71da5d299d3bc.1689792825.git.tjeznach@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZC9b2YYOk1fPhC2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 12:33:46PM -0700, Tomasz Jeznach wrote:

$subject: RISC-V: arch/riscv/config: enable RISC-V IOMMU support

Please look at any other commits to the files you are touching
and use a subject line that emulates them. In this case, try
git log --oneline --no-merges -- arch/riscv/configs/
Same goes for the odd pattern in your driver patches.

Also, the patch may be trivial, but you still need to sign off on it
and provide a commit message.

Thanks,
Conor.

> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0a0107460a5c..1a0c3b24329f 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -178,6 +178,7 @@ CONFIG_VIRTIO_PCI=3Dy
>  CONFIG_VIRTIO_BALLOON=3Dy
>  CONFIG_VIRTIO_INPUT=3Dy
>  CONFIG_VIRTIO_MMIO=3Dy
> +CONFIG_RISCV_IOMMU=3Dy
>  CONFIG_SUN8I_DE2_CCU=3Dm
>  CONFIG_SUN50I_IOMMU=3Dy
>  CONFIG_RPMSG_CHAR=3Dy
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--ZC9b2YYOk1fPhC2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLhGDQAKCRB4tDGHoIJi
0mLOAQCjr7sDbCmb9A6zxx6/5Do/Y1kCHUQH5CJPesMyClbqHQD/X5yNQ4zvkn+N
Q8dUU6CSaELl+p7aG4OKlflP3KBBOQo=
=pChR
-----END PGP SIGNATURE-----

--ZC9b2YYOk1fPhC2j--
