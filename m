Return-Path: <linux-kernel+bounces-132111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319B7898FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B911C22C84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D27172F;
	Thu,  4 Apr 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBNua1OY"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EF1332A1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263537; cv=none; b=A/p5IdcKn2kchhQ8EaKdS66diHNLQb042xVQyfUXkA2+tybB98BefZyVWduQYJ0NIWANlWqBhVA7J+8uPzvXzcoYf9xJuGIl6lqlCbgsiQ/Bj+QT5Si/bdTi7m9IrAcdlSgfHcBZh3r9I1jeQv8rgej9JqdJreCL5/JMkGOS+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263537; c=relaxed/simple;
	bh=px7lvCRRBXkR+Wn3DGgQvajHKn/dKimr4tt9idF5QuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC/OZoApwrjm6Zj/P8+AmazwFiqwHJpq+8UUocKmbIjP2+P0IcxpRmjlJgBGHOgp9B+Mw4r7KxCDxf70qhsCOHySiimpUE/djW5EuqfoGs9g/KI7OVgW+MqqOe9NJlmjF2uCfJip1cK69cwK4i9Gn2OtlabdnUjXnvvGqlGNbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBNua1OY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 13:45:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712263532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faC9VnGInM+BsAmXSg8y4ZIaDISK1P0XMY+yn8LzviY=;
	b=xBNua1OYabSdsuCixDGVv/AQ+feNNrnBTRqGMySX+zwCzvMlxsxocgI8dM02AzPcAkipfP
	QG9H1+0JmGBFDjqVW20DCK/sstkwwCN1hfj+aqegcsnDQkRq1GgMzhJzPSAicm1rli80gQ
	962Ifs5oPx3NHdA7ODADAChniH7rV4Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
Message-ID: <Zg8RZzYccpbqQ_ni@P9FQF9L96D.corp.robot.car>
References: <20240404162515.527802-1-fvdl@google.com>
 <20240404162515.527802-2-fvdl@google.com>
 <Zg7358ygxHBHUCy9@P9FQF9L96D.corp.robot.car>
 <CAPTztWYH5ANR2cYidf+frC2HBJiz6UUh5wC5khHJg8R-gYbcFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWYH5ANR2cYidf+frC2HBJiz6UUh5wC5khHJg8R-gYbcFw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 12:40:58PM -0700, Frank van der Linden wrote:
> On Thu, Apr 4, 2024 at 11:56 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Thu, Apr 04, 2024 at 04:25:15PM +0000, Frank van der Linden wrote:
> > > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > > cma_declare_contiguous_nid (the alignment, computed using the
> > > page order, is correctly passed in).
> > >
> > > This causes a bit in the cma allocation bitmap to always represent
> > > a 4k page, making the bitmaps potentially very large, and slower.
> > >
> > > So, correctly pass in the order instead.
> > >
> > > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> >
> > Hi Frank,
> >
> > there is a comment just above your changes which explains why order_per_bit is 0.
> > Is this not true anymore? If so, please, fix the comment too. Please, clarify.
> >
> > Thanks!
> 
> Hi Roman,
> 
> I'm assuming you're referring to this comment:
> 
> /*
>  * Note that 'order per bit' is based on smallest size that
>  * may be returned to CMA allocator in the case of
>  * huge page demotion.
>  */
> 
> That comment was added in a01f43901cfb9 ("hugetlb: be sure to free
> demoted CMA pages to CMA").
> 
> It talks about HUGETLB_PAGE_ORDER being the minimum order being given
> back to the CMA allocator (after hugetlb demotion), therefore
> order_per_bit must be HUGETLB_PAGE_ORDER. See the commit message for
> that commit:
> 
> "Therefore, at region setup time we use HUGETLB_PAGE_ORDER as the
> smallest possible huge page size that can be given back to CMA."
> 
> But the commit, while correctly changing the alignment, left the
> order_per_bit argument at 0,  even though it clearly intended to set
> it at HUGETLB_PAGE_ORDER. The confusion may have been that
> cma_declare_contiguous_nid has 9 arguments, several of which can be
> left at 0 meaning 'use default', so it's easy to misread.
> 
> In other words, the comment was correct, but the code was not. After
> this patch, comment and code match.

Indeed the mentioned commit which added a comment which was not aligned
with the code was confusing. It all makes sense now, thank you for
the explanation!

Please, feel free to add
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for your patch.

Thanks!

