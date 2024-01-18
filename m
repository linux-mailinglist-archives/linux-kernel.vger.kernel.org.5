Return-Path: <linux-kernel+bounces-30142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FC831A59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9C4B260E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C6825553;
	Thu, 18 Jan 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6YuOy4V"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA925550
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583738; cv=none; b=sKSm7OLs53rqbFXPzZK+gsj7cd6q6t8ipC/x88rmISX1uDmyxmggGrTFMnzoPJQ6CC6+OZ/p98o6ME1JtdS+AM8bJE6PvfpmGAgO1uXREwyYcT51cTyX+H7O+/mKAZ3m0XFTIu8cjQ229SBKnGhzR90mOcqwQo/PWkjf8pI3xPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583738; c=relaxed/simple;
	bh=FO5gQAMQok6d3q0BpSDkG373SE76pdyjyAOUvGhlTGg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=tGbmT0NAh5jTAwuc13p93s62r0Zugn4QfYCE1tnm4ek7B4qGfaVGjz63O39qnyQLcVGMehQZjhGJsDVB9EVDuhXljf1yY+xUviaGtPAQ/eHo/eqFD8WCWXeE0Henf0B0pNoTPfnKQaqOgpDcYqpz6fHIprnKIoUmXz9VQn0ys8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6YuOy4V; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so15573029e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705583734; x=1706188534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjLLZkFenZkp1+ctnAb+pv80xaeiCf5FQ7yqzNCpmxw=;
        b=l6YuOy4VL09MR64R30Bd9KYoHKgoHhGOcCtK2uf7ZdppC5Y3jThKU4JuMRzz8Okp6N
         UzVgK2Qv9A6rqM1t3UTA1UXsS3Qhy+dz/0Utjq2nIjlaMSE/QtZMnsBi9FteMu10xVam
         Y3T1y+44G97B7gLhPKqyCOuvq50s3UKT3DGaiRVX/Yhpm+55qbREDiC+JP8k6Tv8GGO5
         9pTcHIwF0TTv1JtCbIWSQUtx1GqM41DeAqldaOhksiZuZdN6968UkZLHIxjhXokfrqCq
         bd4u4ndXamZA2iluZIt2VcjyfX6BK6XX7wa8ZIeDukv+uolefExwozfpbtt3lxupB9px
         NFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705583734; x=1706188534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjLLZkFenZkp1+ctnAb+pv80xaeiCf5FQ7yqzNCpmxw=;
        b=jmsJbYgJVPgMYSEX+61VPiM5mkalSNFcl7AzuFPpAxXFeHxbcCbme/zBqUqnKX3U6+
         bHqQ0Ux63/QxeEC92VPTUuMULoACJcIpAVWE8u7ZJ/HFTraZvP4zRmg2oIshDwQuGBWr
         Q3uZlWIZlk2FmTc+IPoDWggH7B5pgA1lwWh/+YrAtUK6Mkdl2r0O51CiIphm6EHl50kV
         AAqvB22+8CTEtewftMl4Odlaqwx34qiT/PHChWfJz7HVaCx60+A5fYwOiiEoG5a/Xh5O
         nlFyL0xs3O/oaWPtll0CAfVpUoa8JRtKX5M9c7CvULcT/emXoqDYui1c/6xvIswGKI2s
         J/wg==
X-Gm-Message-State: AOJu0Yyr0nPh5IQa7hGaYxgWAwLE0fm+yJ3DQJh982QDA4g1iquU165k
	SRptmW7DS743XBJ/C4Z54/ZOZnrnE186MiIfKivwX6zr6klc4PKO
X-Google-Smtp-Source: AGHT+IEARGC1Q6/l/I32gVn9JGD+TDNV8GLoYpX3OdmMJ1T0B7/PZWxLKsjSCuu0NZ9MbnZkZQtV4Q==
X-Received: by 2002:a05:6512:3dab:b0:50e:630d:7364 with SMTP id k43-20020a0565123dab00b0050e630d7364mr585649lfv.28.1705583733993;
        Thu, 18 Jan 2024 05:15:33 -0800 (PST)
