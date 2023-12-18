Return-Path: <linux-kernel+bounces-3138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FC8167E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E131E282BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C458107A3;
	Mon, 18 Dec 2023 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ApGMDigy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8A110780
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b4563a03aso452430a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702887346; x=1703492146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84QetDdy0YwkTJVlaghRjx9Y+piF3q674vdNZK8rIls=;
        b=ApGMDigyEcl5MMfXZZuLjG0t1wkj9eqxsmEFIhW21ni5R4C8vEZvYyUl8CETsk+dms
         cqFTtpZkVsTRiMCUZLqk2w5w660RHrvn6gDo8nDVUERl/3LOBQJYO052cTEqndPC/NvZ
         5AFJl8PlC/SQGbc4zOeNZ917tJEuxZRDpBYx3mvKPqtO77rTUUu1uMxqsWAVxHKP2tKT
         UAV5Eh508FkM5p2jF7FChGsvvKsenWnS69Esh6Cx0dFEilxpJDAoG9wahARDl2zi4D6n
         /XGDSxAHnNjhDcou2fleTLze/rHtoiEsoj/w2819t6YMVZ/AefPZCoVlQJV8ys3rTW10
         VPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887346; x=1703492146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84QetDdy0YwkTJVlaghRjx9Y+piF3q674vdNZK8rIls=;
        b=sfZBlYrN6wyd+WO59mnHA+yVWOFlbpIPMf5W8qNWdLpxnk7UmHrmTKfLIDRwAA1wuI
         UG/b5H0Z0F5Kj58cZU4p0rKliJkEHEQnyP4PgofJeTYHGgq/KSjVDkXLop23xydnWpxL
         jTBwCv8jw0q/4RLEw7P2yTmGAojk/dLNI2Qe6paTeQ0+txJIP5CYKYG6fN5mxg82QVC4
         m81V/bbYL6RmOVyWOtAQZUi0isIHXrt0Ng4/DFtr17EftMf9tHj51ruCnX3xbzmgj9xv
         Rm3pZj+LKsAHveUS4uYTuizmb1FOZp6oM9dxlaXUuTtibeUmGbfXa9zzd12ej7sNXXaL
         3yVg==
X-Gm-Message-State: AOJu0Yx4qnvHkok8GhsRa9r3sL91sh2HTdmrfJKC29KkN2UDoKUAN/Cp
	soRBATRM1FY0Ncs1Kfyr0JWTdg==
X-Google-Smtp-Source: AGHT+IEG6Fg8QT0Uq7858+ghK8fKpYD8eAa0zpfFPDeozWKJZ6994Dk9sYhEJq0j59KK58E4W+chzg==
X-Received: by 2002:a17:90a:f190:b0:28b:6a8a:188 with SMTP id bv16-20020a17090af19000b0028b6a8a0188mr310174pjb.95.1702887346671;
        Mon, 18 Dec 2023 00:15:46 -0800 (PST)
Received: from [10.4.170.32] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a01d000b0028acb86f7b5sm11995018pjd.44.2023.12.18.00.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:15:46 -0800 (PST)
Message-ID: <b3736d08-fccc-4499-8801-4e9b8a7394d6@bytedance.com>
Date: Mon, 18 Dec 2023 16:15:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm/zswap: refactor out __zswap_load()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
 <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/14 08:52, Yosry Ahmed wrote:
> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> The zswap_load() and zswap_writeback_entry() have the same part that
>> decompress the data from zswap_entry to page, so refactor out the
>> common part as __zswap_load(entry, page).
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> 
> On a second look, there a few nits here.
> 
> First I think it makes more sense to move this refactoring ahead of
> reusing destmem. Right now, we add the destmem reuse to zswap_load()
> only, then we do the refactor and zswap_writeback_entry() gets it
> automatically, so there is a slight change coming to
> zswap_writeback_entry() hidden in the refactoring patch.
> 
> Let's refactor out __zswap_load() first, then reuse destmem in it.

I tried but found that putting the __zswap_load() first would introduce
another failure case in zswap_writeback_entry(), since the temporary
memory allocation may fail.

So instead, I also move the dstmem reusing in zswap_writeback_entry() to
the dstmem reusing patch. Then this patch becomes having only refactoring.

Thanks.

