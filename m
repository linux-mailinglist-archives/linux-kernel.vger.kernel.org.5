Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9697F622C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbjKWO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:59:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391ED41;
        Thu, 23 Nov 2023 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700751584; x=1732287584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EbumtQAp61xxtl1wFucMhCk0s7eSuM0PDcdqsk0vVXY=;
  b=obSJa5VoOIud2t1a1f3MKpv08+Ly8SjUSJ8d2VAfEy46y7XRUHkXzfz4
   hj1UwfrsUHyue0awmNsN8V3mnG2SCv27GCKA8zCZsGuAZGwMjcyoX++Uw
   pf/PAkEpruBu4XJbCgZdv3Q4a5zHSfLimE923xQQbkdEeUfyyjj0Kf+6z
   Ve2i4I5DqQ6OHlNykkAHgad7c3dnutImNvimxUwM5g+fgVtkoO43Vlro0
   KCrgf2WKuNqxDMZm0k07/39It7BEpR2Uec3n/xic/qXeZ28OMXxbu/bpg
   RFMjk/959mBSZ+HSfDfy71yUOmwRJqnNjx0DGXB99AUKb+USkV9leEMmm
   g==;
X-CSE-ConnectionGUID: dphmfmJ6QC2EtHTlf6BQfw==
X-CSE-MsgGUID: yYZjdC/+SzKEzWIlmXahFg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,222,1695711600"; 
   d="asc'?scan'208";a="12119561"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 07:59:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 07:59:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 07:59:23 -0700
Date:   Thu, 23 Nov 2023 14:58:55 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <dminus@andestech.com>,
        <evan@rivosinc.com>, <geert+renesas@glider.be>,
        <guoren@kernel.org>, <heiko@sntech.de>, <irogers@google.com>,
        <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>, <inochiama@outlook.com>
Subject: Re: [PATCH v4 11/13] riscv: dts: allwinner: Add T-Head PMU extension
Message-ID: <20231123-coping-revenue-be284a351c9d@wendy>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-12-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/5s3BqTCv3O//+Ke"
Content-Disposition: inline
In-Reply-To: <20231122121235.827122-12-peterlin@andestech.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/5s3BqTCv3O//+Ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 08:12:33PM +0800, Yu Chien Peter Lin wrote:
> xtheadpmu stands for T-Head Performance Monitor Unit extension.
> Based on the added T-Head PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.

Allwinner aren't the only ones using T-Head CPUs that the previous
m*id pmu detection code would have matched on. I think the first three
files below will also need to be updated:

rg -l "thead,c[0-9]*\b[^-]" arch/riscv/boot/dts/
arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
arch/riscv/boot/dts/sophgo/cv1800b.dtsi
arch/riscv/boot/dts/thead/th1520.dtsi
arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi

Cheers,
Conor.

--/5s3BqTCv3O//+Ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9orwAKCRB4tDGHoIJi
0mywAQDLiZ7Dv/EbYy9xnbLn22k0W8jszlQjb/0c3Uj362SnMAD+NfU0XmNTf1e8
tbN33jbWPlia/s7ecfUt/OgqNf7XxAY=
=CJRs
-----END PGP SIGNATURE-----

--/5s3BqTCv3O//+Ke--
