Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31076750FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGLRoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:44:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5482EA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:44:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so11510020e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689183849; x=1691775849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFdASlJUOVHSW6ne3w5Oo/kyUPOyXLikOFweT7Qj+YY=;
        b=GMAzSuxQIJpxJ5laPdO3tvKZjGdCUH0temE0+5wv3CUdh/rpKA05JeEhZ28qtpcFNV
         PB6sVXEIWZzRtMF1CAT2kPz3M7DCjyag1KqfGDE27dLkRJWrke3uYZwmWDzKb9QZuQ9d
         S0SnZI992g2PLZpIoZlfV9O/jW1f8aHR2nyD11Bm7+EYCeE5h8obwEnpJKkvmFvPO+YZ
         8XE8hnIs06558h1M/UESCUDBbZ+gESGz8g3eA85PMdfomSX1HamQzU6RjhVGfhMR2Hf/
         UBOPwYXlvLP7St70j33UL1jwl4EngufXx7kulYPLbBYWXQW2nZ54LCe/rQW4op901+L+
         hDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183849; x=1691775849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFdASlJUOVHSW6ne3w5Oo/kyUPOyXLikOFweT7Qj+YY=;
        b=JUTB21/cyrLIVOIP8LOH6BA1ykWHWTg2FheHVhn8WMRpI6S/dvaPspobHkWLGpv3l2
         XzcZc5jkTdw9sHmv1pEh01ocuKJJs9H/bEr8IUk6iy7q9P0n4aji8a/mRGYZXE8yM4u/
         BHmYqI2N9jmuyJdZdPC2oZ1YByFNYXTyhjrwZEeQGBdrN8CfVc5t74P6qINjMpBe0iLS
         UxYc9gu1f4xRz70aSXvTrU1JWtef8Fo0bvb43pmmQaGo54uiNdH7zR93G3ilgQ2la47m
         AehuIImXpv4RPFP8cbRCoaiSlAj0bnJHParZgeLsmMaQHBQC+CO5HB3hQzWcAJdOBDt9
         QsFQ==
X-Gm-Message-State: ABy/qLaocCO+S+ArhjwqzWUM/s5dvRCGsuwC1iD2WZeOJnVahq7VbK4j
        91xYiLnEwHux821HLO0aKYF1KiuXEwoiiRs9LwBP4g==
X-Google-Smtp-Source: APBJJlGLgQdsIIBAYgIUN6rvFu1eGu/3vpUy0NjeuYvuAJsrt4QlurE9526H/4onBGwr+oB1g+n0AAbmwhZRYFa2yn4=
X-Received: by 2002:a05:6512:3b3:b0:4f9:571d:c50e with SMTP id
 v19-20020a05651203b300b004f9571dc50emr15377063lfp.36.1689183849206; Wed, 12
 Jul 2023 10:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230712084134.1648008-1-sameo@rivosinc.com> <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
In-Reply-To: <20230712-bulldozer-affected-199042dc3afd@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 12 Jul 2023 10:43:33 -0700
Message-ID: <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        devicetree@vger.kernel.org, sorear@fastmail.com,
        Jiatai He <jiatai2021@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 3:39=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Samuel, Evan,
>
> On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> >
> > Parse Zb/Zk related string from DT and output them to cpuinfo.
>
> One thing that has sprung to mind is that this is not limited to DT
> anymore, since the information could in theory come from ACPI too.
> Ditto the title I guess.
>
> > It is worth noting that the Scalar Crypto extension defines "zk" as a
> > shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> > implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> > "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> > Zbkx, Zkn, Zkr and Zkt extensions.
> >
> > Also, since there currently is no mechanism to merge all enabled
> > extensions, the generated cpuinfo output could be relatively large.
> > For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> > will generate the following cpuinfo output:
> > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
>
> On that note, I've created another version of what checking for
> supersets could look like, since it'll be needed either by my series or
> this one, depending on what gets merged first. I've yet to test the
> dedicated extensions part of it, but I wanted to get this out before I
> went looking at other fixes in the area.
>
> Evan, since it was you that commented on this stuff last time around,
> could you take another look? I'm still not keen on the "subset_of"
> arrays, but they're an improvement on what I had last time around for
> sure.
>

This looks alright to me. At the risk of getting into bikeshedding
territory, the only awkward bit of it is it composes the extensions in
sort of the opposite way you'd expect. I tend to think of Zks as being
comprised of {zbkb, zbkc, zksed, zksh}, rather than zbkb being a part
of {zks, zkn, zk}, though both are of course correct. Here's an
untested version of the other way. You can decide if you like it
better or worse than what you've got, and I'm fine either way. Sorry
gmail mangles it, if you want the patch for real I can get it to you:

