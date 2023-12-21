Return-Path: <linux-kernel+bounces-9182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20781C200
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532E8285EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35B79491;
	Thu, 21 Dec 2023 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2RQevUcQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21378E72;
	Thu, 21 Dec 2023 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PLpFzJBkRIVRbImC6LLkmU60cfDt3U7Bi6p9cnlmj6Q=; b=2RQevUcQbjUPI2JVCGpeo4x++E
	9R+a4V/PtRyXUsT77FI45fG2H0u4FUrjQFyFWiiaIKgXEljawZdEc1V2X1ETptA6sChNACCd4nkUh
	0Av/T8LiuIK6Fkyx540+WgkU5x7wSn6wo8zCxSelqrMvxd2njXs5QI6GghrSnqOZZcQM1oqT22mRq
	q9SXqvq0jtkZHbNBZqH2lbjQlatN8Xoj66XMuQhkM38GIoWXhY542sZmt1eUdqTAHo3bEIlKjasod
	fMrgDoJlJJYIh4kA+KCLWYBp7HbP9aFHp8+H6vVFohxOJ649PzcOPZ8uFtBw31acuW4Apu0Bls9S1
	XiCYC5ZA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSZ2-004RWi-2C;
	Thu, 21 Dec 2023 23:34:52 +0000
Message-ID: <65d0c378-2126-4746-bb68-99ca97b6e069@infradead.org>
Date: Thu, 21 Dec 2023 15:34:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvdimm/dimm_devs: fix kernel-doc for function params
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 nvdimm@lists.linux.dev
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-2-rdunlap@infradead.org>
 <6584bc064ea54_5580229435@iweiny-mobl.notmuch>
 <6584bd663bd30_576052949c@iweiny-mobl.notmuch>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6584bd663bd30_576052949c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ira,

On 12/21/23 14:34, Ira Weiny wrote:
> Ira Weiny wrote:
>> Randy Dunlap wrote:
> 
> [snip]
> 
>>> diff -- a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
>>> --- a/drivers/nvdimm/dimm_devs.c
>>> +++ b/drivers/nvdimm/dimm_devs.c
>>> @@ -53,7 +53,10 @@ static int validate_dimm(struct nvdimm_d
>>>  
>>>  /**
>>>   * nvdimm_init_nsarea - determine the geometry of a dimm's namespace area
>>> - * @nvdimm: dimm to initialize
>>> + * @ndd: dimm to initialize
>>> + *
>>> + * Returns: %0 if the area is already valid, -errno on error,
>>
>> This is good...
>>
>>> ...otherwise an
>>> + * ND_CMD_* status code.
>>
>> I don't see where any of the ->ndctl() calls return an ND_CMD_* status
>> code.  What am I missing?

Probably nothing.
Yes, please drop that/fix that when you merge it.
Thanks.

> If you agree that this should be dropped I can clean it up as I'm trying
> to prep the nvdimm tree now and was hoping to take this series.
> 
> Ira
> 
>>
>> The rest looks good,
>> Ira

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

