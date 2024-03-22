Return-Path: <linux-kernel+bounces-111975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B788738E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D821C2222F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8731376EF2;
	Fri, 22 Mar 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip6mCrAP"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D576EE9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134191; cv=none; b=gmy5DdE7DS55bXRByI9P6QFWrdWLg3eGtyPklSxa28PpcSzoGRVwSsN1L2v/bUOgV3kybqljjfuH01VbjSFx4kmjSROy8CYF6Ex25cCEcVPWSMlI7obsXQc1c5h0G9WJSCxD3eMzCFnd0jX7YeBl0HzD6l82CiLhBUUFgsbU6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134191; c=relaxed/simple;
	bh=B3u5FvJPNZibWYG5A5u+cfYZkC1oFUVjV09d4t1RmTs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj4pH+rY4DBI/CNAbcG69EMZ1NjukwsGovVv6z0U7k6nR28P+/KFuNxefrWuL2rRKEAoUDstuYgN5AossqaRWXmiMe4PdTobAM57c1mokwWr94mEczeTxuQDXRPOvbFO281VZWCj3MtjuiVR7rGOhtXyrM9QXFQ8hebJ3fP2etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip6mCrAP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so36609451fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711134188; x=1711738988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiOEI1u/n39JDbCsmzZGRMVeyG9x02q5oeFVqSaOL9U=;
        b=Ip6mCrAPZbf+t+9gUtsSoRi/mK4wQ8OdCnEQYhC1Ru1elagKtemELyJ2NE5neRRXI5
         XVRkWvuOX7l4zX3QJHzED/01fhdnntuGrxbd0VOpauZnoOa6LEBWsmL/dWLWOfKgoV8c
         AJJOFvY5s+bS7QJu9+u+qesJuFWM/qTSb0HlNCjysF2hMyF2PayTFDf59v1weNm+879i
         UosiD1jq/NTUfoKz1Lu6/gcNsq8o9OoVRKqO1+iqvJN3KUgY9RJG4/1nzToy/9hH8WZ6
         iQxO5zjnvyQQRdXujvBoWVcGnpIXBdQn7myAYio8xs0l+j++R06cTiHExruS6G8/v+1B
         7BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134188; x=1711738988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiOEI1u/n39JDbCsmzZGRMVeyG9x02q5oeFVqSaOL9U=;
        b=Vx1TBsHAtQYynw80GNhqMxbb2LvCkw4TJhlI9rGd2UnAhJLpzHTnGbQSbh+bfe+204
         7me7HPlqsDQDMhI20sCzrwxFxo90CAcxTkcWA4JS7gB0y1ArQqm5xWNkevGzFiRPpYF9
         kz0c7sdbL7lATkIcC1KVU0ieiwVNCs3na8OcrVFKgqk1O/CFqUD9mOSwrz4uSfQyaHAu
         EKEG4jNo+PntKbRu+eoCs9roKgJ2pMrdivS8ZVO51JBQ4PP2EypRwSRfSxB9hV0TiIBC
         fHdwXqM2b8b6tnPEN2Gjn9j/EIEiwJHZDyKwQnVEcPT3dktOhO4iH8Hf6Z5sqVOu+B12
         VxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXSBmJZyz2sVvupGNytlF30oSVlkOU7V15+PGqipVr5cuC57S6MLy6FHmgejEMqROOjWz3ik0lNmMWYtwkytSjvEs+qFqC/8CVGCTx
X-Gm-Message-State: AOJu0YzMzOqEnl4HTjMi7nu6fC3dLeRTozM+Y2p2QS1TeMA+9qpH6a4n
	6YRyzR8Kxx91s5hDBLuWQLzkSbDu8Hi5LCYgm5DHpRUyLdAeNmyR
X-Google-Smtp-Source: AGHT+IF7g+XE2LFCeky3tKyYVvoigiOqtzZ7ycIK7Nwa6aTRCRmD7Z7+zSyR3QnEiNbdOr7eKNHLIw==
X-Received: by 2002:a19:e056:0:b0:513:5951:61a4 with SMTP id g22-20020a19e056000000b00513595161a4mr232407lfj.6.1711134187309;
        Fri, 22 Mar 2024 12:03:07 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512344f00b00513b1dec266sm14013lfr.245.2024.03.22.12.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:03:06 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 22 Mar 2024 20:03:04 +0100
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <Zf3V6B9f5o0H1LnE@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net>

