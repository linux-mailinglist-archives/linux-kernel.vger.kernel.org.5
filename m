Return-Path: <linux-kernel+bounces-28376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8C82FDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8589B256EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2667C5B;
	Tue, 16 Jan 2024 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp9Mby0F"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9B5232
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447683; cv=none; b=CrmGZl/qnhQ/uViBUbcWEouEYfIbga5NJOnojCqg+i5pynS0H2w9/TrXku1d6XWkKzkRpGKPJDLAXnmuRY0FAgsnKotDyrjNp5d60N56n5w9kf9mJ+zuDykZ6bMntA7/+OpEnd+PDQazlsQE2J1Osu8bYAMi+WpflNrpGNN9wDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447683; c=relaxed/simple;
	bh=EaTW5WNo10+H74qVAOTcCuDWiuu/yKNaKayck7rbaMM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GlsFU22V/gf8OK+ZlkTmWyUSSZ3KQJ/upBdmPBJpXxYLngx9bTRWBIbBo6tbpIABZezHknsYmchpFGgYCNweJx9DRm40Ghc0p54HSVZ1vOH06/sUJGsWelSY+yOoUAGFyu+R2ud53dv1Lumd1Fwc399EgTj6GiU5r8SmQk5beiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp9Mby0F; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso55522125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705447679; x=1706052479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4/fB2lUkP9+qCmyci/R/yc+iovNS9eVNncK5fi4Ws=;
        b=Kp9Mby0FOwvEaIzWOZIQGlywbO5MZjLFVhQ/Zq2iTlMD2Ym6a6c1dmk4oRZ9ZFUlF4
         Z4JCNQZ/mczcxxMYAOjnAnEmmlqlgb063tFQPqsRoXYxcxItJRYDnhymdycoIJpNhWZg
         UKKRabi8IH49Ig651doVxX28En+1E0Jh84JEqAdm2vERBnAylcgrKOwGkAdbelP8CQIT
         kAzcFPaBXulqwLOFKdZ5R3cDFVe1qfWIN4qPLCctENLOdD28d9Hzcb/7a6qA/NS36YLD
         sUZnONhZumzC/+Mv/oUPpg+4eYOSfClC+ZUyO1g6MboTjLGf0CTZtPZX6o1odVZZUJap
         LGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705447679; x=1706052479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM4/fB2lUkP9+qCmyci/R/yc+iovNS9eVNncK5fi4Ws=;
        b=ZLISgz2NfvTlyXWskIP9XfDNvLicISqIBNJXzmQuQQa9VPq03nVk7qtAMRFzOGrQgm
         OnCTruXIbXWybSQNPyJR7J4fHj8S8bdwcWJrjGszPdWZD2vcf/JFFw38TAutz/VsDVHk
         4o93+dB2B3/Ss0bgXLAd1D2QtBYFciDO+N7x/5aszY4H22lmgfLnfEztZdyVC9v21ofR
         Ap2QQYWyVJazGHNcWLf2jDG3m5jI5T5zNjYydAnlei5vjsHuAS7Mg2lE60GsAvdTKDBT
         O2ZlmZPbevBfkAeQhw2+VLNTBOS8Y3XmrAVmto1sMZQpb+FQUFz1aaXOXksnnAUIhXld
         khdA==
X-Gm-Message-State: AOJu0YwXEVS2xMZF5cHl6OfDNimdAJSZ2c8NDdH8sPofkci9Uf3g3NOF
	nXt2TyahOKJXjfEgTCS25xs=
X-Google-Smtp-Source: AGHT+IEM5LzA0LYLa2MMke8vrAmihqwTFkLVZGj+dB+hBPday2n6+OL7uRnpdeGtQBuRN4XHAXI3Ag==
X-Received: by 2002:a7b:cc82:0:b0:40d:8f2d:199b with SMTP id p2-20020a7bcc82000000b0040d8f2d199bmr3933966wma.84.1705447678408;
        Tue, 16 Jan 2024 15:27:58 -0800 (PST)
