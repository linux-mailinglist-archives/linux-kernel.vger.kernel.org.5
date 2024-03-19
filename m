Return-Path: <linux-kernel+bounces-107271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B230C87FA30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7271F22227
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4657BAEC;
	Tue, 19 Mar 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tZ+bL052";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lH0K/9oM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9364CF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838542; cv=none; b=s8ICaaGGDnvVUHnMG39s3DNqp9UAbD0nPHiBF9oVI5Oe2bA108ue6o3lhWyImSCqTQZndhkBhzYlTj0Fkx4y8S/XFByO4Kl7E1gYexsuT9QYbu7x0tb7DiAvRcRBCojVGftPVL+ONl7ippBzIC0m8elk/s52CZI+613HMOUvnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838542; c=relaxed/simple;
	bh=Uznf1KwgK9s2Mcf/Bly2P4ZSBE9X2zZg7VY56gZtXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRTJQDVpYqaohcaEInUENHPUTOaX/6wUfn3zpF3MG5i7JN7obE/HyxIBCbeI7VnmlZkY4FySIZ/W3BSHggVoIVfVco5+5i1Cx7WhlNUYUTn7iOktN4VjZzmqaASHvV7PDbRpKgJK+P8x3DP3EdioiCBYSzIjZjMcLrwoRsV5gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tZ+bL052; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lH0K/9oM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C0473758D;
	Tue, 19 Mar 2024 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710838539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evAYXOFBXt4csSBHICmFoB7rcjRm+TO2+pNemXSDrBk=;
	b=tZ+bL052w7tmINzoF2vUse5Q+bwsa4dPUXomKo8GVdZk08Q5zdbRHWPvjUp8kxSrRWbz+n
	2GAE/DIbTPQewF7HHZym+DbQ/GuWgimCKgGOlABQ/rObzxpce9NG2QMdytcSvVcqTw74KC
	25ltxQ97LeGXFBYzUtExuSfF3sB/A/k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710838538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evAYXOFBXt4csSBHICmFoB7rcjRm+TO2+pNemXSDrBk=;
	b=lH0K/9oM59893VPS0KVZsBsOgPPFMEgrQINcSXqg4z8Tamf9M1sIkrysFFx/9s4wr+GM0X
	35fcExSEsNk7LmjT9z9MiaI3aX82RD9wFj4pT3Zemzu+hAc/wNmyVlZ7MlfC2+IpFua/mk
	YoK9EQ9o1T7uc5tocENqYRudRWP/vug=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F23CF136A5;
	Tue, 19 Mar 2024 08:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PscXOAlT+WV5CAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 19 Mar 2024 08:55:37 +0000
Date: Tue, 19 Mar 2024 09:55:37 +0100
From: Michal Hocko <mhocko@suse.com>
To: liuhailong@oppo.com
Cc: akpm@linux-foundation.org, nathan@kernel.org, ndesaulniers@google.com,
	trix@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, surenb@google.com, zhaoyang.huang@unisoc.com,
	quic_charante@quicinc.com, yuzhao@google.com
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Message-ID: <ZflTCY-Oaxm0U70u@tiehlicka>
References: <20240314141516.31747-1-liuhailong@oppo.com>
 <20240315081803.2223-1-liuhailong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315081803.2223-1-liuhailong@oppo.com>
X-Spam-Score: -1.36
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oppo.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.35)[76.32%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="lH0K/9oM"
X-Rspamd-Queue-Id: 1C0473758D

On Fri 15-03-24 16:18:03, liuhailong@oppo.com wrote:
> From: "Hailong.Liu" <liuhailong@oppo.com>
> 
> This reverts
> commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not eligible")
> commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")
> 
> skip_cma may cause system not responding. if cma pages is large in lru_list
> and system is in lowmemory, many tasks would direct reclaim and waste
> cpu time to isolate_lru_pages and return.
> 
> Test this patch on android-5.15 8G device
> reproducer:
> - cma_declare_contiguous 3G pages
> - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
>   only.
> - run a memleak process in userspace

Does this represent a sane configuration? CMA memory is unusable for
kernel allocations and memleak process is also hard to reclaim due to
swap suppression. Isn't such a system doomed to struggle to reclaim any
memory? Btw. how does the same setup behave with the regular LRU
implementation? My guess would be that it would struggle as well.
-- 
Michal Hocko
SUSE Labs