From e201c34c05cd82812b5b3f47ccdd7d5909259f07 Mon Sep 17 00:00:00 2001
From: Evan Green <evan@rivosinc.com>
Date: Wed, 12 Jul 2023 10:36:15 -0700
Subject: [PATCH] WIP: RISC-V: Allow support for bundled extensions, and add=
 Zk*

---
 arch/riscv/include/asm/hwcap.h | 13 ++++++
 arch/riscv/kernel/cpufeature.c | 82 +++++++++++++++++++++++++++++-----
 2 files changed, 84 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.=
h
index b7b58258f6c7..7d2d10b42cf3 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,17 @@
 #define RISCV_ISA_EXT_ZICSR            40
 #define RISCV_ISA_EXT_ZIFENCEI         41
 #define RISCV_ISA_EXT_ZIHPM            42
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

 #define RISCV_ISA_EXT_MAX              64

@@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
        const unsigned int id;
        const char *name;
        const char *property;
+       const unsigned int *bundled_exts;
+       const unsigned int bundle_size;
 };

 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.=
c
index 5945dfc5f806..2a1f958c1777 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -105,6 +105,39 @@ static bool riscv_isa_extension_check(int id)
        .id =3D _id,                              \
 }

+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) { \
+       .name =3D #_name,                         \
+       .property =3D #_name,                     \
+       .bundled_exts =3D _bundled_exts,          \
+       .bundle_size =3D ARRAY_SIZE(_bundled_exts)        \
+}
+
+static const unsigned int riscv_zk_bundled_exts[] =3D {
+       RISCV_ISA_EXT_ZBKB,
+       RISCV_ISA_EXT_ZBKC,
+       RISCV_ISA_EXT_ZBKX,
+       RISCV_ISA_EXT_ZKND,
+       RISCV_ISA_EXT_ZKNE,
+       RISCV_ISA_EXT_ZKR,
+       RISCV_ISA_EXT_ZKT,
+};
+
+static const unsigned int riscv_zkn_bundled_exts[] =3D {
+       RISCV_ISA_EXT_ZBKB,
+       RISCV_ISA_EXT_ZBKC,
+       RISCV_ISA_EXT_ZBKX,
+       RISCV_ISA_EXT_ZKND,
+       RISCV_ISA_EXT_ZKNE,
+       RISCV_ISA_EXT_ZKNH,
+};
+
+static const unsigned int riscv_zks_bundled_exts[] =3D {
+       RISCV_ISA_EXT_ZBKB,
+       RISCV_ISA_EXT_ZBKC,
+       RISCV_ISA_EXT_ZKSED,
+       RISCV_ISA_EXT_ZKSH
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
+       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
        __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+       __RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
+       __RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
+       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+       __RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
+       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
        __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
        __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
        __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
@@ -179,6 +225,30 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {

 const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);

+static void match_isa_ext(const struct riscv_isa_ext_data *ext, const
char *name,
+                         const char *name_end, struct riscv_isainfo *isain=
fo)
+{
+       if ((name_end - name =3D=3D strlen(ext->name)) &&
+            !strncasecmp(name, ext->name, name_end - name)) {
+
+               /*
+                * If this is a bundle, enable all the ISA extensions that
+                * comprise the bundle.
+                */
+               if (ext->bundle_size) {
+                       unsigned int i;
+                       for (i =3D 0; i < ext->bundle_size; i++) {
+                               if
(riscv_isa_extension_check(ext->bundled_exts[i]))
+                                       set_bit(ext->bundled_exts[i],
isainfo->isa);
+                       }
+
+
+               } else if (riscv_isa_extension_check(ext->id)) {
+                       set_bit(ext->id, isainfo->isa);
+               }
+       }
+}
+
 static void __init riscv_parse_isa_string(unsigned long *this_hwcap,
struct riscv_isainfo *isainfo,
                                          unsigned long *isa2hwcap,
const char *isa)
 {
@@ -310,14 +380,6 @@ static void __init
riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
                if (*isa =3D=3D '_')
                        ++isa;

-#define SET_ISA_EXT_MAP(name, bit)
         \
-               do {
         \
-                       if ((ext_end - ext =3D=3D sizeof(name) - 1) &&
         \
-                            !strncasecmp(ext, name, sizeof(name) - 1)
&&       \
-                            riscv_isa_extension_check(bit))
         \
-                               set_bit(bit, isainfo->isa);
         \
-               } while (false)
         \
-
                if (unlikely(ext_err))
                        continue;
                if (!ext_long) {
@@ -329,10 +391,8 @@ static void __init
riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
                        }
                } else {
                        for (int i =3D 0; i < riscv_isa_ext_count; i++)
-                               SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
-                                               riscv_isa_ext[i].id);
+                               match_isa_ext(&riscv_isa_ext[i], ext,
ext_end, isainfo);
                }
-#undef SET_ISA_EXT_MAP
        }
 }