Received: from pc636 (host-90-235-20-191.mobileonline.telia.com. [90.235.20.191])
        by smtp.gmail.com with ESMTPSA id y17-20020a199151000000b0050e84a3d75bsm634211lfj.254.2024.01.18.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 05:15:33 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 18 Jan 2024 14:15:31 +0100
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Zakkc5jrxmJj-plk@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <63104f8e-2fe3-46b2-842c-f11f8bb4b336@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63104f8e-2fe3-46b2-842c-f11f8bb4b336@lucifer.local>

On Tue, Jan 16, 2024 at 11:25:43PM +0000, Lorenzo Stoakes wrote:
> On Tue, Jan 02, 2024 at 07:46:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> >
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs.
> >
> > Please note:
> >
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> >
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> >
> > 3. The vmallocinfo and vread() have to be reworked to be able to
> >    handle multiple nodes.
> >
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 240 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 173 insertions(+), 67 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 06bd843d18ae..786ecb18ae22 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -728,11 +728,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> >  #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> >
> >
> > -static DEFINE_SPINLOCK(vmap_area_lock);
> >  static DEFINE_SPINLOCK(free_vmap_area_lock);
> >  /* Export for kexec only */
> >  LIST_HEAD(vmap_area_list);
> > -static struct rb_root vmap_area_root = RB_ROOT;
> >  static bool vmap_initialized __read_mostly;
> >
> >  static struct rb_root purge_vmap_area_root = RB_ROOT;
> > @@ -772,6 +770,38 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
> >   */
> >  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> >
> > +/*
> > + * An effective vmap-node logic. Users make use of nodes instead
> > + * of a global heap. It allows to balance an access and mitigate
> > + * contention.
> > + */
> > +struct rb_list {
> 
> I'm not sure this name is very instructive - this contains a red/black tree
> root node, a list head and a lock, but the meaning of it is that it stores
> a red/black tree and a list of vmap_area objects and has a lock to protect
> access.
> 
> A raw 'list_head' without a comment is always hard to parse, maybe some
> comments/embed in vmap_node?
> 
> At the very least if you wanted to keep the name generic it should be
> something like ordered_rb_tree or something like this.
> 
I can add a comment in the vmap_node. rb_list describes a single, solid
data structure where a list and rb-tree are part of one entity protected
by lock. Similar to the B+tree where you have leaf nodes linked between
each other in order to do a fast sequential traversal.

> > +	struct rb_root root;
> > +	struct list_head head;
> > +	spinlock_t lock;
> > +};
> > +
> > +static struct vmap_node {
> > +	/* Bookkeeping data of this node. */
> > +	struct rb_list busy;
> > +} single;
> 
> This may be a thing about encapsulation/naming or similar, but I'm a little
> confused as to why the rb_list type is maintained as a field rather than
> its fields embedded?
> 
The "struct vmap_node" will be extended by the following patches in the
series.

> > +
> > +static struct vmap_node *vmap_nodes = &single;
> > +static __read_mostly unsigned int nr_vmap_nodes = 1;
> > +static __read_mostly unsigned int vmap_zone_size = 1;
> 
> It might be worth adding a comment here explaining that we're binding to a
> single node for now to maintain existing behaviour (and a brief description
> of what these values mean - for instance what unit vmap_zone_size is
> expressed in?)
> 
Right. Agree on it :)