Received: from localhost (host86-162-136-255.range86-162.btcentralplus.com. [86.162.136.255])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm24389513wmq.44.2024.01.16.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 15:27:57 -0800 (PST)
Date: Tue, 16 Jan 2024 23:25:43 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 04/11] mm: vmalloc: Remove global vmap_area_root
 rb-tree
Message-ID: <63104f8e-2fe3-46b2-842c-f11f8bb4b336@lucifer.local>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-5-urezki@gmail.com>

On Tue, Jan 02, 2024 at 07:46:26PM +0100, Uladzislau Rezki (Sony) wrote:
> Store allocated objects in a separate nodes. A va->va_start
> address is converted into a correct node where it should
> be placed and resided. An addr_to_node() function is used
> to do a proper address conversion to determine a node that
> contains a VA.
>
> Such approach balances VAs across nodes as a result an access
> becomes scalable. Number of nodes in a system depends on number
> of CPUs.
>
> Please note:
>
> 1. As of now allocated VAs are bound to a node-0. It means the
>    patch does not give any difference comparing with a current
>    behavior;
>
> 2. The global vmap_area_lock, vmap_area_root are removed as there
>    is no need in it anymore. The vmap_area_list is still kept and
>    is _empty_. It is exported for a kexec only;
>
> 3. The vmallocinfo and vread() have to be reworked to be able to
>    handle multiple nodes.
>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 240 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 173 insertions(+), 67 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 06bd843d18ae..786ecb18ae22 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
>  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
>
>
> -static DEFINE_SPINLOCK(vmap_area_lock);
>  static DEFINE_SPINLOCK(free_vmap_area_lock);
>  /* Export for kexec only */
>  LIST_HEAD(vmap_area_list);
> -static struct rb_root vmap_area_root = RB_ROOT;
>  static bool vmap_initialized __read_mostly;
>
>  static struct rb_root purge_vmap_area_root = RB_ROOT;
> @@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
>   */
>  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
>
> +/*
> + * An effective vmap-node logic. Users make use of nodes instead
> + * of a global heap. It allows to balance an access and mitigate
> + * contention.
> + */
> +struct rb_list {

I'm not sure this name is very instructive - this contains a red/black tree
root node, a list head and a lock, but the meaning of it is that it stores
a red/black tree and a list of vmap_area objects and has a lock to protect
access.

A raw 'list_head' without a comment is always hard to parse, maybe some
comments/embed in vmap_node?

At the very least if you wanted to keep the name generic it should be
something like ordered_rb_tree or something like this.

> +	struct rb_root root;
> +	struct list_head head;
> +	spinlock_t lock;
> +};
> +
> +static struct vmap_node {
> +	/* Bookkeeping data of this node. */
> +	struct rb_list busy;
> +} single;

This may be a thing about encapsulation/naming or similar, but I'm a little
confused as to why the rb_list type is maintained as a field rather than
its fields embedded?

> +
> +static struct vmap_node *vmap_nodes = &single;
> +static __read_mostly unsigned int nr_vmap_nodes = 1;
> +static __read_mostly unsigned int vmap_zone_size = 1;

It might be worth adding a comment here explaining that we're binding to a
single node for now to maintain existing behaviour (and a brief description
of what these values mean - for instance what unit vmap_zone_size is
expressed in?)

