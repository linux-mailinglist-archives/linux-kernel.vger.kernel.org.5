Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F17AECF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjIZMfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIZMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:35:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89935FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:35:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so14485982e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695731725; x=1696336525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKytEP9mjvDlE1ed/dW4EbuXyf3+xZ0haz2NXKtUfpU=;
        b=YG6izvjH9UUjNkrNxxfM11e5Vq/Kydlm5TlHLcoGIdBLeKP9tz70sxzXYrQ+Pv0HOR
         xmyjaYLC7k1Y6H0yQXmlzGNgQYsmmKFqy+pGenYQhGUMT4nToy8X8bBwRlcZbfrcPJN1
         5rc8DN5jpYQ0g4yyRzMgL4XVRaKiKjKupNUY8t1czsoxwrI4bsjiD5SmIl854qOOYco7
         vUDTqTSOS01Nye5sl9K0t3DD06WvTi3nLhGVeL/7NiGkDvOZrzfMJYIFpMQamRmSyON5
         gZj5N1H51i7DEnI8jS0CjSPVwO10P4EsrusI3+9B/D0G2+3ypqFZ90IZMMbVA1qJVebv
         mzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695731725; x=1696336525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKytEP9mjvDlE1ed/dW4EbuXyf3+xZ0haz2NXKtUfpU=;
        b=IoQ2pPfZalKhRtA/zQQhJiHNj7+BhMcKYReoadevBImqrWcnr6mbLIRDY4kCQImLYj
         QNrs8TA4Vi0AtEL1C7QX7S0i6vWUqv57eWCTs2Wf4J5eGBloHVaWO1V+efvxe1BqFfdb
         MJqZA5MHnkwWhe3OAsp4g8JM1Fcj4nTFIJo/tLVoObiGnssKgAVMEeS2gcCryK9a6kUJ
         a0vud+KveCJ587YIkl0dJmaO99IP8XvRvHOnajF1UFD8pRNddLqm1cuf9/wJ7bNqxsE9
         b3XlMkRb7ckb0DfaaEI79cR0xfHPYkPturpEQbGRUFEgs4Iviq9QnCrln4IfZWJO9qe0
         1fng==
X-Gm-Message-State: AOJu0YwTYI8EhAhAOxmi24HekwevSCgdNfBaXQoHrL9Io05nbynjmSwJ
        IJNXQXcb5dmn6nF7Zc4C4rY=
X-Google-Smtp-Source: AGHT+IGEFFN4pVSwp61qEtfdTWgJfugjKiyaj40HflNZcDPvJ1bwM7/5jpqeCT8IC7rE0kSvLozNZA==
X-Received: by 2002:a19:674a:0:b0:4fb:8939:d95c with SMTP id e10-20020a19674a000000b004fb8939d95cmr7534378lfj.30.1695731724346;
        Tue, 26 Sep 2023 05:35:24 -0700 (PDT)
Received: from pc636 (host-90-233-214-51.mobileonline.telia.com. [90.233.214.51])
        by smtp.gmail.com with ESMTPSA id w21-20020ac24435000000b0050307304a80sm2210559lfl.205.2023.09.26.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 05:35:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 26 Sep 2023 14:35:21 +0200
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
Message-ID: <ZRLQCTh9zNIp9OH7@pc636>
References: <ZRJ0wtzu+ZD7ALqs@pc636>
 <ZRGN0DkJ/MHsYloz@pc636>
 <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
 <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
 <20230925105154epcms1p782c335c2355f39a9b583489c56e972f6@epcms1p7>
 <20230926052158epcms1p7fd7f3e3f523e5209977d3f5c62e85afa@epcms1p7>
 <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p4>
 <20230926120549epcms1p4d41733c1c3698bd00eaa7e5ea0de041d@epcms1p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926120549epcms1p4d41733c1c3698bd00eaa7e5ea0de041d@epcms1p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:05:49PM +0900, Jaeseon Sim wrote:
