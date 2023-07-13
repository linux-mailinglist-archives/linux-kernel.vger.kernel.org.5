Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE4752333
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjGMNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjGMNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:17:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B6211B;
        Thu, 13 Jul 2023 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689254240; x=1720790240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E7sEqqhbrFfmEZwgyxrnHJnRF+eAaOP0Nzd8hDng2VE=;
  b=DAfx47ovxcH19ExdJONaKhrwsaQ+hCad4Ep+e75tTXyAx8spM/iCWgLe
   C/BNRwYr2/OYhQgHVSm/hp2ttFEb6wgfADeWOMNISzApTW4FNqIVKhYC6
   DmWKRoli4kzRsaeOffqJxe6KOSGIK3x9P8nL6V6BDqoAiTmNhwsDsacTo
   UbDIsvJ+x8rSRaxHeDSK7SjtpG9QsjZYoJr7lTs0KtEYgiSXOr/9vwIeq
   QaJdAKSjfYRgP8DyOvq7jNxbIMeszoZO6rZTZiGnpO9p51p7hEZ5r6C6A
   TQqQDMKdrcWKfY+EL3hrrncl8PhUcnJL+Q8bbVNuFMZSzMia+Pxhj30kl
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="asc'?scan'208";a="220208830"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 06:17:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 06:17:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 06:17:14 -0700
Date:   Thu, 13 Jul 2023 14:16:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Evan Green <evan@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, <linux@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        <devicetree@vger.kernel.org>, <sorear@fastmail.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230713-bootleg-tray-c5bfe58b5673@wendy>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
 <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
 <20230713-3f574332a06678f908cee21e@orel>
 <20230713-aggregate-uncut-e16ee9270b14@wendy>
 <20230713-692c967c7a08c15dacbcab10@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTE48Nq7TkHCRHEc"
Content-Disposition: inline
In-Reply-To: <20230713-692c967c7a08c15dacbcab10@orel>
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

--gTE48Nq7TkHCRHEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 02:45:57PM +0200, Andrew Jones wrote:
> On Thu, Jul 13, 2023 at 12:27:24PM +0100, Conor Dooley wrote:

> > +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) {	\
> > +	.name =3D #_name,					\
> > +	.property =3D #_name,				\
> > +	.bundle_ids =3D _bundled_exts,			\
> > +	.bundle_size =3D ARRAY_SIZE(_bundled_exts)	\
> > +}
> > +
> > +static const unsigned int riscv_zk_bundled_exts[] =3D {
> > +	RISCV_ISA_EXT_ZBKB,
> > +	RISCV_ISA_EXT_ZBKC,
> > +	RISCV_ISA_EXT_ZBKX,
> > +	RISCV_ISA_EXT_ZKND,
> > +	RISCV_ISA_EXT_ZKNE,
> > +	RISCV_ISA_EXT_ZKR,
> > +	RISCV_ISA_EXT_ZKT,
>=20
> I think RISCV_ISA_EXT_ZKNH also belongs in this bundle,
> since the spec says zk is the zkn bundle plus zkr and zkt.
>=20
> > +};
> > +
> > +static const unsigned int riscv_zkn_bundled_exts[] =3D {
> > +	RISCV_ISA_EXT_ZBKB,
> > +	RISCV_ISA_EXT_ZBKC,
> > +	RISCV_ISA_EXT_ZBKX,
> > +	RISCV_ISA_EXT_ZKND,
> > +	RISCV_ISA_EXT_ZKNE,
> > +	RISCV_ISA_EXT_ZKNH,
> > +};
> > +
> > +static const unsigned int riscv_zks_bundled_exts[] =3D {
> > +	RISCV_ISA_EXT_ZBKB,
> > +	RISCV_ISA_EXT_ZBKC,
> > +	RISCV_ISA_EXT_ZKSED,
> > +	RISCV_ISA_EXT_ZKSH
>=20
> And, per the spec, this one appears to be missing RISCV_ISA_EXT_ZBKX.

Yeah, these do look wrong. I should've cross-checked it.

> I found [1] which calls these shorthands "group names", so maybe we should
> use the term "group" instead of "bundle"?

WFM at least.

> I'm tempted to try to directly
> code that graphic in [1] with something like...
>=20
> #define Zks_group1 \
> 	RISCV_ISA_EXT_ZKSED, \
> 	RISCV_ISA_EXT_ZKSH
>=20
> #define Zks_group2 \
> 	RISCV_ISA_EXT_ZBKB, \
> 	RISCV_ISA_EXT_ZBKC, \
> 	RISCV_ISA_EXT_ZBKX
>=20
> #define Zks_group \
> 	Zks_group1, \
> 	Zks_group2
>=20
> #define Zkn_group1 \
> 	RISCV_ISA_EXT_ZKND, \
> 	RISCV_ISA_EXT_ZKNE, \
> 	RISCV_ISA_EXT_ZKNH
>=20
> #define Zkn_group2 \
> 	Zks_group2
>=20
> #define Zkn_group \
> 	Zkn_group1, \
> 	Zkn_group2
>=20
> static const unsigned int riscv_zks_group[] =3D {
> 	Zks_group,
> };
>=20
> static const unsigned int riscv_zkn_group[] =3D {
> 	Zkn_group,
> };
>=20
> static const unsigned int riscv_zk_group[] =3D {
> 	Zks_group,
> 	Zkn_group,
> 	RISCV_ISA_EXT_ZKR,
> 	RISCV_ISA_EXT_ZKT,
> };
>=20
> ...but now that I have, I'm not sure I like the looks of it...

If you called them RISCV_ISA_EXT_GROUP_ZKN (or similar) it would look a
lot less out of place IMO. I'd probably drop the "group2" dance & pick a
better name for "Zks_group2", maybe just do something like
RISCV_ISA_EXT_GROUP_SCALAR_CRYPTO_BITMANIP? Mouthful, but seemed better
than trying to be clever with ZBK or something.

> [1] https://wiki.riscv.org/display/HOME/Scalar+Cryptography+Instruction+S=
et+Extension+Group+Names+Diagram


--gTE48Nq7TkHCRHEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK/5OwAKCRB4tDGHoIJi
0ry5AP99PnMNEOYct0QDkIe2N2+G1CGzJmhUN6A1xqT/KkLs0QD/aE6I9W7tY9lW
A0LBQi1Gw8uUta0WbR/Ph1YYceZVtAU=
=6z5J
-----END PGP SIGNATURE-----

--gTE48Nq7TkHCRHEc--
