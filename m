Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF59808753
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjLGMFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjLGMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:05:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4C3AA;
        Thu,  7 Dec 2023 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701950734; x=1733486734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vqAtDYB58+ilZDY2IzWBId3CBwPu+5+VxutobiukMs=;
  b=gXVqDHxAC3F0kgJ1e9l17h/8swN7yRsFnYFDsm1A0Od/+9d4GezhwSvU
   fCDvrTlmLHmmuNy92oIC983hN/8/MFfQo+IXbGGmRPbiPlpOL6qkttgb6
   ZzRaF1YjlmgWi0BQ9isbijNPTy8V2/MNHO2UmDF0TsYYTH6DMZJuQmaeI
   8CQCjGBEB6/HJLIyvi1TxXWK9fN9BRj5/BrT6mXm7Zcn1YJEYLCFisCiK
   AHdFIw6adCCOpACh9bTOG6fuSIqsUX4kI9LgMHTlaC4/AevChVzcKPOnH
   FFE0ircjxt4vHoXgwiBv/W7dsiLWIqrw7HJFFkF3B2CjK0i1NKOZvLaWE
   g==;
X-CSE-ConnectionGUID: mTzueT1QSG2gazajd18OtQ==
X-CSE-MsgGUID: N6fBXV3OSlSjijCehmi7zQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="12928857"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 05:05:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 05:05:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 05:05:00 -0700
Date:   Thu, 7 Dec 2023 12:04:30 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Atish Patra <atishp@rivosinc.com>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        <kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/9] RISC-V: Fix the typo in Scountovf CSR name
Message-ID: <20231207-attractor-undone-a3efe2e0bb4e@wendy>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
 <20231205024310.1593100-2-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G7tPSZJn8UmPNl7v"
Content-Disposition: inline
In-Reply-To: <20231205024310.1593100-2-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--G7tPSZJn8UmPNl7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 06:43:02PM -0800, Atish Patra wrote:
> The counter overflow CSR name is "scountovf" not "sscountovf".
>=20
> Fix the csr name.
>=20
> Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
>=20
^^ No blank line here.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h         | 2 +-
>  arch/riscv/include/asm/errata_list.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 306a19a5509c..88cdc8a3e654 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -281,7 +281,7 @@
>  #define CSR_HPMCOUNTER30H	0xc9e
>  #define CSR_HPMCOUNTER31H	0xc9f
> =20
> -#define CSR_SSCOUNTOVF		0xda0
> +#define CSR_SCOUNTOVF		0xda0
> =20
>  #define CSR_SSTATUS		0x100
>  #define CSR_SIE			0x104
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 83ed25e43553..7026fba12eeb 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -152,7 +152,7 @@ asm volatile(ALTERNATIVE_2(						\
> =20
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
>  asm volatile(ALTERNATIVE(						\
> -	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
> +	"csrr %0, " __stringify(CSR_SCOUNTOVF),				\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
>  		CONFIG_ERRATA_THEAD_PMU)				\
> --=20
> 2.34.1
>=20

--G7tPSZJn8UmPNl7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXG0zgAKCRB4tDGHoIJi
0nN2AQCvWU22TUz271qbF0f5QPpTAMxJ3xWOjAley3m+IaVk2AEAgKbSJBE5ydgt
c0kRj6UIA26wDaBYi2ihZnFJRMAJVw0=
=pO03
-----END PGP SIGNATURE-----

--G7tPSZJn8UmPNl7v--
