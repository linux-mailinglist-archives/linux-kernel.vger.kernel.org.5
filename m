Return-Path: <linux-kernel+bounces-136403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342289D3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DC41C20EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABD7E78F;
	Tue,  9 Apr 2024 08:00:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184B7CF2B;
	Tue,  9 Apr 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649602; cv=none; b=g5gYcPZHaMJitkgJ2L/pX+5W0xToR63mle6UJqWyiuRBNg/EZOy+DperrlQrTGbkVeD7oVIe7AYX6Uovwogf5OP1/yVmeW+UZXdaZl+O5yxrr8+5GMoaZ3xRpDAv5mUEVlKkseaIG0zeVB/dnySIwBe2kbOq1LiPH7wTJCu7QJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649602; c=relaxed/simple;
	bh=+3z6auRQhul1eNrO/m8FYJ1d51wSu1m5tm67G9k2QnA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZVv3hBof+BevAh3qhdVGdFttqO+0qG59N8AFkoUR3sxuieAVCCutBcvqrN4X09LwsILd4esLqMYocQNibS74LPop8TYUdNShfnY4GxOyYhk30VJtJSrGvRkCDdJo7RAkpIluU4UNQzsrDHugWxeSMgTEQh01nHUgiL1uSdG31Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VDJFv6FkRz29kj0;
	Tue,  9 Apr 2024 15:57:07 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C68911402C7;
	Tue,  9 Apr 2024 15:59:58 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 15:59:58 +0800
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com>
 <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
 <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
Date: Tue, 9 Apr 2024 15:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/9 0:13, Alexander Duyck wrote:
> On Mon, Apr 8, 2024 at 6:39 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/8 2:13, Alexander H Duyck wrote:
>>> On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
>>>> Update documentation about design, implementation and API usages
>>>> for page_frag.
>>>>
>>>> Also update MAINTAINERS for page_frag. Alexander seems to be the
>>>> orginal author for page_frag, we can add him to the MAINTAINERS
>>>> later if we have an ack from him.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>
>>> Again, this seems more like 2 different pathches at least. One for the
>>> Documentation and MAINTAINERS changes, and one for the function
>>> documentation.
>>
>> Sure.
>>
> 
> [...]
> 
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -16683,6 +16683,16 @@ F:  mm/page-writeback.c
>>>>  F:  mm/readahead.c
>>>>  F:  mm/truncate.c
>>>>
>>>> +PAGE FRAG
>>>> +M:  Yunsheng Lin <linyunsheng@huawei.com>
>>>> +L:  linux-mm@kvack.org
>>>> +L:  netdev@vger.kernel.org
>>>> +S:  Supported
>>>> +F:  Documentation/mm/page_frags.rst
>>>> +F:  include/linux/page_frag_cache.h
>>>> +F:  mm/page_frag_cache.c
>>>> +F:  mm/page_frag_test.c
>>>> +
>>>
>>> I would appreciate it if you could add me as I usually am having to
>>> deal with issues people have with this anyway. You can probably just go
>>> with:
>>> Alexander Duyck <alexander.duyck@gmail.com>
>>
>> Sure, good to your ack here.
> 
> Just to be clear this isn't an Ack, but if you are going to list
> maintainers for this my name should be on the list so this is the
> preferred format. There are still some things to be cleaned up in this
> patch.

Sure, I was talking about "Alexander seems to be the orginal author for
page_frag, we can add him to the MAINTAINERS later if we have an ack from
him." in the commit log.

> .
> 

