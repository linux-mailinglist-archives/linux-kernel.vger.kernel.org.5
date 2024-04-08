Return-Path: <linux-kernel+bounces-134715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC189B5EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FD52816AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08117EF;
	Mon,  8 Apr 2024 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="DZSxrMlg";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="l79Tm+jv"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D91366
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543054; cv=none; b=ZqsWfcbhEPv+KyItAC8oI7YEa2GXCChxq4lXxdfeDSIzS56j3lz9TdDoB45zUbyqm4vANFlJJPPdfjkeyYYGbYDXNhvbtgjjhAtz0rUaK+iyPY4sf1tb5P9gK0vm0t7hdUDotMrRLI7Y6MiGLNXsAcotS0j0pMR05QwWw+uVMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543054; c=relaxed/simple;
	bh=Uhe7xxY/EqJ1uhSxNwXgRLgvAtBQsAk+dSMLtVlxeEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2HkR0Q+NzEa1LrSl2sDPHkMz7STSyCbZr/58DQ+hEym+FbMiPnKY21X9Gmhr/yBXaZ6cfY6LrKLQqFI54zIIkTwgyBlWAuynnPw6MnvJfb4dlSM6JnN9TCAdmaoBHvnlAkFHvy7/QfkOCL0bZmgNAlbBygniS+DpdPviuBoJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=DZSxrMlg; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=l79Tm+jv; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 01AE1C021; Mon,  8 Apr 2024 04:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712543050; bh=k9KOHVhmmHb/n/rH2DpqF4maaKDgCrhTDdUKq2DH+cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZSxrMlgxjjF+GADnfWRhdsMKcUJnI1u40oOWKms4GZDNIRbqzVNxH/4+O0gTxj1r
	 ly6B3UNyZ16hP1z6OSRA++M1QH4LFvegkhuZYnVo5fZhtPmcst+NvYVYNF/H+6WzEm
	 2c2jVKIG2hXwz+Eu9ep/1GsqzOC7s9Ru+ptHiboWjyVLfkYrPDfu9iMDaOUfQcdwKo
	 PFWSNO3s0ON2upGOpKcX91JRZKUlQHvpm7hqTK76jd5CN/w7KCRdtJB5J7m8cKj6rY
	 YhKs9eMAdif8x2nbFA+c/8bUXhTzS0r9B/FujGT/zu7fYJfdbudIMtS9oM5bqa/z6z
	 Yhjj5/7Kgcbnw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 5EA30C009;
	Mon,  8 Apr 2024 04:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712543048; bh=k9KOHVhmmHb/n/rH2DpqF4maaKDgCrhTDdUKq2DH+cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l79Tm+jvDYzHB8li/VrMsXohZk8H7rrFBOkj7xXpHbNxZzHPrEopddFR5cQPFDQsy
	 +AcTARC3B76tSuWe6yN9XMurLLh3PDo8w5DvUzlvFxJM6k69rqV5k3KPOHyj/ac939
	 uu+0IXTjf/xD4SpOv3nXr9aVSjAawaM+4UXdDCkhBNprKwZ3+N8Xjx3sxShCUCjxie
	 QttyzHKq2aVwfPNzn48i69Wj5hOnzAHEEmrNkqOSwoPKLEnHKLm6XusqdWMpvYLVr+
	 pOf79kVXEUT4FHikAPAJ95/T8MbK45sYYz/EQMit29xYlwcc/H86lZP5fOIwgkIix7
	 9/iO+TWX8eTNg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 34fff3ff;
	Mon, 8 Apr 2024 02:24:01 +0000 (UTC)
Date: Mon, 8 Apr 2024 11:23:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/9p: fix uninit-value in p9_client_rpc()
Message-ID: <ZhNVMivKCCq6wir0@codewreck.org>
References: <20240405113540.20456-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405113540.20456-1-n.zhandarovich@fintech.ru>

Nikita Zhandarovich wrote on Fri, Apr 05, 2024 at 04:35:40AM -0700:
> Syzbot with the help of KMSAN reported the following error:
> 
> BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
> BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
>  trace_9p_client_res include/trace/events/9p.h:146 [inline]
>  p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
>  p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
>  v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
>  v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
>  vfs_get_tree+0xa7/0x570 fs/super.c:1797
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page mm/slub.c:2175 [inline]
>  allocate_slab mm/slub.c:2338 [inline]
>  new_slab+0x2de/0x1400 mm/slub.c:2391
>  ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
>  __slab_alloc mm/slub.c:3610 [inline]
>  __slab_alloc_node mm/slub.c:3663 [inline]
>  slab_alloc_node mm/slub.c:3835 [inline]
>  kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
>  p9_tag_alloc net/9p/client.c:278 [inline]
>  p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
>  p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
>  p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
>  v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
>  v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
>  legacy_get_tree+0x114/0x290 fs/fs_context.c:662
>  vfs_get_tree+0xa7/0x570 fs/super.c:1797
>  do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
>  path_mount+0x742/0x1f20 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount+0x725/0x810 fs/namespace.c:3875
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> If p9_check_errors() fails early in p9_client_rpc(), req->rc.tag
> will not be properly initialized. However, trace_9p_client_res()
> ends up trying to print it out anyway before p9_client_rpc()
> finishes.

Good find.
Indeed, tc side is setup properly in p9_tag_alloc() but the rc side can
be left uninit.

Given we do initialize tc side perhaps it's best to initialize rc
similarly in p9_tag_alloc() (eh, there's also some initialization done
in p9pdu_reset that's not used anywhere else... this code could use some
cleanup too), but that's probably overoptimizing it, happy to roll with
that.

I'd appreciate if we could make these initial values something invalid
though -- there is no '0' value for id in the protocol so that one is
fine, but tag=0 is going to be very common so let's initialize it as
P9_NOTAG instead.

I'll move p9pdu_reset code to p9_fcall_init in a later non-fix commit
after you send v2.

> 
> Fix this issue by assigning default values to p9_fcall fields
> such as 'tag' and (just in case KMSAN unearths something new) 'id'
> during the tag allocation stage.
> 
> Reported-and-tested-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
> Fixes: 348b59012e5c ("net/9p: Convert net/9p protocol dumps to tracepoints")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> P.S. Not entirely sure that 'Fixes' tag is fully correct here.

Right there's been quite some rework there, the probe has been added at
this point and I believe the bug has always been present from a quick
look at the code so it's proably correct, but it might not be easy to
backport.
Let's leave it as is.

Thanks,
-- 
Dominique Martinet | Asmadeus

