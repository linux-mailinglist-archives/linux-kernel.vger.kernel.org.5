Return-Path: <linux-kernel+bounces-104020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0487C7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFAC1F215DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB545D527;
	Fri, 15 Mar 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dg1GUQdd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585479E4;
	Fri, 15 Mar 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473539; cv=none; b=u5724EELGDSkFEyE+rAVP7Iu57YzUtWhwdvraFmHl94bsy3Qprb53XwisYX9Pjbs1MYInDGbQ3lwuPoEaNoGfildT4JSKQ0OGGP9+mxIgTA3hncAPk4f54iQM7Yng6R6ZS4nRKUsJKjoNv3uic7QoudK7GosN+KqzWAzRb0o/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473539; c=relaxed/simple;
	bh=8VLFOIqPwuPQnFOYSW2sEHKRMpO4TAf/nX3Cvyrj9BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjuM7ZzFVBbF8iIQbnqPDe9VvOS6KlKmmhi0Y25Mv/8xlqEJKa3NOcH/LZstp4tqDZOo1H8WatojbQFxl7u4sJRQRkxCdkra0pQUHg4BFTPBwonGTOjxXygveLYhDI5Fow+NU6uIIwSGME2tDmEH0XNyp5AMGWt9/m0rveZRw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dg1GUQdd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xad6TWdMoCDKHkALF6smFbmrqhCsydxlR9/cUgdVc/A=; b=Dg1GUQddeltBm36mqGgTIuCRNm
	sSXQfxqSRXod/5TL7O9KLuAPUTAAP4l/ZxtMRPtwMkv1Xz1md29Zsy4VIcfz1q4HMLOkJEjyVNXms
	yhHMm7bKxYbh70eg/g/kaTytL4hmggcwgf8+3si4c1qxU+joJ//Y7uokTYlkxHo+06fSAs0ptd48e
	UDWWzqiqWgm2qlRaG5O81hbF/VaamV/qlXlCbX2a32DJRdj1t6qRwIG3GIXywMjTxy/fc6g4WzB11
	nCOUMZq4ldpo8KFOgZQk1uRQ6iJnOC4uUaNM3SL8elrqqAkDFZLk09uYUqAawtoy6aomE69VlKVea
	D80ilLQw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkyIl-00000009Lp3-11Ss;
	Fri, 15 Mar 2024 03:32:11 +0000
Date: Fri, 15 Mar 2024 03:32:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  99fbb6bfc1:  will-it-scale.per_process_ops
 -4.7% regression
Message-ID: <ZfPBOyONqBnhUa3R@casper.infradead.org>
References: <202403151058.7048f6a8-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403151058.7048f6a8-oliver.sang@intel.com>

On Fri, Mar 15, 2024 at 11:07:58AM +0800, kernel test robot wrote:
> kernel test robot noticed a -4.7% regression of will-it-scale.per_process_ops on:
> 
> commit: 99fbb6bfc16f202adc411ad5d353db214750d121 ("mm: make folios_put() the basis of release_pages()")

I was kind of hoping you'd report this before it hit Linus' tree ...
I did post it last August without any response from the bot, and it's
been in Andrew's tree for a couple of weeks.  Is there a better way
to draw the attention of the performance bots?

> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: page_fault2

OK, this makes sense.  mmap(128MB, MAP_PRIVATE), write to all the pages,
then unmap them.  That's going to throw 32k pages at the page freeing
path.

Can you add this patch and rerun the test?

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 87cc678adc85..67f10b8810a8 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -11,8 +11,8 @@
 
 #include <linux/types.h>
 
-/* 15 pointers + header align the folio_batch structure to a power of two */
-#define PAGEVEC_SIZE	15
+/* 31 pointers + header align the folio_batch structure to a power of two */
+#define PAGEVEC_SIZE	31
 
 struct folio;
 

