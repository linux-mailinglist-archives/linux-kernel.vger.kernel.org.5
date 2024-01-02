Return-Path: <linux-kernel+bounces-14740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7D822154
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2453328458B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529617735;
	Tue,  2 Jan 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz0PdIuB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C26171C8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50ea226bda8so574963e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704221235; x=1704826035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMaatDyVMtexg7cRa9eaEuAm/eowYR09uugeWui4AYQ=;
        b=Pz0PdIuBjcbRTVOympFkruZ117s0tB/fGYZCU5oIHYXArAd3mvmxGFtUJQ10vPEUNR
         ccwQ7VZnHK/rlaNIft/CMY3QsK0A8LwxT14Vi9Q9Azg8e5mtR7RyArQNmEIhkTxy5Ksq
         9YQlINWpGmdh4A8gxgs5w6d2oRJV69lJhfaEhwqY1E7iqgmTFpMLp0FX1U/NptFNm/sl
         Kh+EsLdclrnU/NbI83C0B8HKaNvIdDxgSLsJF7HXpdz++eeLthv9Hgjxers0/5NRYjdM
         SG7DREt4zpMHyNmPLOoaSWPdFs/XO1J3YhvvfFSRkXT5d9+ROUypgsiUmdJ56elPrQIA
         aRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221235; x=1704826035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMaatDyVMtexg7cRa9eaEuAm/eowYR09uugeWui4AYQ=;
        b=kiQ3kPhpYoSkZXjDaw3QCqS5KbiPC2XZf5OdbKuUY3zbeC+uqWjUBh2i6agfW92Vei
         yCbFFHo5GsqCoMYyWdY7hqPH6wEXpU1cl4iKffaVFD790Ijywgz/Bl6DdgyjMCnpUMdc
         rMjUPjvk5m2S7d2ohIPemhv5Wi+OoSolGWBu/M6Q61tJlooflUqV8bV1ZXjyr1EXCTL5
         KYEHGYEOLcqSLNUHI+XLrudae3HnHH68dGP24eHR1deOptTrXgdnzzPv6Lvj0RJJKjPj
         tJF6SJa9B4cSr6yzzAWC6Ir1wjgcSxZDwOyDpF7s3rXSrQzCoaRzNluW1H65guLP4eNN
         1I9Q==
X-Gm-Message-State: AOJu0YyTzO5i8hg5mCc2FyhDmVSb6pD37MXaN39GPa3LDwjHGw9VBHeW
	hSJXpz4gE3jSe22p6HsTmz0=
X-Google-Smtp-Source: AGHT+IHL4Wmy2w8EjWfxM2Ec6BVxhpJGK0/FEzXHtHxP7HAyn5/e0Ve12sc1nQgdeQE352aAG5a4ag==
X-Received: by 2002:a05:6512:3d07:b0:50e:73ac:a179 with SMTP id d7-20020a0565123d0700b0050e73aca179mr7225341lfv.91.1704221235497;
        Tue, 02 Jan 2024 10:47:15 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q1-20020ac246e1000000b0050e7be886d9sm2592656lfo.56.2024.01.02.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:47:15 -0800 (PST)
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
Subject: [PATCH v3 09/11] mm: vmalloc: Support multiple nodes in vmallocinfo
Date: Tue,  2 Jan 2024 19:46:31 +0100
Message-Id: <20240102184633.748113-10-urezki@gmail.com>
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

Allocated areas are spread among nodes, it implies that
the scanning has to be performed individually of each node
in order to dump all existing VAs.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 120 ++++++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 73 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 594ed003d44d..0c671cb96151 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4709,30 +4709,6 @@ bool vmalloc_dump_obj(void *object)
 #endif
 
 #ifdef CONFIG_PROC_FS
