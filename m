Return-Path: <linux-kernel+bounces-5827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72246818FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2115B223F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BF3B797;
	Tue, 19 Dec 2023 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZ7LbWL9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD693B786
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9cbebd8-dd6e-d81c-471f-f40dcc7196ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703011677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByJwa+WNf8NjGFNqgbUtjcVduZ2GVVhl2z4K4cUv1PU=;
	b=CZ7LbWL91MfzoOsp3MYWAoeZOShMOye29ETcMsfHcdxta1T5YSryOeJmus8RRkoCAt8eUN
	JjjPaCR5TVdBlYXstecKTJg1a+2PN9LgPbFLCFW0S6u6xJm1omOJ5wvXIGONBfY9uLIhLj
	8AxV+EbeFvrS//LS61lmPtjtCK0vmjw=
Date: Wed, 20 Dec 2023 02:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, "JiaLong.Yang"
 <jialong.yang@shingroup.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>
Cc: 2738078698@qq.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219070813.29161-1-jialong.yang@shingroup.cn>
 <87wmtai77a.fsf@meer.lwn.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <87wmtai77a.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2023/12/19 22:43, Jonathan Corbet wrote:
> "JiaLong.Yang" <jialong.yang@shingroup.cn> writes:
> 
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>>  Documentation/translations/zh_CN/core-api/printk-basics.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/translations/zh_CN/core-api/printk-basics.rst b/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> index 59c6efb3fc41..cafa01bccff2 100644
>> --- a/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> +++ b/Documentation/translations/zh_CN/core-api/printk-basics.rst
>> @@ -100,7 +100,7 @@ printk()的用法通常是这样的::
>>  
>>  为了调试，还有两个有条件编译的宏：
>>  pr_debug()和pr_devel()，除非定义了 ``DEBUG`` (或者在pr_debug()的情况下定义了
>> -``CONFIG_DYNAMIC_DEBUG`` )，否则它们会被编译。
>> +``CONFIG_DYNAMIC_DEBUG`` )，否则它们不会被编译。
>>  
> 
> This patch needs an actual changelog.  Being illiterate in Chinese, I
> can't make any connection between the subject line and what has actually
> been done here.

Agreed. The change itself looks correct though, feel free to add my

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

in your next revision (with Jon's suggestion addressed).

Thanks,
Zenghui

