Return-Path: <linux-kernel+bounces-36353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7A839F91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396661F2BAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CEE53B9;
	Wed, 24 Jan 2024 02:46:38 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978495225;
	Wed, 24 Jan 2024 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064398; cv=none; b=MYtb+E+zxIbHI03Lrir1TSUHYYDM7KhqvdPz7P79zZpXhPja2SAGbfvZiPZ24xxldsIRkAeW0b7AkzYeHa9OvlsnU0iUgopab/oQBxos8cJMgycF3aVKP9DfcPWmh+iHFL+ydjRziEo+9Zf0qPBB69EFEA78qlxXiBl3JhGxpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064398; c=relaxed/simple;
	bh=kIfCbyqTIfHCDLX59SJ1DP0+CgVWCIkjSYqLb5Zq1x4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pYkQwb39xtlpJpacsB16+B6GPH7JsN3pc3ubjYKKkXWRL2JceK/Q65c7a/ZGZMHNeW8fCROpOIfCPxVT7DamULCNBinpzb6ldw3Zmuz7JRYQBYXwKdXCDI4XgYDl+k+CXQyq8HhSKk8ekE7vLqVxXBd+Bv/RBqhCF7V3MBrAMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TKSyB4VnJz1vsYX;
	Wed, 24 Jan 2024 10:46:10 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ED3E1A0172;
	Wed, 24 Jan 2024 10:46:17 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 10:46:10 +0800
Subject: Re: [PATCH v4 3/7] tracing/probes: support '%pd' type for print
 struct dentry's name
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20240123092139.3698375-1-yebin10@huawei.com>
 <20240123092139.3698375-4-yebin10@huawei.com>
 <20240123234013.52b1834908da7be0272e7a73@kernel.org>
CC: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <65B079F2.4000802@huawei.com>
Date: Wed, 24 Jan 2024 10:46:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240123234013.52b1834908da7be0272e7a73@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/1/23 22:40, Masami Hiramatsu (Google) wrote:
> On Tue, 23 Jan 2024 17:21:35 +0800
> Ye Bin <yebin10@huawei.com> wrote:
>
>> Similar to '%pd' for printk, use '%pd' for print struct dentry's name.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   kernel/trace/trace_kprobe.c | 6 ++++++
>>   kernel/trace/trace_probe.h  | 1 +
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>> index c4c6e0e0068b..00b74530fbad 100644
>> --- a/kernel/trace/trace_kprobe.c
>> +++ b/kernel/trace/trace_kprobe.c
>> @@ -779,6 +779,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>>   	char buf[MAX_EVENT_NAME_LEN];
>>   	char gbuf[MAX_EVENT_NAME_LEN];
>>   	char abuf[MAX_BTF_ARGS_LEN];
>> +	char dbuf[MAX_DENTRY_ARGS_LEN];
> Hmm, no, I don't like to expand stack anymore. Please allocate it
> from heap.
Do I need to change the other buffers on the stacks to allocate memory 
from heap?
>>   	struct traceprobe_parse_context ctx = { .flags = TPARG_FL_KERNEL };
>>   
>>   	switch (argv[0][0]) {
>> @@ -930,6 +931,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>>   		argv = new_argv;
>>   	}
>>   
>> +	ret = traceprobe_expand_dentry_args(argc, argv, dbuf,
>> +					    MAX_DENTRY_ARGS_LEN);
>> +	if (ret)
>> +		goto out;
> And calling this here will not cover the trace_fprobe.
>
> Could you call this from traceprobe_expand_meta_args() instead of
> calling it directly from trace_kprobe? Then it can be used from
> fprobe_event too.
>
> Thank you,
At first I wanted to implement the extension logic in 
traceprobe_expand_meta_args(),
but I found that the code was difficult to understand when I started 
writing. If fprobe_event
wants to support this function, is traceprobe_expand_dentry_args() also 
called? Or re-encapsulate
an interface to include the logic of different extensions. In this way, 
the same buffer is used for
the entire extension process, and the extension function needs to return 
the information about
the length of the buffer.

>> +
>>   	/* setup a probe */
>>   	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
>>   				argc, is_return);
>> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
>> index 553371a4e0b1..d9c053824975 100644
>> --- a/kernel/trace/trace_probe.h
>> +++ b/kernel/trace/trace_probe.h
>> @@ -34,6 +34,7 @@
>>   #define MAX_ARRAY_LEN		64
>>   #define MAX_ARG_NAME_LEN	32
>>   #define MAX_BTF_ARGS_LEN	128
>> +#define MAX_DENTRY_ARGS_LEN	256
> Why do you think
I determined this value according to the extreme case that a parameter 
is expanded to occupy
64 bytes, and a maximum of four such large parameters are supported.
>>   #define MAX_STRING_SIZE		PATH_MAX
>>   #define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
>>   
>> -- 
>> 2.31.1
>>
>>
>


