Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9547F61A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjKWOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345772AbjKWOjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:39:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9631A8;
        Thu, 23 Nov 2023 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700750358; x=1732286358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mio/kqNaH+U+jZDajo8QsPctXLeEgKj3mmEzUpaptE=;
  b=uy6sth0XpBDieWmqTLLcKObU0l5RePp1b+wounYNo/cIUBlw0rQgijII
   oBGhH+21EmDMLepyfmGgYWTfrPVwg7neEvGVjhw8nZfNPvmAH50qyJiFP
   CHR3bgiB88pF+1PHebhNQVlBhzToZYrq0QUyGPTHyZD3ATLjXLTG4uEtg
   NUJoYLvWsf8n4VkGwWZPTC7zbT3vdUeVm0tppUdQk4NX8Cd0MyVtkZ5zu
   fmbEAYzMHM+TSl8D9QnCCvxa9TOZ/OgxgyNAOw7mT8qRsyucumjjIwZ7+
   VTXzwnI7xQWyLv2xj77EYBdWmjLaEM7tjTrUhz9J7y9qDtdKVqtF8/Own
   Q==;
X-CSE-ConnectionGUID: 4AAYCoZfTi6PJe832bnWGg==
X-CSE-MsgGUID: 4TersX+dTLKSZqX2n5bjxw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12937545"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 07:39:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 07:39:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 07:38:58 -0700
Date:   Thu, 23 Nov 2023 14:38:30 +0000
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
Subject: Re: [PATCH v4 04/13] dt-bindings: riscv: Add Andes interrupt
 controller compatible string
Message-ID: <20231123-vigorous-worrier-c8ed0fbbec55@wendy>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-5-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Myq4yn8cC+6SYdA6"
Content-Disposition: inline
In-Reply-To: <20231122121235.827122-5-peterlin@andestech.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Myq4yn8cC+6SYdA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 08:12:26PM +0800, Yu Chien Peter Lin wrote:
> Add "andestech,cpu-intc" compatible string to indicate that
> Andes specific local interrupt is supported on the core,
> e.g. AX45MP cores have 3 types of non-standard local interrupt
> can be handled in supervisor mode:
>=20
> - Slave port ECC error interrupt
> - Bus write transaction error interrupt
> - Performance monitor overflow interrupt
>=20
> These interrupts are enabled/disabled via a custom register
> SLIE instead of the standard interrupt enable register SIE.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Updated commit message
>   - Fixed possible compatibles for Andes INTC
> Changes v3 -> v4:
>   - Add const entry instead of enum (Suggested by Conor)
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index f392e367d673..50307554478f 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -100,7 +100,11 @@ properties:
>          const: 1
> =20
>        compatible:
> -        const: riscv,cpu-intc
> +        oneOf:
> +          - items:
> +              - const: andestech,cpu-intc
> +              - const: riscv,cpu-intc
> +          - const: riscv,cpu-intc
> =20
>        interrupt-controller: true
> =20
> --=20
> 2.34.1
>=20

--Myq4yn8cC+6SYdA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9j5gAKCRB4tDGHoIJi
0hycAP9qsI3APm3yGB24FyPPA6csDBgW0MdowMy/BXFdk8mpqgD6A+eIkaU3B8V0
LKuOUJhXb2lSRMosR/DWKoi3S/tGZgg=
=H/7m
-----END PGP SIGNATURE-----

--Myq4yn8cC+6SYdA6--
