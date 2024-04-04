Return-Path: <linux-kernel+bounces-132115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529A898FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF93E1F2430F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453513AA56;
	Thu,  4 Apr 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+IjTsu7"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D34763FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263982; cv=none; b=LBFRmbL/EB1EHhyReCw/U16FNRU6yKnXV4m2T2UJCXGXLWYTqnIKZrNRLgQooD4XYOGO5gsO+1zoRjrSR11O3DwUMwt2z+X3V4q9ZWMj2rp9vU57jLIPZl5BSGvMzArzt9NT1coDvBRIroyMNgZag+m6AeuY17wsn4IOqOOecQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263982; c=relaxed/simple;
	bh=PiaspA+F9jooN9C8YxL2FbnplrMNjouAklcbZejZSI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/UYjm6WFZw1zahV9ZTFnSDVviGVP+mp6H6ca9cL2RQgR9/PFjvoOa7VLgKjhniGZV+6J8vhK5cKzEqwwx2AGV0I+rSQqO6Kk/NtlxLtPqMhW1vKz58487JfTaLoPBFx8B5rC2GUJgO4rNqVujZExzKOz483kESvCu+6f4PnYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+IjTsu7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 13:52:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712263979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9agO9kC3t1/Wq0yV+pf2SQotdgdN2JIuAhDFcUHIGHs=;
	b=Z+IjTsu7logIWE4MddiQ8AW0Ang6UYIrUFbKUXQYqOxWRzHQKfsBLTDevCzq6HhkqlT0ld
	CB/d0dloDAJJl7XjJgHGNNUa+fYgpyDOTi7Ox/eV2O/Yg5MaIdgPRoxBhUSiZwTfRXHGah
	OlpDE4nRGbsehUZcOud9zk8E9D5/ogk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
Message-ID: <Zg8TJ3CERBAdJRTd@P9FQF9L96D.corp.robot.car>
References: <20240404162515.527802-1-fvdl@google.com>
 <20240404162515.527802-2-fvdl@google.com>
 <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 10:13:21PM +0200, David Hildenbrand wrote:
> On 04.04.24 18:25, Frank van der Linden wrote:
> > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > cma_declare_contiguous_nid (the alignment, computed using the
> > page order, is correctly passed in).
> > 
> > This causes a bit in the cma allocation bitmap to always represent
> > a 4k page, making the bitmaps potentially very large, and slower.
> > 
> > So, correctly pass in the order instead.
> > 
> > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> 
> It might be subopimal, but do we call it a "BUG" that needs "fixing". I
> know, controversial :)

We probably should not rush with a stable backporting, especially given your
next comment on page sizes on arm.

