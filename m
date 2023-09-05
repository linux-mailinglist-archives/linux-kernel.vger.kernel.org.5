Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AD792853
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbjIEQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353642AbjIEHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:00:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AB1B4;
        Tue,  5 Sep 2023 00:00:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31977ace1c8so1906759f8f.1;
        Tue, 05 Sep 2023 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693897247; x=1694502047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXyDlNAn3aTmEsTW95GvcdGMYos2arUzMqrBn1clqqU=;
        b=jNNWHI3DOC7sP3Ti/qBCBMv8WTmQOsm30oiRcxojWhKMNoOXsbz+kcXnay28kNcE9q
         NjUqlLkCyTDhCAkHW+I0oVi/3/+fdV22OFwoMvz8WICuwnVm4mt11RR+uZLRFg5uQROu
         YqfItgXxV0bZdBiixPLaQStdw3nlgHQbYH64Gl/jKcZyMni0i4r+X3y4oXGdLlUFBruW
         Ig6Cr87bYy9SmvU0RCpKpvBCqjC+ravdsTMSrAt3quj0+oO+NXdMHSrTKojgP7DPAzta
         x2EU2AcFec3qxl8rBf//1vNFy+7iG9XY0ZCIP9rXp4LTKWIssCL4CNJE6M0QADjWKK0L
         xMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897247; x=1694502047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXyDlNAn3aTmEsTW95GvcdGMYos2arUzMqrBn1clqqU=;
        b=Y0KWU6v52mwr6ScBOPvGB/Wpu2rI2tUSgtQzwV7G/CBg6DP9KEODK3me2BROwJdpwL
         6mB7Gz3R0vnLzsFyl6xT8Cy6JhZGUXZW2reL/pZtAbJEJKnrnAM2fLOyhGX2ACdtzplb
         pAb8CwKSVIcMf/lmJNtj4tsElUhv4Sjc7EuVDs6eEtA/0lKzNXwIifKlytqJN32WVHdA
         VX5c8JwbcW8ucs2ERuy4jOT0bihROLDUl8CXJvgr+64Lgu7T/dNaFb98niKXlONTwphF
         QpbAPhDszXy3Io4faUHVAanIDqdERIYHCo1cobdyZoQmVsrnQboa84N/KaUdfNdvLjpW
         cJJA==
X-Gm-Message-State: AOJu0YxgtdcbBDJgANQtgzVv0EeJoriEXSZHRc2pUE88b/hqAAbria+w
        OweL7WqQksKSGxrvOAHGdlsIYMLRlyY=
X-Google-Smtp-Source: AGHT+IEKEbKZfrPdCfjnpm+31/ypyN57DgQ4HIlr4pBsGEOmUoh+hYLzMpfl8Lvumz9Ie9xQTh6RQQ==
X-Received: by 2002:a5d:4d49:0:b0:319:6ce2:e5a3 with SMTP id a9-20020a5d4d49000000b003196ce2e5a3mr8470261wru.26.1693897246723;
        Tue, 05 Sep 2023 00:00:46 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id r5-20020adfe685000000b003143867d2ebsm16569287wrm.63.2023.09.05.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:00:45 -0700 (PDT)
Date:   Tue, 5 Sep 2023 08:00:44 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] rcu: Dump vmalloc memory info safely
Message-ID: <9e329429-73a5-4926-af4f-edcf9e547101@lucifer.local>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <20230904180806.1002832-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904180806.1002832-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 06:08:05PM +0000, Joel Fernandes (Google) wrote:
> From: Zqiang <qiang.zhang1211@gmail.com>
>
> Currently, for double invoke call_rcu(), will dump rcu_head objects
> memory info, if the objects is not allocated from the slab allocator,
> the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> need to be held, since the call_rcu() can be invoked in interrupt context,
> therefore, there is a possibility of spinlock deadlock scenarios.
>
> And in Preempt-RT kernel, the rcutorture test also trigger the following
> lockdep warning:
>
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> 3 locks held by swapper/0/1:
>  #0: ffffffffb534ee80 (fullstop_mutex){+.+.}-{4:4}, at: torture_init_begin+0x24/0xa0
>  #1: ffffffffb5307940 (rcu_read_lock){....}-{1:3}, at: rcu_torture_init+0x1ec7/0x2370
>  #2: ffffffffb536af40 (vmap_area_lock){+.+.}-{3:3}, at: find_vmap_area+0x1f/0x70
> irq event stamp: 565512
> hardirqs last  enabled at (565511): [<ffffffffb379b138>] __call_rcu_common+0x218/0x940
> hardirqs last disabled at (565512): [<ffffffffb5804262>] rcu_torture_init+0x20b2/0x2370
> softirqs last  enabled at (399112): [<ffffffffb36b2586>] __local_bh_enable_ip+0x126/0x170
> softirqs last disabled at (399106): [<ffffffffb43fef59>] inet_register_protosw+0x9/0x1d0
> Preemption disabled at:
> [<ffffffffb58040c3>] rcu_torture_init+0x1f13/0x2370
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc4-rt2-yocto-preempt-rt+ #15
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x68/0xb0
>  dump_stack+0x14/0x20
>  __might_resched+0x1aa/0x280
>  ? __pfx_rcu_torture_err_cb+0x10/0x10
>  rt_spin_lock+0x53/0x130
>  ? find_vmap_area+0x1f/0x70
>  find_vmap_area+0x1f/0x70
>  vmalloc_dump_obj+0x20/0x60
>  mem_dump_obj+0x22/0x90
>  __call_rcu_common+0x5bf/0x940
>  ? debug_smp_processor_id+0x1b/0x30
>  call_rcu_hurry+0x14/0x20
>  rcu_torture_init+0x1f82/0x2370
>  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>  ? __pfx_rcu_torture_leak_cb+0x10/0x10
>  ? __pfx_rcu_torture_init+0x10/0x10
>  do_one_initcall+0x6c/0x300
>  ? debug_smp_processor_id+0x1b/0x30
>  kernel_init_freeable+0x2b9/0x540
>  ? __pfx_kernel_init+0x10/0x10
>  kernel_init+0x1f/0x150
>  ret_from_fork+0x40/0x50
>  ? __pfx_kernel_init+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
>
> The previous patch fixes this by using the deadlock-safe best-effort
> version of find_vm_area. However, in case of failure print the fact that
> the pointer was a vmalloc pointer so that we print at least something.
>
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/util.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4..406634f26918 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1071,7 +1071,9 @@ void mem_dump_obj(void *object)
>  	if (vmalloc_dump_obj(object))
>  		return;
>
> -	if (virt_addr_valid(object))
> +	if (is_vmalloc_addr(object))
> +		type = "vmalloc memory";
> +	else if (virt_addr_valid(object))
>  		type = "non-slab/vmalloc memory";

I think you should update this to say non-slab/non-vmalloc memory (as much
as that description sucks!) as this phrasing in the past meant to say
'non-slab or vmalloc memory' (already confusing phrasing) so better to be
clear.

>  	else if (object == NULL)
>  		type = "NULL pointer";
> --
> 2.42.0.283.g2d96d420d3-goog
>
