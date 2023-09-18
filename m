Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803937A4947
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbjIRMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbjIRMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:09:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C125A0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:08:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6515d44b562so25704656d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695038934; x=1695643734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ziZvMGLK6JgmUUboWqZiWtfE7gVK2DDQAWWdwk2gDB8=;
        b=p61uxtX0s6QXhc4OmvJvspTqCcs2jz3xrCH+J4noLOoD1mjKzM0525uRVmVJyeilS4
         hITA3Njo9vEato1lC05/6upCAPiyHpNEzm6+vkejZDLfpWZ6Uq06/XKDJO3TGRZEA4x3
         Li+i7BI+ooan++z/FQ3wS/cQEFl7WbpG2KWcv4tMOcFu2VlGfcWsC+8Ag5Ragp5O6xcn
         X8dJ/T4Fn6/bakka1UpaJFJIn0TTf9o/MOx1bsZOPfs/9CSHOSD4wjPBOBqMRyAE2ywV
         QJfivMQjREm23VomDYxMjvNdlh3+lTK+F8rX2XcD0/bMlTtHu2D0t6vAsuN0Lwt53HK5
         ZBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038934; x=1695643734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziZvMGLK6JgmUUboWqZiWtfE7gVK2DDQAWWdwk2gDB8=;
        b=HrIom0vTAH5dXtNON4G2k1RSPymqSsvhzsn6lmyyPwJ1d78TmkbrRz/uVcmfc4hHPQ
         q7r5bQop0v7bnJRYSLwbJPdkfwOufZucHNLCkXo1x9p42PrwslxcQAvNKnIKFvP9mKPc
         GBEJgTaYjf5oQFFSMyYnacvMyI2pqgo5bxmrDdrLu3LKGFSibSuFwycCBoYRchgy7LEM
         UKjxdQDE2mCH+h//+2BlRRxX9ood/Nxonxqp2Hna6HrrgiFrkOav4KzBctSFFdGpvJfS
         TaXEWHUnt3wsLKA4aDwnvSNNY21Dfed6DeDGBDxCdbmqq1+G8ygY75BqKKTWK0AM8WP5
         QIoA==
X-Gm-Message-State: AOJu0YxuePPL1PNGRDSugB/l0+gVo8+GrN+EL8opSZuoPdoqTrZPyOil
        cZy812ml2rIEorjb0adoafD8fZIzVBqGAEc/wI16cw==
X-Google-Smtp-Source: AGHT+IGe6eycPkCnJorto9OJHO+hQCundE/h1zKNUGuoGj4gpWrDhAWQ0sCOlXxSU9kbzdmJ9bi8fQ6B0MF4HXGsu54=
X-Received: by 2002:a0c:cc82:0:b0:656:5337:e7bd with SMTP id
 f2-20020a0ccc82000000b006565337e7bdmr4263366qvl.3.1695038934426; Mon, 18 Sep
 2023 05:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
In-Reply-To: <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Mon, 18 Sep 2023 14:08:43 +0200
Message-ID: <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 18:30, Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Fri, 15 Sep 2023, Dave Hansen wrote:
>
> > What's the cost?
>
> The only thing that I see is 1-2% on kernel compilations (and "more on
> machines with lots of cores")?

I used kernel compilation time (wall clock time) as a benchmark while
preparing the series. Lower is better.

Intel Skylake, 112 cores:

      LABEL    | COUNT |   MIN   |   MAX   |   MEAN  |  MEDIAN | STDDEV
---------------+-------+---------+---------+---------+---------+--------
SLAB_VIRTUAL=n | 150   | 49.700s | 51.320s | 50.449s | 50.430s | 0.29959
SLAB_VIRTUAL=y | 150   | 50.020s | 51.660s | 50.880s | 50.880s | 0.30495
               |       | +0.64%  | +0.66%  | +0.85%  | +0.89%  | +1.79%

AMD Milan, 256 cores:

    LABEL      | COUNT |   MIN   |   MAX   |   MEAN  |  MEDIAN | STDDEV
---------------+-------+---------+---------+---------+---------+--------
SLAB_VIRTUAL=n | 150   | 25.480s | 26.550s | 26.065s | 26.055s | 0.23495
SLAB_VIRTUAL=y | 150   | 25.820s | 27.080s | 26.531s | 26.540s | 0.25974
               |       | +1.33%  | +2.00%  | +1.79%  | +1.86%  | +10.55%

Are there any specific benchmarks that you would be interested in seeing or
that are usually used for SLUB?

> Problems:
>
> - Overhead due to more TLB lookups
>
> - Larger amounts of TLBs are used for the OS. Currently we are trying to
> use the maximum mappable TLBs to reduce their numbers. This presumably
> means using 4K TLBs for all slab access.

Yes, we are using 4K pages for the slab mappings which is going to increase
TLB pressure. I also tried writing a version of the patch that uses 2M
pages which had slightly better performance, but that had its own problems.
For example most slabs are much smaller than 2M, so we would need to create
and map multiple slabs at once and we wouldn't be able to release the
physical memory until all slabs in the 2M page are unused which increases
fragmentation.

> - Memory may not be physically contiguous which may be required by some
> drivers doing DMA.

In the current implementation each slab is backed by physically contiguous
memory, but different slabs that are adjacent in virtual memory might not
be physically contiguous. Treating objects allocated from two different
slabs as one contiguous chunk of memory is probably wrong anyway, right?

--
Matteo
