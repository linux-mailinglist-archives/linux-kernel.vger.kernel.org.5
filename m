Return-Path: <linux-kernel+bounces-9112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCE81C0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62CF282F87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093E77F09;
	Thu, 21 Dec 2023 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW56y95P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFA77B5A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703196446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XwNzjzjYlQ4OkFShh9gjuNoM97Y9E8n3hq50jUuedQg=;
	b=aW56y95PQF0na6qOM2LbnJpFxvPTRPrbJGAbhdJhpuJCGKYVcKZQ/oHbE9G+gzWmrTUAqS
	nRAjty6MxBJ2qb+vMQqnH/hYFDRvSuTK9lfhHFDEz8m9vN0G6NINc8hlmUuqRWsdjK0doe
	5BmizLsbyA6luVcsmkbca+LQxkTmysw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-8_swdNWdMpyhbkY9sWO6Dg-1; Thu, 21 Dec 2023 17:07:24 -0500
X-MC-Unique: 8_swdNWdMpyhbkY9sWO6Dg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33689c90957so664197f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196443; x=1703801243;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwNzjzjYlQ4OkFShh9gjuNoM97Y9E8n3hq50jUuedQg=;
        b=ZmmSwRSf9WI455OqzN4S2j67DjEZXY/r7swiSkx6IQxaelXHyIW5CBpj/CKqyAPmw4
         1PnkWEjThrekqowGx+71aGe2QI3zzM3gaXDnzPHR8V/I+PqOomZGgIBq9uQ6hkCdGrNp
         6eWzsEadZvsSA5FaxxuDpnNs/laj7Dj8dJYmHEfZrBhb7RKJ7LiVqg+H73BsbLQVlMtr
         vLU7Ya5mVcxoh4jdMp6EgIW3QYG3MMOfTRg2Y6CBdTyT86clmz0DM32PwHGCycKj7K+H
         8N9c8LV8pfVF5d+iYQqNZNCbAMkIhNa57Hy5MVHcBsCsym4y+capO3kyXIuLRs9x4yTL
         crug==
X-Gm-Message-State: AOJu0Yw/F2ttCVa1jTvzYsWEzjoYshC7wE//mNeAeXD4Vlfne36MT6FL
	ArDGgLoA5spQDkEiJ/CqOe1HF1mzqAWI4zYK9P+iBrBolS87tlfzF7FAnNhwZZ8uqE5Ri768srV
	ZjvnayAEKId84Ea+80Jj5smoFSUIKrBd8
X-Received: by 2002:a5d:408d:0:b0:336:60ae:3c4a with SMTP id o13-20020a5d408d000000b0033660ae3c4amr209958wrp.112.1703196443054;
        Thu, 21 Dec 2023 14:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrqGvmGJc7L4wlEO6kkWusGFqDludRg58uGUHX+hhpjjEjAe2cgCdCdshbEAo35Q/ZkPJMpw==
X-Received: by 2002:a5d:408d:0:b0:336:60ae:3c4a with SMTP id o13-20020a5d408d000000b0033660ae3c4amr209948wrp.112.1703196442632;
        Thu, 21 Dec 2023 14:07:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c743:7b00:745e:8663:4f85:318a? (p200300cbc7437b00745e86634f85318a.dip0.t-ipconnect.de. [2003:cb:c743:7b00:745e:8663:4f85:318a])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d4612000000b003367bb8898dsm2879751wrq.66.2023.12.21.14.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 14:07:22 -0800 (PST)
Message-ID: <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
Date: Thu, 21 Dec 2023 23:07:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oliver Sang <oliver.sang@intel.com>, Matthew Wilcox
 <willy@infradead.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
 <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
 <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
 <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.12.23 22:58, Andrew Morton wrote:
> On Thu, 21 Dec 2023 12:32:04 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 21.12.23 12:23, Oliver Sang wrote:
>>> hi, Andrew Morton,
>>>
>>> On Wed, Dec 20, 2023 at 02:11:35PM -0800, Andrew Morton wrote:
>>>> On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
>>>>
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
>>>>>
>>>>> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
>>>>
>>>> I assume this is a bisection result, so it's quite repeatable?
>>>
>>> yes, we bisect to this commit, it's quite repeatable:
>>>
>>> ddd06bb63d9793ce bbcbf2a3f05f74f9d268eab57ab
>>> ---------------- ---------------------------
>>>          fail:runs  %reproduction    fail:runs
>>>              |             |             |
>>>              :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
>>>              :6          100%           6:6     dmesg.RIP:do_swap_page
>>>              :6          100%           6:6     dmesg.invalid_opcode:#[##]
>>>              :6          100%           6:6     dmesg.kernel_BUG_at_mm/memory.c
>>>
>>>
>>
>> Can you try with the snipped I sent? Please let me know if you need a
>> full patch for testing purposes.
> 
> I think a full patch would be better, please.
> 

 From b82e309096abde6c0f24bba50a281e8d3855c132 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 21 Dec 2023 23:04:30 +0100
Subject: [PATCH] Fixup: mm: convert ksm_might_need_to_copy() to work on folios

We must only adjust the page if the folio changed. Otherwise, if we
had a large folio in the swapcache and the folio didn't change, we'd
suddenly change the page to-be-mapped.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/memory.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 149f779910fd5..2f9668d357f5c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3952,7 +3952,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  			folio = swapcache;
  			goto out_page;
  		}
-		page = folio_page(folio, 0);
+		if (folio != swapcache)
+			page = folio_page(folio, 0);
  
  		/*
  		 * If we want to map a page that's in the swapcache writable, we
-- 
2.43.0


-- 
Cheers,

David / dhildenb


