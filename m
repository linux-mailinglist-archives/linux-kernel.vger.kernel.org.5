Return-Path: <linux-kernel+bounces-131999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D968C898E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE141F22DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1B1332A0;
	Thu,  4 Apr 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eKRGb8nQ"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4881B7F4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257008; cv=none; b=GR2FlUj2DRVelxVEP0F8utH5ow2QhDEYDdX9EkjWNldC+utBVjDegKSNM7DmvOJQaxfig9bftaDEmF2zvGC/ZkY1J3kbCox4em8Hv+3dgxaZ1C41DO2B5M3i9FGy4w89visIKd5reANU55dIxFRmcqN5yGt2AKjT94nuhikynaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257008; c=relaxed/simple;
	bh=zEG/Npqm2emOjQ4YMCXzVPh7V6SzrWE+dkLK8JN/yuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehkoXujRtbbcGYe9eHD2BW/jI2mFvbr98lKUoFGgSPIn0Lj2iLIXCvoeAuy1pTkGzXDAdkO2LqYklR1dKAllRLF5puFi/30JF5E59JhLopwHlF0nWou6nUAv8m5aR3TGmtFjftfrk7kxD3bqp4EVJ9adhxYAlHIsk8YdIZvcyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eKRGb8nQ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 11:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712257004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekgsgNqeKKjrKE6jGlMBfAf5nKQ+ack6j3G4b68ujBU=;
	b=eKRGb8nQyxQLzoJybEZ6TV2jXTmzQFx61X99Xnxraie8m4Ihh1eIgyRQMX7nbSU3zz5mig
	yJGFWw4IB0nVU6gIaB7Q16ykH1cSWZ10LOC0qb/nsfDmWzPnG+CQkn3N3ASdNRji5SniN7
	w94KrNysvhntrzVD3nBoK3P6k0vAPA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
Message-ID: <Zg7358ygxHBHUCy9@P9FQF9L96D.corp.robot.car>
References: <20240404162515.527802-1-fvdl@google.com>
 <20240404162515.527802-2-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404162515.527802-2-fvdl@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 04, 2024 at 04:25:15PM +0000, Frank van der Linden wrote:
> The hugetlb_cma code passes 0 in the order_per_bit argument to
> cma_declare_contiguous_nid (the alignment, computed using the
> page order, is correctly passed in).
> 
> This causes a bit in the cma allocation bitmap to always represent
> a 4k page, making the bitmaps potentially very large, and slower.
> 
> So, correctly pass in the order instead.
> 
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")

Hi Frank,

there is a comment just above your changes which explains why order_per_bit is 0.
Is this not true anymore? If so, please, fix the comment too. Please, clarify.

Thanks!

