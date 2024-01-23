Return-Path: <linux-kernel+bounces-34589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35A48381D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67401C2557D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F15101E;
	Tue, 23 Jan 2024 01:31:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58D50A9F;
	Tue, 23 Jan 2024 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973481; cv=none; b=juENGT3MAeqe/WjbSWYpFvxBOyfL87YfAtXNs+s3dWTXvNJ2t4NL3mbeQbfVpN1oR5tSpwb9Kp9M8s41xUDfnwU/m9GCyL93FX4O5+xseMVNfOXK2MOQqc3waIKA9A1XMZCCeXvi0G8m5sEDv1HQOji6M6OyMCjQqjRWH51L+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973481; c=relaxed/simple;
	bh=6ZAxUjEYEMpmJ2rHMdcaKbu60+cOAF9UUnV39OOPUzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYAmJh3yPE84vhduG/8joB0kE9tgw9PU8Ll5DqFigBZMcvV5xBnh9kIkRNGfGyeyVmxBAl3TdKTZLjGd/xNmd9wvlMuw0Sn9+H8iitpIf3MJov4FAb9JM9kmO9q5hVrYlBl2h/zQbKDxws8+7d/NxS+frpZBNBd9Kybo6jBybu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.155])
	by gateway (Coremail) with SMTP id _____8DxdfHhFq9lkPcDAA--.16314S3;
	Tue, 23 Jan 2024 09:31:13 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.155])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c7bFq9l2kMTAA--.22118S3;
	Tue, 23 Jan 2024 09:31:08 +0800 (CST)
Message-ID: <0705c04e-eebd-4402-b4ed-10a8e28fde17@loongson.cn>
Date: Tue, 23 Jan 2024 09:30:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: power: Use kcalloc() instead of
 kzalloc()
To: Hu Haowen <2023002089@link.tyut.edu.cn>,
 Erick Archer <erick.archer@gmx.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240121104344.5001-1-erick.archer@gmx.com>
 <b8823223-e735-4d5a-b90e-6e2f2a6cd104@link.tyut.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <b8823223-e735-4d5a-b90e-6e2f2a6cd104@link.tyut.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c7bFq9l2kMTAA--.22118S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1kWw1UGw1kWFWUZrW5urX_yoWrJr4xpF
	WkKF1xKF98CF1kGw1xtr1UZFy8XF4kGa17Gw1jq3W8ZwsrZrnYqr4jqryY9ry7ZrWkJF4j
	qr1xXFyUZF12yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==


在 2024/1/23 01:11, Hu Haowen 写道:
>
> 在 2024/1/21 18:43, Erick Archer 写道:
>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> and Conventions" documentation [1], size calculations (especially
>> multiplication) should not be performed in memory allocator (or similar)
>> function arguments due to the risk of them overflowing. This could lead
>> to values wrapping around and a smaller allocation being made than the
>> caller was expecting. Using those allocations could lead to linear
>> overflows of heap memory and other misbehaviors.
>>
>> So, in the example code use the purpose specific kcalloc() function
>> instead of the argument size * count in the kzalloc() function.
>>
>> At the same time, modify the translations accordingly.
>>
>> Link: 
>> https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments 
>> [1]
>> Link: https://github.com/KSPP/linux/issues/162
>> Signed-off-by: Erick Archer <erick.archer@gmx.com>
>> ---
>> Hi,
>>
>> This patch is a merger of two previous ones [1] [2].
>> As Hu Haowen and Jonathan Corbet suggested, the translation change
>> only makes sense if the original file is modified. So, with this
>> v2 version the original file and the translations are modified at
>> the same time.
>>
>> [1] 
>> https://lore.kernel.org/linux-hardening/20240120120527.3866-1-erick.archer@gmx.com/
>> [2] 
>> https://lore.kernel.org/linux-hardening/20240120122204.4287-1-erick.archer@gmx.com/
>>
>> Thanks,
>> Erick
>> ---
>>   Documentation/power/opp.rst                    | 2 +-
>>   Documentation/translations/zh_CN/power/opp.rst | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
>> index a7c03c470980..1b7f1d854f14 100644
>> --- a/Documentation/power/opp.rst
>> +++ b/Documentation/power/opp.rst
>> @@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
>>        {
>>           /* Do things */
>>           num_available = dev_pm_opp_get_opp_count(dev);
>> -        speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
>> +        speeds = kcalloc(num_available, sizeof(u32), GFP_KERNEL);
>>           /* populate the table in increasing order */
>>           freq = 0;
>>           while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
>> diff --git a/Documentation/translations/zh_CN/power/opp.rst 
>> b/Documentation/translations/zh_CN/power/opp.rst
>> index 8d6e3f6f6202..7470fa2d4c43 100644
>> --- a/Documentation/translations/zh_CN/power/opp.rst
>> +++ b/Documentation/translations/zh_CN/power/opp.rst
>> @@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
>>        {
>>           /* 做一些事情 */
>>           num_available = dev_pm_opp_get_opp_count(dev);
>> -        speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
>> +        speeds = kcalloc(num_available, sizeof(u32), GFP_KERNEL);
>
>
> For the zh_CN translation,
>
> Reviewed-by: Hu Haowen <2023002089@link.tyut.edu.cn>


Same here,

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

>
>
> Thanks,
>
> Hu Haowen
>
>
>>           /* 按升序填充表 */
>>           freq = 0;
>>           while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
>> -- 
>> 2.25.1
>>
>>
>>


