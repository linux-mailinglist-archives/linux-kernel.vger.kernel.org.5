Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679427F5BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjKWKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjKWKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:06:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6DD62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:06:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2358DC433C8;
        Thu, 23 Nov 2023 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700734013;
        bh=hHlmaaenY3K3RyRqebqvCpM/Pdx7EFiDr57xLbhkwmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOskhRiejjbd78wVpvIEcuUhnWfPA/pMYa8JaotvzigQozPtoR53EOFVp27EIjpJo
         5NxxIBE0GcNP1T0HnntGtFY3PF4Ap0FNWwrKkqOr4kfGfMvhpnkcwWHVHH+hPHVfaO
         kB3uLYjpi6SzP/SH56dNJFAaM26cXAYy1kDjNJftAZRqetJDs/ZoY5Q3ikskMdSRQE
         GfR2ZbRFSW29XywgSoZH9cQJH0NWqBYwmBsxDSsboP2pwk0Ty49hLlCxYofICXQGUd
         0Tz92uuuOIG7VDOYgkAHIs8lMY24XAR++o6Dcv6mXkoVjP2cob+/+CR401JTNq5S/2
         QzGJOhC/pHYFA==
Date:   Thu, 23 Nov 2023 12:06:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm/mm_init.c: Append '\n' to the unavailable ranges
 log-message
Message-ID: <20231123100638.GE636165@kernel.org>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-7-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122182419.30633-7-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:24:04PM +0300, Serge Semin wrote:
> Based on the init_unavailable_range() method and it's callee semantics no
> multi-line info messages are intended to be printed to the console. Thus
> append the '\n' symbol to the respective info string.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3fa33e2d32ba..db8b91175834 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -827,7 +827,7 @@ static void __init init_unavailable_range(unsigned long spfn,
>  	}
>  
>  	if (pgcnt)
> -		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
> +		pr_info("On node %d, zone %s: %lld pages in unavailable ranges\n",
>  			node, zone_names[zone], pgcnt);
>  }
>  
> -- 
> 2.42.1
> 

-- 
Sincerely yours,
Mike.
