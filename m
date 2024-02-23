Return-Path: <linux-kernel+bounces-79008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DCE861C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2941F23B61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB71420B7;
	Fri, 23 Feb 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fld3OJ1P"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2241448DD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714521; cv=none; b=fvZUNQyuYCVhsf2UKRUEJZuMkUYgEgrOnCbx+DKsviW5yCLT+k8okrFqAZKzdHwRWrUk3waDv3CrI/Hqr7JRTzThvaMvOInqHHJ3FFoD2ZWXrdYrI4/Q8UyrCoS6z35dNVfaMu/ve5ttko1dnhMRQf/wlbPF3NpUIhIUaXck/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714521; c=relaxed/simple;
	bh=c3dnmlKszVi84zhy0mjtju32gtCChIoIcgmyJEz1zM8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhkSQlZviXEaNgYUWb6ZR1QiGZPmxzK5mBXeiE1oFyl0IR6wiQree8T5RACZ3wrNJNRf7f8kgI+EOjegbWM1ZDtTUNoovXMwR4MzYs92+hcvsEn7Zr+waekBuEw1mSsnG4W9rJHnYWbwVNuTSeqtYl64lz0dmHqpke1wiqKt630=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fld3OJ1P; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2770e44d0so5027441fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708714512; x=1709319312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pB6SssVeN4e8P+qPOnkLHOXLcyx5Chkn2kKqNO3+YBo=;
        b=fld3OJ1PEFGzyQMhYlzRhVtFJzGIG6yfjBDw0+V+WQLci0fMw3mfHAlAi2Y0mzwbIY
         XghvG+Bn2ojsxWfxcduyAAYpLKPgMW2EgoE27hwsQ/hRX7tmlzBg1ZM+KrJCl91N0l6h
         6Njkdwe5r0pUI8QpI8DE0A57jAHW409QhsoYG24m2YKnY1tUTyhBtSju+G7T+uuApmlZ
         aO1QiNu0KwZj++ZGRu9SFGWH4VoKFxF+rL1BL3O2/y7auxTPPH1RUNc9s3Gx2rKtny2y
         bFAY3lkHbZqOR4cG3GXdIW9FaydAnKgQKdGQbWuukxhzh7CNdmF8T9MUrsWwbTr32Tsp
         BLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708714512; x=1709319312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB6SssVeN4e8P+qPOnkLHOXLcyx5Chkn2kKqNO3+YBo=;
        b=Usy9amswL0ZKm4ES7yjj7mWE32V9J4JgKwM94+ymkrPtAkeDRO6WZFRQLKZIhxc83h
         xWfMpdkylsASCh1Rb3DBfRCeFN7ZB6qitNs86nJ0GpKoQ4nHv+s9MFlb/fP9jxW6+8Jp
         oc1u+4WvkJeD9FRlSCsla/KYUzvBOt53gqvmvl521tTXlSDwZ4RoP7dj1QAfl3pCoVv3
         ryUyFvqQG1loftt6gqHAwQjxTNjXwObmPyrq+Zw6UJsTAuMDHuvfbL6x42ZZG+13/Nf8
         s33sC3mpuV/PSazY6+J2GNN4adDe7Go+oY3GP4WkA1ew4GMU50kF1zI+K0gBgW4vZycL
         KNww==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pm13TabRkFfE4HOaMONcyqE9w748MuK5jwUQpG0YUcSXCDxb4Cq61pCS4M1FXqQRqavl5N6rbwUKHCKT/6VOwXwbxV/PCMkNdj7A
X-Gm-Message-State: AOJu0YwOaRGG5W0aU910jMtk+w9tuWsJ1LPB0bleuRODePyRyf6TR4l2
	3QyXOSEWzCOD6stSaK5dXZxwgoOHSNe7DlOY2F5PFnZqLUeb6exT
X-Google-Smtp-Source: AGHT+IG039YjDQ48PIW08MdE7jp9XbvA3Mct1j3mMUmajx02V7Z/2aIeINiJVVSHnamUWfH913ffuw==
X-Received: by 2002:a2e:868a:0:b0:2d2:3a0c:ab36 with SMTP id l10-20020a2e868a000000b002d23a0cab36mr11175lji.35.1708714511748;
        Fri, 23 Feb 2024 10:55:11 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e9915000000b002d10facb5bfsm2689070lji.97.2024.02.23.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:55:11 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Fri, 23 Feb 2024 19:55:09 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <ZdjqDRLbpnExRhSZ@pc638.lan>
References: <20240102184633.748113-1-urezki@gmail.com>
 <ZdcHXFMq0cwmVKfM@pc636>
 <CAKbZUD3+PJUoXee3MNvToy1zRnDoPoPqMjNAf5_87Uh-u2377w@mail.gmail.com>
 <ZdhmrEmA8wOuVcQT@pc636>
 <Zdhy3S1PzwfEJuS3@MiWiFi-R3L-srv>
 <Zdh8KmZtoQym7Syz@pc636>
 <ZdjAZQRVmP9gnfsJ@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdjAZQRVmP9gnfsJ@MiWiFi-R3L-srv>

