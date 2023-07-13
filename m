Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E041751FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjGML2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjGML2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:28:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBA26B0;
        Thu, 13 Jul 2023 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689247693; x=1720783693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cVM22aFlEy9aqP2P/kawC3TheqKMPle1ATBYdtUqA0w=;
  b=YmqwTwM/s+XMtp2BC6ZbRjc6eY8NIkjLfaU7VH6iW+394A8E4t9nOFgH
   emNWhmhb3AGAPfKNOhFDI5VgjA9Oa46VxOEuscAyUpFjXUR5mLWWNRqto
   WR721ecEkiCDP9v3q94QUPaSTOsV9z8HyIYF8ffA25cHKBABw26eYKeYm
   gjvDtt16FaUE1T1Oe5ib5irFHsD/JNW/kELmDtgMnE4MGwL2cpj9dck4r
   nK63bal8lABq9NijpKX7eJ6C9DeqyX0B+eao2GKNnLD/AMiMcA+RN7mM3
   CVSmDm5uceu1QxGpQUrv3QWVRu1odoGXmZH8C/ozca0zYJZ87GSMRCn8k
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="asc'?scan'208";a="235304537"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 04:28:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 04:27:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 04:27:56 -0700
Date:   Thu, 13 Jul 2023 12:27:24 +0100
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
Message-ID: <20230713-aggregate-uncut-e16ee9270b14@wendy>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
 <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
 <20230713-3f574332a06678f908cee21e@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZTjz7FUhxdRtBBlI"
Content-Disposition: inline
In-Reply-To: <20230713-3f574332a06678f908cee21e@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ZTjz7FUhxdRtBBlI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:46:14AM +0200, Andrew Jones wrote:
> On Wed, Jul 12, 2023 at 10:43:33AM -0700, Evan Green wrote:
> > On Wed, Jul 12, 2023 at 3:39=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > > On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> > > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > > >
> > > > Parse Zb/Zk related string from DT and output them to cpuinfo.
> > >
> > > One thing that has sprung to mind is that this is not limited to DT
> > > anymore, since the information could in theory come from ACPI too.
> > > Ditto the title I guess.
> > >
> > > > It is worth noting that the Scalar Crypto extension defines "zk" as=
 a
> > > > shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one al=
so
> > > > implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> > > > "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> > > > Zbkx, Zkn, Zkr and Zkt extensions.
> > > >
> > > > Also, since there currently is no mechanism to merge all enabled
> > > > extensions, the generated cpuinfo output could be relatively large.
> > > > For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_=
zks"
> > > > will generate the following cpuinfo output:
> > > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
> > >
> > > On that note, I've created another version of what checking for
> > > supersets could look like, since it'll be needed either by my series =
or
> > > this one, depending on what gets merged first. I've yet to test the
> > > dedicated extensions part of it, but I wanted to get this out before I
> > > went looking at other fixes in the area.
> > >
> > > Evan, since it was you that commented on this stuff last time around,
> > > could you take another look? I'm still not keen on the "subset_of"
> > > arrays, but they're an improvement on what I had last time around for
> > > sure.
> > >
> >=20
> > This looks alright to me. At the risk of getting into bikeshedding
> > territory, the only awkward bit of it is it composes the extensions in
> > sort of the opposite way you'd expect. I tend to think of Zks as being
> > comprised of {zbkb, zbkc, zksed, zksh},
>=20
> This is also the way I think of it, so, FWIW, I prefer the approach below,
> where bundles are expanded.

I took the patch Evan sent me off-list & have spun it into a "real"
patch. I did some minor changes (c99 loop, __init marking) to match what
the code was already doing and expanded it to work for the new property
stuff.
I'm not sure that match_isa_ext() needs to be a function, given the
single user - it might be better refactored to drop the outer if & return
whether a match was found.
If done that would allow sharing the same function between isa string and
dedicated property parsing. I left it intact for now. Might also be
worth adding kerneldoc for that struct.

-- >8 --
=46rom 8300b98e487e57d192bc9581c6a3639c40c52623 Mon Sep 17 00:00:00 2001
=46rom: Evan Green <evan@rivosinc.com>
Date: Wed, 12 Jul 2023 10:36:15 -0700
Subject: [PATCH] RISC-V: Add support Scalar Crypto using "bundled extension=
s"

The Scalar Crypto specification defines Zk as a shorthand for the
Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
which are all shorthands for various other extensions. The detailed
breakdown can be found in their dt-binding entries.

Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
"zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt.
For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
should generate the following cpuinfo output:
"rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_z=
kt"

riscv_isa_ext_data grows a pair of new members, to permit setting the
relevant bits for "bundled" extensions, both while parsing the ISA string
and the new dedicated extension properties

Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
There's basically none of the original patch left, so I have dropped the
co-developed-bys and signed-off-bys from before. It does need one from
you now though Evan!
---
 arch/riscv/include/asm/hwcap.h | 13 +++++
 arch/riscv/kernel/cpufeature.c | 94 ++++++++++++++++++++++++++++------
 2 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..f74308633e45 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,17 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_ZBC              43
