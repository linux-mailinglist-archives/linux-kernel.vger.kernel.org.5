Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C777C71A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjHOFe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjHOFaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:30:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D9120;
        Mon, 14 Aug 2023 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692077397;
        bh=HfI/Zoi+DNonzXYoARisMx3D+4O9T300a5BpXZ5Mqlg=;
        h=Date:From:To:Cc:Subject:From;
        b=L6FID5/nUHg1P3TsdKZSQBvASTzjtIN/AIfhl1zpinpVlc51eXKMby0uFrANAV4yl
         7Fp5WiHW2m4qOYJdM0JtbBvkjdsoX0R6gs+ZGopexeM1cseDgFBEiqlBjcxTmjmSHw
         6NX57KOxp+Sv71DgH6GJoFjw7iIsoY2V/LUD2Swa7jtVnVSxcGJdkqKKYGCipa2sUm
         HfG3hP+nnF/CGj4bX0hN9VtsjpFcOMQMURigG38S+y91Y5U000ZBnVywQ7WKz0cMTq
         UPFGpNELcvr0MhnrzFl5kciMZwTGf91nKaUsFcgweWIBBzjaSbLjYdy3fE9+KTfawY
         zIbzEq75C5IQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ0Fw020jz4wZs;
        Tue, 15 Aug 2023 15:29:55 +1000 (AEST)
Date:   Tue, 15 Aug 2023 15:29:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20230815152951.4516ec0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UEeRqO3LgQ/SbJ//6wgJrUU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UEeRqO3LgQ/SbJ//6wgJrUU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                 from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                 from arch/powerpc/include/asm/mmu.h:396,
                 from arch/powerpc/include/asm/lppaca.h:46,
                 from arch/powerpc/include/asm/paca.h:18,
                 from arch/powerpc/include/asm/current.h:13,
                 from include/linux/thread_info.h:23,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from mm/huge_memory.c:8:
mm/huge_memory.c: In function 'maybe_pud_mkwrite':
arch/powerpc/include/asm/book3s/64/pgtable.h:934:41: error: too few argumen=
ts to function 'pte_mkwrite'
  934 | #define pud_mkwrite(pud)        pte_pud(pte_mkwrite(pud_pte(pud)))
      |                                         ^~~~~~~~~~~
mm/huge_memory.c:935:23: note: in expansion of macro 'pud_mkwrite'
  935 |                 pud =3D pud_mkwrite(pud);
      |                       ^~~~~~~~~~~
In file included from include/linux/mm.h:29:
include/linux/pgtable.h:593:21: note: declared here
  593 | static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *v=
ma)
      |                     ^~~~~~~~~~~

Caused by commit

  161e393c0f63 ("mm: Make pte_mkwrite() take a VMA")

interacting with commit

  6440c7b067ef ("powerpc/book3s64/mm: enable transparent pud hugepage")

from the mm-stable tree.

I have applied the following patch for today (hopefully it makes sense):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Aug 2023 15:15:23 +1000
Subject: [PATCH] fix up for "mm: Make pte_mkwrite() take a VMA"

interacting with commit

  6440c7b067ef ("powerpc/book3s64/mm: enable transparent pud hugepage")

from the mm-stable tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/in=
clude/asm/book3s/64/pgtable.h
index 136232a89739..5c497c862d75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -931,7 +931,7 @@ static inline pte_t *pudp_ptep(pud_t *pud)
 #define pud_mkdirty(pud)	pte_pud(pte_mkdirty(pud_pte(pud)))
 #define pud_mkclean(pud)	pte_pud(pte_mkclean(pud_pte(pud)))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
-#define pud_mkwrite(pud)	pte_pud(pte_mkwrite(pud_pte(pud)))
+#define pud_mkwrite(pud)	pte_pud(pte_mkwrite_novma(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
=20
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/UEeRqO3LgQ/SbJ//6wgJrUU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbDU8ACgkQAVBC80lX
0GyxbwgAolDrn43rWYa9wFP3NZpGFpgbuH8Xz46nqLIeWSNipNVXEY+GALOMMZeF
xATylozyBZwZ1DE6XVf6gpxxkfeQVYZV5XSsyaVYBbBAph5OaiZVZE23cgBtSuNe
R8sGFjFlPtDSrIIppNuUGQ3p9hV3VdBzsy9wXBYr/LdnSti+oWEupo13dZHInhWZ
ebXSFo420MkDUTNNXffxD0xFC1pMS3BYDfQcGafkEJuoivFhBYHOG9bOwtH6by2J
YcPRYMIerG/IQN8ox4SrpAnQtVRO3DIE1n+Farf+GsWJvBp3p9uc+SfIpvvyx1No
FdJIdnrXkisDw3sTionXP/fyIixVgA==
=Squl
-----END PGP SIGNATURE-----

--Sig_/UEeRqO3LgQ/SbJ//6wgJrUU--