> > > > We do not have above code anymore:
> > > Sorry, I tried to say it in a simplified way and it caused a misunderstanding.
> > > 
> > > <snip>
> > > static __always_inline int
> > > adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > > 		      struct vmap_area *va, unsigned long nva_start_addr,
> > > 		      unsigned long size)
> > > 
> > > 	} else if (type == NE_FIT_TYPE) {
> > > 		/*
> > > 		 * Split no edge of fit VA.
> > > 		 *
> > > 		 *     |       |
> > > 		 *   L V  NVA  V R
> > > 		 * |---|-------|---|
> > > 		 */
> > > 		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
> > > 		if (unlikely(!lva)) {
> > > 			/*
> > > 			 * For percpu allocator we do not do any pre-allocation
> > > 			 * and leave it as it is. The reason is it most likely
> > > 			 * never ends up with NE_FIT_TYPE splitting. In case of
> > > 			 * percpu allocations offsets and sizes are aligned to
> > > 			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> > > 			 * are its main fitting cases.
> > > 			 *
> > > 			 * There are a few exceptions though, as an example it is
> > > 			 * a first allocation (early boot up) when we have "one"
> > > 			 * big free space that has to be split.
> > > 			 *
> > > 			 * Also we can hit this path in case of regular "vmap"
> > > 			 * allocations, if "this" current CPU was not preloaded.
> > > 			 * See the comment in alloc_vmap_area() why. If so, then
> > > 			 * GFP_NOWAIT is used instead to get an extra object for
> > > 			 * split purpose. That is rare and most time does not
> > > 			 * occur.
> > > 			 *
> > > 			 * What happens if an allocation gets failed. Basically,
> > > 			 * an "overflow" path is triggered to purge lazily freed
> > > 			 * areas to free some memory, then, the "retry" path is
> > > 			 * triggered to repeat one more time. See more details
> > > 			 * in alloc_vmap_area() function.
> > > 			 */
> > > 			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > > 			if (!lva)
> > > 				return -1;
> > > 		}
> > > <snip>
> > > 
> > > Above allocation fail will meet WARN_ON_ONCE in the current kernel now.
> > > Should It be handled by alloc_vmap_area()?, as you described in a comment.
> > > 
> > WARN_ONCE_ONCE() is a warning and not a panic, though your kernel config
> > considers it as a panic. Right, we go on retry path and we can remove
> 
> Right, only in case panic_on_warn is enabled..
> 
> > the warning only for GFP_NOWAIT-alloc-error. From the other hand we
> > should still have possibility to trigger a warning if an allocation
> > is not successful: no vmap space or low memory condition, thus no
> > physical memory.
> 
> Yes, but GFP_NOWAIT-alloc-error can easily occur for low-memory device.
>
Agree. You are really in a low memory condition. We end up here only if
pre-loading also has not succeeded, i.e. GFP_KERNEL also fails.

But i agree with you, we should "improve the warning" because we drain
and repeat.

> How about changing fix as below?:
> 
> <snip>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1468,6 +1468,7 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
>                  */
>                 va->va_start = nva_start_addr + size;
>         } else {
> +               WARN_ON_ONCE(1);
>                 return -1;
>         }
>  
> @@ -1522,7 +1523,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>  
>         /* Update the free vmap_area. */
>         ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> -       if (WARN_ON_ONCE(ret))
> +       if (ret)
>                 return vend;
>  
>  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> @@ -4143,7 +4144,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>                 ret = adjust_va_to_fit_type(&free_vmap_area_root,
>                                             &free_vmap_area_list,
>                                             va, start, size);
> -               if (WARN_ON_ONCE(unlikely(ret)))
> +               if (unlikely(ret))
>                         /* It is a BUG(), but trigger recovery instead. */
>                         goto recovery;
>  
> <snip>
> It will WARN_ONCE_ONCE() only if classify_va_fit_type() is "(type == NOTHING_FIT)".
> 
This is good but i think it should be improved further. We need to
understand from the warning when no memory and when there is no a
vmap space, so:

- if NOTHING_FIT, we should WARN() for sure;
- Second place in the pcpu_get_vm_area(), we do not use NE_FIT. Only in
  the begging after boot, but potentially we can trigger -ENOMEM and we
  should warn in this case. Otherwise you just hide it;
- And last one if after repeating we still do not manage to allocate.

--
Uladzislau Rezki
