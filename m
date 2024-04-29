Return-Path: <linux-kernel+bounces-162598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF918B5DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16F41C21D24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1A81AB4;
	Mon, 29 Apr 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U/ADFdM7"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37F7C09E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404983; cv=none; b=Mo2ydMyomv0n/9P2wHLIxN1gMthBGx684RE/CxcYQvGicSorm6nNZT5mZaxhqem/CMFDJcG4DpaLTeQK1jSA7pMObdgR9YSjh+P5W6qTTgkOzQttxKSZyP7XH6aMHGg5I4pwqKq8Up+OkhxKTiM+2zYwyBedTxO0fcHG0oWR5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404983; c=relaxed/simple;
	bh=u2SqR4xY4qqz6czR1VJmSTq5N17r8ruEGaFZQngeBBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RViEKrFrAONDwLlzh6FuicoV8aXq0QuaRwcGkpQrH6uNOx7uGqfWz83nAlUJbhlPcdOfreZ0gihc10UKyY12R1JDp4KuMKiVe0X81mRanCb4wsZ7FJTXufu70YujXRm2Qze27VdYV/llnNXiVRFmPnrWyloZgDi57HWZSnm1YQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/ADFdM7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 08:36:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714404977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pgIU5d1obfciNK5ZO1w/49MA6EFqpbOPs15zytydTc=;
	b=U/ADFdM745j3hf4HRTQdWUpmPhb8wVUiIyzqLow8fCO10A54hhEZu6tUEL7b6qBL3Ou5W/
	qZ9qenQ3UEK8vQtoKjKTkfGih6rcDrb8BMmzbUjncKkZzatMPVFUWyxsf3/8ktLwcxAx13
	+1mLbgkRziwZfUw+QY3UPftp2vEuDFc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] memcg: reduce memory size of
 mem_cgroup_events_index
Message-ID: <Zi--bEqvwJHXqTLL@P9FQF9L96D>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427003733.3898961-2-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 05:37:27PM -0700, Shakeel Butt wrote:
> mem_cgroup_events_index is a translation table to get the right index of
> the memcg relevant entry for the general vm_event_item. At the moment,
> it is defined as integer array. However on a typical system the max
> entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
> use int as storage type of the array. For now just use int8_t as type
> and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
> touches 127.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

