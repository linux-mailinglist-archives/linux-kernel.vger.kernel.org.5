Return-Path: <linux-kernel+bounces-45130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E55842C03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48D12892EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F078B69;
	Tue, 30 Jan 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa0wGiTD"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA178B62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640290; cv=none; b=IrjuKjSPkmGNPs5B2mMUYjg3LIOmGNtScJWARBd6eTj8sgolVVAuhV+WiUhquhXj4FGZJpp4BGIuLQuKEOGgXPe92oHlgt5qwGJBxpRc5OBzj4OXpnlbv+9eOO2FtKTQ7GYB8ujPrijmSoxHvsDRlpFZgiS80evfkMXOaGbAqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640290; c=relaxed/simple;
	bh=qjQgfYW+YVSOhmZaoEU1OClokv2wKqG7mr2nxxA718w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxbDByjkirfNUI7T2CKUd1Ij040NjZVgeS1Dc3VPf7ZqDlxPPZO09m27ck9dPsDOEYAB67XtHBsDn2EZeNoHl9+yT7wgbTHzJPgtgH3u2dQl3hWTwqxw0sHd3pqunko510e8dXqaqDa5svB/riRbI8LpIB2glDkxp2xTfZFatNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa0wGiTD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5111e5e4e2bso1156458e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706640286; x=1707245086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z23OMEfQd2Zd5DlteZNRvp4RWaGbggWiP82btYQ5h+0=;
        b=Fa0wGiTDHzRDoCBnIMgUpDXevCwkAN4X05Nim80gG50ameLjqqcok6tJtaxTTWH//6
         n4FK4wFdLocjwBk7olbBZb/pXSVMtxKqM5Awj60s5aO08G5PrG8CMXHCea6EbL3VxRkY
         GtR7BE7gdwJUHcxtTks4AFZe/tPTQx8k5YzC6TT8YnzG10jav+SAToRnBCylaRQsKfAN
         i5TVmXtdd7a0BNyelG1JjKr7tAeTo/lkwzs9PzL+GmbkqvPYK1ukRz2SX71loaSKbZhb
         wDKTGWwJgdLH2XmCnUKq6h6qGcf/VmZsUwjAkenUSsF/gjQ6GmKOYJ0GFZP+uyE6dkbN
         iAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640286; x=1707245086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z23OMEfQd2Zd5DlteZNRvp4RWaGbggWiP82btYQ5h+0=;
        b=CQv13mtFQ6q6RZIAam3UMYKyo0jeHrAY6otZbR1gdaVNgAXmOIgTMzf1s7T1gUxWNp
         k41N1vspXP8ASN2bbxHvXtS3X5QAf60+YYgzoIQ8x3Ln4tt2fKA4BOs0j5vYUa5usX8N
         4OpMiBZNdZHIxV5OHavt/xfarpP3umlPAQ4RJmKlSGQpXluMCEpMH1k0kokSoftrsTBE
         CHo8NnQVUOPNr6zeFB2t3426cKGU+AripJzy8PKdT5hG0CtN0TEdnlqcqdPcJv7YMUEA
         tKL+JRfH08Ipj2iPncXX+bK42Z9ZK226eqZ4ED+OyG3Hlv49u4vEzQWHncJtYuA93xuF
         Bvcg==
X-Gm-Message-State: AOJu0YzW5EB5mnB41++CXGx9M1q+2/j4Mh3Yxwu+wBbRKE3EEReRzjcP
	NhrFag9Lqcv6TrNTVpQHodArLU0REOL4QAA9yJTgj7CpUsz+DzyV
X-Google-Smtp-Source: AGHT+IFsFS9OlQA2eeVPaXbz2RO+arsZ/guxCPFD1BkQX+5M8YBVxvWI8aH7kUmWAG3PJ6cmvJ+vKQ==
X-Received: by 2002:a05:6512:2247:b0:511:b42:1711 with SMTP id i7-20020a056512224700b005110b421711mr6396693lfu.29.1706640285904;
        Tue, 30 Jan 2024 10:44:45 -0800 (PST)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b0040ee51f1025sm12843362wmb.43.2024.01.30.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:44:44 -0800 (PST)
Date: Tue, 30 Jan 2024 18:44:43 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] mm: vmalloc: Improve description of vmap node layer
Message-ID: <97342c5a-3d16-477d-9e75-25d54b3bc082@lucifer.local>
References: <20240124180920.50725-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124180920.50725-1-urezki@gmail.com>

