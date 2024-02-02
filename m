Return-Path: <linux-kernel+bounces-50674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88506847C60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA811B20E10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E5B126F18;
	Fri,  2 Feb 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnu044rk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B183A14
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913439; cv=none; b=EGkVbUZpwWkhoBuZzQ+czS8dD2wGQdmaaGNxqDS0t6e1YOmTP1JL4wSMxX+KewFe/dX0ZNr56Ktl8H8C1cGCACRL+SMo6SKW1DmWQdbegAiPyywpnOLcnCJ3KxkPzUE94odtuJ7JrVrugh8rI9vU4lUQm+Fdo5Oi1dDHBQoKYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913439; c=relaxed/simple;
	bh=dM5dO6Fs8QhN1EWpOwbeaj6Tf111WVzMkvZscLFqlnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8F0ruczp3NoCm6Vn66B9I9R4dq81qg8qVPqOtOsUOMjPCGJIMD8eazB2VQA2x4bGVzJ02LQCe9dDq+HvS81cmR7p7P45AgaIgRYEv4YsZTIb8dUuvGsluXSqeN549dwnwefqSpLbKY4kcjRnbmpIse4VBXq0OxDYV80rNq0P5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bnu044rk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=APb3OBf6qWZ1g/Jah6Wu85MBVTLu3d/x4P/LLWjurkQ=; b=bnu044rkMR5UKXu7fdw9ABR5VD
	hL89keFXW4hcZqWewb9LESNjMllDNW+K/o+k/kZ17r7z8WCL0hJjbPdHpUgn1UUXpxvFxC0xCIw2x
	AqnF98IVns/7AFtit6T6YJSbY7Zfw4gd7AcB4UQa/c+o+xwwGqU/RCvzceBV3hZRaGVQkaBkbjpPz
	Rj9Z0/Uhw0yBusmpiuvuxpd5+8Hzx03+vk4EAOubZo6icxeH1QLml+z3OSfPhyKStgHd++dgGs6s3
	aoZlKoyWphYvk/ua88CthS5VSfHXnYqDa43kTJzOIa3rRd3LLD09H/Tp5Ea7DQbtm3uW5BLNBnxem
	FsjD+foA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rW29p-00000002G7Q-2eRN;
	Fri, 02 Feb 2024 22:37:13 +0000
Date: Fri, 2 Feb 2024 22:37:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
Message-ID: <Zb1umQTdJOM6IpNK@casper.infradead.org>
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
 <Zb0LzpBkE71wWyqO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0LzpBkE71wWyqO@smile.fi.intel.com>

On Fri, Feb 02, 2024 at 05:35:42PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> > Use a predefined limit instead of hardcoding it.
> 
> Can we apply this one?

Why are you asking me?  I don't even know what this driver is for.