> > +
> > +static inline unsigned int
> > +addr_to_node_id(unsigned long addr)
> > +{
> > +	return (addr / vmap_zone_size) % nr_vmap_nodes;
> > +}
> > +
> > +static inline struct vmap_node *
> > +addr_to_node(unsigned long addr)
> > +{
> > +	return &vmap_nodes[addr_to_node_id(addr)];
> > +}
> > +
> >  static __always_inline unsigned long
> >  va_size(struct vmap_area *va)
> >  {
> > @@ -803,10 +833,11 @@ unsigned long vmalloc_nr_pages(void)
> >  }
> >
> >  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> > -static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> > +static struct vmap_area *
> > +find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> >  {
> >  	struct vmap_area *va = NULL;
> > -	struct rb_node *n = vmap_area_root.rb_node;
> > +	struct rb_node *n = root->rb_node;
> >
> >  	addr = (unsigned long)kasan_reset_tag((void *)addr);
> >
> > @@ -1552,12 +1583,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >   */
> >  static void free_vmap_area(struct vmap_area *va)
> >  {
> > +	struct vmap_node *vn = addr_to_node(va->va_start);
> > +
> 
> I'm being nitty here, and while I know it's a vmalloc convention to use
> 'va' and 'vm', perhaps we can break away from the super short variable name
> convention and use 'vnode' or something for these values?
> 
> I feel people might get confused between 'vm' and 'vn' for instance.
> 
vnode, varea?

> >  	/*
> >  	 * Remove from the busy tree/list.
> >  	 */
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	spin_lock(&vn->busy.lock);
> > +	unlink_va(va, &vn->busy.root);
> > +	spin_unlock(&vn->busy.lock);
> >
> >  	/*
> >  	 * Insert/Merge it back to the free tree/list.
> > @@ -1600,6 +1633,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  				int node, gfp_t gfp_mask,
> >  				unsigned long va_flags)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_area *va;
> >  	unsigned long freed;
> >  	unsigned long addr;
> > @@ -1645,9 +1679,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	va->vm = NULL;
> >  	va->flags = va_flags;
> >
> > -	spin_lock(&vmap_area_lock);
> > -	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> > -	spin_unlock(&vmap_area_lock);
> > +	vn = addr_to_node(va->va_start);
> > +
> > +	spin_lock(&vn->busy.lock);
> > +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> > +	spin_unlock(&vn->busy.lock);
> >
> >  	BUG_ON(!IS_ALIGNED(va->va_start, align));
> >  	BUG_ON(va->va_start < vstart);
> > @@ -1871,26 +1907,61 @@ static void free_unmap_vmap_area(struct vmap_area *va)
> >
> >  struct vmap_area *find_vmap_area(unsigned long addr)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_area *va;
> > +	int i, j;
> >
> > -	spin_lock(&vmap_area_lock);
> > -	va = __find_vmap_area(addr, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	/*
> > +	 * An addr_to_node_id(addr) converts an address to a node index
> > +	 * where a VA is located. If VA spans several zones and passed
> > +	 * addr is not the same as va->va_start, what is not common, we
> > +	 * may need to scan an extra nodes. See an example:
> 
> For my understading when you say 'scan an extra nodes' do you mean scan
> just 1 extra node, or multiple? If the former I'd replace this with 'may
> need to scan an extra node' if the latter then 'may ened to scan extra
> nodes'.
> 
> It's a nitty language thing, but also potentially changes the meaning of
> this!
> 
Typo, i should replace it to: scan extra nodes.

> > +	 *
> > +	 *      <--va-->
> > +	 * -|-----|-----|-----|-----|-
> > +	 *     1     2     0     1
> > +	 *
> > +	 * VA resides in node 1 whereas it spans 1 and 2. If passed
> > +	 * addr is within a second node we should do extra work. We
> > +	 * should mention that it is rare and is a corner case from
> > +	 * the other hand it has to be covered.
> 
> A very minor language style nit, but you've already said this is not
> common, I don't think you need this 'We should mention...' bit. It's not a
> big deal however!
> 
No problem. We can remove it!

> > +	 */
> > +	i = j = addr_to_node_id(addr);
> > +	do {
> > +		vn = &vmap_nodes[i];
> >
> > -	return va;
> > +		spin_lock(&vn->busy.lock);
> > +		va = __find_vmap_area(addr, &vn->busy.root);
> > +		spin_unlock(&vn->busy.lock);
> > +
> > +		if (va)
> > +			return va;
> > +	} while ((i = (i + 1) % nr_vmap_nodes) != j);
> 
> If you comment above suggests that only 1 extra node might need to be
> scanned, should we stop after one iteration?
> 
Not really. Though we can improve it further to scan backward.

> > +
> > +	return NULL;
> >  }
> >
> >  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_area *va;
> > +	int i, j;
> >
> > -	spin_lock(&vmap_area_lock);
> > -	va = __find_vmap_area(addr, &vmap_area_root);
> > -	if (va)
> > -		unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	i = j = addr_to_node_id(addr);
> > +	do {
> > +		vn = &vmap_nodes[i];
> >
> > -	return va;
> > +		spin_lock(&vn->busy.lock);
> > +		va = __find_vmap_area(addr, &vn->busy.root);
> > +		if (va)
> > +			unlink_va(va, &vn->busy.root);
> > +		spin_unlock(&vn->busy.lock);
> > +
> > +		if (va)
> > +			return va;
> > +	} while ((i = (i + 1) % nr_vmap_nodes) != j);
> 
> Maybe worth adding a comment saying to refer to the comment in
> find_vmap_area() to see why this loop is necessary.
> 
OK. We can do it to make it better for reading.

> > +
> > +	return NULL;
> >  }
> >
> >  /*** Per cpu kva allocator ***/
> > @@ -2092,6 +2163,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >
> >  static void free_vmap_block(struct vmap_block *vb)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_block *tmp;
> >  	struct xarray *xa;
> >
> > @@ -2099,9 +2171,10 @@ static void free_vmap_block(struct vmap_block *vb)
> >  	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
> >  	BUG_ON(tmp != vb);
> >
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(vb->va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	vn = addr_to_node(vb->va->va_start);
> > +	spin_lock(&vn->busy.lock);
> > +	unlink_va(vb->va, &vn->busy.root);
> > +	spin_unlock(&vn->busy.lock);
> >
> >  	free_vmap_area_noflush(vb->va);
> >  	kfree_rcu(vb, rcu_head);
> > @@ -2525,9 +2598,11 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
> >  static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
> >  			      unsigned long flags, const void *caller)
> >  {
> > -	spin_lock(&vmap_area_lock);
> > +	struct vmap_node *vn = addr_to_node(va->va_start);
> > +
> > +	spin_lock(&vn->busy.lock);
> >  	setup_vmalloc_vm_locked(vm, va, flags, caller);
> > -	spin_unlock(&vmap_area_lock);
> > +	spin_unlock(&vn->busy.lock);
> >  }
> >
> >  static void clear_vm_uninitialized_flag(struct vm_struct *vm)
> > @@ -3715,6 +3790,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
> >   */
> >  long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_area *va;
> >  	struct vm_struct *vm;
> >  	char *vaddr;
> > @@ -3728,8 +3804,11 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> 
> Unrelated to your change but makes me feel a little unwell to see 'const
> char *addr'! Can we change this at some point? Or maybe I can :)
> 
You are welcome :)

