Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9017AD968
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjIYNlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjIYNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:40:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255DCD0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:40:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5045cb9c091so3653961e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695649236; x=1696254036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXMtMQGx0MCt04r5Sd/3UUcKCPsweBk7mPT2jQ/UDOQ=;
        b=PoB/+6taWvrnxIVrxrw+fpylLcDKWrOdqRuEdfvPy31YjH4+wJaDyA+bL+xcAyTj8z
         RLRMtO6M02DdS8NQNQsj5JqP+1BjdJz1oAw2zBrU+QXpfpVu+6n8tlk3/xZghGILfcvL
         l/cLz73g1q+rfQIUKQM3CobwvBYB+VdEykqJuHgeRLL2q3+i4iwVPM6C19WkJCZgTwkZ
         8ZZsjIJIfnl2wcebXtXACVYIchv3ffn/+f33KgHklnY9Q97grMRpaXwpzM8YPO+uF7Pm
         G9Z08+pgWmDhbDcz6TzgiTVkk03zQSqBfc69re34a+bu0X82UBdVX8A1sTA/U6wBZunV
         oEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649236; x=1696254036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXMtMQGx0MCt04r5Sd/3UUcKCPsweBk7mPT2jQ/UDOQ=;
        b=sxhKFxhUPvt+F9gFNCRv5HOUSGf5oVb8V/xOXr0IqTN4EC8LqtOECh6bzkt4F/OzZD
         98skMakHgT5pqs2J97W2+UJVSJDkhyqNBbVif6zRRWnaAM77IxyACq+qGCdjpJMvhHmo
         EukOGWbNgzFc9D69kdZCmhYaqiICpXH9Os8qZLD/gypaabWFbFXlzABpukwCHElgaHbr
         Z5cJE1hkSiEFxGDUK/D/NPbopkvgyX/s1KXcW01ndXRF+hCYqD8hDdeBQiGRkVOr4H2w
         CcVv5Py0vvpitPLwFI0oC0+0+slb9wrjLlRoZ+FsI6KLV93XOG/wNyAfC5rCr/HHCRs0
         HglQ==
X-Gm-Message-State: AOJu0YwqV98TVQnxbte+ULO6C1MoGvY4d1Hiu2A3FL1n17tm8ECVDDkA
        Pml+Qr3cRmRjvh67WTStZz0=
X-Google-Smtp-Source: AGHT+IFZGbkKaGFj3/yK0zzVfUaoYfMUYUoloRwV9JiVsdv4BLxs61sGyfJIbzuQRMCr+rbWChnEqA==
X-Received: by 2002:ac2:5988:0:b0:503:436:6d08 with SMTP id w8-20020ac25988000000b0050304366d08mr4988188lfn.16.1695649235486;
        Mon, 25 Sep 2023 06:40:35 -0700 (PDT)
Received: from pc636 (host-90-233-214-51.mobileonline.telia.com. [90.233.214.51])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004fe4e89dc41sm1847770lfq.214.2023.09.25.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:40:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 25 Sep 2023 15:40:32 +0200
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Message-ID: <ZRGN0DkJ/MHsYloz@pc636>
References: <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
 <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
 <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p7>
 <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 07:51:54PM +0900, Jaeseon Sim wrote:
> > On 09/22/23 at 05:34pm, Baoquan He wrote:
> > > Hi Jaeseon,
> Hello Baoquan,
> > > 
> > > On 09/22/23 at 03:27pm, Jaeseon Sim wrote:
> > > > There's panic issue as follows when do alloc_vmap_area:
> > > > 
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > > 
> > > > page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
> > > > Call Trace:
> > > > warn_alloc+0xf4/0x190
> > > > __alloc_pages_slowpath+0xe0c/0xffc
> > > > __alloc_pages+0x250/0x2d0
> > > > new_slab+0x17c/0x4e0
> > > > ___slab_alloc+0x4e4/0x8a8
> > > > __slab_alloc+0x34/0x6c
> > > > kmem_cache_alloc+0x20c/0x2f0
> > > > adjust_va_to_fit_type
> > > > __alloc_vmap_area
> > > > alloc_vmap_area+0x298/0x7fc
> > > > __get_vm_area_node+0x10c/0x1b4
> > > > __vmalloc_node_range+0x19c/0x7c0
> 
> To Uladzislau,
> Sorry. The path is as below.
> 
> Call trace:
>  alloc_vmap_area+0x298/0x7fc
>  __get_vm_area_node+0x10c/0x1b4
>  __vmalloc_node_range+0x19c/0x7c0
>  dup_task_struct+0x1b8/0x3b0
>  copy_process+0x170/0xc40
> 
> > > > 
> > > > Commit 1b23ff80b399 ("mm/vmalloc: invoke classify_va_fit_type() in
> > > > adjust_va_to_fit_type()") moved classify_va_fit_type() into
> > > > adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
> > > > value of adjust_va_to_fit_type(), just as classify_va_fit_type()
> > > > was handled.
> > > 
> > > I don't get what you are fixing. In commit 1b23ff80b399, we have
> >                                    ~~ s/In/Before/, typo
> > > "if (WARN_ON_ONCE(type == NOTHING_FIT))", it's the same as the current
> > > code. You set panic_on_warn, it will panic in old code before commit
> > > 1b23ff80b399. Isn't it an expected behaviour?
> There is a call path which didn't panic in old code, but does on the current.
> 
> static __always_inline int adjust_va_to_fit_type()
> 
> } else if (type == NE_FIT_TYPE) {
> 	lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> 	if (!lva)
> 		return -1;
> 
>
We do not have above code anymore:

<snip>
commit 82dd23e84be3ead53b6d584d836f51852d1096e6
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Thu Jul 11 20:58:57 2019 -0700

    mm/vmalloc.c: preload a CPU with one object for split purpose

<snip>

Which kernel are you testing?

Thanks!

--
Uladzislau Rezki
