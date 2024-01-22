Return-Path: <linux-kernel+bounces-33850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F7836F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A131C28282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D7F47A40;
	Mon, 22 Jan 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acTgM77m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141547786
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945481; cv=none; b=sKt+C1xwbaw3JsdPRVB+CePGV5IOgLj8nMXjly6Ip+N2VoWb4polDaYtYvF5wh3qwbdoZoF+W1OUlB5Bt8HS7rfSxbIbV4X2o91M8w0V6A5EzRpSBs2f/B0aW3it7rc7sV7NOMHn6OnUC3wCu7XKRzo9/+q+JWqWKzkYbRNeBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945481; c=relaxed/simple;
	bh=lB73xuSGxp4NvJLmigyeYoS1BF+SgCCVtRxYWWqS1TQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsacT16iGjuZi30RmhfotjVmgHXRVGFfC+00xh/vxQn3g6pofftGAnb4qMlDUSv9C2CGOSp+00MsZfA8ETtYwoq4O98DElFU6PXOX/s06IN+I04MmS23zuv9DizBFmE6+v7Z+6rsNiyoPnrm7258YF4ftinq4ar5ZZViLdch6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acTgM77m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so4571896e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705945477; x=1706550277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ck+/Ha3vTj1dYVpahC4s/e5ENc+3sMxjTzjbmp7H+qY=;
        b=acTgM77my0FPBP3WPiQKkaY0W6RJAAroXf2SIDvBiDu2sDfj1BrmaV3juxlmAjGG1v
         Yi6gD27H9mB10dRxJlzGw/H3iGgW2EUu46O3c49OpbP2U8ZaqBfCZvdSlZybTtRgz591
         XdfjRnd5CfYUv36BKQp1lKz71KwVqqjnezYEBrN/83zU7mR/hgAUI6rXmrkGpHGZ5oJg
         OdsDBp0bjYjSrO2++KfKr4jkPlA2uOVHpOoPy7lZUZ6FXMbIhZCfofjIVrkXMJFM0jQj
         q36WeeXkgc+bqGysnhjV70eAxdGqBkiTS0ePe6GCboTaaT4QfLjFujJwz/I3jBgeHpad
         Hh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945477; x=1706550277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck+/Ha3vTj1dYVpahC4s/e5ENc+3sMxjTzjbmp7H+qY=;
        b=VQYMNy+MjPbIAe5Pe+2PUaTimfnA+k0CrokRx18Da2PsRbJmiv1/5nXVrLE+Dau8kM
         FRPJtgfrIXhgRUCn1+5LOQiioe951dzvmYiUQOgZkLI6yRsz+kMhXS9fMkk4M/Xh7NWg
         gvdDMf5tevMKHVXhpszO7tEHFoYIiWyQdp7FOH8dCb3n3wcU7tf4gPWVm+yv1lbZz5Za
         1BhFay9TDW6JuQI/KKd7rfAHDhM5dPW609G/Do5Su5ixiN0mPlZdqRuYbB91lfKbLjOE
         ZfS/dh2s8c0DV0XvFdZmTBHTL9wiej5ygJfRX+J7BQ9AXkWJnCtJU33pyJr0M3cZNz+Y
         2lpA==
X-Gm-Message-State: AOJu0Yx+EdSMGwrBREqoeAcXn20d9idn0xDVDnPvbqLQ6O+Dbyb0fkg5
	sH51HZIRo/AwAo/bqy6tVn/90xe9K5HczTdCCSW2xynJhd1Z+n9Q
X-Google-Smtp-Source: AGHT+IECdOknBBn1ho4bjXcV2ESKfrBMsHcPHlBdlntDg/VNbXktACmNxt1d51VJjFzaTMr8qADe6A==
X-Received: by 2002:a05:6512:2205:b0:50e:b2cf:4e17 with SMTP id h5-20020a056512220500b0050eb2cf4e17mr1785559lfu.100.1705945476985;
        Mon, 22 Jan 2024 09:44:36 -0800 (PST)
