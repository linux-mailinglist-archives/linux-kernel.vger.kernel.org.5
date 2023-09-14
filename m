Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856807A0451
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbjINMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjINMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:49:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6531FCE;
        Thu, 14 Sep 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694695783; x=1726231783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LRfBpQwUTjGaQOOdiF6bBmCasixiCE0wp/+lqjUvX04=;
  b=SlSCX7kjqkws70S5p0ZyLFbyRwWcZlCSRldB+cPx83IS4wjgtsPQWo8B
   mhga35cBC5uHW7M2H1moK7H4Vq9WWyNiWSowg2NosuZZoGHel703aba55
   fKnX2e6/zrvJo7ZkWxWIi6TAmiJdBrZG15CLFOsgYgNDiswVc9uMe9Ipw
   7XimtYq+QeJEh6UlyxvQIi0VWVMuqTIzj72lyXmjDljnnbK/CTb/lQMAV
   P+N4QiZW0I8xjk3ipQiWIwTmZ3a3UJcyFwP/ynlP742btDZef1daL+rYH
   KUM3+JMQogJs90MWBtSLwq262hQIyGCxVUyPIG0P8/zvG6Qfz7zVg+A2H
   w==;
X-CSE-ConnectionGUID: 7fr+3FzBQc6WGlJNPeDc1g==
X-CSE-MsgGUID: ZKQIl3KrR2SbqKioEFS7OQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="4641672"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 05:49:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 05:49:33 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 05:49:30 -0700
Date:   Thu, 14 Sep 2023 13:49:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
Message-ID: <20230914-roaming-plunging-948c78d9831c@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byxUR448N23jzR+h"
Content-Disposition: inline
In-Reply-To: <20230912115728.172982-1-bjorn@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--byxUR448N23jzR+h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=F6rn T=F6pel wrote:
> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
>=20
> Hi,
>=20
> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
> AVX-512-to-RISC-V translation patch appended.
>=20
> I've tagged it as RFC, since Andy's series is still not in-tree yet.
>=20
> It's a first step towards a Vector aided Wireguard! ;-)

This has the same problems as Andy's stuff & doesn't build properly for the
automation. What is the plan between yourself and Andy for submitting a
version of the in-kernel vector support that passes build testing?

Cheers,
Conor.

>=20
>=20
> Cheers,
> Bj=F6rn
>=20
> [1] https://lore.kernel.org/linux-riscv/20230721112855.1006-1-andy.chiu@s=
ifive.com/
>=20
> Andy Chiu (3):
>   riscv: sched: defer restoring Vector context for user
>   riscv: vector: do not pass task_struct into
>     riscv_v_vstate_{save,restore}()
>   riscv: vector: allow kernel-mode Vector with preemption
>=20
> Bj=F6rn T=F6pel (1):
>   riscv: Add BLAKE2s V implementation
>=20
> Greentime Hu (2):
>   riscv: Add support for kernel mode vector
>   riscv: Add vector extension XOR implementation
>=20
>  arch/riscv/Kbuild                      |   2 +-
>  arch/riscv/Kconfig                     |  10 ++
>  arch/riscv/crypto/Kconfig              |  16 +++
>  arch/riscv/crypto/Makefile             |   6 +
>  arch/riscv/crypto/blake2s-glue.c       |  39 ++++++
>  arch/riscv/crypto/blake2s-v.S          | 164 +++++++++++++++++++++++++
>  arch/riscv/include/asm/entry-common.h  |  13 ++
>  arch/riscv/include/asm/processor.h     |   2 +
>  arch/riscv/include/asm/simd.h          |  52 ++++++++
>  arch/riscv/include/asm/thread_info.h   |   6 +
>  arch/riscv/include/asm/vector.h        |  50 ++++++--
>  arch/riscv/include/asm/xor.h           |  82 +++++++++++++
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/asm-offsets.c        |   2 +
>  arch/riscv/kernel/entry.S              |  45 +++++++
>  arch/riscv/kernel/kernel_mode_vector.c | 146 ++++++++++++++++++++++
>  arch/riscv/kernel/process.c            |  10 +-
>  arch/riscv/kernel/ptrace.c             |   2 +-
>  arch/riscv/kernel/signal.c             |   4 +-
>  arch/riscv/kernel/vector.c             |   5 +-
>  arch/riscv/lib/Makefile                |   1 +
>  arch/riscv/lib/xor.S                   |  81 ++++++++++++
>  crypto/Kconfig                         |   3 +
>  drivers/net/Kconfig                    |   1 +
>  24 files changed, 725 insertions(+), 18 deletions(-)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile
>  create mode 100644 arch/riscv/crypto/blake2s-glue.c
>  create mode 100644 arch/riscv/crypto/blake2s-v.S
>  create mode 100644 arch/riscv/include/asm/simd.h
>  create mode 100644 arch/riscv/include/asm/xor.h
>  create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
>  create mode 100644 arch/riscv/lib/xor.S
>=20
>=20
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> --=20
> 2.39.2
>=20

--byxUR448N23jzR+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMBSgAKCRB4tDGHoIJi
0mgtAP9tLS4u6b4Irsx6NBLrW89j/8YmAa4iusUmxfsYju7AUwD+M8RdN9euI6/d
KRezKxNx3it8mEaHXr5KwfCfOYRbNg0=
=Gekc
-----END PGP SIGNATURE-----

--byxUR448N23jzR+h--
