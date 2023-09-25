Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB37AD669
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjIYKwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:52:06 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382AB8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:51:57 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230925105155epoutp016f831e932d74ca78e756a3245ac53b8f~IHsqlJD4M3144431444epoutp01d
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:51:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230925105155epoutp016f831e932d74ca78e756a3245ac53b8f~IHsqlJD4M3144431444epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695639115;
        bh=8AxotcjtTh/WUu5XLTzy/Vm2FEZz/hdvdsSBNKi/2z0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=n5H+GJiDJn1TN6ZblIxtip5HVrjOIHOkAZ71koFjozsofvRKKCoRqXaBuKGe6ICe2
         MMoanf/YiC6It3EUi8uxA00X1UPpNeIaM3xc5YBuwI7FjNAK8uISUx9VYU4W0i+GVp
         97puyyIQwR32Au+siJpqcA+109FNGkm7hKNhJvwU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230925105154epcas1p348eb675942d16e9d5c204d1bd07107c6~IHsqDoKaj1443414434epcas1p3O;
        Mon, 25 Sep 2023 10:51:54 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RvKSV3Y9tz4x9Pr; Mon, 25 Sep
        2023 10:51:54 +0000 (GMT)
X-AuditID: b6c32a33-4e9ff700000021d1-cc-6511664a83fa
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.F8.08657.A4661156; Mon, 25 Sep 2023 19:51:54 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Reply-To: jason.sim@samsung.com
Sender: Jaeseon Sim <jason.sim@samsung.com>
From:   Jaeseon Sim <jason.sim@samsung.com>
To:     "bhe@redhat.com" <bhe@redhat.com>,
        "urezki@gmail.com" <urezki@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
Date:   Mon, 25 Sep 2023 19:51:54 +0900
X-CMS-MailID: 20230925105154epcms1p782c335c2355f39a9b583489c56e972f6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmnq5XmmCqwb0mMYs569ewWZx/8IvN
        4vSERUwWve9fMVlc3jWHzeLemv+sFne+zWO3WH2RxYHDY+esu+wem1doeWz6NInd48SM3ywe
        7/ddZfPo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rkd286wFOySqXi1dh9rA2OHaBcjJ4eEgInE5a/HWboYuTiEBHYw
        Sixcdoa9i5GDg1dAUOLvDmEQU1ggXGLjnnKQciEBeYmzWxoYQWxhAW2JUysvMoPYbAKaEl0X
        trCD2CICPhLnvh9iAxnJLLCCSeLx0SdsELt4JWa0P2WBsKUlti/fCjaIU0BP4nLrUWaIuKjE
        zdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouJXGmbQnUzGKJ9WuuM0HYNRJHn+yHiptLNLxd
        CXYDr4CvxOZb38DmsAioSsyaeA7qNheJqffegcWZgZ7c/nYOM8jvzECPrd+lD1GiKLHz91xG
        iBI+iXdfe1hh3tox7wnUWmWJj98uMIK0SghISkzYZQ4R9pDY+XQlKyQI7zJKrFrGNoFRYRYi
        nGch2TsLYe8CRuZVjGKpBcW56anJhgWG8KhNzs/dxAhOnFrGOxgvz/+nd4iRiYPxEKMEB7OS
        CO+vZ3ypQrwpiZVVqUX58UWlOanFhxhNgT6eyCwlmpwPTN15JfGGJpYGJmZGJhbGlsZmSuK8
        ihNmpwgJpCeWpGanphakFsH0MXFwSjUwLVh0w97tn0xtRkqdy2krJ+u/taXC5prBBWqTraSm
        9izcEpp0LWTCyhMMVbf4DdxmiOW9fv5QVSxE2kHEJePRjy+92k0Xl+rdqC2YyqAjfFWT/8kO
        1t3Gi7Y3OlRsfvKI5XvMsW2JRZKxP7ysDGx3qJecZ3wVkiN6cfcSrdKZW99HcDnIKjW67r27
        /rqxvN+8+Ycmbv17qCXOOIXjOuuhAxKvWj4/SF9Sc//33Jkv2x/UbHkTNyuOaWIL09cjq+Ze
        3n/gsDk738RoxfdeLL1vlwmJ/qjznj5l8v2anOQZ5/RMo0ymrp1q1znvzKd4oefbTytqSdZx
        hj6vcP3yWXi1gd1lkzVCt+7+uBd79mbgTSWW4oxEQy3mouJEAKc28ZslBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65