> +
> +static inline unsigned int
> +addr_to_node_id(unsigned long addr)
> +{
> +	return (addr / vmap_zone_size) % nr_vmap_nodes;
> +}
> +
> +static inline struct vmap_node *
> +addr_to_node(unsigned long addr)
> +{
> +	return &vmap_nodes[addr_to_node_id(addr)];
> +}
> +
>  static __always_inline unsigned long
>  va_size(struct vmap_area *va)
>  {
> @@ -803,10 +833,11 @@ unsigned long vmalloc_nr_pages(void)
>  }
>
>  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> -static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> +static struct vmap_area *
> +find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
>  {
>  	struct vmap_area *va = NULL;
> -	struct rb_node *n = vmap_area_root.rb_node;
> +	struct rb_node *n = root->rb_node;
>
>  	addr = (unsigned long)kasan_reset_tag((void *)addr);
>
> @@ -1552,12 +1583,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
>   */
>  static void free_vmap_area(struct vmap_area *va)
>  {
> +	struct vmap_node *vn = addr_to_node(va->va_start);
> +

I'm being nitty here, and while I know it's a vmalloc convention to use
'va' and 'vm', perhaps we can break away from the super short variable name
convention and use 'vnode' or something for these values?

I feel people might get confused between 'vm' and 'vn' for instance.

>  	/*
>  	 * Remove from the busy tree/list.
>  	 */
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	spin_lock(&vn->busy.lock);
> +	unlink_va(va, &vn->busy.root);
> +	spin_unlock(&vn->busy.lock);
>
>  	/*
>  	 * Insert/Merge it back to the free tree/list.
> @@ -1600,6 +1633,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				int node, gfp_t gfp_mask,
>  				unsigned long va_flags)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
>  	unsigned long freed;
>  	unsigned long addr;
> @@ -1645,9 +1679,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = va_flags;
>
> -	spin_lock(&vmap_area_lock);
> -	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> -	spin_unlock(&vmap_area_lock);
> +	vn = addr_to_node(va->va_start);
> +
> +	spin_lock(&vn->busy.lock);
> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> +	spin_unlock(&vn->busy.lock);
>
>  	BUG_ON(!IS_ALIGNED(va->va_start, align));
>  	BUG_ON(va->va_start < vstart);
> @@ -1871,26 +1907,61 @@ static void free_unmap_vmap_area(struct vmap_area *va)
>
>  struct vmap_area *find_vmap_area(unsigned long addr)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
> +	int i, j;
>
> -	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area(addr, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	/*
> +	 * An addr_to_node_id(addr) converts an address to a node index
> +	 * where a VA is located. If VA spans several zones and passed
> +	 * addr is not the same as va->va_start, what is not common, we
> +	 * may need to scan an extra nodes. See an example:

For my understading when you say 'scan an extra nodes' do you mean scan
just 1 extra node, or multiple? If the former I'd replace this with 'may
need to scan an extra node' if the latter then 'may ened to scan extra
nodes'.

It's a nitty language thing, but also potentially changes the meaning of
this!

> +	 *
> +	 *      <--va-->
> +	 * -|-----|-----|-----|-----|-
> +	 *     1     2     0     1
> +	 *
> +	 * VA resides in node 1 whereas it spans 1 and 2. If passed
> +	 * addr is within a second node we should do extra work. We
> +	 * should mention that it is rare and is a corner case from
> +	 * the other hand it has to be covered.

A very minor language style nit, but you've already said this is not
common, I don't think you need this 'We should mention...' bit. It's not a
big deal however!

> +	 */
> +	i = j = addr_to_node_id(addr);
> +	do {
> +		vn = &vmap_nodes[i];
>
> -	return va;
> +		spin_lock(&vn->busy.lock);
> +		va = __find_vmap_area(addr, &vn->busy.root);
> +		spin_unlock(&vn->busy.lock);
> +
> +		if (va)
> +			return va;
> +	} while ((i = (i + 1) % nr_vmap_nodes) != j);

If you comment above suggests that only 1 extra node might need to be
scanned, should we stop after one iteration?

> +
> +	return NULL;
>  }
>
>  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
> +	int i, j;
>
> -	spin_lock(&vmap_area_lock);
> -	va = __find_vmap_area(addr, &vmap_area_root);
> -	if (va)
> -		unlink_va(va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	i = j = addr_to_node_id(addr);
> +	do {
> +		vn = &vmap_nodes[i];
>
> -	return va;
> +		spin_lock(&vn->busy.lock);
> +		va = __find_vmap_area(addr, &vn->busy.root);
> +		if (va)
> +			unlink_va(va, &vn->busy.root);
> +		spin_unlock(&vn->busy.lock);
> +
> +		if (va)
> +			return va;
> +	} while ((i = (i + 1) % nr_vmap_nodes) != j);

Maybe worth adding a comment saying to refer to the comment in
find_vmap_area() to see why this loop is necessary.

> +
> +	return NULL;
>  }
>
>  /*** Per cpu kva allocator ***/
> @@ -2092,6 +2163,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>
>  static void free_vmap_block(struct vmap_block *vb)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_block *tmp;
>  	struct xarray *xa;
>
> @@ -2099,9 +2171,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
>  	BUG_ON(tmp != vb);
>
> -	spin_lock(&vmap_area_lock);
> -	unlink_va(vb->va, &vmap_area_root);
> -	spin_unlock(&vmap_area_lock);
> +	vn = addr_to_node(vb->va->va_start);
> +	spin_lock(&vn->busy.lock);
> +	unlink_va(vb->va, &vn->busy.root);
> +	spin_unlock(&vn->busy.lock);
>
>  	free_vmap_area_noflush(vb->va);
>  	kfree_rcu(vb, rcu_head);
> @@ -2525,9 +2598,11 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
>  static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
>  			      unsigned long flags, const void *caller)
>  {
> -	spin_lock(&vmap_area_lock);
> +	struct vmap_node *vn = addr_to_node(va->va_start);
> +
> +	spin_lock(&vn->busy.lock);
>  	setup_vmalloc_vm_locked(vm, va, flags, caller);
> -	spin_unlock(&vmap_area_lock);
> +	spin_unlock(&vn->busy.lock);
>  }
>
>  static void clear_vm_uninitialized_flag(struct vm_struct *vm)
> @@ -3715,6 +3790,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
>   */
>  long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
>  	struct vm_struct *vm;
>  	char *vaddr;
> @@ -3728,8 +3804,11 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)

