Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104E87DA995
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJ1VQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjJ1VQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:16:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24460121
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:54 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211552euoutp022323be4f7624652c18dcb01dcb7f547b~SYf3uGQPs0879208792euoutp02R
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211552euoutp022323be4f7624652c18dcb01dcb7f547b~SYf3uGQPs0879208792euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698527752;
        bh=MryWcICdLJnJIpSQ//VC4hAIbMIw5xNwvvS8lnrY/z4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ePBvv+WznISzR3zoq3qsBn2CBSEJB2wrKIglDYakrXINkRy/NEALAyS/D37Ds0sMW
         CBZwq1VbMuGTaOih6ybrOyNMlVtrlV0vm2iC1UWGc9UPbkUW/xZJlH7xcOZokOfpAz
         CCUnB7AMfrF+6pejFOr/f+mUZSEJSVinapl2Zh0g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231028211551eucas1p2e50b635ba8eae30317009299b0be2ea3~SYf2kdVsc1224812248eucas1p2E;
        Sat, 28 Oct 2023 21:15:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.57.37758.70A7D356; Sat, 28
        Oct 2023 22:15:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef~SYf2GDan11181011810eucas1p1I;
        Sat, 28 Oct 2023 21:15:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231028211550eusmtrp2373a802e94a6ccdb4bd44f64388a442f~SYf2FekMo1141411414eusmtrp2g;
        Sat, 28 Oct 2023 21:15:50 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-0b-653d7a071720
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.01.25043.60A7D356; Sat, 28
        Oct 2023 22:15:50 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231028211550eusmtip29b55570e519e6390a3d01dce2b0ec14a~SYf120roh1182011820eusmtip2p;
        Sat, 28 Oct 2023 21:15:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:50 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
        2023 22:15:50 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 09/11] shmem: add order arg to shmem_alloc_folio()
Thread-Topic: [RFC PATCH 09/11] shmem: add order arg to shmem_alloc_folio()
Thread-Index: AQHaCePsz4j06UKTKkuVsaJRZMX8Ng==
Date:   Sat, 28 Oct 2023 21:15:49 +0000
Message-ID: <20231028211518.3424020-10-da.gomez@samsung.com>
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7rsVbapBj/nSVjMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKC6blNSczLLU
        In27BK6MJdcqC05IVLxtusnYwNgh0sXIySEhYCIx8/ADli5GLg4hgRWMEq9PP4VyvjBKLN61
        iQ3C+cwo0fL1PGsXIwdYy+o9DhDx5YwSPXdOsMAVbZ96mB3COcMoMWldGyuEs5JR4uKfLawg
        G9kENCX2ndwEViUiMJtV4vDiDkaQBLNAncSaZ7NYQGxhATeJL0segsVFBLwlXvftg7L1JJoW
        9TOB2CwCqhKzu+awgdi8AjYSM89sB4tzAtn3v20HizMKyEo8WvmLHWK+uMStJ/OZIN4WlFg0
        ew8zhC0m8W/XQzYIW0fi7PUnjBC2gcTWpftYIGwliT8dC6Hu1JO4MXUKG4StLbFs4WtmiBsE
        JU7OfAIOCwmBf5wSd/5OY4VodpHY924Z1CBhiVfHt7BD2DIS/3fOZ5rAqD0LyX2zkOyYhWTH
        LCQ7FjCyrGIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMbqf/Hf+6g3HFq496hxiZOBgP
        MUpwMCuJ8DI72qQK8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8VEkhPLEnNTk0tSC2CyTJx
        cEo1ME2bOEua7+tNmcX/cuuFojOsXPecf98vK5WzNXe97IJDudOMDB5NDvfqW2s1Y/a3mYK3
        Kh89KO1v2+l2qqp9Joej7+kMhv3eHwov2nIeL7MXqbfZws1zOy+R6WRqsu4G/ffPK6a+zfQQ
        Er8x9XLGY4kNsZFnpDbNlYx9sij85daJnzUPazcFPultPtda9uzitY9n/pjbb2Ku3m43MXz+
        1+7+qr3vkrevW35Uwb8gqSv0x2EXqatO7iU1CgKnV2XdE1xa7rZSQXGxwh+xiJ3tvbVXOpnW
        v1CxtO9fp5ZpMEeWRf54eeG0Bz7T1CXv3QsLi9ZZcCk0r6t9JW9lOUNl/qoJx/mOeH7f8rxy
        5QZVByWW4oxEQy3mouJEABFLFxvdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xe7psVbapBg++GlnMWb+GzWL13X42
        i8tP+Cyefupjsdh7S9tiz96TLBaXd81hs7i35j+rxa4/O9gtbkx4ymix7Ot7dovdGxexWfz+
        MYfNgddjdsNFFo8Fm0o9Nq/Q8rh8ttRj06pONo9Nnyaxe5yY8ZvF4/MmuQCOKD2bovzSklSF
        jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MJdcqC05IVLxtusnY
        wNgh0sXIwSEhYCKxeo9DFyMXh5DAUkaJg1uPMXYxcgLFZSQ2frnKCmELS/y51sUGUfSRUeL8
        lGZWCOcMo8SUiS2MEM5KRomuHTNYQFrYBDQl9p3cxA6SEBGYzSpxeHEH2FxmgTqJNc9mgRUJ
        C7hJfFnyECwuIuAt8bpvH5StJ9G0qJ8JxGYRUJWY3TWHDcTmFbCRmHlmOxPI3UICuRL9bZkg
        YU6g8P1v28FKGAVkJR6t/MUOsUpc4taT+UwQLwhILNlznhnCFpV4+fgf1Gs6EmevP4F62UBi
        69J9LBC2ksSfjoVQJ+tJ3Jg6hQ3C1pZYtvA1M8Q5ghInZz5hmcAoPQvJullIWmYhaZmFpGUB
        I8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOS07djPLTsYV776qHeIkYmD8RCjBAezkggv
        s6NNqhBvSmJlVWpRfnxRaU5q8SFGU2AQTWSWEk3OB6bHvJJ4QzMDU0MTM0sDU0szYyVxXs+C
        jkQhgfTEktTs1NSC1CKYPiYOTqkGJsW1tlf4mY0/XmfZqfDJbrVO5TLJIKtu0z9rHdurnV4k
        fbq48pFsd4ioXs9PQdnuHAVpTk+v66+NFF6Ev6p6pCbl5C6cFjDhzNpQ4UNiCnZR7Vte7W99
        u+ksN3PQiUvL+1mtO+Sbf6+NdPM01rIpuJnhwjJ/1/dd5wUzttRZGebt2naJRf9h0yP2q7/z
        zqoaFWq9v2pgsJpjd6Ym83e//rS6uwHm6+SPB855Upmfnum7PGERq/6yRxeaY09N9Lr+c0dU
        cL8WA8/crQfv3/u1jMnRapOW6PtIncf6O2u5GLZLOXpeO14crbpwV1rUrMlqjBXbGJpXxjmX
        8xhfWDfzoWvY5CNaKUeDnaT8lR2VWIozEg21mIuKEwHPwMUl1wMAAA==
