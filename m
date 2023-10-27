Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84507D8F90
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJ0HUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:20:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7291B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=knFFWaxiSZ20rjITXNXLCDkayOSwhys26Z492Thl3YA=; b=Rdt2ooQ3LndpAFYw0vgpBfYpeH
        vr/ZMSBLCnJ8he0mHI03vJ4WAp22Epk/eKWPlAKzKa2/1VtFzDowgxBd3pQZbtvhXmuo7em4sf4KK
        OQ+pQiWH0htQsz4/D43QU998IxwbtItYQmLxGewlgjIYTrGh1h/bq39HDy3lmnrEu4wLqPzwMW7uF
        IbX7oy1U0QE3rfKmrcRn8NWIkVEnQTJ6wWtS041I3G1m853AzREy7Ew20bYXKpReXGcnpFTtQ2z+G
        vyR2mx0zrpOikvTdrrGT3pHlZycdHOoDMnVST7mj3Mlp0cxoOtlU1iU+ONFccKY5f44XXWDrAaaik
        l8SzZ2GQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwH8M-00Fm2m-0e;
        Fri, 27 Oct 2023 07:19:54 +0000
Message-ID: <e969ed08-3492-4bac-8f4f-a7e3a59da6f0@infradead.org>
Date:   Fri, 27 Oct 2023 00:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix multiple typos in multiple files
Content-Language: en-US
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        willy@infradead.org, James.Bottomley@hansenpartnership.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231027064345.2434-1-zhaimingbing@cmss.chinamobile.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231027064345.2434-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/26/23 23:43, zhaimingbing wrote:
> 	nommu.c: Fix typo 'privatize'
> 	io-mapping.c: Fix typo 'pre-validation'
> 
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> ---
>  mm/io-mapping.c | 2 +-
>  mm/nommu.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/io-mapping.c b/mm/io-mapping.c
> index 01b362799..486598ba4 100644
> --- a/mm/io-mapping.c
> +++ b/mm/io-mapping.c
> @@ -21,7 +21,7 @@ int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
>  	if (WARN_ON_ONCE((vma->vm_flags & expected_flags) != expected_flags))
>  		return -EINVAL;
>  
> -	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
> +	/* We rely on pre-validation of the io-mapping to skip track_pfn(). */

Not needed. The hyphen seems to be optional from what I see on the internet.

>  	return remap_pfn_range_notrack(vma, addr, pfn, size,
>  		__pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
>  			 (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK)));
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 7f9e9e5a0..40842b080 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -776,7 +776,7 @@ static int validate_mmap_request(struct file *file,
>  			if (!(capabilities & NOMMU_MAP_DIRECT))
>  				return -ENODEV;
>  
> -			/* we mustn't privatise shared mappings */
> +			/* we mustn't privatize shared mappings */

We accept British spellings. :)

>  			capabilities &= ~NOMMU_MAP_COPY;
>  		} else {
>  			/* we're going to read the file into private memory we

Thanks.
-- 
~Randy
