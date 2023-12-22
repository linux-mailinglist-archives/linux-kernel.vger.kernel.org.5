Return-Path: <linux-kernel+bounces-9550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80681C762
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658851F24AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E66F9EF;
	Fri, 22 Dec 2023 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME7P3K+O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F354DF56
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703237919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QS4ozbU1uU8rdiG4JsHHanZc6c5DfsHVtEoE/fuhVTo=;
	b=ME7P3K+OR+WTMhL4IGMvmZgj0tA94jz0fF5G7gCktVRYnBhOM6kw8KNYdnUjlShNGaXi11
	YI88OJbXClzFAa0iUBEaRkam4ra9goR+z1dFuooOwTau2Nd0a7wmRObrmqpvRnbQj56VxR
	yxr4+wQLgTLDx6r/m8qkb6/DIsZqrbc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-dPGKv6sINE-UIXlP46B37Q-1; Fri, 22 Dec 2023 04:38:36 -0500
X-MC-Unique: dPGKv6sINE-UIXlP46B37Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d27ea0165so12020385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703237915; x=1703842715;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS4ozbU1uU8rdiG4JsHHanZc6c5DfsHVtEoE/fuhVTo=;
        b=XccNf526KqH0cqIU24tEpRLoLHKaudCdTw69IOwH8LbYClTe0x9u4/dfSF/zanOObE
         nXVkRF9L8YKyiMnnmIHT2Nmn6TqvJ+sKt85X148lF+Ev9CwkcdtHHybkCrI/lG8MhOli
         DPFxV2o/wAserL4+yfiSoCPzVZ4jGi4Lc5QMKZF7LraWOwHS3lGH4hjd2+X8hGZ2eEqb
         QiAvMhwejYu+aGkw9k+BloCSndPyLYUpE4VwRRI7s3TueUF6AYYO29Rkw0Md9gsExvwo
         Ia2MUlrbOb89qQTEsulyJvD0WGQECPoeAfsxIww6dyMhf8ddjrU7Rl5H3WYc8/bIqCbB
         O/7w==
X-Gm-Message-State: AOJu0YxxxRG2CKK4EraB2B2mmpKAQ865VmB0wwgHmWV5ETohvzDUMx3t
	gxWWhrnjKGsZs9M4lfBtScB/W0KXB8sXK4rl0Mxbei2fZr1CjqphBqft0Kt7GyP8iDniyWZTJ1C
	dTgqBNq6474jDa3vFLZrgSuFORM+l+KJJ
X-Received: by 2002:a05:600c:54c2:b0:40c:38e7:83b0 with SMTP id iw2-20020a05600c54c200b0040c38e783b0mr528205wmb.123.1703237915571;
        Fri, 22 Dec 2023 01:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPI8/Qi50b72Me9o67Ah7Pnrsh+ZbLgeOaghFylmB3aeitHgTGC+IG8ISB5H0Lx1P5IOkdIA==
X-Received: by 2002:a05:600c:54c2:b0:40c:38e7:83b0 with SMTP id iw2-20020a05600c54c200b0040c38e783b0mr528198wmb.123.1703237915195;
        Fri, 22 Dec 2023 01:38:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:2400:64b1:deb6:7ff8:8d67? (p200300cbc74b240064b1deb67ff88d67.dip0.t-ipconnect.de. [2003:cb:c74b:2400:64b1:deb6:7ff8:8d67])
        by smtp.gmail.com with ESMTPSA id az3-20020a05600c600300b0040d4954ac04sm575651wmb.43.2023.12.22.01.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 01:38:34 -0800 (PST)
Message-ID: <08c09914-b698-4c4a-b661-5dc855034a89@redhat.com>
Date: Fri, 22 Dec 2023 10:38:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Content-Language: en-US
To: Oliver Sang <oliver.sang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
 <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
 <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
 <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
 <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
 <ZYVFNvyG9uX2Q9do@xsang-OptiPlex-9020>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZYVFNvyG9uX2Q9do@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.12.23 09:13, Oliver Sang wrote:
> hi, David,
> 
> On Thu, Dec 21, 2023 at 11:07:21PM +0100, David Hildenbrand wrote:
>> On 21.12.23 22:58, Andrew Morton wrote:
>>> On Thu, 21 Dec 2023 12:32:04 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 21.12.23 12:23, Oliver Sang wrote:
>>>>> hi, Andrew Morton,
>>>>>
>>>>> On Wed, Dec 20, 2023 at 02:11:35PM -0800, Andrew Morton wrote:
>>>>>> On Tue, 19 Dec 2023 23:46:50 +0800 kernel test robot <oliver.sang@intel.com> wrote:
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> kernel test robot noticed "kernel_BUG_at_mm/memory.c" on:
>>>>>>>
>>>>>>> commit: bbcbf2a3f05f74f9d268eab57abbdce6a65a94ad ("mm: convert ksm_might_need_to_copy() to work on folios")
>>>>>>
>>>>>> I assume this is a bisection result, so it's quite repeatable?
>>>>>
>>>>> yes, we bisect to this commit, it's quite repeatable:
>>>>>
>>>>> ddd06bb63d9793ce bbcbf2a3f05f74f9d268eab57ab
>>>>> ---------------- ---------------------------
>>>>>           fail:runs  %reproduction    fail:runs
>>>>>               |             |             |
>>>>>               :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
>>>>>               :6          100%           6:6     dmesg.RIP:do_swap_page
>>>>>               :6          100%           6:6     dmesg.invalid_opcode:#[##]
>>>>>               :6          100%           6:6     dmesg.kernel_BUG_at_mm/memory.c
>>>>>
>>>>>
>>>>
>>>> Can you try with the snipped I sent? Please let me know if you need a
>>>> full patch for testing purposes.
>>>
>>> I think a full patch would be better, please.
>>>
> 
> we cannot reproduce the issue reported previously after applying below patch.

Thanks for verifying and happy holidays!

-- 
Cheers,

David / dhildenb


