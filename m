Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EB79443B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbjIFUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIFUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:04:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5519B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:04:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so2668595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694030668; x=1694635468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmMcIhh+Ry+itSHZvmgtEh+vsvBByJvKXB6RAM9pNGQ=;
        b=YfpK0UiHYZsP0nOsd3k0WiHINN/c1HDffqHtbuyrY1RXTTckppfjr7ErNFiUfmKE0F
         N/u5338ERAmMATyNJWWhZEtc4/dpFdyGyu/e1kEe7H+O0JFprc7wi7nvCZUiEOQQmWcp
         G0pQ3H4foadBKA9i6Pu03UY1e99ycDUWP5AII2GEPmZ6moT7vIiJYO79sURgj93D0iP0
         TPL8Se+MKSWerjfGlO5gtNvmwj9IYnMn0e0a5PdF4h261aiEnhh1M9ozDJnAv3KTzBAl
         3S00X+iDfiHvopdzHa2hPKvUWHO0jc4fO2mqc3JXG2qEPOrr3WnTwEr9Y6GttnjOh6Pl
         HEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030668; x=1694635468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmMcIhh+Ry+itSHZvmgtEh+vsvBByJvKXB6RAM9pNGQ=;
        b=VL3vWu56QsI1P92TTiuV2uKXqusQ2OS7azEp9bJ8+waz8ZVQNKwvCGAhG7B2h1IrFI
         yenxuDqy05gXjTd9GxcZwmnDHND2G2ZlnTNxTsykHSgyx2Vqnrc7ps0xVxvyDCvoWzis
         iN595HwWtzzvGgwUT22vjBf/7RmVHhYXq5z2shIDnTHF+aaCpCtLZP4erK5G3gQhHowi
         4AgRa2lB8W6N+SrwSBtatOet42UN8wYZy/GFkr3qjF1m3Zh58tuZuIEVCgj1905Ryh8J
         1cr1pJV/mseN2qtx70JRuM2qkUQphn/naNk8SrRfx19UwTPmebFE9wJnsbS/W0UnNjYi
         qwog==
X-Gm-Message-State: AOJu0YwXsUP+x1kA2iH8b1G9xbq1bD7CKS1deYsNRf+kkeenh8fg99wt
        3nyMnAPRA8y4qQOEM0WZqoM=
X-Google-Smtp-Source: AGHT+IED9e8NyKsYHfBWulB6kYls5zZxPwU85t53yVMQaP9ruOmWv6lEezcMNAM4Yy4mSlMFvVsKJQ==
X-Received: by 2002:a7b:c3d0:0:b0:3fa:8db4:91ec with SMTP id t16-20020a7bc3d0000000b003fa8db491ecmr2959693wmj.10.1694030668261;
        Wed, 06 Sep 2023 13:04:28 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003fbca942499sm470054wmj.14.2023.09.06.13.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:04:27 -0700 (PDT)
Date:   Wed, 6 Sep 2023 21:04:26 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <a21df9dc-ded7-4882-b0e7-688fce4d20b6@lucifer.local>
References: <20230829081142.3619-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:11:33AM +0200, Uladzislau Rezki (Sony) wrote:
> Hello, folk!
>
> This is the v2, the series which tends to minimize the vmap
> lock contention. It is based on the tag: v6.5-rc6. Here you
> can find a documentation about it:

Will take a look when I get a chance at v3 as I gather you're spinning
another version :)

Cheers!

