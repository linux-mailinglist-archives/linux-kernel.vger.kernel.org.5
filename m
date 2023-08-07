Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55151771976
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjHGFcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:32:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777110EB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7277561480
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E15C433C8;
        Mon,  7 Aug 2023 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691386332;
        bh=Nx33dZHqYps2LYUm/QBXsjpmf7uARmP1F3mLqF1K4lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiUVl9PsDHH/Ak6HhKuKR0mNY0qc0g6L6J05y1ZwVpcmaPuxjZQ7uxFIKZhhrunhL
         +mZMMAlyKNIoGfndfUNW7yoCIGRZyhcPcIY7yRZpqz4BlYZHnUJ+fN6TAUV33dNMft
         yzMWmyRFAOrp1ifPMbb0IucPe6pGmRPipXLEXi5QSP6OFJlY/nplFpdIhyUU9zag0i
         aaQO0DsBGCjN4KpLWQqzAtIetv8kJQ4RZLsE4m4GCltVzDArn3Sa1Ij8bpuii6GvSN
         BwFx0oFE/D+u9b9ncSRDfE6JZPOdBLBnqguktESDdaJMzybj6T8iFG5ji5fY5Pr9sP
         VI/8xxWNFkpgw==
Date:   Mon, 7 Aug 2023 08:31:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] mm/mm_init: use helper macro BITS_PER_LONG and
 BITS_PER_BYTE
Message-ID: <20230807053123.GJ2607694@kernel.org>
References: <20230807023528.325191-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807023528.325191-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:35:28AM +0800, Miaohe Lin wrote:
> It's more readable to use helper macro BITS_PER_LONG and BITS_PER_BYTE.
> No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2:
>   use BITS_PER_BYTE per Mike.
>   Collect Reviewed-by tag per David.
>   Thanks both.
> ---
>  mm/mm_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 66aca3f6accd..93b1febd4a32 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
>  	int shift, width;
>  	unsigned long or_mask, add_mask;
>  
> -	shift = 8 * sizeof(unsigned long);
> +	shift = BITS_PER_LONG;
>  	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
>  		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
>  	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
> @@ -1431,9 +1431,9 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>  	usemapsize = roundup(zonesize, pageblock_nr_pages);
>  	usemapsize = usemapsize >> pageblock_order;
>  	usemapsize *= NR_PAGEBLOCK_BITS;
> -	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
> +	usemapsize = roundup(usemapsize, BITS_PER_LONG);
>  
> -	return usemapsize / 8;
> +	return usemapsize / BITS_PER_BYTE;
>  }
>  
>  static void __ref setup_usemap(struct zone *zone)
> -- 
> 2.33.0
> 

-- 
Sincerely yours,
Mike.
