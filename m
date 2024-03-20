Return-Path: <linux-kernel+bounces-109459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A473881981
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA70C1C209DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE041C65;
	Wed, 20 Mar 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMMXw7e8"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154091EB45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974185; cv=none; b=BM1iDYR0Gw7ez6fTeRN3WwRo9TRvews6Vi34xLggiBmTcKMBc0Exs2TT9qoo3s8eH56PGrofO9a92Szi4YT2fMNYDyMNfROr4w+ga3y9eWO478MtiR6l0IS8aKNIolLNVGkNVtsuEYvo5DtXowwnOVtZ1tfUACmf98NcZtnJ8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974185; c=relaxed/simple;
	bh=w4+WlveuzgqPZikAmvyx2NEP17PqNOHdzBDbDqmano0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuF4PCSdjpFKfRDCLB29j1skWIFCzmCK1E8sehfelA3WndQ2W9DGbPlSO0ECk59wXbZoDudfeucEXQsULVsjq3x1EQ7zxy4YvTfcXr7VaaeRfJp5XYka5wq9bmTB1d6axbsnT3VF1vc/zMo8h5bL0PdmYCINTtYZPsnhne2qPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMMXw7e8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Mar 2024 15:36:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710974178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4+WlveuzgqPZikAmvyx2NEP17PqNOHdzBDbDqmano0=;
	b=FMMXw7e8c2juESOCHR7WKcGaCYyV/ITXLNsnQa0XTJbQnxl2TkHAUJeu2ligkjUQ3RwMeS
	YlqqsGfVch8wvfdBsjZm9OMOMD9AYqssFNi/JdT6S+CInwnJofJDTQ/9a4AP5DXALmCE2m
	3DGM91uQKYDj4yFkIDNpnsXz49ecDhg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Message-ID: <Zftk3tzC2btb3Ine@P9FQF9L96D>
References: <20240320202745.740843-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320202745.740843-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 20, 2024 at 04:27:45PM -0400, Johannes Weiner wrote:
> CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
> tracking is enabled. It has been default-enabled and equivalent to
> CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
> accounting sites since, and there is no imaginable cgroup usecase
> going forward that wants to track user pages but not the multitude of
> user-drivable kernel allocations.

I totally support it. I believe one of the reasons for it to exist
was SLOB, which hasn't been supporting the slab memory accounting.
No such reasons anymore.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

