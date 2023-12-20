Return-Path: <linux-kernel+bounces-7517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E681A934
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615551C22955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15634A9B2;
	Wed, 20 Dec 2023 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMaZ3mdq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E6495CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703111354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=biKuMYxWNtLoc9oN17eZQHcrTRic6oxMUpNAggHYZyE=;
	b=eMaZ3mdqqAn8WorJVxsV6SrUJbpDBHOrKhe7Y7/caD+Ew/7fekzLNvfXWK6ZmDOIV6jJbw
	AYlmp8yMUNFJpbKH9ntY54v7wuckA/cUvIrlIHct2DW3e7VA7nqx5/MtxvrTgQMbyTZ9Z6
	V3+q6bLdHns1+vFGte3cdFj4echRdcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-bfuLmGrwOkG4IXB-MPovBA-1; Wed, 20 Dec 2023 17:29:13 -0500
X-MC-Unique: bfuLmGrwOkG4IXB-MPovBA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c295f59ceso6209625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111351; x=1703716151;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biKuMYxWNtLoc9oN17eZQHcrTRic6oxMUpNAggHYZyE=;
        b=L01O72RFNNbovgWaDX1yR1SeoT4IHP+kHjDM87gOjpX75Oax7+f/LeEvX3ko9WBne7
         BphRnpNAkUchsa76D9mXNr72F1erPr6Q3Frmq556A1OLM/VyN85YKWovmV2nsqys0Efi
         WKW6HVLjfwel82vjQ/9RdIbWIJyrBoiwwxtXq3e8jjcUUMXmAbt2hmtJuo9KRcggOyUB
         9u1Hep06MVa9kVzcwNwM48yfC9MDljAmfrhQ1bEWiTUVo7ae+d94X5n25D3OPfN6H9P6
         0IdKMv6zDxIhVsm03qKm4fwQjSXzHI59oILkyNLcLh2ZttW+kVbMA0tU3fQtzqycNrNS
         +bzQ==
X-Gm-Message-State: AOJu0YxDWq09H2pFd7Ref/4lSHpmXNfZaCAxz4UoF1xNcwmsQEM05sZX
	L2VFgredTW2di3LpkVU88hjLHb0QWyPBwLRi4uGP1mkrkpJ725L/uIIK38ZY5xA0NNfpvmypaAw
	5pB4fzGqjZP3yUJ1llF1oL8tq
X-Received: by 2002:a1c:7414:0:b0:40c:3984:4985 with SMTP id p20-20020a1c7414000000b0040c39844985mr142972wmc.79.1703111351636;
        Wed, 20 Dec 2023 14:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi5IOCgb2CqyS6TuCGMRfpRLigZ+qyJiYSR7LUTb3R/siOeoAuuH65SXYN0VAKfTOGT2KFRw==
X-Received: by 2002:a1c:7414:0:b0:40c:3984:4985 with SMTP id p20-20020a1c7414000000b0040c39844985mr142966wmc.79.1703111351182;
        Wed, 20 Dec 2023 14:29:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c740:9d00:be3b:a58f:4d39:51e7? (p200300cbc7409d00be3ba58f4d3951e7.dip0.t-ipconnect.de. [2003:cb:c740:9d00:be3b:a58f:4d39:51e7])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c138400b0040c03c3289bsm961430wmf.37.2023.12.20.14.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 14:29:10 -0800 (PST)
Message-ID: <b8ecc05f-859e-4710-8c4c-a24ac82bff11@redhat.com>
Date: Wed, 20 Dec 2023 23:29:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.23 23:11, Andrew Morton wrote:
> On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
>>
>>
>> Hello,
>>
>> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
>>
>> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
> 
> I assume this is a bisection result, so it's quite repeatable?
> 
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [test failed on linux-next/master aa4db8324c4d0e67aa4670356df4e9fae14b4d37]
>>
>> in testcase: vm-scalability
>> version: vm-scalability-x86_64-1.0-0_20220518
>> with following parameters:
>>
>> 	runtime: 300
>> 	thp_enabled: always
>> 	thp_defrag: always
>> 	nr_task: 32
>> 	nr_ssd: 1
>> 	priority: 1
>> 	test: swap-w-rand
>> 	cpufreq_governor: performance
>>
>> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
>>
>>
>> compiler: gcc-12
>> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202312192319.fa8f5709-oliver.sang@intel.com
>>
>>
>> [   61.404380][ T5947] ------------[ cut here ]------------
>> [   61.409984][ T5947] kernel BUG at mm/memory.c:3990!
>> [   61.415085][ T5947] invalid opcode: 0000 [#1] SMP NOPTI
> 
> This is
> 
> 	BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> 
> and I don't believe that the error path fix
> (https://lkml.kernel.org/r/ZXnPtblC6A1IkyAB@casper.infradead.org) will
> address this.
> 
> Matthew, have you had a chance to consider?

Isn't the
	
	page = folio_page(folio, 0);

just wrong?

We must not do that if the folio didn't change, otherwise we're
in trouble if we had a large folio in the swapcache.


Maybe something like the following?

diff --git a/mm/memory.c b/mm/memory.c
index d995ead7a3933..3aca5e33c6f81 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3961,7 +3961,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
                         folio = swapcache;
                         goto out_page;
                 }
-               page = folio_page(folio, 0);
+               if (folio != swapcache)
+                       page = folio_page(folio, 0);
  
                 /*
                  * If we want to map a page that's in the swapcache writable, we





-- 
Cheers,

David / dhildenb


