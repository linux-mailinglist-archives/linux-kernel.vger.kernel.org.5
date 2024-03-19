Return-Path: <linux-kernel+bounces-107601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5687FEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA51C22BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C818060A;
	Tue, 19 Mar 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HNys9iGe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HNys9iGe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147A2B9A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855646; cv=none; b=mQMQYE+CEaipGt0i3Sm3zz+MAIWc9EanoqSFkAAMppNHXL1vYTC3eMEpL0XI4/OwGMcxa6I0AyjfPccFIqlua3dxXuCNEs+wa99a87+qeUlxJTu8OrMk+kn4e5eiaE4ZMPiyBZLtBHgVUw7OZIdiuStglDPG7lI/eiHwbfgdzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855646; c=relaxed/simple;
	bh=63oP/O63tle25p4dXnRwpLxRWoEsPPqahgfFN+0CMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or4dB8IFwCrQ+FXB+Uivk9HWLP4VKlFldwPoTkHg6QOvuataDNd4hangspoq+03jkThrrgEkBdUYL5A1PCjWMV/nIHNC8SG/Ms7jFhr7F9LgdkNmfajhgkWl8woYKddecBfQwCuWLmKmhQV1LlEtaYRk296ihyg0kRwKZe/Chhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HNys9iGe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HNys9iGe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F5495D714;
	Tue, 19 Mar 2024 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710855643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPnsq29Wc/buvWIEmuCObK4jFQyJYrkPVaoqmvReZ3g=;
	b=HNys9iGe2SR/wFIjkvSlF8NHw/ARy1KUUGVVXmmib3rYzIqtQMQgy7Tc/LDPFq57vSrfqP
	4AePwczBpK/GQevULP+7L6FytLrElZJcjZUf6qUhw9mMAKz3hd4FPqV6z+1qIRh4/AONiG
	IeKogcEvtKvKAtvAoXV+EkA8cw09sEc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710855643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPnsq29Wc/buvWIEmuCObK4jFQyJYrkPVaoqmvReZ3g=;
	b=HNys9iGe2SR/wFIjkvSlF8NHw/ARy1KUUGVVXmmib3rYzIqtQMQgy7Tc/LDPFq57vSrfqP
	4AePwczBpK/GQevULP+7L6FytLrElZJcjZUf6qUhw9mMAKz3hd4FPqV6z+1qIRh4/AONiG
	IeKogcEvtKvKAtvAoXV+EkA8cw09sEc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F0C136A5;
	Tue, 19 Mar 2024 13:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AIUdLdqV+WWraQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 19 Mar 2024 13:40:42 +0000
Date: Tue, 19 Mar 2024 14:40:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: liuhailong@oppo.com, akpm@linux-foundation.org, nathan@kernel.org,
	ndesaulniers@google.com, trix@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	surenb@google.com, zhaoyang.huang@unisoc.com,
	quic_charante@quicinc.com, yuzhao@google.com
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Message-ID: <ZfmV0uEMgZ2Dzdnm@tiehlicka>
References: <20240314141516.31747-1-liuhailong@oppo.com>
 <20240315081803.2223-1-liuhailong@oppo.com>
 <ZflTCY-Oaxm0U70u@tiehlicka>
 <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.82
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.42%]
X-Spam-Flag: NO

On Tue 19-03-24 19:09:18, Barry Song wrote:
> On Tue, Mar 19, 2024 at 4:56 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 15-03-24 16:18:03, liuhailong@oppo.com wrote:
> > > From: "Hailong.Liu" <liuhailong@oppo.com>
> > >
> > > This reverts
> > > commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not eligible")
> > > commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")
> > >
> > > skip_cma may cause system not responding. if cma pages is large in lru_list
> > > and system is in lowmemory, many tasks would direct reclaim and waste
> > > cpu time to isolate_lru_pages and return.
> > >
> > > Test this patch on android-5.15 8G device
> > > reproducer:
> > > - cma_declare_contiguous 3G pages
> > > - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
> > >   only.
> > > - run a memleak process in userspace
> >
> > Does this represent a sane configuration? CMA memory is unusable for
> > kernel allocations and memleak process is also hard to reclaim due to
> > swap suppression. Isn't such a system doomed to struggle to reclaim any
> > memory? Btw. how does the same setup behave with the regular LRU
> > implementation? My guess would be that it would struggle as well.
> 
> I assume the regular LRU implementation you are talking about is the LRU
> without skip_cma()?

No, I mean standard LRU reclaim implementation rather than MGLRU.

-- 
Michal Hocko
SUSE Labs

