Return-Path: <linux-kernel+bounces-158440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B38B201F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025542890FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9E85634;
	Thu, 25 Apr 2024 11:23:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD084E1C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044203; cv=none; b=BRBZS3nTrr2aW/XlK/vTJ2J7BGsS4ajKLj0PtH7nmhMhX1530JxBhUPdLtiV1GAAmC867GyALLlr0iYi8oHx8B207+YIGOHoE7jDlUL4cAGZ9+qGCCq7RUr36bW6JtTXaXQx0NttY3m4IRtlRKHpD5/b18ekw8ILFEfL7aIANjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044203; c=relaxed/simple;
	bh=IxoPg5Bk4OOcY0AMvx8bCOxrSm8QzzJ/qExwynbRwyo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dYCT/ph0aUO7YGTsixlTYSktCOqgAu60MiLn2vS32UL2Lv8AStwEBSmCQKz8dOuHVAXFhPU+Xg5F4kOhYlobNkIK55SUlMyJHaiA3kBx3KHINxHUOCc4BDM0FKjZgeNA3FwHcZLt0aVuKpUi6O6+CnOpM2FGoUatVoV29BXasUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VQD1N3HVFzNnRT;
	Thu, 25 Apr 2024 19:20:40 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 02F0D1800AA;
	Thu, 25 Apr 2024 19:23:13 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:23:12 +0800
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <68489f85-5579-5cff-eed1-55ae585916f3@huawei.com>
 <ZiofNBBRAKTUsh9Q@smile.fi.intel.com> <ZiomPotab29kNe5f@smile.fi.intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fe21919b-a253-679a-5d6c-e4278a97a2a9@huawei.com>
Date: Thu, 25 Apr 2024 19:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiomPotab29kNe5f@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/25 17:45, Andy Shevchenko wrote:
> On Thu, Apr 25, 2024 at 12:15:32PM +0300, Andy Shevchenko wrote:
>> On Thu, Apr 25, 2024 at 02:25:24PM +0800, Miaohe Lin wrote:
>>> On 2024/4/24 0:14, Andy Shevchenko wrote:
> 
> ...
> 
>>>> In some configurations I got
>>>> mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
>>>> Becuase the only user is guarged with a certain ifdeffery,
>>>
>>> guarged?
>>
>> A typo, thanks!
> 
> FWIW, Andrew fixed this along with "Because". Thank you, Andrew!

Got it. Thanks both.
.

> 
>>> ifdeffery?
>>
>> Yes, this is established term.
>>
>>>> do the same for add_to_free_list().
> 


