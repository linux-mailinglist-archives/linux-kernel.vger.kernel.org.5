Return-Path: <linux-kernel+bounces-128169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F7895724
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617611C22507
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2B131725;
	Tue,  2 Apr 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rQsPMRow"
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC212C520
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068756; cv=none; b=SAVFydrF+XDkDeH0ZyS5i/xoRcdBbKEnXJ/Ec5JDUdLKhnpHF1g4mXB5x9/sNzXMOnD3L+3a2xhQjFTHq3GjdXzgiIGQRYtS9Q+oRfIq6prrtA7hM4nxvDqsVdcqvy0+72LIHRr48pRsQWuldV6A4q0m77dzGZKaVLlCmopeXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068756; c=relaxed/simple;
	bh=GqIAkBZhCSE7T+9Q/L2iFkvBGteNe+4Y79ZOv2wjbpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0We3M81Yeyb4GUcBzlAZ8xNoC2ql3WmePkODj1UwPZt5/y98aom/beMqd5GhzynPjtESscXi72JY2yjWiiYvFaY6bIDx3i0t8zmAsIp79c/mNHvsSlqk3YKBJE5nnoTDqCcyqK+FfY/goB1/6e0RLMdPj35EZlxp/X0HYpQrLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rQsPMRow; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1712068751;
	bh=+lvZvZ6fgKMMXekKrbmm+jPgvdCYF6O/k5bC8lil4qY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rQsPMRow+eB5hcRu2QKU4pJFCFICwCrk+ZenBXIxCnYQoKn41oZIFLOL9/9Zq4EDd
	 Rkpy8phYII2/mGOdNkokwC/D3BDTn5ZArsbWeeNW6irOszXQEWnHq1XknX0yL+x9z6
	 0ajpit9qh4dYOgG8H/H3wsRSWApko+8tbgPIXeYI=
Received: from [IPV6:2409:8a60:2a60:b160:3070:152:b0c3:db89] ([2409:8a60:2a60:b160:3070:152:b0c3:db89])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 9C392E33; Tue, 02 Apr 2024 22:39:03 +0800
X-QQ-mid: xmsmtpt1712068743tin63xyu9
Message-ID: <tencent_01245C3A3D73B19FD473649517B56C50D706@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQWsMsoX3hb2F8LGJ8yVTex2llcGPxt0zWhz/np6S8ELLMluS0qy
	 vl6YEuZdKYWfc/IPjb0bLIzx3JgDF3WZQJFPJiKWl/ZvfOyOgRmvfMxcLjOg1GhqmRASVVT0X8Q4
	 XY3T1QTfl+nzrb1QnDhu+3n2YR7wD+i5BJdrP9bLA0Ol2W0Ft3YqnZx4SXei7wQHzMqRezAXQbXb
	 iGfkVC4Zy7kCKwCVpOhYjBvlF0VdGp+vwlro5bb/l0FKQFkBRKTxuCsD/s50nvxvfbRM8+JwAwEQ
	 7djRdjnBXWMclgsmRE0KFlq5yE5qlG9SymyUwTirPWWhUmYF/CkSY+N7IzHw8gBN54IiO5zI2TTW
	 I/dv9pnt6dxmVRrXhVZOBgIMtD1oviHQo7qRpl78A3MG14TuxjVWgnMXMP+y8d4FzEpSvTBeVn7Y
	 eCYRh54pVWxeIGv0LnRvkYMj3Rrs+jS6HDUJOQpXoKvX0rKhFj6slRUKcRac3BGhUE65wh6NEA+0
	 nUPa16eMG9iL1OkP4VkuQa/Rfs1YNk9NHIy5BsHopsxBzIg52QMo7OOOrX7nlF5Lza/lPdA1n3Wo
	 jtJ5ci46aL0m9+ocBoqEinJE1+qLED9hbdCt72VWlh8fK1fh/k/nLCNuGAhMkfkAhBJt37vYV+bC
	 SSIvQezEcUPhY8XSRZysbg+I3iysxijM+hHAcM3VIVGDKllQEHjtGNVBynGSRMZY9NzzZ1Mm5+ai
	 74kV1ck9z9EXG3wsLB/edJm20lKjmsWk5ilmKHDoXIZ62d+FFGoqbQJZpgXbgyRlByhTbco2f5qE
	 jjIbEwfL1uiqtzJn4sdL7MdYfN+mbbcE6adxKwEhbu+BRSqZHFZLBIOHQ3UGpSnLqZ7XeK4Qn569
	 g0h8DT62BtkILp86//W6WlAzjtVG9RzPkX0snHY0/mmfDWlLxm9tMZVTJUWcMMe0YiINByoxXqdp
	 C7K2K98jkFbD98tIT+ofcUG82YCN0IVXtGp/hmaBSCsNcTNqCz6BfrTJMxhPcwN7KsjGoyGdwLF0
	 Jvv2+/CA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <ac20cef4-94b0-a05b-2788-46d9dc8c65b7@foxmail.com>
