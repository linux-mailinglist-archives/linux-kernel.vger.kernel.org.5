Return-Path: <linux-kernel+bounces-67573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46F856DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22FCB25134
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE613A240;
	Thu, 15 Feb 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jUrJy3Pf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD813956C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025173; cv=none; b=PK7PtfGBJu9x9H223jaMQbGcYF40kB8zg2nnAotBNq9qoroVADVj3JJyEMv2iCK31pLxM6XvoZnDkhQkLbRmKJugukAv219/bNiczfhP/+7XLF0G/E9vhZhsBulFB9Y7m0OlP8PuYHnHZXXFy2gt5F4p88EGjOgP6WHaAPpFPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025173; c=relaxed/simple;
	bh=0oSEEi9BR842uBQn+HVEGnH5l5zaquhPajknu+34sHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz3vTtnR/7nbF8EprpdzqRQp3gJBVUSvUri+5MXP3TTiaz8B40/hDnUvNMJyXI2QAfHRwDIZShjPE8tVtIdpvJcwa+ZTckkxfQoUS286UxaAgnOH21o+pN5IL4dte1Qg4Or7LTWP33DfPZ8wbpiFje+8x3eFuS9OUO3X22Nwvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jUrJy3Pf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P4QD/ybns2/Bgpbe3KYdtzHKfNJTrHM+ftFWOfy2J0w=; b=jUrJy3PfE4KJcZTW8kZOD25Zu7
	nQCYSvKD6rDLOqK3K8s/lEr9mkfz0c0700RMj8KQFIrhROQjqOcfGePF7esPr1gcMqN/n3ptt7jFp
	m5UNlH+kNMXRv6rXJpIv2YPhU21fWNQ49WpKHzR/1I6GR7gzLnx0lB9xFUJZ4HtaDesKPuFnzGRWq
	Lt+usireCP1cricIQzDIH+4C1PKBwnGR3+YMrixekZEIZ/2U+yl2PoAiCvDMtsZSb1Su0LjPgh/+9
	1mdkmuSKgmyw9jQ2eDe7G1q/1QTnpYCSK2PCF7Ge6z+/Hx5+zo/WXchuU+s3v1fbuPT34h+Soe7sc
	o0weYslw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rahN3-00000002ek0-1Ovh;
	Thu, 15 Feb 2024 19:26:09 +0000
Date: Thu, 15 Feb 2024 19:26:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/14] linux/mm.h: move page_size() to mm/page_size.h
Message-ID: <Zc5lUbCU6xNXv6jC@casper.infradead.org>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-7-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145602.1371274-7-max.kellermann@ionos.com>

On Thu, Feb 15, 2024 at 03:55:54PM +0100, Max Kellermann wrote:
> Prepare to reduce dependencies in linux/mm.h.

We're really close to eliminating page_size().  Just 23 callers left.
As such, it would be a mistake to name the header after it.  I don't
particularly like how you're splitting up mm.h; I think the real problem
is all the code that says "Oh, I'm allocating memory, I should include
mm.h" instead of including gfp.h or slab.h.

But if you must split it like this, at least call it folio_size.h