> >
> >  	remains = count;
> >
> > -	spin_lock(&vmap_area_lock);
> > -	va = find_vmap_area_exceed_addr((unsigned long)addr);
> > +	/* Hooked to node_0 so far. */
> > +	vn = addr_to_node(0);
> 
> Why can't we use addr for this call? We already enforce the node-0 only
> thing by setting nr_vmap_nodes to 1 right? And won't this be potentially
> subtly wrong when we later increase this?
> 
I used to have 0 here. But please note, it is changed by the next patch in
this series.

> > +	spin_lock(&vn->busy.lock);
> > +
> > +	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
> >  	if (!va)
> >  		goto finished_zero;
> >
> > @@ -3737,7 +3816,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> >  	if ((unsigned long)addr + remains <= va->va_start)
> >  		goto finished_zero;
> >
> > -	list_for_each_entry_from(va, &vmap_area_list, list) {
> > +	list_for_each_entry_from(va, &vn->busy.head, list) {
> >  		size_t copied;
> >
> >  		if (remains == 0)
> > @@ -3796,12 +3875,12 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> >  	}
> >
> >  finished_zero:
> > -	spin_unlock(&vmap_area_lock);
> > +	spin_unlock(&vn->busy.lock);
> >  	/* zero-fill memory holes */
> >  	return count - remains + zero_iter(iter, remains);
> >  finished:
> >  	/* Nothing remains, or We couldn't copy/zero everything. */
> > -	spin_unlock(&vmap_area_lock);
> > +	spin_unlock(&vn->busy.lock);
> >
> >  	return count - remains;
> >  }
> > @@ -4135,14 +4214,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >  	}
> >
> >  	/* insert all vm's */
> > -	spin_lock(&vmap_area_lock);
> >  	for (area = 0; area < nr_vms; area++) {
> > -		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
> > +		struct vmap_node *vn = addr_to_node(vas[area]->va_start);
> >
> > +		spin_lock(&vn->busy.lock);
> > +		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
> >  		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> >  				 pcpu_get_vm_areas);
> > +		spin_unlock(&vn->busy.lock);
> 
> Hmm, before we were locking/unlocking once before the loop, now we're
> locking on each iteration, this seems inefficient.
> 
> Seems like we need logic like:
> 
> /* ... something to check nr_vms > 0 ... */
> struct vmap_node *last_node = NULL;
> 
> for (...) {
> 	struct vmap_node *vnode = addr_to_node(vas[area]->va_start);
> 
> 	if (vnode != last_node) {
> 		spin_unlock(last_node->busy.lock);
> 		spin_lock(vnode->busy.lock);
> 		last_node = vnode;
> 	}
> 
> 	...
> }
> 
> if (last_node)
> 	spin_unlock(last_node->busy.lock);
> 
> To minimise the lock twiddling. What do you think?
>
This per-cpu-allocator prefetches several VA units per-cpu. I do not
find it as critical because it is not a hot path for the per-cpu allocator. 
When its buffers are exhausted it does an extra prefetch. So it is not
frequent.