On Fri, Feb 23, 2024 at 11:57:25PM +0800, Baoquan He wrote:
> On 02/23/24 at 12:06pm, Uladzislau Rezki wrote:
> > > On 02/23/24 at 10:34am, Uladzislau Rezki wrote:
> > > > On Thu, Feb 22, 2024 at 11:15:59PM +0000, Pedro Falcato wrote:
> > > > > Hi,
> > > > > 
> > > > > On Thu, Feb 22, 2024 at 8:35 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > Hello, Folk!
> > > > > >
> > > > > >[...]
> > > > > > pagetable_alloc - gets increased as soon as a higher pressure is applied by
> > > > > > increasing number of workers. Running same number of jobs on a next run
> > > > > > does not increase it and stays on same level as on previous.
> > > > > >
> > > > > > /**
> > > > > >  * pagetable_alloc - Allocate pagetables
> > > > > >  * @gfp:    GFP flags
> > > > > >  * @order:  desired pagetable order
> > > > > >  *
> > > > > >  * pagetable_alloc allocates memory for page tables as well as a page table
> > > > > >  * descriptor to describe that memory.
> > > > > >  *
> > > > > >  * Return: The ptdesc describing the allocated page tables.
> > > > > >  */
> > > > > > static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
> > > > > > {
> > > > > >         struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> > > > > >
> > > > > >         return page_ptdesc(page);
> > > > > > }
> > > > > >
> > > > > > Could you please comment on it? Or do you have any thought? Is it expected?
> > > > > > Is a page-table ever shrink?
> > > > > 
> > > > > It's my understanding that the vunmap_range helpers don't actively
> > > > > free page tables, they just clear PTEs. munmap does free them in
> > > > > mmap.c:free_pgtables, maybe something could be worked up for vmalloc
> > > > > too.
> > > > >
> > > > Right. I see that for a user space, pgtables are removed. There was a
> > > > work on it.
> > > > 
> > > > >
> > > > > I would not be surprised if the memory increase you're seeing is more
> > > > > or less correlated to the maximum vmalloc footprint throughout the
> > > > > whole test.
> > > > > 
> > > > Yes, the vmalloc footprint follows the memory usage. Some uses cases
> > > > map lot of memory.
> > > 
> > > The 'nr_threads=256' testing may be too radical. I took the test on
> > > a bare metal machine as below, it's still running and hang there after
> > > 30 minutes. I did this after system boot. I am looking for other
> > > machines with more processors.
> > > 
> > > [root@dell-r640-068 ~]# nproc 
> > > 64
> > > [root@dell-r640-068 ~]# free -h
> > >                total        used        free      shared  buff/cache   available
> > > Mem:           187Gi        18Gi       169Gi        12Mi       262Mi       168Gi
> > > Swap:          4.0Gi          0B       4.0Gi
> > > [root@dell-r640-068 ~]# 
> > > 
> > > [root@dell-r640-068 linux]# tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256
> > > Run the test with following parameters: run_test_mask=127 nr_threads=256
> > > 
> > Agree, nr_threads=256 is a way radical :) Mine took 50 minutes to
> > complete. So wait more :)
> 
> Right, mine could take the similar time to finish that. I got a machine
> with 288 cpus, see if I can get some clues. When I go through the code
> flow, suddenly realized it could be drain_vmap_area_work which is the 
> bottle neck and cause the tremendous page table pages costing.
> 
> On your system, there's 64 cpus. then 
> 
> nr_lazy_max = lazy_max_pages() = 7*32M = 224M;
> 
> So with nr_threads=128 or 256, it's so easily getting to the nr_lazy_max
> and triggering drain_vmap_work(). When cpu resouce is very limited, the
> lazy vmap purging will be very slow. While the alloc/free in lib/tet_vmalloc.c 
> are going far faster and more easily then vmap reclaiming. If old va is not
> reused, new va is allocated and keep extending, the new page table surely
> need be created to cover them.
> 
> I will take testing on the system with 288 cpus, will update if testing
> is done.
> 
<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 12caa794abd4..a90c5393d85f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1754,6 +1754,8 @@ size_to_va_pool(struct vmap_node *vn, unsigned long size)
 	return NULL;
 }
 
+static unsigned long lazy_max_pages(void);
+
 static bool
 node_pool_add_va(struct vmap_node *n, struct vmap_area *va)
 {
@@ -1763,6 +1765,9 @@ node_pool_add_va(struct vmap_node *n, struct vmap_area *va)
 	if (!vp)
 		return false;
 
+	if (READ_ONCE(vp->len) > lazy_max_pages())
+		return false;
+
 	spin_lock(&n->pool_lock);
 	list_add(&va->list, &vp->head);
 	WRITE_ONCE(vp->len, vp->len + 1);
@@ -2170,9 +2175,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end,
 				INIT_WORK(&vn->purge_work, purge_vmap_node);
 
 				if (cpumask_test_cpu(i, cpu_online_mask))
-					schedule_work_on(i, &vn->purge_work);
+					queue_work_on(i, system_highpri_wq, &vn->purge_work);
 				else
-					schedule_work(&vn->purge_work);
+					queue_work(system_highpri_wq, &vn->purge_work);
 
 				nr_purge_helpers--;
 			} else {
<snip>

We need this. This settles it back to a normal PTE-usage. Tomorrow i
will check if cache-len should be limited. I tested on my 64 CPUs
system with radical 256 kworkers. It looks good.

--
Uladzislau Rezki