References: <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
        <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
        <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
        <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 09/22/23 at 05:34pm, Baoquan He wrote:
> > Hi Jaeseon,
Hello Baoquan,
> > 
> > On 09/22/23 at 03:27pm, Jaeseon Sim wrote:
> > > There's panic issue as follows when do alloc_vmap_area:
> > > 
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > 
> > > page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
> > > Call Trace:
> > > warn_alloc+0xf4/0x190
> > > __alloc_pages_slowpath+0xe0c/0xffc
> > > __alloc_pages+0x250/0x2d0
> > > new_slab+0x17c/0x4e0
> > > ___slab_alloc+0x4e4/0x8a8
> > > __slab_alloc+0x34/0x6c
> > > kmem_cache_alloc+0x20c/0x2f0
> > > adjust_va_to_fit_type
> > > __alloc_vmap_area
> > > alloc_vmap_area+0x298/0x7fc
> > > __get_vm_area_node+0x10c/0x1b4
> > > __vmalloc_node_range+0x19c/0x7c0

To Uladzislau,
Sorry. The path is as below.

Call trace:
 alloc_vmap_area+0x298/0x7fc
 __get_vm_area_node+0x10c/0x1b4
 __vmalloc_node_range+0x19c/0x7c0
 dup_task_struct+0x1b8/0x3b0
 copy_process+0x170/0xc40

> > > 
> > > Commit 1b23ff80b399 ("mm/vmalloc: invoke classify_va_fit_type() in
> > > adjust_va_to_fit_type()") moved classify_va_fit_type() into
> > > adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
> > > value of adjust_va_to_fit_type(), just as classify_va_fit_type()
> > > was handled.
> > 
> > I don't get what you are fixing. In commit 1b23ff80b399, we have
>                                    ~~ s/In/Before/, typo
> > "if (WARN_ON_ONCE(type == NOTHING_FIT))", it's the same as the current
> > code. You set panic_on_warn, it will panic in old code before commit
> > 1b23ff80b399. Isn't it an expected behaviour?
There is a call path which didn't panic in old code, but does on the current.

static __always_inline int adjust_va_to_fit_type()

} else if (type == NE_FIT_TYPE) {
	lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
	if (!lva)
		return -1;

If the above path is taken, Retry path should be triggred at alloc_vmap_area(). 
But it is currenly unable to so.

> > 
> > > 
> > > There is another path in adjust_va_to_fit_type() which could
> > > return failure and will be handled in alloc_vmap_area().
> > > Remove WARN_ON_ONCE() for this case.
> > > 
> > > Fixes: 45c62fc2897d ("mm/vmalloc: Remove WARN_ON_ONCE related to adjust_va_to_fit_type")
> > 
> > The commit id for Fixes tag is wrong.
> > 
> > > Signed-off-by: Jaeseon Sim <jason.sim@samsung.com>
> > > ---
> > >  mm/vmalloc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ef8599d394fd..4a82b6525d48 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1522,7 +1522,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> > >  
> > >          /* Update the free vmap_area. */
> > >          ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > > -        if (WARN_ON_ONCE(ret))
> > > +        if (ret)
> > >                  return vend;
> > >  
> > >  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> > > @@ -4143,7 +4143,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> > >                  ret = adjust_va_to_fit_type(&free_vmap_area_root,
> > >                                              &free_vmap_area_list,
> > >                                              va, start, size);
> > > -                if (WARN_ON_ONCE(unlikely(ret)))
> > > +                if (unlikely(ret))
> > >                          /* It is a BUG(), but trigger recovery instead. */
> > >                          goto recovery;
> > >  
> > > -- 
> > > 2.17.1
> > > 
> > 
>
