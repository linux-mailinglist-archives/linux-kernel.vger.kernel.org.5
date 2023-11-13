Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3947EA3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKMTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKMTva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:51:30 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375B132
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:51:26 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af20c488so57817407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699905085; x=1700509885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2lstRegQrjo3/tFDGD0ypKnw40CbFMYKLzrPxFGG+0=;
        b=SYpdKERJnhhmwhWOYxrloaeFCPs6POq4zstk+rwk8TFIpOhfzvfO2KCAUSFumPu1Oa
         ETCzuGGEfUpSGKp7m8aBX6TtH6HQp9BPIhhWbY4KuzHlxmcLHkk2QezRskp+gerzarm3
         A4HBKp8gak9zly/Gx7Y2jl7Epx5eeGsAam+4EW5Mx798UtgTKcjOIOPLuEeWslwPAjTb
         5J5gqzTmT2IY+UrTK83qPU9NnmOcmc2URElo2l6niVM6R63nWUyHeClsSbubxgbO85LI
         psPbjh0XcVq3sO/6o30Ia1P1OeX94nQ7WaPEMfmrwJE+pn27aMApRiyxuFFyfqvTEL7m
         5S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699905085; x=1700509885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2lstRegQrjo3/tFDGD0ypKnw40CbFMYKLzrPxFGG+0=;
        b=dbYmBl8YtwkgVxamL8RVPFzgSa25q+MXkXK/gx/Eqp31B9fJ7EnV8GJdReAuOizUrt
         8IMQzJ4qVJHtk6jb3xdMQmCo2MiF9rFN5i/hwBYL4h6yQ/Ngbv0Qvp6zpCIgxJu6sguL
         kSE18xbGRwPZRMuzLAp3DAzNUJYGVy1ZPcAwk0viustuaG8eutdFA23Gef41u5OmQU1u
         YocGn6JUo7xGRs3C4EQDdDZy3wAnVeK9HiL21QgUz3lqaM0aMbKSunqdHWW8XJkrhYgH
         O4i8FnhnTTeTsMGb4tFGohsRCxUjep/2i7+ul6aJ3RGdvyIVeAafz51GHIKBAZOzzjJ2
         x8mQ==
X-Gm-Message-State: AOJu0YzvdWfjpafvS1+HNMEa5NAA60ogErwO3euv5Fq/z0/nrbU1Uadk
        AqTz3lc6gHSp3319w4Fm6YY=
X-Google-Smtp-Source: AGHT+IHu9QXLrm505wbLh4b5vFFepaQ9/4r1ubLWoF6jdnj9a/8AROq8qcHKy5Z8Og7zA3rTAs+wYw==
X-Received: by 2002:a0d:d74d:0:b0:5a7:d86c:988 with SMTP id z74-20020a0dd74d000000b005a7d86c0988mr7930048ywd.28.1699905085379;
        Mon, 13 Nov 2023 11:51:25 -0800 (PST)
Received: from fedora ([2600:1700:2f7d:1800::46])
        by smtp.gmail.com with ESMTPSA id h73-20020a816c4c000000b00582fae92aa7sm1957340ywc.93.2023.11.13.11.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 11:51:24 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:51:22 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 4/6] mm: memory: use a folio in do_cow_page()
Message-ID: <ZVJ+Og+SX2l1SQxI@fedora>
References: <20231113152222.3495908-1-wangkefeng.wang@huawei.com>
 <20231113152222.3495908-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113152222.3495908-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:22:20PM +0800, Kefeng Wang wrote:
> Use folio_prealloc() helper and convert to use a folio in
> do_cow_page(), which save five compound_head() calls.

s/do_cow_page()/do_cow_fault()/

Aside from that,
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d85df1c59f52..f350ab2a324f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4653,6 +4653,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct folio *folio;
>  	vm_fault_t ret;
>  
>  	ret = vmf_can_call_fault(vmf);
> @@ -4661,16 +4662,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>  	if (ret)
>  		return ret;
>  
> -	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
> -	if (!vmf->cow_page)
> +	folio = folio_prealloc(vma->vm_mm, vma, vmf->address, false);
> +	if (!folio)
>  		return VM_FAULT_OOM;
>  
> -	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
> -				GFP_KERNEL)) {
> -		put_page(vmf->cow_page);
> -		return VM_FAULT_OOM;
> -	}
> -	folio_throttle_swaprate(page_folio(vmf->cow_page), GFP_KERNEL);
> +	vmf->cow_page = &folio->page;
>  
>  	ret = __do_fault(vmf);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> @@ -4679,7 +4675,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>  		return ret;
>  
>  	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
> -	__SetPageUptodate(vmf->cow_page);
> +	__folio_mark_uptodate(folio);
>  
>  	ret |= finish_fault(vmf);
>  	unlock_page(vmf->page);
> @@ -4688,7 +4684,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>  		goto uncharge_out;
>  	return ret;
>  uncharge_out:
> -	put_page(vmf->cow_page);
> +	folio_put(folio);
>  	return ret;
>  }
>  
> -- 
> 2.27.0