-static void *s_start(struct seq_file *m, loff_t *pos)
-{
-	struct vmap_node *vn = addr_to_node(0);
-
-	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vn->busy.lock);
-
-	return seq_list_start(&vn->busy.head, *pos);
-}
-
-static void *s_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	struct vmap_node *vn = addr_to_node(0);
-	return seq_list_next(p, &vn->busy.head, pos);
-}
-
-static void s_stop(struct seq_file *m, void *p)
-{
-	struct vmap_node *vn = addr_to_node(0);
-
-	spin_unlock(&vn->busy.lock);
-	mutex_unlock(&vmap_purge_lock);
-}
-
 static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 {
 	if (IS_ENABLED(CONFIG_NUMA)) {
@@ -4776,84 +4752,82 @@ static void show_purge_info(struct seq_file *m)
 	}
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int vmalloc_info_show(struct seq_file *m, void *p)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
 	struct vm_struct *v;
+	int i;
 
-	vn = addr_to_node(0);
-	va = list_entry(p, struct vmap_area, list);
+	for (i = 0; i < nr_vmap_nodes; i++) {
+		vn = &vmap_nodes[i];
 
-	if (!va->vm) {
-		if (va->flags & VMAP_RAM)
-			seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
-				(void *)va->va_start, (void *)va->va_end,
-				va->va_end - va->va_start);
+		spin_lock(&vn->busy.lock);
+		list_for_each_entry(va, &vn->busy.head, list) {
+			if (!va->vm) {
+				if (va->flags & VMAP_RAM)
+					seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
+						(void *)va->va_start, (void *)va->va_end,
+						va->va_end - va->va_start);
 
-		goto final;
-	}
+				continue;
+			}
 
-	v = va->vm;
+			v = va->vm;
 
-	seq_printf(m, "0x%pK-0x%pK %7ld",
-		v->addr, v->addr + v->size, v->size);
+			seq_printf(m, "0x%pK-0x%pK %7ld",
+				v->addr, v->addr + v->size, v->size);
 
-	if (v->caller)
-		seq_printf(m, " %pS", v->caller);
+			if (v->caller)
+				seq_printf(m, " %pS", v->caller);
 
-	if (v->nr_pages)
-		seq_printf(m, " pages=%d", v->nr_pages);
+			if (v->nr_pages)
+				seq_printf(m, " pages=%d", v->nr_pages);
 
-	if (v->phys_addr)
-		seq_printf(m, " phys=%pa", &v->phys_addr);
+			if (v->phys_addr)
+				seq_printf(m, " phys=%pa", &v->phys_addr);
 
-	if (v->flags & VM_IOREMAP)
-		seq_puts(m, " ioremap");
+			if (v->flags & VM_IOREMAP)
+				seq_puts(m, " ioremap");
 
-	if (v->flags & VM_ALLOC)
-		seq_puts(m, " vmalloc");
+			if (v->flags & VM_ALLOC)
+				seq_puts(m, " vmalloc");
 
-	if (v->flags & VM_MAP)
-		seq_puts(m, " vmap");
+			if (v->flags & VM_MAP)
+				seq_puts(m, " vmap");
 
-	if (v->flags & VM_USERMAP)
-		seq_puts(m, " user");
+			if (v->flags & VM_USERMAP)
+				seq_puts(m, " user");
 
-	if (v->flags & VM_DMA_COHERENT)
-		seq_puts(m, " dma-coherent");
+			if (v->flags & VM_DMA_COHERENT)
+				seq_puts(m, " dma-coherent");
 
-	if (is_vmalloc_addr(v->pages))
-		seq_puts(m, " vpages");
+			if (is_vmalloc_addr(v->pages))
+				seq_puts(m, " vpages");
 
-	show_numa_info(m, v);
-	seq_putc(m, '\n');
+			show_numa_info(m, v);
+			seq_putc(m, '\n');
+		}
+		spin_unlock(&vn->busy.lock);
+	}
 
 	/*
 	 * As a final step, dump "unpurged" areas.
 	 */
-final:
-	if (list_is_last(&va->list, &vn->busy.head))
-		show_purge_info(m);
-
+	show_purge_info(m);
 	return 0;
 }
 
-static const struct seq_operations vmalloc_op = {
-	.start = s_start,
-	.next = s_next,
-	.stop = s_stop,
-	.show = s_show,
-};
-
 static int __init proc_vmalloc_init(void)
 {
+	void *priv_data = NULL;
+
 	if (IS_ENABLED(CONFIG_NUMA))
-		proc_create_seq_private("vmallocinfo", 0400, NULL,
-				&vmalloc_op,
-				nr_node_ids * sizeof(unsigned int), NULL);
-	else
-		proc_create_seq("vmallocinfo", 0400, NULL, &vmalloc_op);
+		priv_data = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
+
+	proc_create_single_data("vmallocinfo",
+		0400, NULL, vmalloc_info_show, priv_data);
+
 	return 0;
 }
 module_init(proc_vmalloc_init);
-- 
2.39.2


