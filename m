Return-Path: <linux-kernel+bounces-146854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA888A6BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8FD283295
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128212C485;
	Tue, 16 Apr 2024 13:11:33 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEA12AAE7;
	Tue, 16 Apr 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273092; cv=none; b=KgSSE0RWp5O+ByoMQKUPl23pHEHF+0paMmhW6S+PrUBav5b0R7whyBqo/wq/BGZOK0bynGlXQT50HxWq+ngTkMWSOhK+dc8XDRohTtt3zIEx+ws4mFg3YFcWHDHzmYzXjuP8Jc1kGjUDcEtBJCDrMbX5+5WfNw5i46IU9UdLEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273092; c=relaxed/simple;
	bh=LPP/2ZESy+w5a7RXrfWqEvuaDZMNiJboMaxL8S7iUR4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=URfcDZXV5HL3UyYfJBPzpmNG5C+orhEUpHT0slnydTQ3xICcwUne8R1KH0jq2ytqBEh71jwXvfOvO9mOMnw8IQX7R6Z2a9whzLc2ZygrPErO/6U1Q1SQYQpBKv8D+e3dX7kV92psse9MYrKRKnRF/ALjX7PiawZzSnfK6Cc1vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJktG0Bmyz17N1f;
	Tue, 16 Apr 2024 21:10:30 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2940C140120;
	Tue, 16 Apr 2024 21:11:28 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 21:11:27 +0800
Subject: Re: [PATCH net-next v2 14/15] mm: page_frag: update documentation for
 page_frag
To: Bagas Sanjaya <bagasdotme@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-15-linyunsheng@huawei.com> <Zh4XD6jP4dLoZN4Q@archie.me>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <483f22fe-1830-8b5c-c32d-9422e356f296@huawei.com>
Date: Tue, 16 Apr 2024 21:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zh4XD6jP4dLoZN4Q@archie.me>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/16 14:13, Bagas Sanjaya wrote:
> On Mon, Apr 15, 2024 at 09:19:39PM +0800, Yunsheng Lin wrote:
>> +API interface
>> +=============
>> +As the design and implementation of page_frag API, the allocation side does not
>                                         "... implies, the allocation side ..."
>> +allow concurrent calling, it is assumed that the caller must ensure there is not
>                       "... . Instead, it is assumed that ...:
>> +concurrent alloc calling to the same page_frag_cache instance by using it's own
>                                                             "... by using its own ..."
>> +lock or rely on some lockless guarantee like NAPI softirq.
>> +
>> +Depending on different use cases, callers expecting to deal with va, page or
>> +both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
>> +or page_frag_alloc* API accordingly.
>> +
>> +There is also a use case that need minimum memory in order for forward
>> +progressing, but can do better if there is more memory available. Introduce
> Did you mean "... but more performant if more memory is available"?
>> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
> s/Introduce/Using/
>> +requests the minimum memory it need and the prepare API will return the maximum
>> +size of the fragment returned, caller need to report back to the page_frag core
>                                   "The caller needs to either call the commit API ..."
>> +how much memory it actually use by calling commit API, or not calling the commit
> "... to report how much memory it actually uses ..."
>> +API if deciding to not use any memory.
> "... or not do so if deciding to not use any memory."

Thanks.
Your wording seems better than mine, will update it accordingly.

> 
> Thanks.
> 

