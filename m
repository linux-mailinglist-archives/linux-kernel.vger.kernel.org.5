Return-Path: <linux-kernel+bounces-14741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB80822155
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A31C229F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F917986;
	Tue,  2 Jan 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbWj9Eqr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC716171D7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso4334342e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221237; x=1704826037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36KamwtZGiOJ+iCEiFn7yiYoyZmI7LhL5vNG1kBAh/Y=;
        b=mbWj9EqrC4HIMlsTfAsHEcbfwNCgTFrjYtO5o6KeiT7Cf+zUTUFJoAWwuTBFtR+TJJ
         KqIhYe1ydLVim3Dv6eFxyLlTq9Cc6BGrVYvpyBxJZib7ospyLZSDppFuer2cMB1bLKeI
         ZQw6aeOkgy2kK7c+lFTqFpWR5AXdRL+d7Pbj7rR9Ky63sMzDszrR6aNSVDZWgVvqN9YX
         FiFLuNz9TCh+UqfDTcahYbCgJbuk096HtB4dvFR2Vluz3gTh6Ce4WbvmK8uaOM9KjMBs
         Ss6djungNmtXXKzVRWBs75W5byPFaUAOljj5dmg8pd8rBFPHHf/HZTaIcvyCRAQudzUo
         y6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221237; x=1704826037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36KamwtZGiOJ+iCEiFn7yiYoyZmI7LhL5vNG1kBAh/Y=;
        b=LhZnG8iccmzhl02s3103AAT3gIhiV+hcWGzH0Q8vBRNY/4aLgBAvhhIsWJxKjShx/z
         oeBfj/a3jnIPv03S1C40qLY6PgUpLfr1YdC0Lqi31sYNa82pDDWBePfOliZHy5oXXVGd
         vCrRu0hQ8P5NCOCJnXQDufrbw6IgBb0Btp0vkHBHrAFUb3UTjYRY5RcjVusisUotuiJj
         IPBpDb2NZkNwqPA4MT+OzpBLUlnDisu0FkGh8fjLeiUn4Pna4jMLhbOJg+aO/VANw9GC
         W+fjsR8o1cuIw81t8V0T2fznw2jLLxWnUHN7LYyJT48ou/ApbvwJvZWzpdd1zeiz454V
         HCmQ==
X-Gm-Message-State: AOJu0YxQORKfiTfv3AjWgKYZJ/Cw74bfF+K561fkAzVGKLkJUr/Zrk3P
	EFC54b3Zm/lIYzSLogLPRs8=
X-Google-Smtp-Source: AGHT+IFi7xrYzx6xhsiq08yLfVLl/kXBKY0Xd49T3HSM7WNrgq2+gVmjHodohn+UrhXHc14kRcbU4A==
X-Received: by 2002:ac2:5d67:0:b0:50e:383b:19bd with SMTP id h7-20020ac25d67000000b0050e383b19bdmr6365437lft.102.1704221236664;
        Tue, 02 Jan 2024 10:47:16 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:47:16 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v3 10/11] mm: vmalloc: Set nr_nodes based on CPUs in a system
Date: Tue,  2 Jan 2024 19:46:32 +0100
Message-Id: <20240102184633.748113-11-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102184633.748113-1-urezki@gmail.com>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of nodes which are used in the alloc/free paths is
set based on num_possible_cpus() in a system. Please note a
high limit threshold though is fixed and corresponds to 128
nodes.

For 32-bit or single core systems an access to a global vmap
heap is not balanced. Such small systems do not suffer from
lock contentions due to low number of CPUs. In such case the
nr_nodes is equal to 1.

Test on AMD Ryzen Threadripper 3970X 32-Core Processor:
sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64

<default perf>
 94.41%     0.89%  [kernel]        [k] _raw_spin_lock
 93.35%    93.07%  [kernel]        [k] native_queued_spin_lock_slowpath
 76.13%     0.28%  [kernel]        [k] __vmalloc_node_range
 72.96%     0.81%  [kernel]        [k] alloc_vmap_area
 56.94%     0.00%  [kernel]        [k] __get_vm_area_node
 41.95%     0.00%  [kernel]        [k] vmalloc
 37.15%     0.01%  [test_vmalloc]  [k] full_fit_alloc_test
 35.17%     0.00%  [kernel]        [k] ret_from_fork_asm
 35.17%     0.00%  [kernel]        [k] ret_from_fork
 35.17%     0.00%  [kernel]        [k] kthread
 35.08%     0.00%  [test_vmalloc]  [k] test_func
 34.45%     0.00%  [test_vmalloc]  [k] fix_size_alloc_test
 28.09%     0.01%  [test_vmalloc]  [k] long_busy_list_alloc_test
 23.53%     0.25%  [kernel]        [k] vfree.part.0
 21.72%     0.00%  [kernel]        [k] remove_vm_area
 20.08%     0.21%  [kernel]        [k] find_unlink_vmap_area
  2.34%     0.61%  [kernel]        [k] free_vmap_area_noflush