Unrelated to your change but makes me feel a little unwell to see 'const
char *addr'! Can we change this at some point? Or maybe I can :)

>
>  	remains = count;
>
> -	spin_lock(&vmap_area_lock);
> -	va = find_vmap_area_exceed_addr((unsigned long)addr);
> +	/* Hooked to node_0 so far. */
> +	vn = addr_to_node(0);

Why can't we use addr for this call? We already enforce the node-0 only
thing by setting nr_vmap_nodes to 1 right? And won't this be potentially
subtly wrong when we later increase this?

> +	spin_lock(&vn->busy.lock);
> +
> +	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
>  	if (!va)
>  		goto finished_zero;
>
> @@ -3737,7 +3816,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  	if ((unsigned long)addr + remains <= va->va_start)
>  		goto finished_zero;
>
> -	list_for_each_entry_from(va, &vmap_area_list, list) {
> +	list_for_each_entry_from(va, &vn->busy.head, list) {
>  		size_t copied;
>
>  		if (remains == 0)
> @@ -3796,12 +3875,12 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
>  	}
>
>  finished_zero:
> -	spin_unlock(&vmap_area_lock);
> +	spin_unlock(&vn->busy.lock);
>  	/* zero-fill memory holes */
>  	return count - remains + zero_iter(iter, remains);
>  finished:
>  	/* Nothing remains, or We couldn't copy/zero everything. */
> -	spin_unlock(&vmap_area_lock);
> +	spin_unlock(&vn->busy.lock);
>
>  	return count - remains;
>  }
> @@ -4135,14 +4214,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  	}
>
>  	/* insert all vm's */
> -	spin_lock(&vmap_area_lock);
>  	for (area = 0; area < nr_vms; area++) {
> -		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
> +		struct vmap_node *vn = addr_to_node(vas[area]->va_start);
>
> +		spin_lock(&vn->busy.lock);
> +		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
>  		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
> +		spin_unlock(&vn->busy.lock);

Hmm, before we were locking/unlocking once before the loop, now we're
locking on each iteration, this seems inefficient.

Seems like we need logic like:

/* ... something to check nr_vms > 0 ... */
struct vmap_node *last_node = NULL;

for (...) {
	struct vmap_node *vnode = addr_to_node(vas[area]->va_start);

	if (vnode != last_node) {
		spin_unlock(last_node->busy.lock);
		spin_lock(vnode->busy.lock);
		last_node = vnode;
	}

	...
}

if (last_node)
	spin_unlock(last_node->busy.lock);

To minimise the lock twiddling. What do you think?

>  	}
> -	spin_unlock(&vmap_area_lock);
>
>  	/*
>  	 * Mark allocated areas as accessible. Do it now as a best-effort
> @@ -4253,55 +4333,57 @@ bool vmalloc_dump_obj(void *object)
>  {
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  	const void *caller;
> -	struct vm_struct *vm;
>  	struct vmap_area *va;
> +	struct vmap_node *vn;
>  	unsigned long addr;
>  	unsigned int nr_pages;
> +	bool success = false;
>
> -	if (!spin_trylock(&vmap_area_lock))
> -		return false;

Nitpick on style for this, I really don't know why you are removing this
early exit? It's far neater to have a guard clause than to nest a whole
bunch of code below.

> -	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> -	if (!va) {
> -		spin_unlock(&vmap_area_lock);
> -		return false;
> -	}
> +	vn = addr_to_node((unsigned long)objp);

Later in the patch where you fix build bot issues with the below
__find_vmap_area() invocation, you move from addr to (unsigned long)objp.

However since you're already referring to that here, why not change what
addr refers to and use that in both instances, e.g.

unsigned long addr = (unsigned long)objp;

Then update things that refer to the objp value as necessary.

>
> -	vm = va->vm;
> -	if (!vm) {
> -		spin_unlock(&vmap_area_lock);
> -		return false;
> +	if (spin_trylock(&vn->busy.lock)) {
> +		va = __find_vmap_area(addr, &vn->busy.root);
> +
> +		if (va && va->vm) {
> +			addr = (unsigned long)va->vm->addr;
> +			caller = va->vm->caller;
> +			nr_pages = va->vm->nr_pages;

Again it feels like you're undoing some good here, now you're referencing
va->vm over and over when you could simply assign vm = va->vm as the
original code did.

Also again it'd be nicer to use an early exit/guard clause approach.

> +			success = true;
> +		}
> +
> +		spin_unlock(&vn->busy.lock);
>  	}
> -	addr = (unsigned long)vm->addr;
> -	caller = vm->caller;
> -	nr_pages = vm->nr_pages;
> -	spin_unlock(&vmap_area_lock);
> -	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> -		nr_pages, addr, caller);
> -	return true;
> +
> +	if (success)
> +		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> +			nr_pages, addr, caller);

With the redefinition of addr, you could then simply put va->vm->addr here.

> +
> +	return success;
>  }
>  #endif

These are all essentially style nits (the actual bug was fixed by your
follow up patch for the build bots) :)

>
>  #ifdef CONFIG_PROC_FS
>  static void *s_start(struct seq_file *m, loff_t *pos)
> -	__acquires(&vmap_purge_lock)
> -	__acquires(&vmap_area_lock)

Do we want to replace these __acquires() directives? I suppose we simply
cannot now we need to look up the node.

>  {
> +	struct vmap_node *vn = addr_to_node(0);

Hm does the procfs operation span only one node? I guess we can start from
the initial node for an iteration, but I wonder if '&vmap_nodes[0]' here is
a more 'honest' thing to do rather than to assume that address 0 gets
translated to node zero here?

I think a comment like:

/* We start from node 0 */

