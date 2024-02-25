Return-Path: <linux-kernel+bounces-80164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE223862B41
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E75281659
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729B215E8B;
	Sun, 25 Feb 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VgBh4Y3M"
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256A14A8E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874827; cv=none; b=odu7v1DG3eef+Ytz6fWiFm2bDM2Wq5V5+9Wa4pce/+UzC0/XZgolu2dYXiZO1uf6UVs/yxHrlQ4idW8sK1hKkIGkJYrk8qgK/oW/W8fHcxim3scootKGX52XZCKdM+aKlhjd70HpEHfxi9f5qwABUDJPyyfF5of1+1c8ORYDhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874827; c=relaxed/simple;
	bh=jeNfjnxxcRqnXlrHUNKilYLZvsnJbVm+H0bw7X1E9+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbvFmDh1yoAs67ayuefZVn1twzcBus2Wt1+8rMstMdBw1teDyt1ZGTCPtm9CfbLhIfoCbvZ/jIMHueyfhQTjFPlmzrJc04eZZTWiao62762UXhNKMkgKW7raro09GwfJ8qy8ZVnon5vt348uO3Ad/Ey+x4x079KLD+lpGqI31kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VgBh4Y3M; arc=none smtp.client-ip=203.205.251.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708874515;
	bh=FYkb2WUYghXygfrJl++b1n88w6e+biYY2vkpHFfOpno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VgBh4Y3Ml7NLeiarcuxQ/dkDWKBsYhVFV2EAqIpNnb4eflrFjxI8uxULByJc9VQTR
	 0mz8zzyXLtx3HrXssdFyEAOJaoRO2ABLQmS1mcpuB1s/xt15LYGKdgy2NDN50fj57/
	 le/cR+bTwsnVW2tkiYWbPmgYkoidWqpdBg+WPLb8=
Received: from [IPV6:2409:8a60:2a61:ef40:ff0d:5ef6:e160:29d5] ([2409:8a60:2a61:ef40:ff0d:5ef6:e160:29d5])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 573986EC; Sun, 25 Feb 2024 23:21:51 +0800
X-QQ-mid: xmsmtpt1708874511td34wbheo
Message-ID: <tencent_19AD2A877A2E286032273D82D9CDCFE9B905@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmFWqisWlR7nkfQJyrWg9Qs1NDe9POvBoKvb9jVkhcOVKLkWW866p
	 zo8iPQsO4//0wFfSpMdfEnALu4/wD8bzQwmsSO5Mwl9MnSSdaTe6xIzewsr54OVwiTOK/zuOJtE8
	 GLPbG1rT0QR5r+fGSSBuprt+1HIBrMfrI8xPLmreXmAlr6j2zlZf4po4kgSvi6Fcmre7SpFbPMEK
	 3ya/k9zcjHiD1EFTN10UgLV0yKnjAK7aVQsTCkX9hxqBqJSfXEBXHGqfE2BSc/cHC8p1Jp00gcZS
	 6cpeqnCP1sYdwfq/pFGUkQrSznRGnzAEqEb7tMi8hq1k5f00mfexwe7qmr42KDqB9g+VRabrFusU
	 XLbksApnQ3XaHlxIMUmi4x2WREIqSeeebJk/+BkJB0yPoQp2wqEVBJwIg2xJnWy/INw3xxZou10P
	 nVleW7x6yDeSHk0EQf5dteLMdv4cgVCWPv5Bs7Z731KNyAhJLtc80kXWbc4rt9dGra6UPi37W0c9
	 cbpdqM5dIGvTTF1yzLzKWheiYO7bkkUzhq4JzmZ5Oh40XfP+K+cgwPnHeoaKoeF70aIwrIUjziie
	 /tR1C/x7atrlvwgbdN7AhVO3gYoAjP5s/NFJivANU3KdDzF+xlzWiwFbpVEiB2FFHm7vBCQ6/uqm
	 /qgvE+oQq6ZEvzuQjkSTFnMFmirf1f4Q46y8e/RqMnwpbzZDVKgj3MhHVMTc3GTCs0aJyjMmXALD
	 oRSFaiaNZezPw6wDn81bjE/9T+Egzm56hamtYBO1g0zXfyEwXDvS2JHL035mN6Ay+HYvGyEW5uzD
	 P4piC2/EpjXG7QR/nooTHdggoCIXm4T74ms1G7kBXGoQGXBV/Q3pdYeHwQ5Ro4aRhMJbvXQVeL55
	 rPX2GvPSASJzZHM7v5NJjUjydxD0YJzvZNvra+VPj+Uj4GcujsyKIyxPD8gR1zesLIahUwWyEHk3
	 vof1kUOftMakxFCIo2rzkVk1Br7aBCxXRuG+bhjmX4vRpLB//q8ahK524NC06SOcC5rLcrlqSYBs
	 EB3ENYtQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <3dc8aa60-36a3-b118-578c-873253ceee06@foxmail.com>
