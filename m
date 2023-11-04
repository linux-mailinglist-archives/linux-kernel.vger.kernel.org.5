Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640C7E0CF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKDA6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjKDA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:58:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10BE3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:57:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231104005754euoutp012e60a1bedd4d484c750e76b220e5ec87~URZb1op5z1873918739euoutp01M
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 00:57:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231104005754euoutp012e60a1bedd4d484c750e76b220e5ec87~URZb1op5z1873918739euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699059474;
        bh=1KdTgtYEN2dnWWW2liOHDQAROLy4THOQmqwXWvqVoBg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SUcbDIYmLUZfmeHpoem3N3WYTH3mXMqK5IK/fsr3MMdJT3b0JEfCVpXuWEjHz21wV
         C4vvMk2RkInPUV8lBUPXAGXtOGs2gA4EbqF1DEakX9N7AxvQykm0xPj2OAfJFTmKki
         KYIGCFooSRYP2Sbz0jjVLKSLtDF++5xPjvj4wvxY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231104005753eucas1p1a92a433419ced42881862ba7643d303d~URZbdRkCt2722627226eucas1p1O;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.9E.42423.11795456; Sat,  4
        Nov 2023 00:57:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231104005753eucas1p19e4ec0196f5ea297f59fb86b2a648b53~URZbHLER31996619966eucas1p1p;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231104005753eusmtrp297c5d7c9860fb6d646e7d3309512a88f~URZbGq1Ei0448904489eusmtrp2t;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-38-65459711785b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.08.25043.11795456; Sat,  4
        Nov 2023 00:57:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231104005753eusmtip1cddf8a9bfb0b96b110e142adafaad76f~URZa8Fzl61908919089eusmtip1Q;
        Sat,  4 Nov 2023 00:57:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 4 Nov 2023 00:57:51 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 4 Nov
        2023 00:57:51 +0000
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Thread-Topic: [PATCH 1/2] test_xarray: add tests for advanced multi-index
        use
Thread-Index: AQHaDrnvyiy7tu6TLES21e0ZuAEgHQ==
Date:   Sat, 4 Nov 2023 00:57:50 +0000
Message-ID: <20231104005747.1389762-2-da.gomez@samsung.com>
In-Reply-To: <20231104005747.1389762-1-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOV3B6a6pBrdvK1pc3jWHzeLGhKeM
        Fr9/zGFzYPbYvELLY9OqTjaPz5vkApijuGxSUnMyy1KL9O0SuDL+729hL3irXrHoylHWBsb5
        Cl2MnBwSAiYSn0/OYu1i5OIQEljBKLG1cSozhPOFUeLJxcdMEM5nRomFP28ww7Q83j2NDcQW
        ElgO1HJOCa5o4915UO2nGSUO3D+DMHja1Olg7WwCmhL7Tm5iB7FFBPQlVl46ywhSxCzwilHi
        3dGJLCAJYQEPiS37z7NBFPlLTNz6iBXC1pP40H4XrIZFQEXiwYS1YHFeAWuJ5sUPmUBsTgEb
        iT2r14MtYBSQlXi08heYzSwgLnHryXwmiB8EJRbN3gP1j5jEv10P2SBsHYmz158wQtgGEluX
        7mOBsJUk/nQsZISYoydxY+oUNghbW2LZwtfMEDcISpyc+YQF5BkJgcmcEruubGGFaHaRWPV5
        CdRQYYlXx7ewQ9gyEv93zmeawKg9C8l9s5DsmIVkxywkOxYwsqxiFE8tLc5NTy02zEst1ytO
        zC0uzUvXS87P3cQITCin/x3/tINx7quPeocYmTgYDzFKcDArifA6erukCvGmJFZWpRblxxeV
        5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTCFXeWstH7uut7l6xyLr1UTmXfV
        2Fx97bvT5P6NWY4eMb/fftAICb/d5/zvY9TJryzZWquOM17qzFgkPGGK6CGF/9fNk1UE5Sy/
        HVSpPX1rSfYEddtEhWcG03Z+lJB+J/HS5i7jhbjyGyLnP/95fKijsPB8W5g+o6zCmZS2d2Kb
        PkidZ5GYLccs/TK5NsePY4mlzDnLr7cW9rWs7VHP/hmu3n9hgba2o59AfuG1KqEf3UvWueqo
        cYSw9K/cJvJgpoZ5p9K22NvVRutE+2fIp1T77zWd8zzhpcL5fb+kc9dEJq+5WVtw8r1Y6tP9
        Htz3+EzvrDNQZV/4w6D70vxp0csffvz8Tub2wsXX15W9e3pDiaU4I9FQi7moOBEAxe8JPJcD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4XV3B6a6pBh0feC0u75rDZnFjwlNG
        i98/5rA5MHtsXqHlsWlVJ5vH501yAcxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
        sVZGpkr6djYpqTmZZalF+nYJehn/97ewF7xVr1h05ShrA+N8hS5GTg4JAROJx7unsXUxcnEI
        CSxllDj/5zU7REJGYuOXq6wQtrDEn2tdUEUfGSW2tl5ihnBOM0p8OTKfEcJZwSjx70AzWDub
        gKbEvpObwGwRAX2JlZfOghUxC7xilGh4sJoJJCEs4CGxZf95NogiX4k7pzqYIWw9iQ/td1lA
        bBYBFYkHE9aC3cErYC3RvPghWK8QkP29/QCYzSlgI7Fn9XqwZYwCshKPVv4Cs5kFxCVuPZnP
        BPGDgMSSPeeZIWxRiZeP/0H9piNx9voTRgjbQGLr0n0sELaSxJ+OhYwQc/QkbkydwgZha0ss
        W/iaGeIeQYmTM5+wTGCUnoVk3SwkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+
        7iZGYFLYduznlh2MK1991DvEyMTBeIhRgoNZSYTX0dslVYg3JbGyKrUoP76oNCe1+BCjKTCM
        JjJLiSbnA9NSXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD07yN
        SeEm26xOuXZ+vnr/qdUJgaTew6cEtp4Ns2dxlMiZZiTtdbtxuv+1FzGP892z/E2f31z4fB1X
        SNr6rpr9u6a2vl4hd/lLleaFY6Hvvu3fc2Fugcux6cvEeXMba6ebfbNvs66x28Do7m+ju+Gh
        0dp/PMJ5t62VzF5OvFgscTwh735X9YuTPb6reRlu6l3tuSM4MfPfxAkih43tXSb5v/5lLJP5
        7cNGJ59NtSkR0yR8tB435Mn9uf4kmsfdJK5dp/nFKcnEb7lHf7dI/WD4NS+da35BEy/D1i1M
        P2sXmHT63bQ9ksZowqQoe1nCjfdaA5dffnC89A2duu75F57wWwcsOHuf/VXHTtc/3gcslViK
        MxINtZiLihMBl6/+0JMDAAA=