> 
> >  	}
> > -	spin_unlock(&vmap_area_lock);
> >
> >  	/*
> >  	 * Mark allocated areas as accessible. Do it now as a best-effort
> > @@ -4253,55 +4333,57 @@ bool vmalloc_dump_obj(void *object)
> >  {
> >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >  	const void *caller;
> > -	struct vm_struct *vm;
> >  	struct vmap_area *va;
> > +	struct vmap_node *vn;
> >  	unsigned long addr;
> >  	unsigned int nr_pages;
> > +	bool success = false;
> >
> > -	if (!spin_trylock(&vmap_area_lock))
> > -		return false;
> 
> Nitpick on style for this, I really don't know why you are removing this
> early exit? It's far neater to have a guard clause than to nest a whole
> bunch of code below.
> 
Hm... I can return back as it used to be. I do not have a strong opinion here.

> > -	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> > -	if (!va) {
> > -		spin_unlock(&vmap_area_lock);
> > -		return false;
> > -	}
> > +	vn = addr_to_node((unsigned long)objp);
> 
> Later in the patch where you fix build bot issues with the below
> __find_vmap_area() invocation, you move from addr to (unsigned long)objp.
> 
> However since you're already referring to that here, why not change what
> addr refers to and use that in both instances, e.g.
> 
> unsigned long addr = (unsigned long)objp;
> 
> Then update things that refer to the objp value as necessary.
> 
That is what i was thinking of. We can send a separate patch for this.

> >
> > -	vm = va->vm;
> > -	if (!vm) {
> > -		spin_unlock(&vmap_area_lock);
> > -		return false;
> > +	if (spin_trylock(&vn->busy.lock)) {
> > +		va = __find_vmap_area(addr, &vn->busy.root);
> > +
> > +		if (va && va->vm) {
> > +			addr = (unsigned long)va->vm->addr;
> > +			caller = va->vm->caller;
> > +			nr_pages = va->vm->nr_pages;
> 
> Again it feels like you're undoing some good here, now you're referencing
> va->vm over and over when you could simply assign vm = va->vm as the
> original code did.
> 
> Also again it'd be nicer to use an early exit/guard clause approach.
> 
We can change it in separate patch.

> > +			success = true;
> > +		}
> > +
> > +		spin_unlock(&vn->busy.lock);
> >  	}
> > -	addr = (unsigned long)vm->addr;
> > -	caller = vm->caller;
> > -	nr_pages = vm->nr_pages;
> > -	spin_unlock(&vmap_area_lock);
> > -	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > -		nr_pages, addr, caller);
> > -	return true;
> > +
> > +	if (success)
> > +		pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > +			nr_pages, addr, caller);
> 
> With the redefinition of addr, you could then simply put va->vm->addr here.
> 
> > +
> > +	return success;
> >  }
> >  #endif
> 
> These are all essentially style nits (the actual bug was fixed by your
> follow up patch for the build bots) :)
> 
Right :)

> >
> >  #ifdef CONFIG_PROC_FS
> >  static void *s_start(struct seq_file *m, loff_t *pos)
> > -	__acquires(&vmap_purge_lock)
> > -	__acquires(&vmap_area_lock)
> 
> Do we want to replace these __acquires() directives? I suppose we simply
> cannot now we need to look up the node.
> 
Yep. It is reworked anyway in another patch.

> >  {
> > +	struct vmap_node *vn = addr_to_node(0);
> 
> Hm does the procfs operation span only one node? I guess we can start from
> the initial node for an iteration, but I wonder if '&vmap_nodes[0]' here is
> a more 'honest' thing to do rather than to assume that address 0 gets
> translated to node zero here?
> 
> I think a comment like:
> 
> /* We start from node 0 */
> 
> Would be useful here at any rate.
> 
It works since nr_nodes is set to 1. By later patches in this series
it is fulfilled and completed.