Date: Tue, 2 Apr 2024 22:39:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] sysctl: move the extra1/2 boundary check of u8 to
 sysctl_check_table_array
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
References: <CGME20240302152805eucas1p22ac49edeee0be22bcf5562daeba11716@eucas1p2.samsung.com>
 <tencent_8599CCEFED19AF4A8A5A358862B226FD8A05@qq.com>
 <20240328165341.3ov54gwjymghtp2g@joelS2.panther.com>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240328165341.3ov54gwjymghtp2g@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/29 00:53, Joel Granados wrote:
> On Sat, Mar 02, 2024 at 11:27:45PM +0800, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
> 
> <--- snip --->
> 
>> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
>> index 6ef887c19c48..84e759a8328f 100644
>> --- a/kernel/sysctl-test.c
>> +++ b/kernel/sysctl-test.c
>> @@ -367,6 +367,35 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
>>   	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
>>   }
>>   
>> +/*
>> + * Test that registering an invalid extra value is not allowed.
>> + */
>> +static void sysctl_test_register_sysctl_sz_invalid_extra_value(
>> +		struct kunit *test)
>> +{
>> +	unsigned char data = 0;
>> +	struct ctl_table table[] = {
> I'm pretty sure that this is going to clash with the constification that
> Thomas is working on. Please re-work this patch knowing that these
> ctl_tables are going to have to change to const at some point.
> 
>> +		{
>> +			.procname	= "foo",
>> +			.data		= &data,
>> +			.maxlen		= sizeof(u8),
>> +			.mode		= 0644,
>> +			.proc_handler	= proc_dou8vec_minmax,
>> +			.extra1		= SYSCTL_ZERO,
>> +			.extra2		= SYSCTL_ONE_THOUSAND,
>> +		},
>> +		{}
> Don't use the sentinel here. We are removing them and all new sysctl
> tables (even the test ones) should be created without them
> 
>> +	};
>> +	unsigned int size = ARRAY_SIZE(table);
> You do not need size here. When you use register_sysctl, the size will
> be automatically calculated for you.
> 
>> +
>> +	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
>> +	table[0].extra1 = SYSCTL_ONE_THOUSAND;
>> +	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
>> +	table[0].extra1 = SYSCTL_ONE_HUNDRED;
>> +	table[0].extra2 = SYSCTL_TWO_HUNDRED;
>> +	KUNIT_EXPECT_NOT_NULL(test, register_sysctl_sz("foo", table, size));
> Replace all these by register_sysctl please.
> 
Thanks for your review comments w.r.t [PATCH v2], which will be complied 
by in next patch version [PATCH v3].

--
Best wishes,
Wen

>> +}
>> +
>>   static struct kunit_case sysctl_test_cases[] = {
>>   	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
>>   	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
>> @@ -378,6 +407,7 @@ static struct kunit_case sysctl_test_cases[] = {
>>   	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
>>   	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
>>   	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
>> +	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
>>   	{}
>>   };
>>   
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index f67b39d3d6e5..28888744626a 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
>>   	if (table->maxlen != sizeof(u8))
>>   		return -EINVAL;
>>   
>> -	if (table->extra1) {
>> -		min = *(unsigned int *) table->extra1;
>> -		if (min > 255U)
>> -			return -EINVAL;
>> -	}
>> -	if (table->extra2) {
>> -		max = *(unsigned int *) table->extra2;
>> -		if (max > 255U)
>> -			return -EINVAL;
>> -	}
>> +	if (table->extra1)
>> +		min = *(unsigned char *) table->extra1;
>> +	if (table->extra2)
>> +		max = *(unsigned char *) table->extra2;
>>   
>>   	tmp = *table;
>>   
>> -- 
>> 2.25.1
>>
> 


