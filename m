Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E67AE4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjIZFWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjIZFWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:22:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329FD7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:22:01 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230926052159epoutp02d01a6ba1f7f1d4936891ea89f7f97e89~IW14o9aFB0552905529epoutp023
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:21:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230926052159epoutp02d01a6ba1f7f1d4936891ea89f7f97e89~IW14o9aFB0552905529epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695705719;
        bh=Ae3csVniCNOtjKr88euFOzMx2vv3dPx0MYaEJq/LpAo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gla8zA8qMvNF7CHu8mcgO4vFftD0Vi7RQ+2UHWCmD5bnTuZ+uUTewPFTlObaSnMgZ
         qkvIn9Tu7NkyvvikbFysgUpWOm/2+Hrs93YgF8SwAK60dGHA8yqM2gAc1/XPR27MJh
         B4NfiL7SEb91kTtkcNJguxhXXCcq2sDEsW1apRUU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230926052158epcas1p2f56142adfac6451bad63f56b67d5d326~IW134ulon1275612756epcas1p2-;
        Tue, 26 Sep 2023 05:21:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rvp5L33snz4x9Px; Tue, 26 Sep
        2023 05:21:58 +0000 (GMT)
X-AuditID: b6c32a38-28bff700000027b3-cb-65126a76827a
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.ED.10163.67A62156; Tue, 26 Sep 2023 14:21:58 +0900 (KST)
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
In-Reply-To: <ZRGN0DkJ/MHsYloz@pc636>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
Date:   Tue, 26 Sep 2023 14:21:58 +0900
X-CMS-MailID: 20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmnm5ZllCqwb6HYhZz1q9hszj/4Beb
        xekJi5gset+/YrK4vGsOm8W9Nf9ZLe58m8dusfoiiwOHx85Zd9k9Nq/Q8tj0aRK7x4kZv1k8
        3u+7yubRt2UVo8fnTXIB7FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJ
        uam2Si4+AbpumTlANykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK9IoTc4tL
        89L18lJLrAwNDIxMgQoTsjNm3f7BXrBRuWLCrvPsDYxnpboYOTkkBEwkZl67yNTFyMUhJLCD
        UeL/3h4gh4ODV0BQ4u8OYRBTWCBcYuOecpByIQF5ibNbGhhBbGEBbYlTKy8yg9hsApoSXRe2
        sIPYIgLqEg8f/GQGGckscJpJonPfdmaIXbwSM9qfskDY0hLbl29lBJnPKaAqcW5rMURYVOLm
        6rfsMPb7Y/MZIWwRidZ7Z6HGCEo8+LkbKi4lcaZtCdTIYon1a64zQdg1Ekef7IeKm0s0vF3J
        BmLzCvhKvPvcxQaylgVo7dHN5RAlLhLHD50DK2EGenH72znMICXMQG+t36UPUaIosfP3XEaI
        Ej6Jd197WGGe2jHvCdRWZYmP3y6APSUhICkxYZc5RNhDYufTlayQMN7FJNE68zrzBEaFWYhg
        noVk8SyExQsYmVcxiqUWFOempxYbFpjAYzY5P3cTIzhtalnsYJz79oPeIUYmDsZDjBIczEoi
        vL+e8aUK8aYkVlalFuXHF5XmpBYfYjQF+ngis5Rocj4wceeVxBuaWBqYmBmZWBhbGpspifMe
        e9WbIiSQnliSmp2aWpBaBNPHxMEp1cBk5HV700OtFQUV2a5dmWrFf/R39TDP2Lq+0OhT4M3D
        pi+e8/Z4m1g89ruzcf2hYiWPRJFH6rGzp8+wrpz1gj32oekv5UdbNb6tLw+bKx49k3PprRfG
        niy+2UzCe597Tuko95zKrWdSNueG04b0C16r69pSbTOWc+tIKAYrN7WpaDies99zUzkmblNB
        feWjn4faV3s9zlrkObtct+t82vLaypNr8ng5Pa+lPP7auXOHjsCxGJ6U5iMMurskV2WteCXI
        Pr8u9enPUHvz+h6hW5GPyh79TBCd8DNJat2fW4XWVza/vHVBepNYTsym+KKuyokeXQdzmNsP
        Op1eFrpw13ym4/delP37antkxoeg+3eVWIozEg21mIuKEwGO5+evJAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65
References: <ZRGN0DkJ/MHsYloz@pc636> <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
        <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
        <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
        <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
        <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p7>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Sep 25, 2023 at 07:51:54PM +0900, Jaeseon Sim wrote:
> > > On 09/22/23 at 05:34pm, Baoquan He wrote:
> > > > Hi Jaeseon,
> > Hello Baoquan,
> > > > 
> > > > On 09/22/23 at 03:27pm, Jaeseon Sim wrote:
> > > > > There's panic issue as follows when do alloc_vmap_area:
> > > > > 
> > > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > > > 
> > > > > page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
> > > > > Call Trace:
> > > > > warn_alloc+0xf4/0x190
> > > > > __alloc_pages_slowpath+0xe0c/0xffc
> > > > > __alloc_pages+0x250/0x2d0
> > > > > new_slab+0x17c/0x4e0
> > > > > ___slab_alloc+0x4e4/0x8a8
> > > > > __slab_alloc+0x34/0x6c
> > > > > kmem_cache_alloc+0x20c/0x2f0
> > > > > adjust_va_to_fit_type
> > > > > __alloc_vmap_area
> > > > > alloc_vmap_area+0x298/0x7fc
> > > > > __get_vm_area_node+0x10c/0x1b4
> > > > > __vmalloc_node_range+0x19c/0x7c0
> > 
> > To Uladzislau,
> > Sorry. The path is as below.
> > 
> > Call trace:
> >  alloc_vmap_area+0x298/0x7fc
> >  __get_vm_area_node+0x10c/0x1b4
> >  __vmalloc_node_range+0x19c/0x7c0
> >  dup_task_struct+0x1b8/0x3b0
> >  copy_process+0x170/0xc40
> > 
> > > > > 
> > > > > Commit 1b23ff80b399 ("mm/vmalloc: invoke classify_va_fit_type() in
> > > > > adjust_va_to_fit_type()") moved classify_va_fit_type() into
> > > > > adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
> > > > > value of adjust_va_to_fit_type(), just as classify_va_fit_type()
> > > > > was handled.
> > > > 
> > > > I don't get what you are fixing. In commit 1b23ff80b399, we have
> > >                                    ~~ s/In/Before/, typo
> > > > "if (WARN_ON_ONCE(type == NOTHING_FIT))", it's the same as the current
> > > > code. You set panic_on_warn, it will panic in old code before commit
> > > > 1b23ff80b399. Isn't it an expected behaviour?
> > There is a call path which didn't panic in old code, but does on the current.
> > 
> > static __always_inline int adjust_va_to_fit_type()
> > 
> > } else if (type == NE_FIT_TYPE) {
> > 	lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > 	if (!lva)
> > 		return -1;
> > 
> >
> We do not have above code anymore:
Sorry, I tried to say it in a simplified way and it caused a misunderstanding.

<snip>
static __always_inline int
adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
		      struct vmap_area *va, unsigned long nva_start_addr,
		      unsigned long size)

	} else if (type == NE_FIT_TYPE) {
		/*
		 * Split no edge of fit VA.
		 *
		 *     |       |
		 *   L V  NVA  V R
		 * |---|-------|---|
		 */
		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
		if (unlikely(!lva)) {
			/*
			 * For percpu allocator we do not do any pre-allocation
			 * and leave it as it is. The reason is it most likely
			 * never ends up with NE_FIT_TYPE splitting. In case of
			 * percpu allocations offsets and sizes are aligned to
			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
			 * are its main fitting cases.
			 *
			 * There are a few exceptions though, as an example it is
			 * a first allocation (early boot up) when we have "one"
			 * big free space that has to be split.
			 *
			 * Also we can hit this path in case of regular "vmap"
			 * allocations, if "this" current CPU was not preloaded.
			 * See the comment in alloc_vmap_area() why. If so, then
			 * GFP_NOWAIT is used instead to get an extra object for
			 * split purpose. That is rare and most time does not
			 * occur.
			 *
			 * What happens if an allocation gets failed. Basically,
			 * an "overflow" path is triggered to purge lazily freed
			 * areas to free some memory, then, the "retry" path is
			 * triggered to repeat one more time. See more details
			 * in alloc_vmap_area() function.
			 */
			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
			if (!lva)
				return -1;
		}
<snip>

Above allocation fail will meet WARN_ON_ONCE in the current kernel now.
Should It be handled by alloc_vmap_area()?, as you described in a comment.

Thanks!
Jaeseon

> 
> <snip>
> commit 82dd23e84be3ead53b6d584d836f51852d1096e6
> Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Date:   Thu Jul 11 20:58:57 2019 -0700
> 
>     mm/vmalloc.c: preload a CPU with one object for split purpose
> 
> <snip>
> 
> Which kernel are you testing?

I'm currently testing v6.1. 
The panic occurred during power on/off test.
> 
> Thanks!
> 
> --
> Uladzislau Rezki