Received: from pc636 (host-90-235-23-195.mobileonline.telia.com. [90.235.23.195])
        by smtp.gmail.com with ESMTPSA id er17-20020a05651248d100b0050e9a8057f6sm2058360lfb.259.2024.01.22.09.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:44:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 22 Jan 2024 18:44:34 +0100
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
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
Message-ID: <Za6pgt2j1n4PTcGI@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-5-urezki@gmail.com>
 <63104f8e-2fe3-46b2-842c-f11f8bb4b336@lucifer.local>
 <Zakkc5jrxmJj-plk@pc636>
 <2c318a40-9e0f-4d24-b5cc-e712f7b2c334@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c318a40-9e0f-4d24-b5cc-e712f7b2c334@lucifer.local>

On Sat, Jan 20, 2024 at 12:55:10PM +0000, Lorenzo Stoakes wrote:
> On Thu, Jan 18, 2024 at 02:15:31PM +0100, Uladzislau Rezki wrote:
> 
> [snip]
> 
> >
> > > > +	struct rb_root root;
> > > > +	struct list_head head;
> > > > +	spinlock_t lock;
> > > > +};
> > > > +
> > > > +static struct vmap_node {
> > > > +	/* Bookkeeping data of this node. */
> > > > +	struct rb_list busy;
> > > > +} single;
> > >
> > > This may be a thing about encapsulation/naming or similar, but I'm a little
> > > confused as to why the rb_list type is maintained as a field rather than
> > > its fields embedded?
> > >
> > The "struct vmap_node" will be extended by the following patches in the
> > series.
> >
> 
> Yeah sorry I missed this, only realising after I sent...!
> 
> > > > +
> > > > +static struct vmap_node *vmap_nodes = &single;
> > > > +static __read_mostly unsigned int nr_vmap_nodes = 1;
> > > > +static __read_mostly unsigned int vmap_zone_size = 1;
> > >
> > > It might be worth adding a comment here explaining that we're binding to a
> > > single node for now to maintain existing behaviour (and a brief description
> > > of what these values mean - for instance what unit vmap_zone_size is
> > > expressed in?)
> > >
> > Right. Agree on it :)
> >
> 
> Indeed :)
> 
> [snip]
> 
> > > >  /* Look up the first VA which satisfies addr < va_end, NULL if none. */
> > > > -static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> > > > +static struct vmap_area *
> > > > +find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
> > > >  {
> > > >  	struct vmap_area *va = NULL;
> > > > -	struct rb_node *n = vmap_area_root.rb_node;
> > > > +	struct rb_node *n = root->rb_node;
> > > >
> > > >  	addr = (unsigned long)kasan_reset_tag((void *)addr);
> > > >
> > > > @@ -1552,12 +1583,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> > > >   */
> > > >  static void free_vmap_area(struct vmap_area *va)
> > > >  {
> > > > +	struct vmap_node *vn = addr_to_node(va->va_start);
> > > > +
> > >
> > > I'm being nitty here, and while I know it's a vmalloc convention to use
> > > 'va' and 'vm', perhaps we can break away from the super short variable name
> > > convention and use 'vnode' or something for these values?
> > >
> > > I feel people might get confused between 'vm' and 'vn' for instance.
> > >
> > vnode, varea?
> 
> I think 'vm' and 'va' are fine, just scanning through easy to mistake 'vn'
> and 'vm'. Obviously a litle nitpicky! You could replace all but a bit
> churny, so I think vn -> vnode works best imo.
> 
> [snip]
> 
> > > >  struct vmap_area *find_vmap_area(unsigned long addr)
> > > >  {
> > > > +	struct vmap_node *vn;
> > > >  	struct vmap_area *va;
> > > > +	int i, j;
> > > >
> > > > -	spin_lock(&vmap_area_lock);
> > > > -	va = __find_vmap_area(addr, &vmap_area_root);
> > > > -	spin_unlock(&vmap_area_lock);
> > > > +	/*
> > > > +	 * An addr_to_node_id(addr) converts an address to a node index
> > > > +	 * where a VA is located. If VA spans several zones and passed
> > > > +	 * addr is not the same as va->va_start, what is not common, we
> > > > +	 * may need to scan an extra nodes. See an example:
> > >
> > > For my understading when you say 'scan an extra nodes' do you mean scan
> > > just 1 extra node, or multiple? If the former I'd replace this with 'may
> > > need to scan an extra node' if the latter then 'may ened to scan extra
> > > nodes'.
> > >
> > > It's a nitty language thing, but also potentially changes the meaning of
> > > this!
> > >
> > Typo, i should replace it to: scan extra nodes.
> 
> Thanks.
> 
> >
> > > > +	 *
> > > > +	 *      <--va-->
> > > > +	 * -|-----|-----|-----|-----|-
> > > > +	 *     1     2     0     1
> > > > +	 *
> > > > +	 * VA resides in node 1 whereas it spans 1 and 2. If passed
> > > > +	 * addr is within a second node we should do extra work. We
> > > > +	 * should mention that it is rare and is a corner case from
> > > > +	 * the other hand it has to be covered.
> > >
> > > A very minor language style nit, but you've already said this is not
> > > common, I don't think you need this 'We should mention...' bit. It's not a
> > > big deal however!
> > >
> > No problem. We can remove it!
> 
> Thanks.
> 
> >
> > > > +	 */
> > > > +	i = j = addr_to_node_id(addr);
> > > > +	do {
> > > > +		vn = &vmap_nodes[i];
> > > >
> > > > -	return va;
> > > > +		spin_lock(&vn->busy.lock);
> > > > +		va = __find_vmap_area(addr, &vn->busy.root);
> > > > +		spin_unlock(&vn->busy.lock);
> > > > +
> > > > +		if (va)
> > > > +			return va;
> > > > +	} while ((i = (i + 1) % nr_vmap_nodes) != j);
> > >
> > > If you comment above suggests that only 1 extra node might need to be
> > > scanned, should we stop after one iteration?
> > >
> > Not really. Though we can improve it further to scan backward.
> 
> I think it'd be good to clarify in the comment above that the VA could span
> more than 1 node then, as the diagram seems to imply only 1 (I think just
> simply because of the example you were showing).
> 
> [snip]
> 
> > > >  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> > > >  {
> > > > +	struct vmap_node *vn;
> > > >  	struct vmap_area *va;
> > > > +	int i, j;
> > > >
> > > > -	spin_lock(&vmap_area_lock);
> > > > -	va = __find_vmap_area(addr, &vmap_area_root);
> > > > -	if (va)
> > > > -		unlink_va(va, &vmap_area_root);
> > > > -	spin_unlock(&vmap_area_lock);
> > > > +	i = j = addr_to_node_id(addr);
> > > > +	do {
> > > > +		vn = &vmap_nodes[i];
> > > >
> > > > -	return va;
> > > > +		spin_lock(&vn->busy.lock);
> > > > +		va = __find_vmap_area(addr, &vn->busy.root);
> > > > +		if (va)
> > > > +			unlink_va(va, &vn->busy.root);
> > > > +		spin_unlock(&vn->busy.lock);
> > > > +
> > > > +		if (va)
> > > > +			return va;
> > > > +	} while ((i = (i + 1) % nr_vmap_nodes) != j);
> > >
> > > Maybe worth adding a comment saying to refer to the comment in
> > > find_vmap_area() to see why this loop is necessary.
> > >
> > OK. We can do it to make it better for reading.
> 
> Thanks!
> 
> [snip]
> 
> > > > @@ -3728,8 +3804,11 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> > >
> > > Unrelated to your change but makes me feel a little unwell to see 'const
> > > char *addr'! Can we change this at some point? Or maybe I can :)
> > >
> > You are welcome :)
> 
> Haha ;) yes I think I might tbh, I have noted it down.
> 
> >
> > > >
> > > >  	remains = count;
> > > >
> > > > -	spin_lock(&vmap_area_lock);
> > > > -	va = find_vmap_area_exceed_addr((unsigned long)addr);
> > > > +	/* Hooked to node_0 so far. */
> > > > +	vn = addr_to_node(0);
> > >
> > > Why can't we use addr for this call? We already enforce the node-0 only
> > > thing by setting nr_vmap_nodes to 1 right? And won't this be potentially
> > > subtly wrong when we later increase this?
> > >
> > I used to have 0 here. But please note, it is changed by the next patch in
> > this series.
> 
> Yeah sorry, again hadn't noticed this.
> 
> [snip]
> 
> > > > +		spin_lock(&vn->busy.lock);
> > > > +		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
> > > >  		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
> > > >  				 pcpu_get_vm_areas);
> > > > +		spin_unlock(&vn->busy.lock);
> > >
> > > Hmm, before we were locking/unlocking once before the loop, now we're
> > > locking on each iteration, this seems inefficient.
> > >
> > > Seems like we need logic like:
> > >
> > > /* ... something to check nr_vms > 0 ... */
> > > struct vmap_node *last_node = NULL;
> > >
> > > for (...) {
> > > 	struct vmap_node *vnode = addr_to_node(vas[area]->va_start);
> > >
> > > 	if (vnode != last_node) {
> > > 		spin_unlock(last_node->busy.lock);
> > > 		spin_lock(vnode->busy.lock);
> > > 		last_node = vnode;
> > > 	}
> > >
> > > 	...
> > > }
> > >
> > > if (last_node)
> > > 	spin_unlock(last_node->busy.lock);
> > >
> > > To minimise the lock twiddling. What do you think?
> > >
> > This per-cpu-allocator prefetches several VA units per-cpu. I do not
> > find it as critical because it is not a hot path for the per-cpu allocator.
> > When its buffers are exhausted it does an extra prefetch. So it is not
> > frequent.
> 
> OK, sure I mean this is simpler and more readable so if not a huge perf
> concern then not a big deal.
> 
> >
> > >
> > > >  	}
> > > > -	spin_unlock(&vmap_area_lock);
> > > >
> > > >  	/*
> > > >  	 * Mark allocated areas as accessible. Do it now as a best-effort
> > > > @@ -4253,55 +4333,57 @@ bool vmalloc_dump_obj(void *object)
> > > >  {
> > > >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > >  	const void *caller;
> > > > -	struct vm_struct *vm;
> > > >  	struct vmap_area *va;
> > > > +	struct vmap_node *vn;
> > > >  	unsigned long addr;
> > > >  	unsigned int nr_pages;
> > > > +	bool success = false;
> > > >
> > > > -	if (!spin_trylock(&vmap_area_lock))
> > > > -		return false;
> > >
> > > Nitpick on style for this, I really don't know why you are removing this
> > > early exit? It's far neater to have a guard clause than to nest a whole
> > > bunch of code below.
> > >
> > Hm... I can return back as it used to be. I do not have a strong opinion here.
> 
> Yeah that'd be ideal just for readability.
> 
> [snip the rest as broadly fairly trivial comment stuff on which we agree]
> 
> >
> > Thank you for the review! I can fix the comments as separate patches if
> > no objections.
> 
> Yes, overall it's style/comment improvement stuff nothing major, feel free
> to send as follow-up patches.
> 
> I don't want to hold anything up here so for the rest, feel free to add:
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 
Appreciate! I will go through again and send out the patch that adds
more detailed explanation as requested in this review.

Again, thank you!

--
Uladzislau Rezki