X-CMS-MailID: 20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef
X-Msg-Generator: CA
X-RootMTR: 20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <20231028211518.3424020-1-da.gomez@samsung.com>
        <CGME20231028211550eucas1p1dc1d47e413de350deda962c3df5111ef@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add folio order argument to the shmem_alloc_folio() and merge it with
the shmem_alloc_folio_huge(). Return will make use of the new
page_rmappable_folio() where order-0 and high order folios are
both supported.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d8dc2ceaba18..fc7605da4316 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1614,40 +1614,27 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t l=
imit_gfp)
 	return result;
 }
=20
-static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
-		struct shmem_inode_info *info, pgoff_t index)
+static struct folio *shmem_alloc_folio(gfp_t gfp, struct shmem_inode_info =
*info,
+				       pgoff_t index, unsigned int order)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct page *page;
=20
-	mpol =3D shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
-	page =3D alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id()=
);
+	mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
+	page =3D alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
 	mpol_cond_put(mpol);
=20
 	return page_rmappable_folio(page);
 }
=20
-static struct folio *shmem_alloc_folio(gfp_t gfp,
-		struct shmem_inode_info *info, pgoff_t index)
-{
-	struct mempolicy *mpol;
-	pgoff_t ilx;
-	struct page *page;
-
-	mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
-	page =3D alloc_pages_mpol(gfp, 0, mpol, ilx, numa_node_id());
-	mpol_cond_put(mpol);
-
-	return (struct folio *)page;
-}
-
 static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 		struct inode *inode, pgoff_t index,
 		struct mm_struct *fault_mm, size_t len)
 {
 	struct address_space *mapping =3D inode->i_mapping;
 	struct shmem_inode_info *info =3D SHMEM_I(inode);
+	unsigned int order =3D 0;
 	struct folio *folio;
 	long pages;
 	int error;
@@ -1668,12 +1655,12 @@ static struct folio *shmem_alloc_and_add_folio(gfp_=
t gfp,
 				index + HPAGE_PMD_NR - 1, XA_PRESENT))
 			return ERR_PTR(-E2BIG);
=20
-		folio =3D shmem_alloc_hugefolio(gfp, info, index);
+		folio =3D shmem_alloc_folio(gfp, info, index, HPAGE_PMD_ORDER);
 		if (!folio)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
-		pages =3D 1;
-		folio =3D shmem_alloc_folio(gfp, info, index);
+		pages =3D 1UL << order;
+		folio =3D shmem_alloc_folio(gfp, info, index, order);
 	}
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
@@ -1774,7 +1761,7 @@ static int shmem_replace_folio(struct folio **foliop,=
 gfp_t gfp,
 	 */
 	gfp &=3D ~GFP_CONSTRAINT_MASK;
 	VM_BUG_ON_FOLIO(folio_test_large(old), old);
-	new =3D shmem_alloc_folio(gfp, info, index);
+	new =3D shmem_alloc_folio(gfp, info, index, 0);
 	if (!new)
 		return -ENOMEM;
=20
@@ -2618,7 +2605,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
=20
 	if (!*foliop) {
 		ret =3D -ENOMEM;
-		folio =3D shmem_alloc_folio(gfp, info, pgoff);
+		folio =3D shmem_alloc_folio(gfp, info, pgoff, 0);
 		if (!folio)
 			goto out_unacct_blocks;
=20
--=20
2.39.2
