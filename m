Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869AE791A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353175AbjIDO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349143AbjIDO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:56:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A39173F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so23247021fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693839342; x=1694444142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMYqlhxNIvQnoz2i2gTHdbFl4bwBHBPtaOUi7bDs8bs=;
        b=T7GqJxF5yio/YB9TYslaaZTFOLomvcYjV2pALXir6t4Jna7NjLrijHRDeFFwBGd3v4
         AdlawfKg9nKnRq/abKVFyEbVZiHeuUBRaDkARfcYnkR0gaC9/AEpNCpLGU6kOHjxRUxh
         5hpdQKgHQk23Tg7a12pU6FWu9Muv6tmBQI2/Z90DTeZG1IzZryTzKVzD5rYGl/CpOOIW
         uLwmeR+fh8Y6ITwnZ9XmBCj8zwRV9sSSNq69gJ1NQAQVez/MkWQLNdiWeF+PHD0viYcM
         oXJCEJFScm8dyQwPOXdpxRU/02xJ2mb2M6nEGZgcyCxADAr0AIFP/1uOsItXgn8Uz4mk
         S7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839342; x=1694444142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMYqlhxNIvQnoz2i2gTHdbFl4bwBHBPtaOUi7bDs8bs=;
        b=gvzKWhdL/Bho2XC0eehiL5RIZZcfhNmD+JXlJgHLWmrC3qlQzADIpED0YeV3qLHxUJ
         t0tJZioe16cdd3gGjlzbi4N37EBXkbZb9R2bzw8XLg6z4dJ/y9Q6vIE+NM50juXdoO0H
         RpLejL0EXdiziIcJl+mJmFpCaWrIde3Iv0HH4VgRTklMVXvewDiWpY5gXzdFvOY6X6/X
         fA+CZsFFP4GvUOGF/pqt4oHr7WbiOazjCdPecGds5h0S/nhR6Fo7RBXXLmn8ggYiWheY
         D5lLheI75rSzco1Zr4gTYOHmCTc/QQrYw415lMBvddy6xeJCs33v8QbzfHWhxcrg7ja2
         PQgg==
X-Gm-Message-State: AOJu0Yw5kcFqzcAjQutwumiEu+HrREKMYI1jA3xwOHcS57BWbcA+KmKZ
        KvPvlF6TD8yBSYjz/KioP6U=
X-Google-Smtp-Source: AGHT+IHYMVpp2doc7lurqwDdugR0o+F59rLyi+qulPer88rRAn8DqEoDwXp+MwCCiJ6Zf5JxUpI46Q==
X-Received: by 2002:a05:651c:158:b0:2bd:1732:c10b with SMTP id c24-20020a05651c015800b002bd1732c10bmr7333565ljd.34.1693839341809;
        Mon, 04 Sep 2023 07:55:41 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w20-20020a2e3014000000b002bcb89e92dcsm2178791ljw.6.2023.09.04.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 07:55:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 16:55:38 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <ZPXv6o3a43xisdmc@pc636>
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

Hello, Andrew!

> Hello, folk!
> 
> This is the v2, the series which tends to minimize the vmap
> lock contention. It is based on the tag: v6.5-rc6. Here you
> can find a documentation about it:
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
It would be good if this series somehow could be tested having some runtime
from the people. So far there was a warning from the test robot:

https://lore.kernel.org/lkml/202308292228.RRrGUYyB-lkp@intel.com/T/#m397b3834cb3b7a0a53b8dffb3624384c8e278007

<snip>
urezki@pc638:~/data/raid0/coding/linux.git$ git diff
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 08990f630c21..7105d7bcd37e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4778,7 +4778,7 @@ static void vmap_init_free_space(void)
         *  |<--------------------------------->|
         */
        for (busy = vmlist; busy; busy = busy->next) {
-               if (busy->addr - vmap_start > 0) {
+               if ((unsigned long) busy->addr - vmap_start > 0) {
                        free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
                        if (!WARN_ON_ONCE(!free)) {
                                free->va_start = vmap_start;
urezki@pc638:~/data/raid0/coding/linux.git$
<snip>

This extra patch has to be applied to fix the warning. 

From my side i have tested it as much as i can. Can it be plugged
into linux-next to get some runtime? Or is there any other way you
prefer to go?

Thank you in advance!

--
Uladzislau Rezki
