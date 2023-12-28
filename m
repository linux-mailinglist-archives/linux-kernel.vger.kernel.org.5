Return-Path: <linux-kernel+bounces-12465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4481F524
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633EE1F226A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB763BA;
	Thu, 28 Dec 2023 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SSnhSY69"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864463A8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so2238172b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703745687; x=1704350487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtOib/QJxTg8GX+g7Tz3ySApfqH2yKoafoUMfxDDf3Q=;
        b=SSnhSY694ONyB1lTzjO6REj/a9iCTSPXKrH0bTICnvOm2J5OgUnxN/s9iKPI0R0IEg
         irAB3rUiycl0HqkTKekXZOyILCgJcCNA4ATAC4A7yIa46lv0BWGyClXr9fn604/w7s45
         /Z6wFqayes9Y0EClVLLTceul3Zu5HcZyKY/T5VqV6NXZ8hgLLcxnNGcrDvZt4NfVAUeU
         tmHI7DbEVSvYB0leRa4vIRJYkQrXgTVcP29JLCN11KnmpF8OYJ5ZznI5yXGnc99FFzK0
         UVoG9nhkIjcUmDrbko/XY2cuy7YBPYWC7Kj14zYueFo8CeAVkqoMjNFH798Qr8xtWy1L
         oU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703745687; x=1704350487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtOib/QJxTg8GX+g7Tz3ySApfqH2yKoafoUMfxDDf3Q=;
        b=KIvEzSm13/vyg/Mu/Tp908FVnFwolYh4B1U8pdM8W6EO91dOEbD/YISMknQBBdoxPW
         L+fJzvh4ab8sgJbjYnzrsaq5MRDjz0dXBmjwUnAVE9vZWQjCom+CLH2MTjvKJ95YUXPW
         qvqbhHEqF7ztcwC4dkuBQm2joL/MzpJyO7rnU+p5tWY3tPyyhlfmwRsXpwQrDJbyMNP1
         c06/7UwZCjJEbePVNs8oQvtLA+6iKz+xIx+cjk7iANZQcc5vEbXsI2c2U87aJqAab3R2
         sjG8Igu+oN8r6+0b34QiG4F3ueeXsFe9CVxOAaXxAk0U0XD6Pr8rlFhXcH/IFl2iaalN
         S1Tg==
X-Gm-Message-State: AOJu0Yx2jBNxHuc3EbCSbvb6sFVzo3zNFvfv0ZUzoNQE+AHkKbkUDnHs
	nJU3UPZMgQJfiIq0oX8xfj7ZaHj7n6X/zA==
X-Google-Smtp-Source: AGHT+IG37mijfbwzfT4b5t490ZOCdhIBvBlcbw7GHnnk+iVu+C7IYJEYS27zRiEAxyMA3NEnRieqZA==
X-Received: by 2002:a05:6a00:4585:b0:6d9:9f29:9dcd with SMTP id it5-20020a056a00458500b006d99f299dcdmr2630585pfb.45.1703745687585;
        Wed, 27 Dec 2023 22:41:27 -0800 (PST)
Received: from [10.255.185.101] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id h32-20020a63f920000000b005b9083b81f0sm12314663pgi.36.2023.12.27.22.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 22:41:27 -0800 (PST)
Message-ID: <23b76f56-dd91-470b-9967-8482951e5364@bytedance.com>
Date: Thu, 28 Dec 2023 14:41:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <21cnbao@gmail.com>, Seth Jennings <sjenning@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool
 <vitaly.wool@konsulko.com>, Chris Li <chriscli@google.com>,
 Yosry Ahmed <yosryahmed@google.com>, Dan Streetman <ddstreet@ieee.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
 <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
 <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
 <20231227125853.2dd07cd61f8a8df95042677c@linux-foundation.org>
 <CAKEwX=PDeez9D8t4WSe2qd753h=06ZSJwQ8TQDv1xLXB0cpn-Q@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=PDeez9D8t4WSe2qd753h=06ZSJwQ8TQDv1xLXB0cpn-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/28 07:21, Nhat Pham wrote:
> On Wed, Dec 27, 2023 at 12:58 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 27 Dec 2023 14:11:06 +0800 Chengming Zhou <zhouchengming@bytedance.com> wrote:
>>
>>>> i remember there was an over-compression case,  that means the compressed
>>>> data can be bigger than the source data. the similar thing is also done in zram
>>>> drivers/block/zram/zcomp.c
>>>
>>> Right, there is a buffer overflow report[1] that I just +to you.
>>
>> What does "[1]" refer to?  Is there a bug report about this series?
> 
> I think Chengming was referring to this:
> 
> https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/
> 
> Syzkaller/syzbot found an edge case where the page's "compressed" form
> was larger than one page, which tripped up the compression code (since
> we reduced the compression buffer size to 1 page here).

Right, thanks Nhat!

The reported bug can be fixed by a patch I posted:
https://lore.kernel.org/all/20231227093523.2735484-1-chengming.zhou@linux.dev/

Although this bug is fixed, we still have to revert the first patch to use
2 pages buffer in zswap, since not all compressor drivers would respect the
buffer size we passed in and may overflow our output buffer.

Barry Song has explained the background in:
https://lore.kernel.org/all/CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com/

I will send an updated series later.

Thanks!