On Fri, Mar 22, 2024 at 11:21:02AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > Concurrent access to a global vmap space is a bottle-neck.
> > We can simulate a high contention by running a vmalloc test
> > suite.
> > 
> > To address it, introduce an effective vmap node logic. Each
> > node behaves as independent entity. When a node is accessed
> > it serves a request directly(if possible) from its pool.
> > 
> > This model has a size based pool for requests, i.e. pools are
> > serialized and populated based on object size and real demand.
> > A maximum object size that pool can handle is set to 256 pages.
> > 
> > This technique reduces a pressure on the global vmap lock.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> This patch results in a persistent "spinlock bad magic" message
> when booting s390 images with spinlock debugging enabled.
> 
> [    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
> [    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
> [    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
> [    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
> [    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
> [    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
> [    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
> [    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
> [    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
> [    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
> [    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40
> 
> Bisect results and decoded stacktrace below.
> 
> The uninitialized spinlock is &vn->busy.lock.
> Debugging shows that this lock is actually never initialized.
> 
It is. Once the vmalloc_init() "main entry" function is called from the:

<snip>
start_kernel()
  mm_core_init()
    vmalloc_init()
<snip>

> [    0.464684] ####### locking 0000000002280fb8
> [    0.464862] BUG: spinlock bad magic on CPU#0, swapper/0
> ...
> [    0.464684] ####### locking 0000000002280fb8
> [    0.477479] ####### locking 0000000002280fb8
> [    0.478166] ####### locking 0000000002280fb8
> [    0.478218] ####### locking 0000000002280fb8
> ...
> [    0.718250] #### busy lock init 0000000002871860
> [    0.718328] #### busy lock init 00000000028731b8
> 
> Only the initialized locks are used after the call to vmap_init_nodes().
> 
Right, when the vmap space and vmalloc is initialized.

> Guenter
> 
> ---
> # bad: [8e938e39866920ddc266898e6ae1fffc5c8f51aa] Merge tag '6.9-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6
> # good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
> git bisect start 'HEAD' 'v6.8'
> # good: [e56bc745fa1de77abc2ad8debc4b1b83e0426c49] smb311: additional compression flag defined in updated protocol spec
> git bisect good e56bc745fa1de77abc2ad8debc4b1b83e0426c49
> # bad: [902861e34c401696ed9ad17a54c8790e7e8e3069] Merge tag 'mm-stable-2024-03-13-20-04' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 902861e34c401696ed9ad17a54c8790e7e8e3069
> # good: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
> git bisect good 480e035fc4c714fb5536e64ab9db04fedc89e910
> # good: [fe46a7dd189e25604716c03576d05ac8a5209743] Merge tag 'sound-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect good fe46a7dd189e25604716c03576d05ac8a5209743
> # bad: [435a75548109f19e5b5b14ae35b9acb063c084e9] mm: use folio more widely in __split_huge_page
> git bisect bad 435a75548109f19e5b5b14ae35b9acb063c084e9
> # good: [4d5bf0b6183f79ea361dd506365d2a471270735c] mm/mmu_gather: add tlb_remove_tlb_entries()
> git bisect good 4d5bf0b6183f79ea361dd506365d2a471270735c
> # bad: [4daacfe8f99f4b4cef562649d56c48642981f46e] mm/damon/sysfs-schemes: support PSI-based quota auto-tune
> git bisect bad 4daacfe8f99f4b4cef562649d56c48642981f46e
> # good: [217b2119b9e260609958db413876f211038f00ee] mm,page_owner: implement the tracking of the stacks count
> git bisect good 217b2119b9e260609958db413876f211038f00ee
> # bad: [40254101d87870b2e5ac3ddc28af40aa04c48486] arm64, crash: wrap crash dumping code into crash related ifdefs
> git bisect bad 40254101d87870b2e5ac3ddc28af40aa04c48486
> # bad: [53becf32aec1c8049b854f0c31a11df5ed75df6f] mm: vmalloc: support multiple nodes in vread_iter
> git bisect bad 53becf32aec1c8049b854f0c31a11df5ed75df6f
> # good: [7fa8cee003166ef6db0bba70d610dbf173543811] mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
> git bisect good 7fa8cee003166ef6db0bba70d610dbf173543811
> # good: [282631cb2447318e2a55b41a665dbe8571c46d70] mm: vmalloc: remove global purge_vmap_area_root rb-tree
> git bisect good 282631cb2447318e2a55b41a665dbe8571c46d70
> # bad: [96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e] mm: vmalloc: add a scan area of VA only once
> git bisect bad 96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e
> # bad: [72210662c5a2b6005f6daea7fe293a0dc573e1a5] mm: vmalloc: offload free_vmap_area_lock lock
> git bisect bad 72210662c5a2b6005f6daea7fe293a0dc573e1a5
> # first bad commit: [72210662c5a2b6005f6daea7fe293a0dc573e1a5] mm: vmalloc: offload free_vmap_area_lock lock
> 
> ---
> [    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> [    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
> [    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    0.466270] Call Trace:
> [    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
> [    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
> [    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
> [    0.466572] find_vm_area (mm/vmalloc.c:3150)
> [    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
> [    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
> [    0.466651] paging_init (arch/s390/mm/init.c:97)
> [    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
> [    0.466702] start_kernel (init/main.c:899)
> [    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
> [    0.466811] INFO: lockdep is turned off.
> 
<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..0d77d171b5d9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2343,6 +2343,9 @@ struct vmap_area *find_vmap_area(unsigned long addr)
        struct vmap_area *va;
        int i, j;

+       if (unlikely(!vmap_initialized))
+               return NULL;
+
        /*
         * An addr_to_node_id(addr) converts an address to a node index
         * where a VA is located. If VA spans several zones and passed
<snip>

Could you please test it?

--
Uladzislau Rezki

