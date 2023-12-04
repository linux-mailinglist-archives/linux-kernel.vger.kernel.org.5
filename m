Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA4803C27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjLDR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjLDR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F429A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701712781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=y/n3XETFOZPx/XYOME4s/DOGADFc/e3GNu9UPa/MpLQ=;
        b=bBLGQVAdLnONkT+70vZu+M62KpObm5rEiuZvbTTLFBPWY+SsDaR3NXktoFocfI2BRfzxUY
        7aRnnf0pRjzNoVLOV4Fd89V2v9Llg0ZxZ63AFLsTbD04fK6Uvbz5PDVAavu+nqayLy0HO1
        svJ7kvoAe2ZtBNQegSRZS6zIvvoN0/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-ffLt5CB5MfiV7s8tqbF5lg-1; Mon, 04 Dec 2023 12:59:40 -0500
X-MC-Unique: ffLt5CB5MfiV7s8tqbF5lg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333354a9242so1179559f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712779; x=1702317579;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/n3XETFOZPx/XYOME4s/DOGADFc/e3GNu9UPa/MpLQ=;
        b=rG5Fcbzf0KpUSvp19I5mfelapLP6GMSFAX7QlR4Zf45s/SiZ3PWSssNW4Q35TJtgTm
         OtAIJolmvc568h7Xp/SiYVYnpI9QALclzLMr8d65Srqb8BfNgmzV9MzvIw579v02D1+U
         N60oChc6a5+CtZVXJzUpCfsubDo2YLRgs/OS3tJXyS4gTLnXuo9ImhH3cRdNiGC5tNDe
         8hmneGT93MnXD3v7qEXQ1iKdz26T5/+fzHx4eyW40y0/LuxdNIGeyVSqBkJDKx/sB7jW
         4XPFyqCdc3uOq/HhKT92LN2ihOT2rsNTS3f01O55fwZ3gMKUoMKL0xazcs16KezhlXpx
         4V1g==
X-Gm-Message-State: AOJu0YxHmQtL0pr44RWmFRt82bsgzkE/SFaRPiV36AYYBj4bRiizB6W3
        5HH4JiHc1XFwDdkP08c7jsHAg05f5IbdQtqpwmJy+OajOE7vsKsLGSNQeFSvLqLduhotKYHC6Zy
        Liw4/ZisTxWV1H2LhlxBq5YGPd8nl9BLt+lkIBgEwfoAJCs/bFqa39c+Mo4HtsYgXEsGpKK4RF7
        iJXCwk
X-Received: by 2002:a05:600c:a0a:b0:40b:5e56:7b5d with SMTP id z10-20020a05600c0a0a00b0040b5e567b5dmr3150309wmp.166.1701712778926;
        Mon, 04 Dec 2023 09:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt/l7AeQDswbm7Ci4IBH0mEfB75rib92wPfAuefYCyEyivuiO0RMgqmbHbUiO4LvRSUXDLCQ==
X-Received: by 2002:a05:600c:a0a:b0:40b:5e56:7b5d with SMTP id z10-20020a05600c0a0a00b0040b5e567b5dmr3150290wmp.166.1701712778457;
        Mon, 04 Dec 2023 09:59:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b004030e8ff964sm19635029wmq.34.2023.12.04.09.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:59:38 -0800 (PST)
Message-ID: <1120cff5-df34-47ab-86ca-d73887fcba2e@redhat.com>
Date:   Mon, 4 Dec 2023 18:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204142146.91437-35-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline void __page_dup_rmap(struct page *page, bool compound)
> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,
> +		struct page *page, unsigned int nr_pages,
> +		struct vm_area_struct *src_vma, enum rmap_mode mode)
>   {
> -	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
> +	int i;
>   
> -	if (compound) {
> -		struct folio *folio = (struct folio *)page;
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>   
> -		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
> -		atomic_inc(&folio->_entire_mapcount);
> -	} else {
> -		atomic_inc(&page->_mapcount);
> +	/*
> +	 * No need to check+clear for already shared PTEs/PMDs of the folio.
> +	 * This includes PTE mappings of (order-0) KSM folios.
> +	 */
> +	if (likely(mode == RMAP_MODE_PTE)) {
> +		for (i = 0; i < nr_pages; i++) {
> +			if (PageAnonExclusive(page + i))
> +				goto clear;
> +		}
> +	} else if (mode == RMAP_MODE_PMD) {
> +		if (PageAnonExclusive(page))
> +			goto clear;
>   	}
> +	goto dup;
> +
> +clear:
> +	/*
> +	 * If this folio may have been pinned by the parent process,
> +	 * don't allow to duplicate the mappings but instead require to e.g.,
> +	 * copy the subpage immediately for the child so that we'll always
> +	 * guarantee the pinned folio won't be randomly replaced in the
> +	 * future on write faults.
> +	 */
> +	if (likely(!folio_is_device_private(folio) &&
> +	    unlikely(folio_needs_cow_for_dma(src_vma, folio))))
> +		return -EBUSY;
> +
> +	if (likely(mode == RMAP_MODE_PTE)) {
> +		for (i = 0; i < nr_pages; i++)
> +			ClearPageAnonExclusive(page + i);
> +	} else if (mode == RMAP_MODE_PMD) {
> +		ClearPageAnonExclusive(page);
> +	}
> +
> +dup:
> +	__folio_dup_rmap(folio, page, nr_pages, mode);
> +	return 0;

Playing with this, I think it can be implemented more efficiently by 
only looping once and optimizing for the common case that PAE is set. 
Will have to do some more measurements.

-- 
Cheers,

David / dhildenb

