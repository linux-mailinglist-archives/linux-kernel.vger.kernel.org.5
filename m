Return-Path: <linux-kernel+bounces-21806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064482948C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B7B1C24B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70E3C097;
	Wed, 10 Jan 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QR6/n0si"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DB3A8CB;
	Wed, 10 Jan 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ozsgV78QtWaa5DByhahm2PsgoXx1vXQSwE+6AXxoL/A=; b=QR6/n0si+nTe74CiAMw2w7N+68
	39l9Dj41XJQsAUgmPv3If5eJH0InzdOVVOoEEjylegoWi2PJxN0CyEigaK94VZsncemW08HQotDUX
	xg7TOuZqAVo1QkK+dAvfHjs6YMn3Om9K5uX5XjCKv5olbarfGzuRoPVeRuNp9fI5IVVzXz9NuEue0
	OrGvfyUKOoEZvgLtfzKxy1BEeH867kXrtjKmJml4H4JILI1GW98hN8366tkc8MYFXB61YxODEzRym
	pmyxUF4MziAcTjMGScsSjcuMLateat6jyh4ezEeb3Pjx6nhSUwMY+qSqpGpLFMMY43dS/f4Geea0v
	3Z+uZxWw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNTRv-00AfwL-1P;
	Wed, 10 Jan 2024 07:56:31 +0000
Message-ID: <9fdcb306-862f-4ad5-a52f-cd70fd21cf05@infradead.org>
Date: Tue, 9 Jan 2024 23:56:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: vt6655: fix open parentheses alignment
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthias Yee <mgyee9@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240110072304.2226-1-mgyee9@gmail.com>
 <e3941caa-7546-415f-be7b-b955cf13aa8b@infradead.org>
 <f22e751e-863a-46a9-8dd6-0ac55f1ad9c8@moroto.mountain>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f22e751e-863a-46a9-8dd6-0ac55f1ad9c8@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/24 23:51, Dan Carpenter wrote:
> On Tue, Jan 09, 2024 at 11:30:17PM -0800, Randy Dunlap wrote:
>>> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
>>> index 36183f2a64c1..688c870d89bc 100644
>>> --- a/drivers/staging/vt6655/card.c
>>> +++ b/drivers/staging/vt6655/card.c
>>> @@ -81,9 +81,9 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
>>>   * Return Value: none
>>>   */
>>>  static void calculate_ofdmr_parameter(unsigned char rate,
>>> -				       u8 bb_type,
>>> -				       unsigned char *tx_rate,
>>> -				       unsigned char *rsv_time)
>>> +				      u8 bb_type,
>>> +				      unsigned char *tx_rate,
>>> +				      unsigned char *rsv_time)
>>>  {
>>>  	switch (rate) {
>>>  	case RATE_6M:
>>
>> Is there any chance that checkpatch is wrong about this warning?
>>
>> I much prefer the alignment as it was before this patch: following lines
>> are aligned with the first parameter after the '('.
>>
> 
> It just looks weird in the diff because of the + character at the front
> and how the tabs work out.  It looks ok in the code.

Oops, sorry, you are correct. Thanks!

-- 
#Randy