X-CMS-MailID: 20231104005753eucas1p19e4ec0196f5ea297f59fb86b2a648b53
X-Msg-Generator: CA
X-RootMTR: 20231104005753eucas1p19e4ec0196f5ea297f59fb86b2a648b53
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231104005753eucas1p19e4ec0196f5ea297f59fb86b2a648b53
References: <20231104005747.1389762-1-da.gomez@samsung.com>
        <CGME20231104005753eucas1p19e4ec0196f5ea297f59fb86b2a648b53@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The multi index selftests are great but they don't replicate
how we deal with the page cache exactly, which makes it a bit
hard to follow as the page cache uses the advanced API.

Add tests which use the advanced API, mimicking what we do in the
page cache, while at it, extend the example to do what is needed for
min order support.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Tested-by: Daniel Gomez <da.gomez@samsung.com>
---
 lib/test_xarray.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..0572a3ec2cf8 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -674,6 +674,139 @@ static noinline void check_multi_store(struct xarray =
*xa)
 #endif
 }
=20
+#ifdef CONFIG_XARRAY_MULTI
+static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
+						  unsigned long index,
+						  unsigned int order,
+						  void *p)
+{
+	XA_STATE(xas, xa, index);
+
+	xas_set_order(&xas, index, order);
+
+	do {
+		xas_lock_irq(&xas);
+
+		xas_store(&xas, p);
+		XA_BUG_ON(xa, xas_error(&xas));
+		XA_BUG_ON(xa, xa_load(xa, index) !=3D p);
+
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	XA_BUG_ON(xa, xas_error(&xas));
+}
+
+static noinline void check_xa_multi_store_adv_delete(struct xarray *xa,
+						     unsigned long index,
+						     unsigned int order)
+{
+	unsigned int nrpages =3D 1UL << order;
+	unsigned long base =3D round_down(index, nrpages);
+	XA_STATE(xas, xa, base);
+
+	xas_set_order(&xas, base, order);
+	xas_store(&xas, NULL);
+	xas_init_marks(&xas);
+}
+
+static unsigned long some_val =3D 0xdeadbeef;
+static unsigned long some_val_2 =3D 0xdeaddead;
+
+/* mimics the page cache */
+static noinline void check_xa_multi_store_adv(struct xarray *xa,
+					      unsigned long pos,
+					      unsigned int order)
+{
+	unsigned int nrpages =3D 1UL << order;
+	unsigned long index, base, next_index, next_next_index;
+	unsigned int i;
+
+	index =3D pos >> PAGE_SHIFT;
+	base =3D round_down(index, nrpages);
+	next_index =3D round_down(base + nrpages, nrpages);
+	next_next_index =3D round_down(next_index + nrpages, nrpages);
+
+	check_xa_multi_store_adv_add(xa, base, order, &some_val);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D &some_val);
+
+	XA_BUG_ON(xa, xa_load(xa, next_index) !=3D NULL);
+
+	/* Use order 0 for the next item */
+	check_xa_multi_store_adv_add(xa, next_index, 0, &some_val_2);
+	XA_BUG_ON(xa, xa_load(xa, next_index) !=3D &some_val_2);
+
+	/* Remove the next item */
+	check_xa_multi_store_adv_delete(xa, next_index, 0);
+
+	/* Now use order for a new pointer */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	check_xa_multi_store_adv_delete(xa, base, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* starting fresh again */
+
+	/* let's test some holes now */
+
+	/* hole at base and next_next */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) !=3D NULL);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* hole at base and next */
+
+	check_xa_multi_store_adv_add(xa, next_next_index, order, &some_val_2);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, base + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_index + i) !=3D NULL);
+
+	for (i =3D 0; i < nrpages; i++)
+		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) !=3D &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+#endif
+
+static noinline void check_multi_store_advanced(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int max_order =3D IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned long end =3D ULONG_MAX/2;
+	unsigned long pos, i;
+
+	/*
+	 * About 117 million tests below.
+	 */
+	for (pos =3D 7; pos < end; pos =3D (pos * pos) + 564) {
+		for (i =3D 0; i < max_order; i++) {
+			check_xa_multi_store_adv(xa, pos, i);
+			check_xa_multi_store_adv(xa, pos + 157, i);
+		}
+	}
+#endif
+}
+
 static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base=
)
 {
 	int i;
@@ -1804,6 +1937,7 @@ static int xarray_checks(void)
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
+	check_multi_store_advanced(&array);
 	check_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
--=20
2.39.2
