Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65A7AEC21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjIZMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:06:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04BE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:05:54 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230926120551epoutp01f79bb31db2e28878a3ccd1a0c1816132~IcWgUAmCX2455724557epoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:05:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230926120551epoutp01f79bb31db2e28878a3ccd1a0c1816132~IcWgUAmCX2455724557epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695729951;
        bh=Cn4ZLPTLfxpBJj7oBG2HSVYPS54wpoXOybQPdg3bcDw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=J8UlEI4HuUfupck07TdsN3hm4616hhINMNpXP5khJfNbq8q1x/ojl9juf9z2Hz4EL
         oNDaz0jJhMlrmCjsw0eEUJDZuc5eEZG4pFxIMnG2iFuYZ7qqbf+EcfkM7fK35zh14V
         4bNNIjocxBoZVx6ZQZIYMKNpaCdB5wyqGP2dQyPM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230926120549epcas1p443dee4c646d11ae27005e6e016fc9e5d~IcWe02qHh0615906159epcas1p4i;
        Tue, 26 Sep 2023 12:05:49 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rvz3K450Wz4x9Pw; Tue, 26 Sep
        2023 12:05:49 +0000 (GMT)
X-AuditID: b6c32a39-6ffff7000000255f-63-6512c91d3d4c
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.6E.09567.D19C2156; Tue, 26 Sep 2023 21:05:49 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZRJ0wtzu+ZD7ALqs@pc636>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926120549epcms1p4d41733c1c3698bd00eaa7e5ea0de041d@epcms1p4>
Date:   Tue, 26 Sep 2023 21:05:49 +0900
X-CMS-MailID: 20230926120549epcms1p4d41733c1c3698bd00eaa7e5ea0de041d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmnq7sSaFUg+kTZS3mrF/DZnH+wS82
        i9MTFjFZ9L5/xWRxedccNot7a/6zWtz5No/dYvVFFgcOj52z7rJ7bF6h5bHp0yR2jxMzfrN4
        vN93lc2jb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgV6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGfMuP2dsWCTSsXC/yfYGxgvSnYxcnBICJhIfDpg0cXIxSEksINR
        ovvlWiaQOK+AoMTfHcIgprBAuMTGPeVdjJxAJfISZ7c0MILYwgLaEqdWXmQGsdkENCW6Lmxh
        B7FFBNQlHj74yQwyklngNJNE577tYEUSArwSM9qfskDY0hLbl28FG8QpoCrx/k4PO0RcVOLm
        6rdw9vtj8xkhbBGJ1ntnoeYISjz4uRsqLiVxpm0J1MxiifVrrjNB2DUSR5/sh4qbSzS8XckG
        YvMK+Eqcv94MVsMCtPfNjI1Q9S4Sf3/dB7OZgZ7c/nYOM8jvzECPrd+lD1GiKLHz91xGiBI+
        iXdfe1hh3tox7wnUGGWJj98uMEJCVlJiwi5ziLCHxM6nK1khoTyTWWLr5KuMExgVZiECehaS
        xbMQFi9gZF7FKJZaUJybnlpsWGAKj9rk/NxNjODEqWW5g3H62w96hxiZOBgPMUpwMCuJ8P56
        xpcqxJuSWFmVWpQfX1Sak1p8iNEU6OWJzFKiyfnA1J1XEm9oYmlgYmZkYmFsaWymJM577m1v
        ipBAemJJanZqakFqEUwfEwenVAOTkP3nTy9M/0R8/zHnfWndIuPJs9/nM2mmr6te7KwzK9Mn
        xva3an2E98V7D0LXb190YubifX07lr0LM3bJne7gw/220eLFgTw3tzZ2R3c59wdHLpzhL4mt
        CXV6+vXnOy7Wneoy7omhjEekWxWvccqrxxXskGvoNFuUp2YY/J35wqxXP8UN4he45j65c+x3
        Y+HbaeHXDnbq9l9pPs0m+MmW8/fMgElZOi92LdA5voP9tNbbw88vym8xmL3/5ezAFfsa07d3
        hZ6LUCmW5npttGba+fazGW/2P2E50BHZ+Fws+JnmsogEZ9Y/l8QeOfr0Tw7ZnG1jvWjZ6oIn
        Dy7LlrGW5itpv3J+PMF0c8SvF7xvlViKMxINtZiLihMByACb3SUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65