On Wed, Jan 24, 2024 at 07:09:19PM +0100, Uladzislau Rezki (Sony) wrote:
> This patch adds extra explanation of recently added vmap
> node layer based on community feedback. No functional change.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 60 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 14 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 257981e37936..b8be601b056d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -765,9 +765,10 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
>  static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
>
>  /*
> - * An effective vmap-node logic. Users make use of nodes instead
> - * of a global heap. It allows to balance an access and mitigate
> - * contention.
> + * This structure defines a single, solid model where a list and
> + * rb-tree are part of one entity protected by the lock. Nodes are
> + * sorted in ascending order, thus for O(1) access to left/right
> + * neighbors a list is used as well as for sequential traversal.
>   */
>  struct rb_list {
>  	struct rb_root root;
> @@ -775,16 +776,23 @@ struct rb_list {
>  	spinlock_t lock;
>  };
>
> +/*
> + * A fast size storage contains VAs up to 1M size. A pool consists
> + * of linked between each other ready to go VAs of certain sizes.
> + * An index in the pool-array corresponds to number of pages + 1.
> + */
> +#define MAX_VA_SIZE_PAGES 256
> +
>  struct vmap_pool {
>  	struct list_head head;
>  	unsigned long len;
>  };
>
>  /*
> - * A fast size storage contains VAs up to 1M size.
> + * An effective vmap-node logic. Users make use of nodes instead
> + * of a global heap. It allows to balance an access and mitigate
> + * contention.
>   */
> -#define MAX_VA_SIZE_PAGES 256
> -
>  static struct vmap_node {
>  	/* Simple size segregated storage. */
>  	struct vmap_pool pool[MAX_VA_SIZE_PAGES];
> @@ -803,6 +811,11 @@ static struct vmap_node {
>  	unsigned long nr_purged;
>  } single;
>
> +/*
> + * Initial setup consists of one single node, i.e. a balancing
> + * is fully disabled. Later on, after vmap is initialized these
> + * parameters are updated based on a system capacity.
> + */
>  static struct vmap_node *vmap_nodes = &single;
>  static __read_mostly unsigned int nr_vmap_nodes = 1;
>  static __read_mostly unsigned int vmap_zone_size = 1;
> @@ -2048,7 +2061,12 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
>  			}
>  		}
>
> -		/* Attach the pool back if it has been partly decayed. */
> +		/*
> +		 * Attach the pool back if it has been partly decayed.
> +		 * Please note, it is supposed that nobody(other contexts)
> +		 * can populate the pool therefore a simple list replace
> +		 * operation takes place here.
> +		 */
>  		if (!full_decay && !list_empty(&tmp_list)) {
>  			spin_lock(&vn->pool_lock);
>  			list_replace_init(&tmp_list, &vn->pool[i].head);
> @@ -2257,16 +2275,14 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	 * An addr_to_node_id(addr) converts an address to a node index
>  	 * where a VA is located. If VA spans several zones and passed
>  	 * addr is not the same as va->va_start, what is not common, we
> -	 * may need to scan an extra nodes. See an example:
> +	 * may need to scan extra nodes. See an example:
>  	 *
> -	 *      <--va-->
> +	 *      <----va---->
>  	 * -|-----|-----|-----|-----|-
>  	 *     1     2     0     1
>  	 *
> -	 * VA resides in node 1 whereas it spans 1 and 2. If passed
> -	 * addr is within a second node we should do extra work. We
> -	 * should mention that it is rare and is a corner case from
> -	 * the other hand it has to be covered.
> +	 * VA resides in node 1 whereas it spans 1, 2 an 0. If passed
> +	 * addr is within 2 or 0 nodes we should do extra work.
>  	 */
>  	i = j = addr_to_node_id(addr);
>  	do {
> @@ -2289,6 +2305,9 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  	struct vmap_area *va;
>  	int i, j;
>
> +	/*
> +	 * Check the comment in the find_vmap_area() about the loop.
> +	 */
>  	i = j = addr_to_node_id(addr);
>  	do {
>  		vn = &vmap_nodes[i];
> @@ -4882,7 +4901,20 @@ static void vmap_init_nodes(void)
>  	int i, n;
>
>  #if BITS_PER_LONG == 64
> -	/* A high threshold of max nodes is fixed and bound to 128. */
> +	/*
> +	 * A high threshold of max nodes is fixed and bound to 128,
> +	 * thus a scale factor is 1 for systems where number of cores
> +	 * are less or equal to specified threshold.
> +	 *
> +	 * As for NUMA-aware notes. For bigger systems, for example
> +	 * NUMA with multi-sockets, where we can end-up with thousands
> +	 * of cores in total, a "sub-numa-clustering" should be added.
> +	 *
> +	 * In this case a NUMA domain is considered as a single entity
> +	 * with dedicated sub-nodes in it which describe one group or
> +	 * set of cores. Therefore a per-domain purging is supposed to
> +	 * be added as well as a per-domain balancing.
> +	 */
>  	n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
>
>  	if (n > 1) {
> --
> 2.39.2
>

Looks good to me (sorry for delay, busy with many things in life :)! Feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

