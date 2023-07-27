Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798D764B71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjG0IPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjG0IMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:12:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253935AB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:07:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso6767975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690445222; x=1691050022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FYxBpzPpC5O6YqpkIvrfnMVqesGcNf08sa9kAENUdY=;
        b=DPHqd4jJ4aCJ/ldSJMSi2jpGa9mD88lGm346gmWtivG/pxsYPMaWip1zoYbH/a4coT
         1u6SknFx4FWBaUj+1vMwJ0oZicCLV8K9PG7TQkgYkxQyICErAjNTPFvGWLAh8lWw6dpY
         q+i1F4j2Lf4KXij+sw2p6q2WkpVclXZTptS/Vr7lgFgU8IJs+YeRZair63x655FFyIBR
         ScsonJm1JrPcdavl7kjoD49RAbj77BQVPfADOUA8GYdLyC88Ie3tCCgUJKFBVfxWjBLR
         FibTVEScPEX8iUoEtf3jR3zNd61RhU4cxrNaGtBGbfjpcE8O8saA1d41XdwB/xiGsrZZ
         1SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445222; x=1691050022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FYxBpzPpC5O6YqpkIvrfnMVqesGcNf08sa9kAENUdY=;
        b=HcV5WqNpcdK0cmxJkByuTzHIQ/tToBQ/UknrSXvI3xzRQ1EZwJ9QfFDCGLNXUmcuiS
         dhg4mJv+CprqQVGCQQXKkoIfGHtS3p2CUKWcWZplDER5urS1eHWRD6RRHB88b/lwkbrV
         oOqqcwC+Oh/DZRMyyc7IRefnosS+eorknlJNk1ZqGru5DhF2y6vHhTNIqLnfu+8CYwaB
         kN7z3IoPGvhc9oG/DPyEnMk78uRX6cXOWJmLVtUdvX/J/gXp3wpsrOZhikDo4Ba8PlXj
         2AlI2HuPxc5szuytScSi7T4g0W9hynvbbatBwKgahhHA1CVGAgQX8g2TlNLqEtbc20f8
         6N7g==
X-Gm-Message-State: ABy/qLbxojcIMIA6YMs3cW7bEnytBmPYQseNbdBF/Pq+z4QuE8csXrUW
        hn9o00IrPOrjw76RDY1M0DOVn+6SFtdrqTuOjDE3Ig==
X-Google-Smtp-Source: APBJJlESVm3o8EnthSnO0wSdv89jxTgM1e60N2vrTcCIowIo43OPkYeplR8UZwVzk03vqs4NZslRBGLk21TmdRmjyEM=
X-Received: by 2002:a05:600c:ad6:b0:3fc:2dfb:3cd3 with SMTP id
 c22-20020a05600c0ad600b003fc2dfb3cd3mr1012433wmr.41.1690445222226; Thu, 27
 Jul 2023 01:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
In-Reply-To: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
From:   Marco Elver <elver@google.com>
Date:   Thu, 27 Jul 2023 10:06:25 +0200
Message-ID: <CANpmjNMWqcseZAijhVP_TDORXxBTgj0GWbTzq5ive2e+0Xto+A@mail.gmail.com>
Subject: Re: mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here
 instead of GFP_KERNEL?
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Helge Deller <deller@gmx.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 06:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
[...]
> smatch warnings:
> mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here instead of GFP_KERNEL?
>
> (Just included these for the LOLs)
> mm/kfence/kfence_test.c:395 test_double_free() error: double free of 'expect.addr'
> mm/kfence/kfence_test.c:671 test_memcache_typesafe_by_rcu() error: dereferencing freed memory 'expect.addr'

Nice! ;-)

> vim +/gfp +287 mm/kfence/kfence_test.c
>
[...]
> bc8fbc5f305aec Marco Elver     2021-02-25  278          do {
> bc8fbc5f305aec Marco Elver     2021-02-25  279                  if (test_cache)
> bc8fbc5f305aec Marco Elver     2021-02-25  280                          alloc = kmem_cache_alloc(test_cache, gfp);
> bc8fbc5f305aec Marco Elver     2021-02-25  281                  else
> bc8fbc5f305aec Marco Elver     2021-02-25  282                          alloc = kmalloc(size, gfp);
>                                                                                               ^^^
>
> bc8fbc5f305aec Marco Elver     2021-02-25  283
> bc8fbc5f305aec Marco Elver     2021-02-25  284                  if (is_kfence_address(alloc)) {
> 8dae0cfed57357 Vlastimil Babka 2021-11-03  285                          struct slab *slab = virt_to_slab(alloc);
> 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28  286                          struct kmem_cache *s = test_cache ?:
> 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28 @287                                          kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
>                                                                                                                     ^^^^^^^^^^
> I feel like using gfp might be correct but I'm not sure?  This code
> is from prior to this commit.  Let's add Marco to the CC.

It's not a bug today: If we were testing something other than
GFP_KERNEL, then yes, we should use gfp here. But the only reason
"gfp" is a function arg at all, is that 1 test case also uses
__GFP_ZERO, but that's irrelevant in getting the kmalloc type (at
least today).

The cache is used to test the below "helpers return the right values
even for KFENCE objects".

I think when I wrote the test I just chose GFP_KERNEL, because none of
the test cases use something else, and didn't give it a second
thought. Not sure it's worth changing, because functionally it doesn't
matter.

I'm open to changing it, if it makes this warning go away. Preferences?

> bc8fbc5f305aec Marco Elver     2021-02-25  288
> bc8fbc5f305aec Marco Elver     2021-02-25  289                          /*
> bc8fbc5f305aec Marco Elver     2021-02-25  290                           * Verify that various helpers return the right values
> bc8fbc5f305aec Marco Elver     2021-02-25  291                           * even for KFENCE objects; these are required so that
> bc8fbc5f305aec Marco Elver     2021-02-25  292                           * memcg accounting works correctly.
> bc8fbc5f305aec Marco Elver     2021-02-25  293                           */
> 8dae0cfed57357 Vlastimil Babka 2021-11-03  294                          KUNIT_EXPECT_EQ(test, obj_to_index(s, slab, alloc), 0U);
> 8dae0cfed57357 Vlastimil Babka 2021-11-03  295                          KUNIT_EXPECT_EQ(test, objs_per_slab(s, slab), 1);
