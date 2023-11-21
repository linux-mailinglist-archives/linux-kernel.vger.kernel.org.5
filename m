Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85B87F3423
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjKUQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKUQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:46:17 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E6191;
        Tue, 21 Nov 2023 08:46:12 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ca164bc0bbso27352847b3.3;
        Tue, 21 Nov 2023 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700585172; x=1701189972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTjTeR6ZPalJseQYqmfsMOl0WKPRmFx/E/5HJrg4U0M=;
        b=mrg/ZMCMeXJNVNlh9IlQetoOcopWNl/6mFzYN6FW2slMwCLmG5sz3jv9MS1PZs1XTu
         6F3Ej1P5Zb774sBwijxMhy8ZYPCjI/RKQQb8v8fxg19upJdtXBt2ZRzvgQXiy0Ihf1GA
         D4O+BA4LbvN4u4w/40vEGRKUHmUEutDAAX0USvRpAgKP3u7DpxXjJxy0cy/W1COZM8SG
         MM7EPFGV2Yjza/ZwVUO70M4GzOdbUu0yHN4+aq/YmpRbKMuS77a+Ol3/QKIBr9ZgEN22
         CMVs69SaKJAvl6G9MIe53DhEG+Uo/Q3tBN6zJTULUnvgBDq+IQqf1jwBgMDezRvqbLXe
         9i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700585172; x=1701189972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTjTeR6ZPalJseQYqmfsMOl0WKPRmFx/E/5HJrg4U0M=;
        b=lzIHhpje9Dd0CXlbvx6d+d36vZsbdkSYNNxsoZJMhcWiYx0GCg1qRpeCkPFwDcjuIK
         9Q5aDDDHFmPimVfvJRr76cJ0ux3GNCZZxoD68j+Bunp4MoQIXLVpFI6ZYEQrayhdmf+R
         yt7krfCBUCZz1eHOLZeRuTZZmfb6M8s9bubKjHtWmuFLLhJtG3EnvANOozMHBlQBN1PG
         FAbL5tEn+/awvCAyfnqxE/Io93lZRHitv8sYIsl+ZbpM0koVfncjJWE0P71u61dmTN2q
         TwzrBeLoJ46Y4uloOFdZAQ/ooZ/Ir0JOkWskcfgOirLS73+tQEWisRaQU5lQisWszRKD
         Qhpg==
X-Gm-Message-State: AOJu0YzMMGKzUBCBuIkca0I9rcd04bzubx2MsE917sQ5PTxu50MCre7h
        +puL1zfa9iCozLsr10yZD9qsATwieXU=
X-Google-Smtp-Source: AGHT+IFg+2OBmlB8+ldAAybnLE+vIEKH5SHD4vI3ZcF3/RJqXNwgitLYiDXbYw+qOTpp3uN3Me+SUA==
X-Received: by 2002:a0d:e2c6:0:b0:58f:a19f:2b79 with SMTP id l189-20020a0de2c6000000b0058fa19f2b79mr11495216ywe.9.1700585171782;
        Tue, 21 Nov 2023 08:46:11 -0800 (PST)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.gmail.com with ESMTPSA id i133-20020a81548b000000b005a206896d62sm3143442ywb.111.2023.11.21.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 08:46:11 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:46:08 -0800
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v2] pgtable: do not expose _refcount field via ptdesc
Message-ID: <ZVze0PgnDqnsmiCM@unknowna0e70b2ca394.attlocal.net>
References: <20231121120310.696335-1-agordeev@linux.ibm.com>
 <20231121144717.6318-A-hca@linux.ibm.com>
 <ZVzQkTueDRSJ76me@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzQkTueDRSJ76me@tuxmaker.boeblingen.de.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:45:21PM +0100, Alexander Gordeev wrote:
> Since commit d08d4e7cd6bf ("s390/mm: use full 4KB page for 2KB PTE")
> _refcount field is not used for fragmented page tracking on s390 and
> there is no other code left that accesses this field explicitly.
> 
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/mm_types.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 957ce38768b2..ce0cfc6e4d94 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -401,11 +401,11 @@ FOLIO_MATCH(compound_head, _head_2a);
>   * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
>   * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
>   * @pt_mm:            Used for x86 pgds.
> - * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
>   * @_pt_pad_2:        Padding to ensure proper alignment.
>   * @ptl:              Lock for the page table.
>   * @__page_type:      Same as page->page_type. Unused for page tables.
> - * @_refcount:        Same as page refcount. Used for s390 page tables.
> + * @_pt_pad_3:        Padding that aliases with page's refcount.

I like updating the documentation, but I'd rather see _refcount renamed
to __page_refcount similar to the other unused page fields. _pt_pad_*
is used for variables that aren't present in struct page (and are
required for padding).

>   * @pt_memcg_data:    Memcg data. Tracked for page tables here.
>   *
>   * This struct overlays struct page for now. Do not modify without a good
> @@ -438,7 +438,7 @@ struct ptdesc {
>  #endif
>  	};
>  	unsigned int __page_type;
> -	atomic_t _refcount;
> +	unsigned int _pt_pad_3;
>  #ifdef CONFIG_MEMCG
>  	unsigned long pt_memcg_data;
>  #endif
> @@ -452,7 +452,6 @@ TABLE_MATCH(compound_head, _pt_pad_1);
>  TABLE_MATCH(mapping, __page_mapping);
>  TABLE_MATCH(rcu_head, pt_rcu_head);
>  TABLE_MATCH(page_type, __page_type);
> -TABLE_MATCH(_refcount, _refcount);

Its still a good idea to keep this check. In the case of !CONFIG_MEMCG,
_refcount is the last variable of ptdesc and if some change were to happen
that caused it to be misaligned we will want to know.

>  #ifdef CONFIG_MEMCG
>  TABLE_MATCH(memcg_data, pt_memcg_data);
>  #endif
> -- 
> 2.39.2
> 
> 
