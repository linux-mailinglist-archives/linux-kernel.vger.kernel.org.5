Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793780876C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjLGMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:12:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB7CA;
        Thu,  7 Dec 2023 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701951158; x=1733487158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUdSIX8FoylL7nOf/wJzJkkU/Ybmn3rRb/4PMgZXUHU=;
  b=lWwdoA/9smlUWJM/gWPYauCfbklKRNhV81yDL6bMqrdrSO47xaqH7+z6
   /ib7YVjylOL17zEa30/cacwhKtR6uDg1Zg1yNzBYNTlnQPrhUqnYoRNP2
   hZYnTBBysrkmHxx7jo87tuq0tc6awMbgKzEHZ7YskPZN64KhggRM51VYu
   ouys+fTeRx7Yg+2j+DptJSUNuTN+2Us9PZqhwWLfdfwwd8+wo59LqLnUB
   Y07Kjh9KPnuHAorSy7Xn5lIpHzIw6V+rjHscopm3xu+4OorhGAEM/a92X
   bU+2cSWLKVCLf7fSA75DcYp2fsHkMQAbr20KgJL+hahsdC3W4DNEX2604
   Q==;
X-CSE-ConnectionGUID: qtDtQC/MR0SMM/C1i87NvA==
X-CSE-MsgGUID: s22SpVhHSQ68I8AV5gRHvg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="13245727"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 05:12:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 05:12:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 05:12:18 -0700
Date:   Thu, 7 Dec 2023 12:11:48 +0000
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
Subject: Re: [RFC 3/9] RISC-V: Add FIRMWARE_READ_HI definition
Message-ID: <20231207-jailbreak-kinsman-7353788a9a40@wendy>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
 <20231205024310.1593100-4-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bcU5bmCaFN29LsCy"
Content-Disposition: inline
In-Reply-To: <20231205024310.1593100-4-atishp@rivosinc.com>
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

--bcU5bmCaFN29LsCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 06:43:04PM -0800, Atish Patra wrote:
> SBI v2.0 added another function to SBI PMU extension to read
> the upper bits of a counter with width larger than XLEN.

This definition here is quite a lot less specific than that in 11/1 of
the spec. I don't think that really matters much in reality since we
only support exactly one XLEN where that is the case.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Add the definition for that function.
>=20
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..f3eeca79a02d 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -121,6 +121,7 @@ enum sbi_ext_pmu_fid {
>  	SBI_EXT_PMU_COUNTER_START,
>  	SBI_EXT_PMU_COUNTER_STOP,
>  	SBI_EXT_PMU_COUNTER_FW_READ,
> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
>  };
> =20
>  union sbi_pmu_ctr_info {
> --=20
> 2.34.1
>=20

--bcU5bmCaFN29LsCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXG2hAAKCRB4tDGHoIJi
0u82AQDwi9UWn/9J92nmBoN8G2OQGiug9IR7IXTBPPHlWTNSfAD/QYb6iHZA/FQG
jX9pKcuUfaQ3vFjOevTwuCQy563jmAo=
=tIJW
-----END PGP SIGNATURE-----

--bcU5bmCaFN29LsCy--
