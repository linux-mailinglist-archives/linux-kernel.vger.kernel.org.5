Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886F780238F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjLCL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCL6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:58:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EAFE6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:58:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7623C433CA;
        Sun,  3 Dec 2023 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701604707;
        bh=pziQ1U7QdvFt6jazsNDQct2z9qMxwW1lVib4eO04oAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUojLJ0D+hYzFpx4UrmEnt9hX3wdMqFvaPaScNdRJdBUkFxOK1TgiKTlQA2imiz1s
         Skxn+cTAEJn+ljsDkSEMFy6RotyZEf1HHA+eExaEgkxR6pz74CYXB9ujxCIn52F6bb
         EnmjraVq10aj62PL9SvsO/gowrBB7a1dSx5kbhdE6egTVL+10D8duPz3mFV3GtQtLI
         dvdAxoXf2IXlKZXq4LV+TN9wB1Hrw4UD9xL6+ONRE7YxrMg11jPbRzh4x9d5lpsAUy
         LV7TN9ebLHkYgrT6QIOORyT7xIYLG+w40wV+i5W9Lw+BSooqjNZRKsM2MJdJPMsZl6
         7jI5bQTF5NFtQ==
Date:   Sun, 3 Dec 2023 13:58:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mm_init.c: Extend init unavailable range doc info
Message-ID: <20231203115815.GM636165@kernel.org>
References: <20231202111855.18392-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202111855.18392-1-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 02:18:52PM +0300, Serge Semin wrote:
> Besides of the already described reasons the pages backended memory holes
> might present due to having non-memory regions covered by the contiguous
> flatmem mapping. Add such note to the init_unavailable_range() method kdoc
> in order to point out to one more reason of having the function executed
> for such regions.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> 
> ---
> 
> Link: https://lore.kernel.org/linux-mips/20231122182419.30633-6-fancer.lancer@gmail.com/
> Changelog v2:
> - The holes in the memory are actually justified by having the flatmem
>   mapping model. Change the patch and the log accordingly. (@Mike)
> ---
>  mm/mm_init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 077bfe393b5e..824bf53e8253 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * - physical memory bank size is not necessarily the exact multiple of the
>   *   arbitrary section size
>   * - early reserved memory may not be listed in memblock.memory
> + * - non-memory regions covered by the contigious flatmem mapping
>   * - memory layouts defined with memmap= kernel parameter may not align
>   *   nicely with memmap sections
>   *
> -- 
> 2.42.1
> 

-- 
Sincerely yours,
Mike.
