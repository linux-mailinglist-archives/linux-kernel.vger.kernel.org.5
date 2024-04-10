Return-Path: <linux-kernel+bounces-138456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C989F184
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D339C1C230D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFE815B0EC;
	Wed, 10 Apr 2024 11:56:16 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255F156865;
	Wed, 10 Apr 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750176; cv=none; b=c7nHSpUpijhGK9zG1a8qUTFHtzfyUMCShh42oiguAL3HuinkOHUxEwSE1h6IGB4CbN4d0t5L4ki7GGlhTryzaF+r/bZ5PSnG0tICTGc9iBdPqs3sIN3GKo72tcZDEjRrykGxXYCiJl22qpboCG+8+4tUEXKFIL8g1r51u97d820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750176; c=relaxed/simple;
	bh=QOyaJy+CNi6R9607nxZfxgMXDaD6rr1ppov0JOl34z0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HkXeZ7a7B+OOphAFY1p6NrnUErFu1a3MzLFw9QRibRq1XeXSICIMzCp2xeRdmeC/JerMLdJqcu62RJJ5wCm4mJx74LnJ4PD0jFuQRNOcITMIeZnYUkBksWqsp3gkGSI8O4izkOYPZb8QLxvH4BK9HWGx1lMwO0+ElxMaaCIWxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VF1Rz0bmjz1RC7s;
	Wed, 10 Apr 2024 19:53:19 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C4CA14037E;
	Wed, 10 Apr 2024 19:56:11 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 19:56:11 +0800
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com>
 <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
 <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
 <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com>
 <20240409062504.26cfcdde@kernel.org>
 <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <dea82ac3-65fc-c941-685f-9d4655aa4a52@huawei.com>
Date: Wed, 10 Apr 2024 19:56:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/9 23:11, Alexander Duyck wrote:
> On Tue, Apr 9, 2024 at 6:25 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
>>>> Just to be clear this isn't an Ack, but if you are going to list
>>>> maintainers for this my name should be on the list so this is the
>>>> preferred format. There are still some things to be cleaned up in this
>>>> patch.
>>>
>>> Sure, I was talking about "Alexander seems to be the orginal author for
>>> page_frag, we can add him to the MAINTAINERS later if we have an ack from
>>> him." in the commit log.
>>
>> Do we have to have a MAINTAINERS entry for every 1000 lines of code?

Do we have something like rule or guidance against that?
Looking at the entry in MAINTAINERS, it seems quite normal to me,
I thouht it is generally encourage someone with willing and ability
to be a maintainer/reviewer.

Considering you have refused adding me as the reviewer of page_pool
despite the support from two maintainers of page_pool, for the season
of something like below:
'page pool is increasingly central to the whole networking stack.
The bar for "ownership" is getting higher and higher..'

I think I might need a second opinion here.

>> It really feels forced :/

I am not a native english speaker here, I would rather not comment
on the 'forced' part here and focus more on the technical disscusion.

> 
> I don't disagree. However, if nothing else I think it gets used as a
> part of get_maintainers.pl that tells you who to email about changes
> doesn't it? It might make sense in my case since I am still
> maintaining it using my gmail account, but I think the commits for
> that were mostly from my Intel account weren't they? So if nothing
> else it might be a way to provide a trail of breadcrumbs on how to
> find a maintainer who changed employers..

+1.
I generally pay more attention to the patch that is to'ed or cc'ed
to my email when I am overloaded with other work.

> .
> 

