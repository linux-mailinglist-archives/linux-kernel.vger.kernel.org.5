Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC97AE576
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjIZGGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjIZGGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:06:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3154DE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:05:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so124384521fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695708357; x=1696313157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgxlFDA/bxmUPsLJjc6g70eWQh+QzFKzh1Zln4PSV60=;
        b=Hf4sj+tOmDoemXTEP+47guE49eTiY8l8TEGaCe94yT5nwV62jrmeJ9v/KHOECZHtUA
         ilRAoI75N0nz/IoflcQJufwmbGPnWi6oZlP4fWuj1XY0jizMAbx3mzvMURpKHVCsRFHD
         7pOvlZsQSzMXD6yqqK+rd3txxAFsDo4hkaRF6CX9cNpTESBrRhW4DD99EcFvI1Oq+740
         QRpn6zmQBSyDtujqLRjwN5RM7x5kK7sDyIaf8P98G8lzZ9cc5l/39zepW6NQ1p6NRMUG
         ptoRHTcMVa+NrrUotOAX7RDNoFgawKXFEerH8uEJranWxNO1wydtArt5bk81Fkpv7Vjm
         gNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695708357; x=1696313157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgxlFDA/bxmUPsLJjc6g70eWQh+QzFKzh1Zln4PSV60=;
        b=ZE8o/Dpccfl+x1oSulv4Kpz3Jzoi1sriJCR7d6UJkZTgpmnkbSp3zltQIMZeMv/xEm
         Fp9YUWlmFGLyr5RPhsyzrkpVD4E1SdhbOSBZX9BOtYzFP17vzC8Rc59KkukVnfoo4lU3
         WYB+BXRENpuHW5ACgcOpYe9lC2X+GAiEv70jUGDrI3kf0/2IeGhwT73NhoEPa5GW23KW
         GDKZBMQx4Klb67N3HbutiRVOpsrkWYlW1JIzBOAlt+rkDlr2bahyoOySj8B0lz+HYpLm
         7eEHF8nuP9scHLKkV2g8I8hhtqpnS9ZZsSa3SF6oQ3tE7DlFU3ecL982kjO4itOfnbWm
         j3Vw==
X-Gm-Message-State: AOJu0YwDAHBtOwEXsP+FiBxEy+WWiJZFx1UcrA6U1zBDkiuDxWEziLzS
        ZBZMzK3evmdHbzuMtVCWPcQ=
X-Google-Smtp-Source: AGHT+IHYJRSkCqz+BcxPGgEWjVl/4ojbM6zIh2FG6lWZYKDBV1zfelKRAqeEmELB2VyZHlnWmgoeBw==
X-Received: by 2002:a2e:9b42:0:b0:2be:54b4:ff87 with SMTP id o2-20020a2e9b42000000b002be54b4ff87mr7163447ljj.40.1695708356809;
        Mon, 25 Sep 2023 23:05:56 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a7-20020a05651c010700b002b6daa3fa2csm2426964ljb.69.2023.09.25.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:05:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 26 Sep 2023 08:05:54 +0200
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Message-ID: <ZRJ0wtzu+ZD7ALqs@pc636>
References: <ZRGN0DkJ/MHsYloz@pc636>
 <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
 <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
 <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
 <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p7>
 <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We do not have above code anymore:
> Sorry, I tried to say it in a simplified way and it caused a misunderstanding.
> 
> <snip>
> static __always_inline int
> adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> 		      struct vmap_area *va, unsigned long nva_start_addr,
> 		      unsigned long size)
> 
> 	} else if (type == NE_FIT_TYPE) {
> 		/*
> 		 * Split no edge of fit VA.
> 		 *
> 		 *     |       |
> 		 *   L V  NVA  V R
> 		 * |---|-------|---|
> 		 */
> 		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
> 		if (unlikely(!lva)) {
> 			/*
> 			 * For percpu allocator we do not do any pre-allocation
> 			 * and leave it as it is. The reason is it most likely
> 			 * never ends up with NE_FIT_TYPE splitting. In case of
> 			 * percpu allocations offsets and sizes are aligned to
> 			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> 			 * are its main fitting cases.
> 			 *
> 			 * There are a few exceptions though, as an example it is
> 			 * a first allocation (early boot up) when we have "one"
> 			 * big free space that has to be split.
> 			 *
> 			 * Also we can hit this path in case of regular "vmap"
> 			 * allocations, if "this" current CPU was not preloaded.
> 			 * See the comment in alloc_vmap_area() why. If so, then
> 			 * GFP_NOWAIT is used instead to get an extra object for
> 			 * split purpose. That is rare and most time does not
> 			 * occur.
> 			 *
> 			 * What happens if an allocation gets failed. Basically,
> 			 * an "overflow" path is triggered to purge lazily freed
> 			 * areas to free some memory, then, the "retry" path is
> 			 * triggered to repeat one more time. See more details
> 			 * in alloc_vmap_area() function.
> 			 */
> 			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> 			if (!lva)
> 				return -1;
> 		}
> <snip>
> 
> Above allocation fail will meet WARN_ON_ONCE in the current kernel now.
> Should It be handled by alloc_vmap_area()?, as you described in a comment.
> 
WARN_ONCE_ONCE() is a warning and not a panic, though your kernel config
considers it as a panic. Right, we go on retry path and we can remove
the warning only for GFP_NOWAIT-alloc-error. From the other hand we
should still have possibility to trigger a warning if an allocation
is not successful: no vmap space or low memory condition, thus no
physical memory.

> 
> > 
> > <snip>
> > commit 82dd23e84be3ead53b6d584d836f51852d1096e6
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Thu Jul 11 20:58:57 2019 -0700
> > 
> >     mm/vmalloc.c: preload a CPU with one object for split purpose
> > 
> > <snip>
> > 
> > Which kernel are you testing?
> 
> I'm currently testing v6.1. 
> The panic occurred during power on/off test.
>
Could you please describe in more detail your test sequence, setup and HW?

--
Uladzislau Rezki
