Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C77857BF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbjHWMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjHWMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFEFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692792910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFwWSzRs0xwFrDqvvFOgPgLU8OzIU2Ty0NqzM9qwE2U=;
        b=WWv6+LkA+DkM3ithJP2EkGdGwTqjbrO0fTobJ9FpircDB6a8TkFonmf4y1MlUxPukrscZE
        ztj5wCalNPVJJPHcYjggegNhNPwuhNg4D24Bh4EzqvQu9+lVN2+kQreOm1B3+xbXcEoB6X
        E5/nMaYYfq/OhBUZXx/OaOUPcWuVlYk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-yULEDqlZMcWj-PgJJzF0kw-1; Wed, 23 Aug 2023 08:15:09 -0400
X-MC-Unique: yULEDqlZMcWj-PgJJzF0kw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so37087795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792908; x=1693397708;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFwWSzRs0xwFrDqvvFOgPgLU8OzIU2Ty0NqzM9qwE2U=;
        b=j73oMfPTCg8w6EN2iaSbTO7CVBZyj4DLaBw0lQLBZmUoayf3442hxwNptwbahhWqUi
         nIbnHv1X4rnnQR57YDbb0RIn/uPJuRht3VpWXbYbolUdtjfz9j1C8A4YvHpFyjDGuOvQ
         D+eNXlFf08bNC1ZLYh/Lhve0U9f7HeNRD1RjG3s2a4PN9oe1xh3jF06sMssCiudjSp+R
         IzM1fqjuVsIXR2gcIuh7X3NGOXb7xOiK3kO0Nsmx336YgEkDWoZ81zXp4Yo7an5y9IFL
         XbjYy/NWzRMX29tKMG+7ykb5EyLXPGgentJ7ZT7Pd1L21I6lf+L+WTZCnYFW2pdCkxHP
         Yc6w==
X-Gm-Message-State: AOJu0YzuGwx4SFTcEgGAVHE66COfv5swhKpIb56fkRv/UiE7iJCcPJdI
        nIbqSuZZrMegXcjeVdYP1z9wOBauaPd0Nkuv96Q6WJ+LIIXJge6veolQ56txrBnm0pVo9vAr0U6
        nfe+JZr3/IjevlvGyJXXhx6Cw4XaEPKzL43AiMTUb+aFN6fLvWKMlO63jHrxRCWCGxt9//KqZFc
        AZH41A
X-Received: by 2002:a7b:c5d2:0:b0:3fe:15e7:c8a1 with SMTP id n18-20020a7bc5d2000000b003fe15e7c8a1mr9728630wmk.16.1692792908442;
        Wed, 23 Aug 2023 05:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG28nStaH2pAlw8WpvCGW2tEuMAfhtZM10vfd40F/qfUC7bXlTCBmTUICuBOgWznLA2QpUulw==
X-Received: by 2002:a7b:c5d2:0:b0:3fe:15e7:c8a1 with SMTP id n18-20020a7bc5d2000000b003fe15e7c8a1mr9728594wmk.16.1692792907985;
        Wed, 23 Aug 2023 05:15:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397? (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de. [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
        by smtp.gmail.com with ESMTPSA id v6-20020a7bcb46000000b003fbb25da65bsm18776863wmj.30.2023.08.23.05.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 05:15:07 -0700 (PDT)
Message-ID: <6f0a82a3-6948-20d9-580b-be1dbf415701@redhat.com>
Date:   Wed, 23 Aug 2023 14:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20230821160849.531668-1-david@redhat.com>
 <20230821160849.531668-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
In-Reply-To: <20230821160849.531668-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.23 18:08, David Hildenbrand wrote:
> Let's stop using page->private on tail pages, making it possible to
> just unconditionally reuse that field in the tail pages of large folios.
> 
> The remaining usage of the private field for THP_SWAP is in the THP
> splitting code (mm/huge_memory.c), that we'll handle separately later.
> 
> Update the THP_SWAP documentation and sanity checks in mm_types.h and
> __split_huge_page_tail().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

@Andrew, the following change on top


 From 2b1fd10ef07c6d47aa9cd0ce10445ab1e1b97361 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Aug 2023 19:16:55 +0200
Subject: [PATCH] fixup: mm/swap: stop using page->private on tail pages for
  THP_SWAP

Per Yoshry, use folio_page_idx(). It shouldn't make a difference for
our (THP) use case, but it's certainly cleaner.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/swap.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 84fe0e94f5cd..e5cf58a1cf9e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,7 +344,7 @@ static inline swp_entry_t page_swap_entry(struct page *page)
  	struct folio *folio = page_folio(page);
  	swp_entry_t entry = folio_swap_entry(folio);
  
-	entry.val += page - &folio->page;
+	entry.val += folio_page_idx(folio, page);
  	return entry;
  }
  
-- 
2.41.0


-- 
Cheers,

David / dhildenb

