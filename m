Return-Path: <linux-kernel+bounces-6274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F618196A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D94B244C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162279DE;
	Wed, 20 Dec 2023 02:01:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D027472;
	Wed, 20 Dec 2023 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8AxG+ndSoJlv9ACAA--.14206S3;
	Wed, 20 Dec 2023 10:01:01 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxneTYSoJlRlABAA--.8731S3;
	Wed, 20 Dec 2023 10:00:57 +0800 (CST)
Message-ID: <312376bd-b95c-447d-b93e-e42fb5437d06@loongson.cn>
Date: Wed, 20 Dec 2023 10:00:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, "JiaLong.Yang"
 <jialong.yang@shingroup.cn>, Alex Shi <alexs@kernel.org>
Cc: 2738078698@qq.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219070813.29161-1-jialong.yang@shingroup.cn>
 <87wmtai77a.fsf@meer.lwn.net>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <87wmtai77a.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxneTYSoJlRlABAA--.8731S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4DXw1xXw4DAFyUCF15Awc_yoW8Gw17p3
	sFkr1xGanrCry5C3yxXry29FnYya4xuanrKrWDuw1jqFn5Jr4rAFsrtas09FZxZr92yayY
	qFs3KF98uayYvFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

Hi JiaLong,

在 2023/12/19 22:43, Jonathan Corbet 写道:
> "JiaLong.Yang" <jialong.yang@shingroup.cn> writes:
>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>>   Documentation/translations/zh_CN/core-api/printk-basics.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/translations/zh_CN/core-api/printk-basics.rst b/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> index 59c6efb3fc41..cafa01bccff2 100644
>> --- a/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> +++ b/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> @@ -100,7 +100,7 @@ printk()的用法通常是这样的::
>>   
>>   为了调试，还有两个有条件编译的宏：
>>   pr_debug()和pr_devel()，除非定义了 ``DEBUG`` (或者在pr_debug()的情况下定义了
>> -``CONFIG_DYNAMIC_DEBUG`` )，否则它们会被编译。
>> +``CONFIG_DYNAMIC_DEBUG`` )，否则它们不会被编译。
>>   
> This patch needs an actual changelog.  Being illiterate in Chinese, I
> can't make any connection between the subject line and what has actually
> been done here.

As jon said, could you please write a commit message?

For details see: .../Documentation/translations/zh_CN/process/5.Posting.rst


Thanks,

Yanteng

>
> Thanks,
>
> jon