+#define RISCV_ISA_EXT_ZBKB             44
+#define RISCV_ISA_EXT_ZBKC             45
+#define RISCV_ISA_EXT_ZBKX             46
+#define RISCV_ISA_EXT_ZKND             47
+#define RISCV_ISA_EXT_ZKNE             48
+#define RISCV_ISA_EXT_ZKNH             49
+#define RISCV_ISA_EXT_ZKR              50
+#define RISCV_ISA_EXT_ZKSED            51
+#define RISCV_ISA_EXT_ZKSH             52
+#define RISCV_ISA_EXT_ZKT              53
=20
 #define RISCV_ISA_EXT_MAX		64
=20
@@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
 	const char *property;
+	const unsigned int *bundle_ids;
+	const unsigned int bundle_size;
 };
=20
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ccbe27b3060b..d999d73554f0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -105,6 +105,39 @@ static bool riscv_isa_extension_check(int id)
 	.id =3D _id,				\
 }
=20
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) {	\
+	.name =3D #_name,					\
+	.property =3D #_name,				\
+	.bundle_ids =3D _bundled_exts,			\
+	.bundle_size =3D ARRAY_SIZE(_bundled_exts)	\
+}
+
+static const unsigned int riscv_zk_bundled_exts[] =3D {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKR,
+	RISCV_ISA_EXT_ZKT,
+};
+
+static const unsigned int riscv_zkn_bundled_exts[] =3D {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKNH,
+};
+
+static const unsigned int riscv_zks_bundled_exts[] =3D {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZKSED,
+	RISCV_ISA_EXT_ZKSH
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined=
 in
  * chapter 27 of the unprivileged specification.
@@ -167,7 +200,20 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
 	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
@@ -179,6 +225,26 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
=20
 const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
=20
+static void inline __init match_isa_ext(const struct riscv_isa_ext_data *e=
xt, const char *name,
+					const char *name_end, struct riscv_isainfo *isainfo)
+{
+	if ((name_end - name =3D=3D strlen(ext->name)) &&
+	     !strncasecmp(name, ext->name, name_end - name)) {
+		/*
+		 * If this is a bundle, enable all the ISA extensions that
+		 * comprise the bundle.
+		 */
+		if (ext->bundle_size) {
+			for (int i =3D 0; i < ext->bundle_size; i++) {
+				if (riscv_isa_extension_check(ext->bundle_ids[i]))
+					set_bit(ext->bundle_ids[i], isainfo->isa);
+			}
+		} else if (riscv_isa_extension_check(ext->id)) {
+			set_bit(ext->id, isainfo->isa);
+		}
+	}
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struc=
t riscv_isainfo *isainfo,
 					  unsigned long *isa2hwcap, const char *isa)
 {
@@ -310,14 +376,6 @@ static void __init riscv_parse_isa_string(unsigned lon=
g *this_hwcap, struct risc
 		if (*isa =3D=3D '_')
 			++isa;
=20
-#define SET_ISA_EXT_MAP(name, bit)						\
-		do {								\
-			if ((ext_end - ext =3D=3D strlen(name)) &&			\
-			     !strncasecmp(ext, name, strlen(name)) &&		\
-			     riscv_isa_extension_check(bit))			\
-				set_bit(bit, isainfo->isa);			\
-		} while (false)							\
-
 		if (unlikely(ext_err))
 			continue;
 		if (!ext_long) {
@@ -329,10 +387,8 @@ static void __init riscv_parse_isa_string(unsigned lon=
g *this_hwcap, struct risc
 			}
 		} else {
 			for (int i =3D 0; i < riscv_isa_ext_count; i++)
-				SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
-						riscv_isa_ext[i].id);
+				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
 		}
-#undef SET_ISA_EXT_MAP
 	}
 }
=20
@@ -436,18 +492,26 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
 		}
=20
 		for (int i =3D 0; i < riscv_isa_ext_count; i++) {
+			const struct riscv_isa_ext_data ext =3D riscv_isa_ext[i];
+
 			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
-						     riscv_isa_ext[i].property) < 0)
+						     ext.property) < 0)
 				continue;
=20
-			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
+			if (ext.bundle_size) {
+				for (int j =3D 0; j < ext.bundle_size; j++) {
+					if (riscv_isa_extension_check(ext.bundle_ids[i]))
+						set_bit(ext.bundle_ids[j], this_isa);
+				}
+			} else if (riscv_isa_extension_check(ext.id)) {
+				set_bit(ext.id, this_isa);
+			} else {
 				continue;
+			}
=20
 			/* Only single letter extensions get set in hwcap */
 			if (strnlen(riscv_isa_ext[i].name, 2) =3D=3D 1)
 				this_hwcap |=3D isa2hwcap[riscv_isa_ext[i].id];
-
-			set_bit(riscv_isa_ext[i].id, this_isa);
 		}
=20
 		of_node_put(cpu_node);
--=20
2.40.1



--ZTjz7FUhxdRtBBlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK/fnAAKCRB4tDGHoIJi
0qHVAPsG/LcopHKPJTYnEd8RN/papFF3NBBsGZ/NtVhAUU4zpwEAmqs8YptV4QLN
wb9Vtq3mB5Eq4pAA8+xbPMrZwQ9xHQE=
=Y7gz
-----END PGP SIGNATURE-----

--ZTjz7FUhxdRtBBlI--
