Return-Path: <linux-kernel+bounces-31716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C58332EF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40A4284B52
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E281FD6;
	Sat, 20 Jan 2024 06:26:54 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539ED1856;
	Sat, 20 Jan 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705732013; cv=none; b=mOEu/Gjl3ZnTRbEm2Mwf/fAEC/6LpKJ4TKIyKZWXCGB3B8QrtqEGvKNekt6MOkA3a6f3zQYg7dcwXjZ6X26U8iG3atg7z1MXGXgpSrpZLPtiXTIm51Cc4mjLwCmuyvqxaGwTUhIHBu6/6FTKkIeyAsm/Jk4wbX2zLJerFyBhuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705732013; c=relaxed/simple;
	bh=z0u6S3vvz6Wa3U8Vbzh/1y+xQOvDrXCzXXQdLEA1UBk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LQGkY15DAJeGysjiw8c/8LngYAthrFMLyTbbmIOL6VS+ccTnt7WTM8Iq41OPBwQ14QUzpGuGuDF99CD5lWLB5s/rmNb9tTcJ4pWQmgG9Sn7DtHsyUg3+pm6spp0EL9VHW5Ffa72xV3y6FTy/HMufCIpjCzrBicl6ouGqLcY78U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TH60X16yFz1gxkm;
	Sat, 20 Jan 2024 14:25:00 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 937421A0172;
	Sat, 20 Jan 2024 14:26:40 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 20 Jan 2024 14:26:40 +0800
Subject: Re: [PATCH 0/3] support '%pd' and '%pD' for print file name
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20240119013848.3111364-1-yebin10@huawei.com>
 <20240119234356.1598e760edbfa58f5440a941@kernel.org>
CC: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <65AB679F.9070402@huawei.com>
Date: Sat, 20 Jan 2024 14:26:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240119234356.1598e760edbfa58f5440a941@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/1/19 22:43, Masami Hiramatsu (Google) wrote:
> On Fri, 19 Jan 2024 09:38:45 +0800
> Ye Bin <yebin10@huawei.com> wrote:
>
>> During fault locating, the file name needs to be printed based on the
>> dentry/file address. The offset needs to be calculated each time, which
>> is troublesome. Similar to printk, kprobe supports printing file names
>> for dentry/file addresses.
> Hi Ye,
>
> Thanks for your proposal!
>
> Generically, I think this type of hack is not good for the tracing
> because there are already some ways to do that. e.g.
>   - Use perf probe to specify dentry->name:string or file->name:string
>   - Use BTF to specify in the same way (but only for function entry)
> And those are more obvious what it does.
>
> However, if this is implemented in more generic syntax, it will be
> acceptable.
> For example, type specifying with "arg1:printfmt(%pD)" will be
> more generic because it is apparently one of the printfmt and output
> string. Or, maybe we can just allow to use ":%pD" as a fetch type
> (start with '%' means the printfmt)
>
> Also, could you update readme_msg[] in kernel/trace/trace.c if
> you add a type, and add a testcase of selftests/ftrace, for this
> feature? Documentation should also be updated with more syntax
> information.
>
> Thank you,
Thank you very much for your suggestion.
I will re-implement this function according to your suggestion.
>> Ye Bin (3):
>>    tracing/probes: support '%pd' type for print struct dentry's name
>>    tracing/probes: support '%pD' type for print struct file's name
>>    Documentation: tracing: add new type 'pd' and 'pD' for kprobe
>>
>>   Documentation/trace/kprobetrace.rst |  3 +-
>>   kernel/trace/trace_probe.c          | 50 +++++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.31.1
>>
>


