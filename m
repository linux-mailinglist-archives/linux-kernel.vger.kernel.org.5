Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A547A043E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjINMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINMr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:47:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C301FCC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694695644; x=1726231644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMp3otj0E3N1naQgnjsWYmftiJNjCbwcCEIwK3540lA=;
  b=g+xI9VjIvRdUNb9EocDLqFfUCFIaA1HpTJiR84m2RJnz4nEweEOEigO8
   /2evzxF+Iw06ajZF4w3ghD34lInDgW0RRCrwdlPpeV1YhFuWBXN2ZULXD
   VAnCrojXnBiLMeTORdZ2im1Gy2kr7gpHNrFyxMEGZuxsQxurW6TqLG1tj
   mB9TWDFtGTRsDg5CTncaR8iJz9WL0kGBgcYEfX98+KLDjANN2UHLFyzMd
   y6SGO3fatjQkfWgsg4LYlZg9CEnuyAoWcGNsVmy5j28zK/W4H2P8CbW2Q
   zp9Bd8maY+xoBcBvNBmyHnsaka0TzM6vqmr12V0hMRjEfLgDVsb+z5kx8
   g==;
X-CSE-ConnectionGUID: lkrc8tYBQW+sSqrl8F8mbg==
X-CSE-MsgGUID: vLu6P7iFQCiOKWUeCiVYmQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="4824435"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 05:47:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 05:46:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 05:46:45 -0700
Date:   Thu, 14 Sep 2023 13:46:29 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 4/5] riscv: Vector checksum library
Message-ID: <20230914-pennant-obligate-db3adf056281@wendy>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KDMf+6JZIfT6eNsC"
Content-Disposition: inline
In-Reply-To: <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KDMf+6JZIfT6eNsC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> This patch is not ready for merge as vector support in the kernel is
> limited. However, the code has been tested in QEMU so the algorithms
> do work. This code requires the kernel to be compiled with C vector
> support, but that is not yet possible. It is written in assembly
> rather than using the GCC vector instrinsics because they did not
> provide optimal code.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 92 insertions(+)
>=20
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 47d98c51bab2..eb4596fc7f5b 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -12,6 +12,10 @@
> =20
>  #include <net/checksum.h>
> =20
> +#ifdef CONFIG_RISCV_ISA_V
> +#include <riscv_vector.h>

What actually includes this header, I don't see it in either Andy's
in-kernel vector series or Bjorn's blake2 one.
Can you link to the pre-requisites in your cover letter please.

Thanks,
Conor.

--KDMf+6JZIfT6eNsC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMApQAKCRB4tDGHoIJi
0mhkAQCXmf4t51iUccwMbirqaRqdZmk8Yzcti0AGOXOg+2IUZQD/UOoVsc8T1wQw
644D6sgHFMl2lPtyh7o/BcKqkMHoYgA=
=61Sl
-----END PGP SIGNATURE-----

--KDMf+6JZIfT6eNsC--
