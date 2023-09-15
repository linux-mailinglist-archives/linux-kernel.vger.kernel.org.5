Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053917A1804
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjIOIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:10:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69EAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:10:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0db66af1bso14467285ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694765425; x=1695370225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2YVTb9jN/H45T6LbvxRBUTeCRk1zmWouQOJbDdhJRA=;
        b=YkBt9dBrNDNiNsGpjEtGPSNL6y5LIP7eNWtSZmocRKeeZ66wLNlA1Szs/zoZ5aeJYb
         D9Iy9xY/n1XA4WvtUmuby/3RMKA/LBH10T95IJ/HjkfnIoi/Fk+GjY8IkhyADrV09Qf6
         woF2M3dcz0x8LLA8IW6DZaKqagiH/PUScTGdq8eTTqF7bjR8QOP3OEUBNOT0325OSvto
         J66Nu5EPULEJUVTKZC0kIzRDSvTKIT6J1lHnSf/INZychJ5FxPXMo6FH524A5y9bII49
         DKvh+ftDg9ZQBlYnTAo3u3iyp4U5jD/i4hPFI80dd1pfFRuZNQcs3Wq5+XnmxVsdDK+D
         YMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694765425; x=1695370225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2YVTb9jN/H45T6LbvxRBUTeCRk1zmWouQOJbDdhJRA=;
        b=icSGP5Hdwn/bAdBIWkp1EhTokRRf/8Lj44kVEiA1oIqlYIEbcVTGdfwCylHkRo3iSR
         BIAPh1PQjCFvd3jBhO9FAuhRG/DaBvCeefFsDLwYFX7R0ebdRDx/ydg5suhLuK/ZZR6U
         +Q3oVEXH/KjwfB/3MTyHja2er3KtuTMja6PxI/pYPSX6z3izNWJkKUcjL07kN3OZOlzB
         iQw9jPWjw0UndEVxG/J7Xzf8yd5xQO3oBKNxnzbg46e7XnxMgi6bkdPj4whYN/v6lcSH
         iE0Kj0LK42voAlM5nT7awCxP15jZ3QGl9QdTvFhziSys/ozr+lI+hHfnBRNHjtJSM3MT
         QBZA==
X-Gm-Message-State: AOJu0Yyfl3W2VpKU5KQT/gS1nufyONDrPyxMCpkCs6vVyQW5ghz8dbvF
        g4HgOyd1ZlI1u8gvX3mHwzE=
X-Google-Smtp-Source: AGHT+IGrjKXOWtXDDkUAlFc1m1gWy3mZqIi/UitnpbTFbqIQRm7ssRn26iMJ91ZPMvGMQt0TdjEO0Q==
X-Received: by 2002:a17:903:1c5:b0:1bd:ca21:c83 with SMTP id e5-20020a17090301c500b001bdca210c83mr935133plh.68.1694765424725;
        Fri, 15 Sep 2023 01:10:24 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001bc87e6e26bsm2849482plc.222.2023.09.15.01.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:10:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 10A278AA8415; Fri, 15 Sep 2023 15:10:18 +0700 (WIB)
Date:   Fri, 15 Sep 2023 15:10:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     xiaohui li <buhuiyuanyuan1984@gmail.com>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: =?utf-8?B?44CQQnVn44CRdXNlLWFmdGVyLWZy?= =?utf-8?Q?ee?= in NVMe
 request double completion detected by kasan
Message-ID: <ZQQRaj6WFizrDZHM@debian.me>
References: <CAEVrx8CEFY21BBpbpq5CmshyzgDY_WYg7VGh6Br1bZac7kBiTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xg/7I3pXssFjS9Dt"
Content-Disposition: inline
In-Reply-To: <CAEVrx8CEFY21BBpbpq5CmshyzgDY_WYg7VGh6Br1bZac7kBiTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xg/7I3pXssFjS9Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:00:34PM +0800, xiaohui li wrote:
> hello everyone:
>=20
> on my aarch64 board + linux kernel 5.10.4,  while doing nvme io test,
> a use-after-free bug has been detected by kasan such as below,
> as this bug has turned up frequently, with high probability.
> in the end,  my nvme disk can't work right now.
> hope some one can give me some advise on how to solve this problem, many =
thanks.

Which nvme disk you have this issue?

