Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D427EA3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKMTcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:32:03 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601DAD71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:32:00 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso3029739fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699903919; x=1700508719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hotpoRzPNg0gMmGSMdKIMSIWB7Z31+HA7sTVFI0oz60=;
        b=dkbOIimU9YEkKvMuX9mLDFv+lxdXZ6m2q/TrzRBNLw21vwilyqO6rOiUnwvS24IPDs
         +WTsLtLt5S3e8BX8b7iYsjLOTpozPuUUFj39Y2fRIf9tHIIWDUfC48EZpzBxR+c2iC+a
         coQLitQpXzUsS4lu8gUAeDDAwxAXa3V17T7z+p14yLBmn3AguvWwfehu6m/KQZgS5Eop
         RrgutgkKb+hsMnj2ePMTag6VNW6xbn9znw82BBmPXWcwVF66M3G6rVocpWBsRquzoV6/
         qo0Vz5b+qhNhLcg4L1EwBTpC74CyK/OwZJYSLw+iAn9zcK9EffHmGyD386/Dlxc7Dnib
         uiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903919; x=1700508719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hotpoRzPNg0gMmGSMdKIMSIWB7Z31+HA7sTVFI0oz60=;
        b=QcI9xY+qiQzH8+AsreMLphKuCdgRltaEips0gDdfp5n+hKLLseX3FYYCRlnOASVMuC
         1ZyDlOVrPcZSSmVK3Tyz1tGlGxYLGx3fwnI1uI5LSRhtVY9bf6B3YVf7PrV4k+RX1slx
         6Od5CsSYrZ/7cQkE1eVnsvISDqwSEL1qs9nzyz5W+q5WMfLm5UkvqeDxpNgVCwj0bVP8
         GmNgBdffBARQTd9pMuZ0akXF+0mG/JsppJyS9Cd7iN3S0xyIAGBUkZQda7+2MXWgzcDG
         NvDbWBy7LV6iIhff5ZubFikA0UQhbl9WLbNpqIkhhKQlk+hbfYgPU1oiEX7AiWMp5Ubd
         AZQQ==
X-Gm-Message-State: AOJu0YyrSXKcRiq+n5Pkv4WjGTeQHaUZpq+5Ao4TDfOl+zSUBVhaweOQ
        Gjm7LHz7i3xgB9jOn6mrtDs=
X-Google-Smtp-Source: AGHT+IGceLoBZqM2PHMkJ5D/TxmMnFCd1Me4IF4Mq7jbX23K2p+xb+PtiIJoWTkSj3XxDyJXWH85AQ==
X-Received: by 2002:a05:6870:ed98:b0:1ea:3746:b7d6 with SMTP id fz24-20020a056870ed9800b001ea3746b7d6mr10147561oab.28.1699903919676;
        Mon, 13 Nov 2023 11:31:59 -0800 (PST)
Received: from fedora ([2600:1700:2f7d:1800::46])
        by smtp.gmail.com with ESMTPSA id m21-20020a056870a41500b001d4d8efa7f9sm1112892oal.4.2023.11.13.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:31:59 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:31:54 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 3/6] mm: memory: rename page_copy_prealloc() to
 folio_prealloc()
Message-ID: <ZVJ5qqQbr/DqZh4G@fedora>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
 <20231113152222.3495908-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113152222.3495908-4-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:22:19PM +0800, Kefeng Wang wrote:
> Let's rename page_copy_prealloc() to folio_prealloc(), which could
> be reused in more functons, as it maybe zero the new page, pass a
> new need_zero to it, and call the vma_alloc_zeroed_movable_folio()
> if need_zero is true.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 379354b35891..d85df1c59f52 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -992,12 +992,17 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	return 0;
>  }
>  
> -static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
> -		struct vm_area_struct *vma, unsigned long addr)
> +static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
> +		struct vm_area_struct *vma, unsigned long addr, bool need_zero)
>  {
>  	struct folio *new_folio;
>  
> -	new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr, false);
> +	if (need_zero)
> +		new_folio = vma_alloc_zeroed_movable_folio(vma, addr);
> +	else
> +		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> +					    addr, false);
> +
>  	if (!new_folio)
>  		return NULL;
>  
> @@ -1129,7 +1134,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>  	} else if (ret == -EBUSY) {
>  		goto out;
>  	} else if (ret ==  -EAGAIN) {
> -		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
> +		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
>  		if (!prealloc)
>  			return -ENOMEM;
>  	} else if (ret) {
> -- 
> 2.27.0