>
> wget ftp://vps418301.ovh.net/incoming/Fix_a_vmalloc_lock_contention_in_SMP_env_v2.pdf
>
> even though it is a bit outdated(it follows v1), it still gives a
> good overview on the problem and how it can be solved. On demand
> and by request i can update it.
>
> The v1 is here: https://lore.kernel.org/linux-mm/ZIAqojPKjChJTssg@pc636/T/
>
> Delta v1 -> v2:
>   - open coded locking;
>   - switch to array of nodes instead of per-cpu definition;
>   - density is 2 cores per one node(not equal to number of CPUs);
>   - VAs first go back(free path) to an owner node and later to
>     a global heap if a block is fully freed, nid is saved in va->flags;
>   - add helpers to drain lazily-freed areas faster, if high pressure;
>   - picked al Reviewed-by.
>
> Test on AMD Ryzen Threadripper 3970X 32-Core Processor:
> sudo ./test_vmalloc.sh run_test_mask=127 nr_threads=64
>
> <v6.5-rc6 perf>
>   94.17%     0.90%  [kernel]    [k] _raw_spin_lock
>   93.27%    93.05%  [kernel]    [k] native_queued_spin_lock_slowpath
>   74.69%     0.25%  [kernel]    [k] __vmalloc_node_range
>   72.64%     0.01%  [kernel]    [k] __get_vm_area_node
>   72.04%     0.89%  [kernel]    [k] alloc_vmap_area
>   42.17%     0.00%  [kernel]    [k] vmalloc
>   32.53%     0.00%  [kernel]    [k] __vmalloc_node
>   24.91%     0.25%  [kernel]    [k] vfree
>   24.32%     0.01%  [kernel]    [k] remove_vm_area
>   22.63%     0.21%  [kernel]    [k] find_unlink_vmap_area
>   15.51%     0.00%  [unknown]   [k] 0xffffffffc09a74ac
>   14.35%     0.00%  [kernel]    [k] ret_from_fork_asm
>   14.35%     0.00%  [kernel]    [k] ret_from_fork
>   14.35%     0.00%  [kernel]    [k] kthread
> <v6.5-rc6 perf>
>    vs
> <v6.5-rc6+v2 perf>
>   74.32%     2.42%  [kernel]    [k] __vmalloc_node_range
>   69.58%     0.01%  [kernel]    [k] vmalloc
>   54.21%     1.17%  [kernel]    [k] __alloc_pages_bulk
>   48.13%    47.91%  [kernel]    [k] clear_page_orig
>   43.60%     0.01%  [unknown]   [k] 0xffffffffc082f16f
>   32.06%     0.00%  [kernel]    [k] ret_from_fork_asm
>   32.06%     0.00%  [kernel]    [k] ret_from_fork
>   32.06%     0.00%  [kernel]    [k] kthread
>   31.30%     0.00%  [unknown]   [k] 0xffffffffc082f889
>   22.98%     4.16%  [kernel]    [k] vfree
>   14.36%     0.28%  [kernel]    [k] __get_vm_area_node
>   13.43%     3.35%  [kernel]    [k] alloc_vmap_area
>   10.86%     0.04%  [kernel]    [k] remove_vm_area
>    8.89%     2.75%  [kernel]    [k] _raw_spin_lock
>    7.19%     0.00%  [unknown]   [k] 0xffffffffc082fba3
>    6.65%     1.37%  [kernel]    [k] free_unref_page
>    6.13%     6.11%  [kernel]    [k] native_queued_spin_lock_slowpath
> <v6.5-rc6+v2 perf>
>
> On smaller systems, for example, 8xCPU Hikey960 board the
> contention is not that high and is approximately ~16 percent.
>
> Uladzislau Rezki (Sony) (9):
>   mm: vmalloc: Add va_alloc() helper
>   mm: vmalloc: Rename adjust_va_to_fit_type() function
>   mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
>   mm: vmalloc: Remove global vmap_area_root rb-tree
>   mm: vmalloc: Remove global purge_vmap_area_root rb-tree
>   mm: vmalloc: Offload free_vmap_area_lock lock
>   mm: vmalloc: Support multiple nodes in vread_iter
>   mm: vmalloc: Support multiple nodes in vmallocinfo
>   mm: vmalloc: Set nr_nodes/node_size based on CPU-cores
>
>  mm/vmalloc.c | 929 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 683 insertions(+), 246 deletions(-)
>
> --
> 2.30.2
>