<default perf>
   vs
<patch-series perf>
 82.32%     0.22%  [test_vmalloc]  [k] long_busy_list_alloc_test
 63.36%     0.02%  [kernel]        [k] vmalloc
 63.34%     2.64%  [kernel]        [k] __vmalloc_node_range
 30.42%     4.46%  [kernel]        [k] vfree.part.0
 28.98%     2.51%  [kernel]        [k] __alloc_pages_bulk
 27.28%     0.19%  [kernel]        [k] __get_vm_area_node
 26.13%     1.50%  [kernel]        [k] alloc_vmap_area
 21.72%    21.67%  [kernel]        [k] clear_page_rep
 19.51%     2.43%  [kernel]        [k] _raw_spin_lock
 16.61%    16.51%  [kernel]        [k] native_queued_spin_lock_slowpath
 13.40%     2.07%  [kernel]        [k] free_unref_page
 10.62%     0.01%  [kernel]        [k] remove_vm_area
  9.02%     8.73%  [kernel]        [k] insert_vmap_area
  8.94%     0.00%  [kernel]        [k] ret_from_fork_asm
  8.94%     0.00%  [kernel]        [k] ret_from_fork
  8.94%     0.00%  [kernel]        [k] kthread
  8.29%     0.00%  [test_vmalloc]  [k] test_func
  7.81%     0.05%  [test_vmalloc]  [k] full_fit_alloc_test
  5.30%     4.73%  [kernel]        [k] purge_vmap_node
  4.47%     2.65%  [kernel]        [k] free_vmap_area_noflush
<patch-series perf>

confirms that a native_queued_spin_lock_slowpath goes down to
16.51% percent from 93.07%.

The throughput is ~12x higher:

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
Run the test with following parameters: run_test_mask=7 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    10m51.271s
user    0m0.013s
sys     0m0.187s
urezki@pc638:~$

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
Run the test with following parameters: run_test_mask=7 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    0m51.301s
user    0m0.015s
sys     0m0.040s
urezki@pc638:~$

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0c671cb96151..ef534c76daef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4879,10 +4879,27 @@ static void vmap_init_free_space(void)
 static void vmap_init_nodes(void)
 {
 	struct vmap_node *vn;
-	int i, j;
+	int i, n;
+
+#if BITS_PER_LONG == 64
+	/* A high threshold of max nodes is fixed and bound to 128. */
+	n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
+
+	if (n > 1) {
+		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
+		if (vn) {
+			/* Node partition is 16 pages. */
+			vmap_zone_size = (1 << 4) * PAGE_SIZE;
+			nr_vmap_nodes = n;
+			vmap_nodes = vn;
+		} else {
+			pr_err("Failed to allocate an array. Disable a node layer\n");
+		}
+	}
+#endif
 
-	for (i = 0; i < nr_vmap_nodes; i++) {
-		vn = &vmap_nodes[i];
+	for (n = 0; n < nr_vmap_nodes; n++) {
+		vn = &vmap_nodes[n];
 		vn->busy.root = RB_ROOT;
 		INIT_LIST_HEAD(&vn->busy.head);
 		spin_lock_init(&vn->busy.lock);
@@ -4891,9 +4908,9 @@ static void vmap_init_nodes(void)
 		INIT_LIST_HEAD(&vn->lazy.head);
 		spin_lock_init(&vn->lazy.lock);
 
-		for (j = 0; j < MAX_VA_SIZE_PAGES; j++) {
-			INIT_LIST_HEAD(&vn->pool[j].head);
-			WRITE_ONCE(vn->pool[j].len, 0);
+		for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
+			INIT_LIST_HEAD(&vn->pool[i].head);
+			WRITE_ONCE(vn->pool[i].len, 0);
 		}
 
 		spin_lock_init(&vn->pool_lock);
-- 
2.39.2