> > +
> >  	mutex_lock(&vmap_purge_lock);
> > -	spin_lock(&vmap_area_lock);
> > +	spin_lock(&vn->busy.lock);
> >
> > -	return seq_list_start(&vmap_area_list, *pos);
> > +	return seq_list_start(&vn->busy.head, *pos);
> >  }
> >
> >  static void *s_next(struct seq_file *m, void *p, loff_t *pos)
> >  {
> > -	return seq_list_next(p, &vmap_area_list, pos);
> > +	struct vmap_node *vn = addr_to_node(0);
> 
> This one I'm a little more uncertain of, obviously comments above still
> apply but actually shouldn't we add a check to see if we're at the end of
> the list and should look at the next node?
> 
> Even if we only have one for now, I don't like the idea of leaving in
> hardcoded things that might get missed when we move to nr_vmap_nodes > 1.
> 
> For instance right now if you increased this above 1 it'd break things
> right?
> 
> I'd say better to write logic assuming nr_vmap_nodes _could_ be > 1 even
> if, to start, it won't be.
> 
Same as above. It is incomplete and stick to a single node. Further
patches solve this fully.

> > +	return seq_list_next(p, &vn->busy.head, pos);
> >  }
> >
> >  static void s_stop(struct seq_file *m, void *p)
> > -	__releases(&vmap_area_lock)
> > -	__releases(&vmap_purge_lock)
> >  {
> > -	spin_unlock(&vmap_area_lock);
> > +	struct vmap_node *vn = addr_to_node(0);
> 
> See comments above about use of addr_to_node(0).
> 
All this s_start/s_next/etc are removed and reworked by following
patches.

> > +
> > +	spin_unlock(&vn->busy.lock);
> >  	mutex_unlock(&vmap_purge_lock);
> >  }
> >
> > @@ -4344,9 +4426,11 @@ static void show_purge_info(struct seq_file *m)
> >
> >  static int s_show(struct seq_file *m, void *p)
> >  {
> > +	struct vmap_node *vn;
> >  	struct vmap_area *va;
> >  	struct vm_struct *v;
> >
> > +	vn = addr_to_node(0);
> 
> This one is really quite icky, should we make it easy for a vmap_area to
> know its vmap_node? How is this going to work once nr_vmap_nodes > 1?
> 
Same as above.

Thank you for the review! I can fix the comments as separate patches if
no objections.

--
Uladzislau Rezki