References: <ZRJ0wtzu+ZD7ALqs@pc636> <ZRGN0DkJ/MHsYloz@pc636>
        <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
        <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
        <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
        <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
        <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
        <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > We do not have above code anymore:
> > Sorry, I tried to say it in a simplified way and it caused a misunderstanding.
> > 
> > <snip>
> > static __always_inline int
> > adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > 		      struct vmap_area *va, unsigned long nva_start_addr,
> > 		      unsigned long size)
> > 
> > 	} else if (type == NE_FIT_TYPE) {
> > 		/*
> > 		 * Split no edge of fit VA.
> > 		 *
> > 		 *     |       |
> > 		 *   L V  NVA  V R
> > 		 * |---|-------|---|
> > 		 */
> > 		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
> > 		if (unlikely(!lva)) {
> > 			/*
> > 			 * For percpu allocator we do not do any pre-allocation
> > 			 * and leave it as it is. The reason is it most likely
> > 			 * never ends up with NE_FIT_TYPE splitting. In case of
> > 			 * percpu allocations offsets and sizes are aligned to
> > 			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> > 			 * are its main fitting cases.
> > 			 *
> > 			 * There are a few exceptions though, as an example it is
> > 			 * a first allocation (early boot up) when we have "one"
> > 			 * big free space that has to be split.
> > 			 *
> > 			 * Also we can hit this path in case of regular "vmap"
> > 			 * allocations, if "this" current CPU was not preloaded.
> > 			 * See the comment in alloc_vmap_area() why. If so, then
> > 			 * GFP_NOWAIT is used instead to get an extra object for
> > 			 * split purpose. That is rare and most time does not
> > 			 * occur.
> > 			 *
> > 			 * What happens if an allocation gets failed. Basically,
> > 			 * an "overflow" path is triggered to purge lazily freed
> > 			 * areas to free some memory, then, the "retry" path is
> > 			 * triggered to repeat one more time. See more details
> > 			 * in alloc_vmap_area() function.
> > 			 */
> > 			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > 			if (!lva)
> > 				return -1;
> > 		}
> > <snip>
> > 
> > Above allocation fail will meet WARN_ON_ONCE in the current kernel now.
> > Should It be handled by alloc_vmap_area()?, as you described in a comment.
> > 
> WARN_ONCE_ONCE() is a warning and not a panic, though your kernel config
> considers it as a panic. Right, we go on retry path and we can remove

Right, only in case panic_on_warn is enabled..

> the warning only for GFP_NOWAIT-alloc-error. From the other hand we
> should still have possibility to trigger a warning if an allocation
> is not successful: no vmap space or low memory condition, thus no
> physical memory.

Yes, but GFP_NOWAIT-alloc-error can easily occur for low-memory device.
How about changing fix as below?:

<snip>
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1468,6 +1468,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
                 */
                va->va_start = nva_start_addr + size;
        } else {
+               WARN_ON_ONCE(1);
                return -1;
        }
 
@@ -1522,7 +1523,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
 
        /* Update the free vmap_area. */
        ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
-       if (WARN_ON_ONCE(ret))
+       if (ret)
                return vend;
 
 #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
@@ -4143,7 +4144,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
                ret = adjust_va_to_fit_type(&free_vmap_area_root,
                                            &free_vmap_area_list,
                                            va, start, size);
-               if (WARN_ON_ONCE(unlikely(ret)))
+               if (unlikely(ret))
                        /* It is a BUG(), but trigger recovery instead. */
                        goto recovery;
 
<snip>
It will WARN_ONCE_ONCE() only if classify_va_fit_type() is "(type == NOTHING_FIT)".

> 
> > 
> > > 
> > > <snip>
> > > commit 82dd23e84be3ead53b6d584d836f51852d1096e6
> > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Date:   Thu Jul 11 20:58:57 2019 -0700
> > > 
> > >     mm/vmalloc.c: preload a CPU with one object for split purpose
> > > 
> > > <snip>
> > > 
> > > Which kernel are you testing?
> > 
> > I'm currently testing v6.1. 
> > The panic occurred during power on/off test.
> >
> Could you please describe in more detail your test sequence, setup and HW?

I'm testing on Samsung Exynos arm64 board with aosp platform, kernel v6.1.
I did power on/off test on hundreds of device for a week and
the same issue reproduced several times.

Thanks
Jaeseon

> 
> --
> Uladzislau Rezki
