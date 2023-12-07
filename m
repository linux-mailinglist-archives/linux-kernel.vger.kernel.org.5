Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F38087C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379274AbjLGMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:33:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B4D57;
        Thu,  7 Dec 2023 04:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701952399; x=1733488399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x+W86EcBv8nw8a8iPOChoKU5STU5d1Xy1ovac4ozBgo=;
  b=qZboFrET/vva98NsSpyoHq6timY/F4xtq3xNmUiKGatdClHGPaLHuaJT
   md7S4py4vM42Lw60AfpdZrRCn6Tu7WiBJCtBtps551Yu+QkoPtEswZvVp
   27uBUp5v3DFymNmYbX1olivwAM9KSAf+yM+SjO/wIDDB6j+HfDlr5oByB
   QCa/BL2x8ETANPRInal5qr2Uv58a1jAIhjcj95MA/I1vh/ygWX3wwMj+S
   rOjbc9BhgPGOPSSLzx9sLuMYgNy30WVFVqFpV6NGg0KBogYXY38igi5di
   wGM3hgMTMxG4gA5d5ST2HSrCjG41aW55kGL/oh0UihVmkrz8n17wyTzQR
   A==;
X-CSE-ConnectionGUID: aqnjUHDXQVi84lfCJE9wQw==
X-CSE-MsgGUID: /RjNEEfKS2iR2vvEfe94nA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="13246334"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 05:33:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 05:32:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 05:32:49 -0700
Date:   Thu, 7 Dec 2023 12:32:19 +0000
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
Subject: Re: [RFC 4/9] drivers/perf: riscv: Read upper bits of a firmware
 counter
Message-ID: <20231207-fidgeting-plywood-8347d9d346be@wendy>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
 <20231205024310.1593100-5-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XhRhZMNOguKWXngK"
Content-Disposition: inline
In-Reply-To: <20231205024310.1593100-5-atishp@rivosinc.com>
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

--XhRhZMNOguKWXngK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 06:43:05PM -0800, Atish Patra wrote:
> SBI v2.0 introduced a explicit function to read the upper bits
> for any firmwar counter width that is longer than XLEN. Currently,
> this is only applicable for RV32 where firmware counter can be
> 64 bit.

The v2.0 spec explicitly says that this function returns the upper
32 bits of the counter for rv32 and will always return 0 for rv64
or higher. The commit message here seems overly generic compared to
the actual definition in the spec, and makes it seem like it could
be used with a 128 bit counter on rv64 to get the upper 64 bits.

I tried to think about what "generic" situation the commit message
had been written for, but the things I came up with would all require
changes to the spec to define behaviour for FID #5 and/or FID #1, so
in the end I couldn't figure out the rationale behind the non-committal
wording used here.

>=20
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 40a335350d08..1c9049e6b574 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -490,16 +490,23 @@ static u64 pmu_sbi_ctr_read(struct perf_event *even=
t)
>  	struct hw_perf_event *hwc =3D &event->hw;
>  	int idx =3D hwc->idx;
>  	struct sbiret ret;
> -	union sbi_pmu_ctr_info info;
>  	u64 val =3D 0;
> +	union sbi_pmu_ctr_info info =3D pmu_ctr_list[idx];
> =20
>  	if (pmu_sbi_is_fw_event(event)) {
>  		ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
>  				hwc->idx, 0, 0, 0, 0, 0);
>  		if (!ret.error)
>  			val =3D ret.value;
> +#if defined(CONFIG_32BIT)

Why is this not IS_ENABLED()? The code below uses one. You could then
fold it into the if statement below.

> +		if (sbi_v2_available && info.width >=3D 32) {

 >=3D 32? I know it is from the spec, but why does the spec define it as
 "One less than number of bits in CSR"? Saving bits in the structure I
 guess?

> +			ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +					hwc->idx, 0, 0, 0, 0, 0);

> +			if (!ret.error)
> +				val =3D val | ((u64)ret.value << 32);

If the first ecall fails but the second one doesn't won't we corrupt
val by only setting the upper bits? If returning val =3D=3D 0 is the thing
to do in the error case (which it is in the existing code) should the
first `if (!ret.error)` become `if (ret.error)` -> `return 0`?


> +				val =3D val | ((u64)ret.value << 32);

Also, |=3D ?

Cheers,
Conor.

> +		}
> +#endif
>  	} else {
> -		info =3D pmu_ctr_list[idx];
>  		val =3D riscv_pmu_ctr_read_csr(info.csr);
>  		if (IS_ENABLED(CONFIG_32BIT))
>  			val =3D ((u64)riscv_pmu_ctr_read_csr(info.csr + 0x80)) << 31 | val;
> --=20
> 2.34.1
>=20

--XhRhZMNOguKWXngK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXG7UwAKCRB4tDGHoIJi
0r2OAQCApjbKr5g5FWhR6Dh2IJ77Aicsmju3mhbnvHV+FF5kyQD3ZQ8zb96npad+
hNqsfLMRc6TW40sbKjhC72+9dmhHBA==
=xm03
-----END PGP SIGNATURE-----

--XhRhZMNOguKWXngK--
