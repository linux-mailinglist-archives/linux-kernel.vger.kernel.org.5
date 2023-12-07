Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26647808761
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379088AbjLGMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjLGMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:09:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8651AD;
        Thu,  7 Dec 2023 04:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701950947; x=1733486947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PGxT31Xg37wy+4bCiUCfwZRvaijOlfFRgBP5EBA3Gws=;
  b=JD8SGKxRDO83kAlE5wb1Y3sgb1F3DSQJj+oM2hsYctNa3PELir9ort5w
   kboc8XZlChzfPqVDU7S6ZBhVLyFw51dzGmNuugsyz5siDnRXZcLc27cIn
   gBjtY0KHyxrbATWTHu+OHuU+pjmsqMIDNThhdZW/wli6P68DVhnb2q3Xm
   37uZOWxuUgSiIGBc3szXVdAZuG8aTLQ8dEn0hM/sfUZAnshJc5GNUQmeY
   30gMA3PN94bZvvJVP4VSr8uri3AwRrW8ssrdyl5otsSXprIrCG/pNt1N6
   fhVeSVopuQDs1+4i/eElr1ii/MAgSqI+AhAKRmiJkz/dKe3JwvkZu8iy3
   g==;
X-CSE-ConnectionGUID: r15LG2u6TWaA+hfIIKdEMQ==
X-CSE-MsgGUID: wSGchTArRhy/DVmW0Qj2Bg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="asc'?scan'208";a="180081943"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2023 05:09:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 05:08:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Dec 2023 05:08:27 -0700
Date:   Thu, 7 Dec 2023 12:07:58 +0000
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
Subject: Re: [RFC 2/9] drivers/perf: riscv: Add a flag to indicate SBI v2.0
 support
Message-ID: <20231207-professed-component-84128c06befa@wendy>
References: <20231205024310.1593100-1-atishp@rivosinc.com>
 <20231205024310.1593100-3-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+sZQ4vQi3zI/C7dL"
Content-Disposition: inline
In-Reply-To: <20231205024310.1593100-3-atishp@rivosinc.com>
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

--+sZQ4vQi3zI/C7dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 06:43:03PM -0800, Atish Patra wrote:
> SBI v2.0 added few functions to improve SBI PMU extension. In order
> to be backward compatible, the driver must use these functions only
> if SBI v2.0 is available.
>=20
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

IMO this does not make sense in a patch of its own and should probably
be squashed with the first user for it.

> ---
>  drivers/perf/riscv_pmu_sbi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 16acd4dcdb96..40a335350d08 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -35,6 +35,8 @@
>  PMU_FORMAT_ATTR(event, "config:0-47");
>  PMU_FORMAT_ATTR(firmware, "config:63");
> =20
> +static bool sbi_v2_available;
> +
>  static struct attribute *riscv_arch_formats_attr[] =3D {
>  	&format_attr_event.attr,
>  	&format_attr_firmware.attr,
> @@ -1108,6 +1110,9 @@ static int __init pmu_sbi_devinit(void)
>  		return 0;
>  	}
> =20
> +	if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> +		sbi_v2_available =3D true;
> +
>  	ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
>  				      "perf/riscv/pmu:starting",
>  				      pmu_sbi_starting_cpu, pmu_sbi_dying_cpu);
> --=20
> 2.34.1
>=20

--+sZQ4vQi3zI/C7dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXG1nQAKCRB4tDGHoIJi
0phjAP0azU1/zzjDgPsIIJnAK22vEXqExrH10eEONV0Q6Qw4TAD+LGAWT5Xv5AM3
SnKvsMXfm2zEtsmp003njCE7XqidDwI=
=Nnit
-----END PGP SIGNATURE-----

--+sZQ4vQi3zI/C7dL--
