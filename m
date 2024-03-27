Return-Path: <linux-kernel+bounces-121623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52A88EAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBDF28EBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255C130A6A;
	Wed, 27 Mar 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IavBJGsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBA12F596
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556524; cv=none; b=qCyIVoKmhyuqIcI6UVMhklMwBOaTpxK2RY/9FbrykryqlBRYUQNML7vQqq/yCHLEMumy9n4LCcQ1OIN2pFoaNQlkArMGAgTiwMixnMAHvWB72fjxvrJiQPyfzDcMNeg7I3g6J62b7SZWSXj5jEelNM89L9JSlddwRjCvlzpQQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556524; c=relaxed/simple;
	bh=/HwfEIPp2rgEplQNov6HPpeEoXKzTzryrZH4IYBxJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQSr/lk138eOTm4D5DP6CGxpzAK/owgCK3z6VTAoIyQN+vZQcuf502CIn5YLT47zzlDLH9P4F/NLV5gCOhKYhjfBLJh3AJ5voer+Ev5FTncHc9AaC5bWvk8y8DoW6bzqUdSxR8luYy1RrcmXVAdnswyp5bDxhHu6+huMPUu/XAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IavBJGsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE561C433C7;
	Wed, 27 Mar 2024 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556524;
	bh=/HwfEIPp2rgEplQNov6HPpeEoXKzTzryrZH4IYBxJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IavBJGszFmAlc2pEn+zfe6ZTmvjuzS8OniqKBl3fq326ok4Z1/lQIFhubB5J3YlF+
	 UJ7cH6fmsukvoIbMe+qb0s38Dpb5PZkO6MeQepUNQjTYesXIsI7Tt6Okk8maBGjSOE
	 2ZjVJLDIGgdH9xzzcM3kKRi0rqL4LQ0EAJjGeovCvCD4A6h/kwamy8QttJ8EIgV/zp
	 IzQAw0jKezVA3KsiiT8nk7Tn7rm+KI1haka80NRE9CgIVAe6TudWIlsqAq3Su1BT8/
	 j2oRBxYxdj1bTB2sEPjNeWwA+TXigfhS5Lc9NBty0edAy6fDSDCpgqHNsZ1UG/5piz
	 SSHvZMjybuQKQ==
Date: Wed, 27 Mar 2024 18:21:20 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 5/6] mm/mm_init.c: remove unneeded calc_memmap_size()
Message-ID: <ZgRHgL1zbQc2DJlc@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-6-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:45PM +0800, Baoquan He wrote:
> Nobody calls calc_memmap_size() now.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

Looks like I replied to patch 6/6 twice by mistake and missed this one.

> ---
>  mm/mm_init.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7f71e56e83f3..e269a724f70e 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1331,26 +1331,6 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
>  }
>  
> -static unsigned long __init calc_memmap_size(unsigned long spanned_pages,
> -						unsigned long present_pages)
> -{
> -	unsigned long pages = spanned_pages;
> -
> -	/*
> -	 * Provide a more accurate estimation if there are holes within
> -	 * the zone and SPARSEMEM is in use. If there are holes within the
> -	 * zone, each populated memory region may cost us one or two extra
> -	 * memmap pages due to alignment because memmap pages for each
> -	 * populated regions may not be naturally aligned on page boundary.
> -	 * So the (present_pages >> 4) heuristic is a tradeoff for that.
> -	 */
> -	if (spanned_pages > present_pages + (present_pages >> 4) &&
> -	    IS_ENABLED(CONFIG_SPARSEMEM))
> -		pages = present_pages;
> -
> -	return PAGE_ALIGN(pages * sizeof(struct page)) >> PAGE_SHIFT;
> -}
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void pgdat_init_split_queue(struct pglist_data *pgdat)
>  {
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.

