Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759E7BCF20
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjJHPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjJHPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:39:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D0A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:39:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a2536adaf3so45389837b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696779556; x=1697384356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8i4LmYSLa0m2la/ko//veY4X3W2mbwibD+qxtMKA9Uk=;
        b=mRI0ibQGGngrwJhG4y6zTLa1f/ND1cDusl8h5uc0SciP9JPIwuW1coas8pigxXIAwc
         MzunXmO5COEo6+GWEHQTipdfnOuTYFkphd1M83nK9fxQ3Tij0kNHHQx42mNaWgg1l5Cw
         kq5T89Xsqiw2Py2FE/T1hH+5AwzVQ/ej+6pjr+sb5JBZkZzG8Kv/2hw+iI5DGm0khvD8
         tMPzRb/opHwu5Rx+dGSk5TwsCwXO862GEs8qFErMwqSvzVS1oOpiV9XH1njjGMYgpAEV
         LuI2JNmAXNIPb1KVfZeGvikSddjDnYwjWU2JRNXOC6bFWtFnGyzprFXZvVmrAtS86EHK
         9V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696779556; x=1697384356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i4LmYSLa0m2la/ko//veY4X3W2mbwibD+qxtMKA9Uk=;
        b=Xq/5y2nA3B4W2jh8NG73io4dSyPEINVo/4ei3xlZDVCKkk2Iev9jXSuhWr8Pt8Xjrh
         zdKGITNOMSN/uP04PjrQkZClT9w2jSgq12W5v52Gn+5tpMDvurbDZz3q0nQCUPhnkhEW
         auvfSB9TECnSFrNchLtwZwt1CZleiN+v8ygx/vUl76aKlDb2fI2nWOKFPaoHBe8mYciG
         vkQCZJfD2yMnsStT9fweeCw47fIQ6T3CrDKg8rFZSE4qIkJVITp7htc+HQ8v/HS8VS06
         maROi7ktvRYqesD8WG2LVMsNvHQRbJRtKvXvdsRC4ZVMiDXlwcDrHUXgw9/6/z+BWiHK
         JoJQ==
X-Gm-Message-State: AOJu0YyJJGpXrGqyzUzKUSFBkH3OptkO+IGRZHmkPGQn2pT7pZQlSUln
        Yj/juwLK3kwvcvMhsSfTPO0=
X-Google-Smtp-Source: AGHT+IFotSlQkf5zn2YvP/6NdvVrVDoAsvqkkOCU9yzh2Tq/ZgX/aJoTBlGP07LbpGgHNd99mB40FA==
X-Received: by 2002:a0d:f182:0:b0:5a4:3e67:35a3 with SMTP id a124-20020a0df182000000b005a43e6735a3mr12890777ywf.49.1696779555740;
        Sun, 08 Oct 2023 08:39:15 -0700 (PDT)
Received: from localhost ([2607:fb90:be24:c307:d0e:f8ae:4f55:e8af])
        by smtp.gmail.com with ESMTPSA id v20-20020a81a554000000b005a2521fb26csm2893300ywg.99.2023.10.08.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 08:39:15 -0700 (PDT)
Date:   Sun, 8 Oct 2023 08:39:13 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] lib/bitmap: move bitmap allocators for device to
 linux/device.h
Message-ID: <ZSLNIZxCacxioX95@yury-ThinkPad>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
 <20231007233510.2097166-2-yury.norov@gmail.com>
 <2023100855-railroad-wrecking-25af@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100855-railroad-wrecking-25af@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 06:53:49AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 07, 2023 at 04:35:09PM -0700, Yury Norov wrote:
> > The allocators are simple wrappers around bitmap_{alloc,free}().
> > So move them from bitmap to device sources.
> 
> No, they belong in the bitmap.h file, as they are devm_* versions of the
> same functions in this file.  They don't belong in the device.h file.

OK then. I don't thing that the functions are anything wrong, and
don't want to 'get rid of them' in any way.

But could you please elaborate? I'm not too familiar to devm_* things,
and to me devm_alloc/free() look similar to e.g.
vfio_dma_bitmap_alloc_all() or iova_bitmap_alloc(), which allocate
memory for bitmap + do some other initialization things.

And they all reside in corresponding subsystems. Why devm differs? 
 
> > Similarly to other device wrappers, turn them to static inlines
> > and place in header.
> 
> Why do these need to be inline functions?

Because they are small. devm_bitmap_free() and devm_bitmap_zalloc()
are pure one-line wrappers, and devm_bimap_alloc() is a 2 function
calls followed by conditionals, which is similar  to
__devm_add_action_or_reset() or devm_kmalloc_array() in the same file,
and much less than some other inliners in the source tree.

In my plans, I want to move bitmap_{z,}alloc/free() to linux/bitmap.h,
and that way devm_bitmap_alloc() together with other users would be
propagated __kmalloc_array() by compiler without generating pretty
useless call/ret's, and benefit from compile-time optimizations if
__builtin_constant_p() hits.

Maybe it's worth to do in this series.

Thanks,
Yury