>=20
> ------------------------------------------
> nvme nvme0: I/O 75 QID 6 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 75 QID 6 timeout, reset controller
> nvme nvme0: 15/0/0 default/read/poll queues
>=20
> [  163.462149][    C1] BUG: KASAN: use-after-free in
> dma_direct_unmap_sg+0x78/0x298
> [  163.469591][    C1] Read of size 8 at addr ffff0000462fa010 by task
> kworker/u16:5/475
> [  163.477457][    C1]
> [  163.479679][    C1] CPU: 1 PID: 475 Comm: kworker/u16:5 Not tainted 5.=
10.4 #2
> [  163.486847][    C1] Hardware name: Intellifusion Edge10 (DT)
> [  163.492558][    C1] Workqueue: writeback wb_workfn (flush-259:0)
> [  163.498618][    C1] Call trace:
> [  163.501794][    C1]  dump_backtrace+0x0/0x2b8
> [  163.506182][    C1]  show_stack+0x20/0x70
> [  163.510230][    C1]  dump_stack+0xfc/0x168
> [  163.514371][    C1]  print_address_description.constprop.0+0x70/0x4e4
> [  163.520856][    C1]  kasan_report+0x138/0x208
> [  163.525247][    C1]  __asan_load8+0x9c/0xd8
> [  163.529466][    C1]  dma_direct_unmap_sg+0x78/0x298
> [  163.534378][    C1]  dma_unmap_sg_attrs+0x64/0xb0
> [  163.539126][    C1]  nvme_unmap_data+0xb0/0x298
> [  163.543697][    C1]  nvme_pci_complete_rq+0x7c/0x140
> [  163.548699][    C1]  nvme_irq+0x218/0x4a8
> [  163.552749][    C1]  __handle_irq_event_percpu+0x8c/0x3c8
> [  163.558188][    C1]  handle_irq_event_percpu+0x8c/0x108
> [  163.563451][    C1]  handle_irq_event+0x6c/0x120
> [  163.568105][    C1]  handle_simple_irq+0xe0/0x128
> [  163.572846][    C1]  generic_handle_irq+0x54/0x70
> [  163.577595][    C1]  edge_pcie_irq_domain_handler+0x128/0x1a8
> [  163.583380][    C1]  generic_handle_irq+0x54/0x70
> [  163.588121][    C1]  __handle_domain_irq+0x88/0xf0
> [  163.592947][    C1]  gic_handle_irq+0xe4/0x128
> [  163.597425][    C1]  el1_irq+0xc4/0x180
> [  163.601296][    C1]  __asan_load8+0x70/0xd8
> [  163.605518][    C1]  walk_stackframe+0x3c/0x78
> [  163.609995][    C1]  arch_stack_walk+0xd4/0x168
> [  163.614563][    C1]  stack_trace_save+0xa4/0xd8
> [  163.619129][    C1]  kasan_save_stack+0x28/0x58
> [  163.623695][    C1]  __kasan_kmalloc.isra.0+0xc8/0xe8
> [  163.628783][    C1]  kasan_slab_alloc+0x18/0x28
> [  163.633349][    C1]  kmem_cache_alloc+0x1a8/0x640
> [  163.638089][    C1]  ext4_init_io_end+0x2c/0xb0
> [  163.642657][    C1]  ext4_writepages+0x4bc/0x1288
> [  163.647398][    C1]  do_writepages+0xc0/0x1a0
> [  163.651796][    C1]  __writeback_single_inode+0x70/0x7e0
> [  163.657148][    C1]  writeback_sb_inodes+0x324/0x708
> [  163.662152][    C1]  __writeback_inodes_wb+0x70/0x158
> [  163.667243][    C1]  wb_writeback+0x3ac/0x620
> [  163.671636][    C1]  wb_workfn+0x3cc/0x900
> [  163.675769][    C1]  process_one_work+0x3e8/0x888
> [  163.680507][    C1]  worker_thread+0x7c/0x678
> [  163.684901][    C1]  kthread+0x1e0/0x220
> [  163.688858][    C1]  ret_from_fork+0x10/0x34
> [  163.693154][    C1]
> [  163.695365][    C1] Allocated by task 475:
> [  163.699498][    C1]  stack_trace_save+0xa4/0xd8
> [  163.704063][    C1]  kasan_save_stack+0x28/0x58
> [  163.708628][    C1]  __kasan_kmalloc.isra.0+0xc8/0xe8
> [  163.713715][    C1]  kasan_kmalloc+0x10/0x20
> [  163.718017][    C1]  __kmalloc+0x3cc/0x690
> [  163.722152][    C1]  mempool_kmalloc+0x24/0x30
> [  163.726632][    C1]  mempool_alloc+0xe8/0x218
> [  163.731027][    C1]  nvme_map_data+0xf0/0xda8
> [  163.735419][    C1]  nvme_queue_rq+0x148/0x3b8
> [  163.739903][    C1]  __blk_mq_try_issue_directly+0x214/0x2e8
> [  163.745602][    C1]  blk_mq_request_issue_directly+0xbc/0x108
> [  163.751388][    C1]  blk_mq_try_issue_list_directly+0xe8/0x1d8
> [  163.757266][    C1]  blk_mq_sched_insert_requests+0x230/0x300
> [  163.763052][    C1]  blk_mq_flush_plug_list+0x22c/0x3c8
> [  163.768318][    C1]  blk_flush_plug_list+0x1e4/0x228
> [  163.773319][    C1]  blk_mq_submit_bio+0x40c/0xa50
> [  163.778147][    C1]  submit_bio_noacct+0x590/0x630
> [  163.782965][    C1]  submit_bio+0xc8/0x360
> [  163.787093][    C1]  ext4_io_submit+0xa8/0xd0
> [  163.791485][    C1]  ext4_writepages+0x8f8/0x1288
> [  163.796224][    C1]  do_writepages+0xc0/0x1a0
> [  163.800621][    C1]  __writeback_single_inode+0x70/0x7e0
> [  163.805974][    C1]  writeback_sb_inodes+0x324/0x708
> [  163.810978][    C1]  __writeback_inodes_wb+0x70/0x158
> [  163.816068][    C1]  wb_writeback+0x3ac/0x620
> [  163.820461][    C1]  wb_workfn+0x3cc/0x900
> [  163.824590][    C1]  process_one_work+0x3e8/0x888
> [  163.829328][    C1]  worker_thread+0x7c/0x678
> [  163.833721][    C1]  kthread+0x1e0/0x220
> [  163.837677][    C1]  ret_from_fork+0x10/0x34
> [  163.841972][    C1]
> [  163.844181][    C1] Freed by task 475:
> [  163.847967][    C1]  stack_trace_save+0xa4/0xd8
> [  163.852533][    C1]  kasan_save_stack+0x28/0x58
> [  163.857097][    C1]  kasan_set_track+0x28/0x40
> [  163.861577][    C1]  kasan_set_free_info+0x24/0x48
> [  163.866402][    C1]  __kasan_slab_free+0x100/0x180
> [  163.871227][    C1]  kasan_slab_free+0x14/0x20
> [  163.875703][    C1]  kfree+0xe0/0x400
> [  163.879401][    C1]  mempool_kfree+0x18/0x28
> [  163.883706][    C1]  mempool_free+0x7c/0x1e0
> [  163.888013][    C1]  nvme_unmap_data+0x1ac/0x298
> [  163.892668][    C1]  nvme_pci_complete_rq+0x7c/0x140
> [  163.897670][    C1]  nvme_irq+0x218/0x4a8
> [  163.901717][    C1]  __handle_irq_event_percpu+0x8c/0x3c8
> [  163.907155][    C1]  handle_irq_event_percpu+0x8c/0x108
> [  163.912419][    C1]  handle_irq_event+0x6c/0x120
> [  163.917072][    C1]  handle_simple_irq+0xe0/0x128
> [  163.921812][    C1]  generic_handle_irq+0x54/0x70
> [  163.926560][    C1]  edge_pcie_irq_domain_handler+0x128/0x1a8
> [  163.932345][    C1]  generic_handle_irq+0x54/0x70
> [  163.937085][    C1]  __handle_domain_irq+0x88/0xf0
> [  163.941909][    C1]  gic_handle_irq+0xe4/0x128
> [  163.946378][    C1]
> [  163.948594][    C1] The buggy address belongs to the object at
> ffff0000462fa000
> [  163.948594][    C1]  which belongs to the cache kmalloc-4k of size 4096
> [  163.962561][    C1] The buggy address is located 16 bytes inside of
> [  163.962561][    C1]  4096-byte region [ffff0000462fa000, ffff0000462fb=
000)
> [  163.975734][    C1] The buggy address belongs to the page:
> [  163.981262][    C1] page:00000000925a6593 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x2462f8
> [  163.991397][    C1] head:00000000925a6593 order:3
> compound_mapcount:0 compound_pincount:0
> [  163.999622][    C1] flags: 0x4000000000010200(slab|head)
> [  164.004983][    C1] raw: 4000000000010200 dead000000000100
> dead000000000122 ffff000042003500
> [  164.013469][    C1] raw: 0000000000000000 0000000000040004
> 00000001ffffffff 0000000000000000
> [  164.021946][    C1] page dumped because: kasan: bad access detected
> [  164.028242][    C1]
> [  164.030450][    C1] Memory state around the buggy address:
> [  164.035973][    C1]  ffff0000462f9f00: fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc fc
> [  164.043934][    C1]  ffff0000462f9f80: fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc fc
> [  164.051894][    C1] >ffff0000462fa000: fa fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [  164.059848][    C1]                          ^
> [  164.064326][    C1]  ffff0000462fa080: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [  164.072287][    C1]  ffff0000462fa100: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
>=20
> ....
>=20
> [  164.102216][    C1] BUG: KASAN: double-free or invalid-free in
> mempool_kfree+0x18/0x28
> [  164.110169][    C1]
> [  164.112390][    C1] CPU: 1 PID: 475 Comm: kworker/u16:5 Tainted: G
>   B             5.10.4 #2
> [  164.120955][    C1] Hardware name: Intellifusion Edge10 (DT)
> [  164.126661][    C1] Workqueue: writeback wb_workfn (flush-259:0)
> [  164.132720][    C1] Call trace:
> [  164.135892][    C1]  dump_backtrace+0x0/0x2b8
> [  164.140282][    C1]  show_stack+0x20/0x70
> [  164.144328][    C1]  dump_stack+0xfc/0x168
> [  164.148469][    C1]  print_address_description.constprop.0+0x70/0x4e4
> [  164.154951][    C1]  kasan_report_invalid_free+0x64/0x90
> [  164.160299][    C1]  __kasan_slab_free+0x154/0x180
> [  164.165126][    C1]  kasan_slab_free+0x14/0x20
> [  164.169601][    C1]  kfree+0xe0/0x400
> [  164.173299][    C1]  mempool_kfree+0x18/0x28
> [  164.177605][    C1]  mempool_free+0x7c/0x1e0
> [  164.181914][    C1]  nvme_unmap_data+0x1ac/0x298
> [  164.186569][    C1]  nvme_pci_complete_rq+0x7c/0x140
> [  164.191570][    C1]  nvme_irq+0x218/0x4a8
> [  164.195619][    C1]  __handle_irq_event_percpu+0x8c/0x3c8
> [  164.201058][    C1]  handle_irq_event_percpu+0x8c/0x108
> [  164.206322][    C1]  handle_irq_event+0x6c/0x120
> [  164.210976][    C1]  handle_simple_irq+0xe0/0x128
> [  164.215717][    C1]  generic_handle_irq+0x54/0x70
> [  164.220464][    C1]  edge_pcie_irq_domain_handler+0x128/0x1a8
> [  164.226250][    C1]  generic_handle_irq+0x54/0x70
> [  164.230992][    C1]  __handle_domain_irq+0x88/0xf0
> [  164.235817][    C1]  gic_handle_irq+0xe4/0x128
> [  164.240292][    C1]  el1_irq+0xc4/0x180
> [  164.244163][    C1]  __asan_load8+0x70/0xd8
> [  164.248384][    C1]  walk_stackframe+0x3c/0x78
> [  164.252860][    C1]  arch_stack_walk+0xd4/0x168
> [  164.257429][    C1]  stack_trace_save+0xa4/0xd8
> [  164.261995][    C1]  kasan_save_stack+0x28/0x58
> [  164.266561][    C1]  __kasan_kmalloc.isra.0+0xc8/0xe8
> [  164.271650][    C1]  kasan_slab_alloc+0x18/0x28
> [  164.276213][    C1]  kmem_cache_alloc+0x1a8/0x640
> [  164.280952][    C1]  ext4_init_io_end+0x2c/0xb0
> [  164.285517][    C1]  ext4_writepages+0x4bc/0x1288
> [  164.290257][    C1]  do_writepages+0xc0/0x1a0
> [  164.294655][    C1]  __writeback_single_inode+0x70/0x7e0
> [  164.300008][    C1]  writeback_sb_inodes+0x324/0x708
> [  164.305012][    C1]  __writeback_inodes_wb+0x70/0x158
> [  164.310102][    C1]  wb_writeback+0x3ac/0x620
> [  164.314497][    C1]  wb_workfn+0x3cc/0x900
> [  164.318628][    C1]  process_one_work+0x3e8/0x888
> [  164.323365][    C1]  worker_thread+0x7c/0x678
> [  164.327759][    C1]  kthread+0x1e0/0x220
> [  164.331716][    C1]  ret_from_fork+0x10/0x34
> [  164.336013][    C1]
> [  164.338223][    C1] Allocated by task 475:
> [  164.342356][    C1]  stack_trace_save+0xa4/0xd8
> [  164.346921][    C1]  kasan_save_stack+0x28/0x58
> [  164.351487][    C1]  __kasan_kmalloc.isra.0+0xc8/0xe8
> [  164.356574][    C1]  kasan_kmalloc+0x10/0x20
> [  164.360876][    C1]  __kmalloc+0x3cc/0x690
> [  164.365009][    C1]  mempool_kmalloc+0x24/0x30
> [  164.369488][    C1]  mempool_alloc+0xe8/0x218
> [  164.373883][    C1]  nvme_map_data+0xf0/0xda8
> [  164.378276][    C1]  nvme_queue_rq+0x148/0x3b8
> [  164.382760][    C1]  __blk_mq_try_issue_directly+0x214/0x2e8
> [  164.388460][    C1]  blk_mq_request_issue_directly+0xbc/0x108
> [  164.394246][    C1]  blk_mq_try_issue_list_directly+0xe8/0x1d8
> [  164.400125][    C1]  blk_mq_sched_insert_requests+0x230/0x300
> [  164.405909][    C1]  blk_mq_flush_plug_list+0x22c/0x3c8
> [  164.411175][    C1]  blk_flush_plug_list+0x1e4/0x228
> [  164.416177][    C1]  blk_mq_submit_bio+0x40c/0xa50
> [  164.421005][    C1]  submit_bio_noacct+0x590/0x630
> [  164.425831][    C1]  submit_bio+0xc8/0x360
> [  164.429960][    C1]  ext4_io_submit+0xa8/0xd0
> [  164.434352][    C1]  ext4_writepages+0x8f8/0x1288
> [  164.439090][    C1]  do_writepages+0xc0/0x1a0
> [  164.443487][    C1]  __writeback_single_inode+0x70/0x7e0
> [  164.448838][    C1]  writeback_sb_inodes+0x324/0x708
> [  164.453842][    C1]  __writeback_inodes_wb+0x70/0x158
> [  164.458931][    C1]  wb_writeback+0x3ac/0x620
> [  164.463325][    C1]  wb_workfn+0x3cc/0x900
> [  164.467456][    C1]  process_one_work+0x3e8/0x888
> [  164.472193][    C1]  worker_thread+0x7c/0x678
> [  164.476585][    C1]  kthread+0x1e0/0x220
> [  164.480541][    C1]  ret_from_fork+0x10/0x34
> [  164.484836][    C1]
> [  164.487045][    C1] Freed by task 475:
> [  164.490828][    C1]  stack_trace_save+0xa4/0xd8
> [  164.495393][    C1]  kasan_save_stack+0x28/0x58
> [  164.499958][    C1]  kasan_set_track+0x28/0x40
> [  164.504438][    C1]  kasan_set_free_info+0x24/0x48
> [  164.509264][    C1]  __kasan_slab_free+0x100/0x180
> [  164.514089][    C1]  kasan_slab_free+0x14/0x20
> [  164.518564][    C1]  kfree+0xe0/0x400
> [  164.522261][    C1]  mempool_kfree+0x18/0x28
> [  164.526567][    C1]  mempool_free+0x7c/0x1e0
> [  164.530875][    C1]  nvme_unmap_data+0x1ac/0x298
> [  164.535529][    C1]  nvme_pci_complete_rq+0x7c/0x140
> [  164.540531][    C1]  nvme_irq+0x218/0x4a8
> [  164.544577][    C1]  __handle_irq_event_percpu+0x8c/0x3c8
> [  164.550016][    C1]  handle_irq_event_percpu+0x8c/0x108
> [  164.555279][    C1]  handle_irq_event+0x6c/0x120
> [  164.559931][    C1]  handle_simple_irq+0xe0/0x128
> [  164.564672][    C1]  generic_handle_irq+0x54/0x70
> [  164.569408][    C1]  edge_pcie_irq_domain_handler+0x128/0x1a8
> [  164.575192][    C1]  generic_handle_irq+0x54/0x70
> [  164.579932][    C1]  __handle_domain_irq+0x88/0xf0
> [  164.584757][    C1]  gic_handle_irq+0xe4/0x128
> [  164.589225][    C1]
> [  164.591439][    C1] The buggy address belongs to the object at
> ffff0000462fa000
> [  164.591439][    C1]  which belongs to the cache kmalloc-4k of size 4096
> [  164.605405][    C1] The buggy address is located 0 bytes inside of
> [  164.605405][    C1]  4096-byte region [ffff0000462fa000, ffff0000462fb=
000)
> [  164.618491][    C1] The buggy address belongs to the page:
> [  164.624015][    C1] page:00000000925a6593 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x2462f8
> [  164.634151][    C1] head:00000000925a6593 order:3
> compound_mapcount:0 compound_pincount:0
> [  164.642374][    C1] flags: 0x4000000000010200(slab|head)
> [  164.647732][    C1] raw: 4000000000010200 dead000000000100
> dead000000000122 ffff000042003500
> [  164.656218][    C1] raw: 0000000000000000 0000000000040004
> 00000001ffffffff 0000000000000000
> [  164.664694][    C1] page dumped because: kasan: bad access detected
> [  164.670990][    C1]
> [  164.673199][    C1] Memory state around the buggy address:
> [  164.678721][    C1]  ffff0000462f9f00: fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc fc
> [  164.686682][    C1]  ffff0000462f9f80: fc fc fc fc fc fc fc fc fc
> fc fc fc fc fc fc fc
> [  164.694642][    C1] >ffff0000462fa000: fa fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [  164.702594][    C1]                    ^
> [  164.706550][    C1]  ffff0000462fa080: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [  164.714510][    C1]  ffff0000462fa100: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [  164.722464][    C1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  164.730436][    C1] ------------[ cut here ]------------
> [  164.735781][    C1] refcount_t: underflow; use-after-free.
> [  164.741420][    C1] WARNING: CPU: 1 PID: 475 at lib/refcount.c:28
> refcount_warn_saturate+0x11c/0x178
> [  164.750600][    C1] Modules linked in:
> [  164.754402][    C1] CPU: 1 PID: 475 Comm: kworker/u16:5 Tainted: G
>   B             5.10.4 #2
> [  164.762967][    C1] Hardware name: Intellifusion Edge10 (DT)
> [  164.768677][    C1] Workqueue: writeback wb_workfn (flush-259:0)
> [  164.774741][    C1] pstate: 60400085 (nZCv daIf +PAN -UAO -TCO BTYPE=
=3D--)
> [  164.781489][    C1] pc : refcount_warn_saturate+0x11c/0x178
> [  164.787103][    C1] lr : refcount_warn_saturate+0x11c/0x178
> [  164.792706][    C1] sp : ffff0000eb4a0fe0
> [  164.796743][    C1] x29: ffff0000eb4a0fe0 x28: 0000000000000000
> [  164.802800][    C1] x27: 00000000000001a2 x26: ffff0000453671f6
> [  164.808856][    C1] x25: fffffdffbfeeaf00 x24: ffff0000457b751c
> [  164.814913][    C1] x23: ffff0000457b7518 x22: 0000000000000000
> [  164.820969][    C1] x21: ffff000045e70000 x20: ffff0000457b75d0
> [  164.827024][    C1] x19: 0000000000000003 x18: 0000000000000000
> [  164.833078][    C1] x17: 0000000000000000 x16: 0000000000000000
> [  164.839133][    C1] x15: 0000000000000000 x14: 0720072007200720
> [  164.845191][    C1] x13: 0720072007200720 x12: ffff80001d690d0c
> [  164.851248][    C1] x11: 1fffe0001d690d0b x10: ffff80001d690d0b
> [  164.857305][    C1] x9 : dfffa00000000000 x8 : ffff0000eb48685b
> [  164.863360][    C1] x7 : 0000000000000001 x6 : ffff0000eb486858
> [  164.869416][    C1] x5 : 00007fffe296f2f5 x4 : dfffa00000000000
> [  164.875473][    C1] x3 : ffffa000100e359c x2 : ffff80001d6941c6
> [  164.881529][    C1] x1 : 050c75be6612ca00 x0 : 0000000000000000
> [  164.887584][    C1] Call trace:
> [  164.890766][    C1]  refcount_warn_saturate+0x11c/0x178
> [  164.896031][    C1]  blk_mq_free_request+0x254/0x2c0
> [  164.901032][    C1]  blk_mq_end_request+0x1c4/0x1e8
> [  164.905951][    C1]  nvme_complete_rq+0xa8/0x458
> [  164.910608][    C1]  nvme_pci_complete_rq+0x84/0x140
> [  164.915610][    C1]  nvme_irq+0x218/0x4a8
> [  164.919660][    C1]  __handle_irq_event_percpu+0x8c/0x3c8
> [  164.925098][    C1]  handle_irq_event_percpu+0x8c/0x108
> [  164.930362][    C1]  handle_irq_event+0x6c/0x120
> [  164.935016][    C1]  handle_simple_irq+0xe0/0x128
> [  164.939756][    C1]  generic_handle_irq+0x54/0x70
> [  164.944502][    C1]  edge_pcie_irq_domain_handler+0x128/0x1a8
> [  164.950287][    C1]  generic_handle_irq+0x54/0x70
> [  164.955028][    C1]  __handle_domain_irq+0x88/0xf0
> [  164.959854][    C1]  gic_handle_irq+0xe4/0x128
> [  164.964331][    C1]  el1_irq+0xc4/0x180
> [  164.968202][    C1]  __asan_load8+0x70/0xd8
> [  164.972425][    C1]  walk_stackframe+0x3c/0x78
> [  164.976902][    C1]  arch_stack_walk+0xd4/0x168
> [  164.981471][    C1]  stack_trace_save+0xa4/0xd8
> [  164.986036][    C1]  kasan_save_stack+0x28/0x58
> [  164.990603][    C1]  __kasan_kmalloc.isra.0+0xc8/0xe8
> [  164.995690][    C1]  kasan_slab_alloc+0x18/0x28
> [  165.000254][    C1]  kmem_cache_alloc+0x1a8/0x640
> [  165.004992][    C1]  ext4_init_io_end+0x2c/0xb0
> [  165.009559][    C1]  ext4_writepages+0x4bc/0x1288
> [  165.014301][    C1]  do_writepages+0xc0/0x1a0
> [  165.018699][    C1]  __writeback_single_inode+0x70/0x7e0
> [  165.024051][    C1]  writeback_sb_inodes+0x324/0x708
> [  165.029055][    C1]  __writeback_inodes_wb+0x70/0x158
> [  165.034145][    C1]  wb_writeback+0x3ac/0x620
> [  165.038539][    C1]  wb_workfn+0x3cc/0x900
> [  165.042669][    C1]  process_one_work+0x3e8/0x888
> [  165.047406][    C1]  worker_thread+0x7c/0x678
> [  165.051800][    C1]  kthread+0x1e0/0x220
> [  165.055757][    C1]  ret_from_fork+0x10/0x34
> [  165.060058][    C1] ---[ end trace 39fad493b57b2c12 ]---
> [  165.188702][    C4] nvme nvme0: invalid id 0 completed on queue 5
> [  165.247987][    C4] nvme nvme0: invalid id 0 completed on queue 5
> [  165.307319][    C4] nvme nvme0: invalid id 0 completed on queue 5
> [  193.539269][  T154] nvme nvme0: I/O 392 QID 2 timeout, aborting
> [  193.588563][    C6] nvme nvme0: Abort status: 0x0
>=20

Can you test latest mainline (currently v6.6-rc1)?

--=20
An old man doll... just what I always wanted! - Clara

--Xg/7I3pXssFjS9Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQQRagAKCRD2uYlJVVFO
o6cRAP4otyz2M04fPOOlMaJ1FfxUAUzQu15GHOsOnA00gMchegEAnw+C+1kds3CH
KsiD5lqlhHZmj/PAZI627gslW97PsAo=
=ZDcU
-----END PGP SIGNATURE-----

--Xg/7I3pXssFjS9Dt--
