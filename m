Return-Path: <linux-kernel+bounces-5318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CBD81895A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC851C23994
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48431BDDB;
	Tue, 19 Dec 2023 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OwCPXOOH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F81BDE6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d940d14d69so117946b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702994891; x=1703599691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58GcE9Z/uz2j3e713mEO6HJcPRG3l2oQcTHcq8xiCnE=;
        b=OwCPXOOHaoTvjIjhMtwJgp0fkojQ1Zcm/odV1QCxDjvDPrGllQg9nq/Aw/I+n9agAi
         D8X0d9QxM0T3kxhdnL7qDVmJANC8ow7vE+BVTAQkhe52qUVbeweUTULPF+clbCF2uTxI
         i6rt6oOY3xzw0GVoINuYVWQhqR5OjpcMfw/BXU/OUrNSObFG+VAxug2cXtxEc6o8wPcK
         A2yFAcTXD7C73wEc9oXj8GD2r44WkGmp57B6gRkDEW9F24PwvdPOPewe8KeThCSwPx67
         yjv09WFd4UPuSegmZH9B4chg8YGMPuBHSTf47/Ntx/nLrIo9Kv9w5Eso1JyGXH60bjJn
         3T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702994891; x=1703599691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58GcE9Z/uz2j3e713mEO6HJcPRG3l2oQcTHcq8xiCnE=;
        b=isErEa7D4mNRdn5XYjmZzmEtaLodTf3H7u7W47u1wt2YMdandKsvJCJqBqdP6eRrOb
         hQiqvDcRGcLK1yv1Ta8URL5S3okzTW6yXwL/l3790h2RB0K6do3YqQJtTjcuEKSW0Fm/
         JU1MnMnemFiMUBHnsgodhlLYcK612UCwsijndHrcoR/b+PPeT3mON2wkZ1UeHkbVo4bI
         GUCQAoM2tNAUggOEEsfx3s3/3097Ps1pLc+yDHNlCxDN4u8QS2TYmdsTDnyncmgxcSMF
         9neJ123I37TlWV9dJW+PyJuJkrEiFYkop8xnXcXKe8Xq3O9nphqus7jAX1+bTsNHVat5
         smBQ==
X-Gm-Message-State: AOJu0YzUCfPjm/v5TRoiU9+An1YY48XONIasA1+455bD0CTP7h5GcErR
	7unk/VJ+JxCF2xaZYgsNA5ktCA==
X-Google-Smtp-Source: AGHT+IGFTJSBxLhU68yjcoeat5xPaXoM1wmDboj99HXkH0bvKHXdQ8CSBkMkcnVP+qZtm1+N6wjNHA==
X-Received: by 2002:a05:6a00:9a7:b0:6d7:affe:100d with SMTP id u39-20020a056a0009a700b006d7affe100dmr2434859pfg.13.1702994890904;
        Tue, 19 Dec 2023 06:08:10 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:b832:9c5b:158b:a863? ([2409:8a28:e64:34f0:b832:9c5b:158b:a863])
        by smtp.gmail.com with ESMTPSA id gu18-20020a056a004e5200b006d9415b769csm191274pfb.169.2023.12.19.06.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:08:10 -0800 (PST)
Message-ID: <66b3f3ec-7146-4763-bd51-bb48ebb4ba95@bytedance.com>
Date: Tue, 19 Dec 2023 22:07:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm/zswap: cleanup zswap_load()
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>
Cc: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-4-4eac09b94ece@bytedance.com>
 <CAF8kJuOnBhVRcC9bPJrqSDQYynbG+CpJDveFn9MJNmsBsFyM+g@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuOnBhVRcC9bPJrqSDQYynbG+CpJDveFn9MJNmsBsFyM+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/19 20:47, Chris Li wrote:
> On Mon, Dec 18, 2023 at 3:50 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> After the common decompress part goes to __zswap_load(), we can cleanup
>> the zswap_load() a little.
>>
>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 3433bd6b3cef..86886276cb81 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1759,7 +1759,6 @@ bool zswap_load(struct folio *folio)
>>         struct zswap_tree *tree = zswap_trees[type];
>>         struct zswap_entry *entry;
>>         u8 *dst;
>> -       bool ret;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>
>> @@ -1776,19 +1775,16 @@ bool zswap_load(struct folio *folio)
>>                 dst = kmap_local_page(page);
>>                 zswap_fill_page(dst, entry->value);
>>                 kunmap_local(dst);
>> -               ret = true;
>> -               goto stats;
>> +       } else {
>> +               __zswap_load(entry, page);
> 
> Very minor nitpick. I think this change you only take out the "ret",
> you don't have to remove the goto. Personally I prefer the one with
> the goto because If (!entry->length) is a rare case, having them
> indented match the normal execution flow is the streamlined one
> without indentation.
> 
> If you keep the else statement without the goto. You can move
> __zswap_load(entry,page) to the if statement so most common case go
> through the if statement rather than else.

Make sense. I will change if a new version is needed.

> 
> I also think this commit can fold into the previous one. As I said,
> this is minor comment, it is your call.
> 
> Acked-by: Chis Li <chrisl@kernel.org> (Google)

Thanks for review!