Would be useful here at any rate.

> +
>  	mutex_lock(&vmap_purge_lock);
> -	spin_lock(&vmap_area_lock);
> +	spin_lock(&vn->busy.lock);
>
> -	return seq_list_start(&vmap_area_list, *pos);
> +	return seq_list_start(&vn->busy.head, *pos);
>  }
>
>  static void *s_next(struct seq_file *m, void *p, loff_t *pos)
>  {
> -	return seq_list_next(p, &vmap_area_list, pos);
> +	struct vmap_node *vn = addr_to_node(0);

This one I'm a little more uncertain of, obviously comments above still
apply but actually shouldn't we add a check to see if we're at the end of
the list and should look at the next node?

Even if we only have one for now, I don't like the idea of leaving in
hardcoded things that might get missed when we move to nr_vmap_nodes > 1.

For instance right now if you increased this above 1 it'd break things
right?

I'd say better to write logic assuming nr_vmap_nodes _could_ be > 1 even
if, to start, it won't be.

> +	return seq_list_next(p, &vn->busy.head, pos);
>  }
>
>  static void s_stop(struct seq_file *m, void *p)
> -	__releases(&vmap_area_lock)
> -	__releases(&vmap_purge_lock)
>  {
> -	spin_unlock(&vmap_area_lock);
> +	struct vmap_node *vn = addr_to_node(0);

See comments above about use of addr_to_node(0).

> +
> +	spin_unlock(&vn->busy.lock);
>  	mutex_unlock(&vmap_purge_lock);
>  }
>
> @@ -4344,9 +4426,11 @@ static void show_purge_info(struct seq_file *m)
>
>  static int s_show(struct seq_file *m, void *p)
>  {
> +	struct vmap_node *vn;
>  	struct vmap_area *va;
>  	struct vm_struct *v;
>
> +	vn = addr_to_node(0);

This one is really quite icky, should we make it easy for a vmap_area to
know its vmap_node? How is this going to work once nr_vmap_nodes > 1?

>  	va = list_entry(p, struct vmap_area, list);
>
>  	if (!va->vm) {
> @@ -4397,7 +4481,7 @@ static int s_show(struct seq_file *m, void *p)
>  	 * As a final step, dump "unpurged" areas.
>  	 */
>  final:
> -	if (list_is_last(&va->list, &vmap_area_list))
> +	if (list_is_last(&va->list, &vn->busy.head))
>  		show_purge_info(m);
>
>  	return 0;
> @@ -4428,7 +4512,8 @@ static void vmap_init_free_space(void)
>  {
>  	unsigned long vmap_start = 1;
>  	const unsigned long vmap_end = ULONG_MAX;
> -	struct vmap_area *busy, *free;
> +	struct vmap_area *free;
> +	struct vm_struct *busy;
>
>  	/*
>  	 *     B     F     B     B     B     F
> @@ -4436,12 +4521,12 @@ static void vmap_init_free_space(void)
>  	 *  |           The KVA space           |
>  	 *  |<--------------------------------->|
>  	 */
> -	list_for_each_entry(busy, &vmap_area_list, list) {
> -		if (busy->va_start - vmap_start > 0) {
> +	for (busy = vmlist; busy; busy = busy->next) {
> +		if ((unsigned long) busy->addr - vmap_start > 0) {
>  			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
>  			if (!WARN_ON_ONCE(!free)) {
>  				free->va_start = vmap_start;
> -				free->va_end = busy->va_start;
> +				free->va_end = (unsigned long) busy->addr;
>
>  				insert_vmap_area_augment(free, NULL,
>  					&free_vmap_area_root,
> @@ -4449,7 +4534,7 @@ static void vmap_init_free_space(void)
>  			}
>  		}
>
> -		vmap_start = busy->va_end;
> +		vmap_start = (unsigned long) busy->addr + busy->size;
>  	}
>
>  	if (vmap_end - vmap_start > 0) {
> @@ -4465,9 +4550,23 @@ static void vmap_init_free_space(void)
>  	}
>  }
>
> +static void vmap_init_nodes(void)
> +{
> +	struct vmap_node *vn;
> +	int i;
> +
> +	for (i = 0; i < nr_vmap_nodes; i++) {
> +		vn = &vmap_nodes[i];
> +		vn->busy.root = RB_ROOT;
> +		INIT_LIST_HEAD(&vn->busy.head);
> +		spin_lock_init(&vn->busy.lock);
> +	}
> +}
> +
>  void __init vmalloc_init(void)
>  {
>  	struct vmap_area *va;
> +	struct vmap_node *vn;
>  	struct vm_struct *tmp;
>  	int i;
>
> @@ -4489,6 +4588,11 @@ void __init vmalloc_init(void)
>  		xa_init(&vbq->vmap_blocks);
>  	}
>
> +	/*
> +	 * Setup nodes before importing vmlist.
> +	 */
> +	vmap_init_nodes();
> +
>  	/* Import existing vmlist entries. */
>  	for (tmp = vmlist; tmp; tmp = tmp->next) {
>  		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> @@ -4498,7 +4602,9 @@ void __init vmalloc_init(void)
>  		va->va_start = (unsigned long)tmp->addr;
>  		va->va_end = va->va_start + tmp->size;
>  		va->vm = tmp;
> -		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +
> +		vn = addr_to_node(va->va_start);
> +		insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
>  	}
>
>  	/*
> --
> 2.39.2
>

