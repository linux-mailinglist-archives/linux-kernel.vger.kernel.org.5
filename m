Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A844377C014
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHNSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjHNSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB501BD5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692039142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igkdo9cOm/OvdG54WgkKwtpnvmKDjEIs5/xewVmFgn8=;
        b=CDFbb/tCmXCh0z4ve87jI1HVGajJbJkb/PzbScuz3MbRu6aO9NaWIepyERQRL9ZnLSJimS
        UHZ8afJ8f0e2f8efWpmGuHQHGjCGBHH193LNbiIVUfIiTYJk5eDXlsXNtxYGOQu1eNZBL5
        5/sWxWagq+r6vpMJS5i8WmYX4B10XLU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-X7qdfqKINtC7-ZqZLtbdYA-1; Mon, 14 Aug 2023 14:52:21 -0400
X-MC-Unique: X7qdfqKINtC7-ZqZLtbdYA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-645778904dfso8675166d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039140; x=1692643940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igkdo9cOm/OvdG54WgkKwtpnvmKDjEIs5/xewVmFgn8=;
        b=ZGikNZnJBINN4cevejoziS1ZdvtwZR5P6p57/dzplMkJfsdf7+g+2p7KEC9qNyW3Sa
         0bpNqjyNdbsbjCYDWU1Y268Zx6TC9k7qttpoIsEJ/ZW0IgcLND1KRajM50M7KP2N9nyN
         w7gSWYnYw/XeeW6oO1wCiaItDlKDq1KG635tW2jOaOQ77T23B5gKeJgXKj6T+OInwzL8
         Y0odLToRoJeA8FQMcXkbrn5YKZRUP364icbRI09hX24R2QK/0r0rRsv3vYMzoR5KMsrk
         058+pL5Hm4Zc/wobQulGx+ZcZLgqjKuXR5eKqlMHOAlCh4MEN56jGHQe4NBaQrFeNEEB
         Aw2w==
X-Gm-Message-State: AOJu0YxUWYnjK/yZxFx7XTaKbdFgCVocB9SH5GLTN0EqaEjZYziMXRZ8
        bsR1ZwNBLePoauQmxS+j3Gwp6p1wulTZ18pzhw10+THV/dwniURbhOn5qYxsBtZUhZTJjPQtGfH
        Y60RR8GOBuCix9p6QuxQ18Lgt
X-Received: by 2002:ad4:5f0f:0:b0:625:aa48:e50f with SMTP id fo15-20020ad45f0f000000b00625aa48e50fmr14434227qvb.6.1692039140491;
        Mon, 14 Aug 2023 11:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrALdj980XAQhySV6fg3YjSPRn7c73JooppkvwmK5v4lICFmqgAg6/maXEDqd7+1omZXTykg==
X-Received: by 2002:ad4:5f0f:0:b0:625:aa48:e50f with SMTP id fo15-20020ad45f0f000000b00625aa48e50fmr14434213qvb.6.1692039140266;
        Mon, 14 Aug 2023 11:52:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id q12-20020a0ce20c000000b00647290bd591sm553315qvl.121.2023.08.14.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:52:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:52:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/3] mm: Add TAIL_MAPPING_REUSED_MAX
Message-ID: <ZNp32fml0bKuFfQw@x1n>
References: <20230814184411.330496-1-peterx@redhat.com>
 <20230814184411.330496-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814184411.330496-2-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:44:09PM -0400, Peter Xu wrote:
> Tail pages have a sanity check on ->mapping fields, not all of them but
> only upon index>2.  It's because we reused ->mapping fields of the tail
> pages index=0,1 for other things.
> 
> Define a macro for "max index of tail pages that got ->mapping field
> reused" on top of folio definition, because when we grow folio tail pages
> we'd want to boost this too together.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm_types.h | 9 +++++++++
>  mm/huge_memory.c         | 6 +++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 291c05cacd48..3f2b0d46f5d6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -248,6 +248,15 @@ static inline struct page *encoded_page_ptr(struct encoded_page *page)
>  	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
>  }
>  
> +/*
> + * This macro defines the maximum tail pages (of a folio) that can have the
> + * page->mapping field reused (offset 12 for 32bits, or 24 for 64bits).
> + *
> + * When the tail page's mapping field reused, it'll be exempted from
> + * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
> + */
> +#define  TAIL_MAPPING_REUSED_MAX  (2)
> +
>  /**
>   * struct folio - Represents a contiguous set of bytes.
>   * @flags: Identical to the page flags.
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0b709d2c46c6..72f244e16dcb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2444,9 +2444,9 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  			 (1L << PG_dirty) |
>  			 LRU_GEN_MASK | LRU_REFS_MASK));
>  
> -	/* ->mapping in first and second tail page is replaced by other uses */
> -	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping != TAIL_MAPPING,
> -			page_tail);
> +	/* ->mapping in <=TAIL_MAPPING_REUSED_MAX tail pages are reused */
> +	VM_BUG_ON_PAGE(tail > TAIL_MAPPING_REUSED_MAX &&
> +		       page_tail->mapping != TAIL_MAPPING, page_tail);
>  	page_tail->mapping = head->mapping;
>  	page_tail->index = head->index + tail;

I tend to also squash this in when repost:

diff --git a/mm/internal.h b/mm/internal.h
index 02a6fd36f46e..a75df0bd1f89 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 {
        struct page *p = head + tail_idx;

-       p->mapping = TAIL_MAPPING;
+       if (tail_idx > TAIL_MAPPING_REUSED_MAX)
+               p->mapping = TAIL_MAPPING;
        set_compound_head(p, head);
        set_page_private(p, 0);
 }

-- 
Peter Xu