Date: Sun, 25 Feb 2024 23:21:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 8/8] ucounts: delete these duplicate static variables
 ue_zero and ue_int_max
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>,
 Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
 <tencent_AA60553AD4DF41859328E9CACC367EFDCF08@qq.com>
 <875xyczpzm.fsf@email.froward.int.ebiederm.org>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <875xyczpzm.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/25 20:29, Eric W. Biederman wrote:
> wenyang.linux@foxmail.com writes:
> 
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Since these static variables (ue_zero and ue_int_max) are only used for
>> boundary checks and will not be changed, remove it and use the ones in
>> our shared const array.
> 
> What happened to the plans to kill the shared const array?
> 
> You can still save a lot more by turning .extra1 and .extra2
> into longs instead of keeping them as pointers and needing
> constants to be pointed at somewhere.
> 
> As I recall the last version of this actually broke the code,
> (but not on little endian).
>
Thank you. While developing a driver recently, we accidentally 
discovered some redundant code related to extra1/extra2, so we tried to 
optimize it a bit.


Thank you for your comments. This plan (kill the shared const array) 
seems meaningful and should require some work. We are very willing to 
participate.

I am glad to receive your feedback. This plan (kill the shared const 
array) seems meaningful and should require a lot of work. We are very 
willing to participate.


> This one if the constants are properly named looks better
> than that, but I don't see any reason why you want shared
> constants for such a handful of things.  Especially when
> it has proven to be error prone in the past.
>


This patch series replaces multiple static variables (such as zero, 
two_five_five, n_65535, ue_int_max, etc) with some unified macros (such 
as SYSCTL_U8_ZERO, SYSCTL_U8_MAX, SYSCTL_U16_MAX, etc.).

Although according to the current implementation of sysctl, these macros 
are currently defined as pointers to the elements of this shared array, 
and they can also be easily switched from pointers to appropriate 
numbers when the shared array of sysctl is removed according to the 
above plan.

So the current patch series is also beneficial for subsequent 
optimization, that is, deleting this shared const array.


> The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know
> how to stomp kernel memory.
> 

As above, thanks.


--
Best wishes,
Wen

> 
> 
>>
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   kernel/ucount.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/ucount.c b/kernel/ucount.c
>> index 4aa6166cb856..05bbba02ae4f 100644
>> --- a/kernel/ucount.c
>> +++ b/kernel/ucount.c
>> @@ -58,17 +58,14 @@ static struct ctl_table_root set_root = {
>>   	.permissions = set_permissions,
>>   };
>>   
>> -static long ue_zero = 0;
>> -static long ue_int_max = INT_MAX;
>> -
>>   #define UCOUNT_ENTRY(name)					\
>>   	{							\
>>   		.procname	= name,				\
>>   		.maxlen		= sizeof(long),			\
>>   		.mode		= 0644,				\
>>   		.proc_handler	= proc_doulongvec_minmax,	\
>> -		.extra1		= &ue_zero,			\
>> -		.extra2		= &ue_int_max,			\
>> +		.extra1		= SYSCTL_LONG_ZERO,		\
>> +		.extra2		= SYSCTL_LONG_S32_MAX,		\
>>   	}
>>   static struct ctl_table user_table[] = {
>>   	UCOUNT_ENTRY("max_user_namespaces"),


