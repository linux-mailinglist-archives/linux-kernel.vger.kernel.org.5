Return-Path: <linux-kernel+bounces-111715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C65886FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0D31F211BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAB25381A;
	Fri, 22 Mar 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Zs/EUJ+o"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA1535A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122221; cv=none; b=CL1Fim01Nr3aTFBxk8hxoMbSK7Q+j+HppJ4MnF6z5rmhpMzII/cPHesuFVLU1cSO2yp7fM9PZTyvOKzEsMovTTsW8qDX80kdEafSXEFCoUd2qLKgnlm0YwQtzX1bAgEqcjDN3c3oXsX8EGCr7LQQxY1Vj/WGk/pNxf8CKK6wQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122221; c=relaxed/simple;
	bh=Q6Z6Y78zjUvTC8yteKd1TQVGNbJDKneCaLYEMur8mxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc6zGMQPFX9vH6Sjj0x4sKNh8vtTyb/yxKamr/n+73+SwPo9oYDOaZ9QqzlZ+CoNNMHdRvBMQSNocaav1lEHgciOREvFN2FugYEC8sGJ6TywoGZlBp8Ql5V8LsNecWSpitefl0ltXXStMlnD2wP8CLWC/yeP/C7F7PUYPq3IxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Zs/EUJ+o; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1711122200;
	bh=GJDoebOMWa+Y0Raoch9R+8A+TdpWU0Z/PpJq6lCHs6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zs/EUJ+oMoHVriSST6i1CjpeDUWlY538CHfaf2rN7C2Q7zAZLdjG3dCOrtRmstgNj
	 QM9fRqXtUkkAIyGc29r6NiTxGxXxfKVYluMZ6UfIrHSQqFwPOs7R3BP8dUIZrUVZzr
	 4FXpoTvp3IbZ1ojLV+r1tdwi5hnqQNy1FVp0B2wk=
Received: from [IPV6:2409:8a60:2a60:b160:6151:55c3:310e:bea2] ([2409:8a60:2a60:b160:6151:55c3:310e:bea2])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id AD1AA813; Fri, 22 Mar 2024 23:43:17 +0800
X-QQ-mid: xmsmtpt1711122197t0jl68v9r
Message-ID: <tencent_994355E551CB05854C76A567301BFBC93D0A@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuB5p/v5iz0Q0ujBbw/MIFnFSrdTczd2bd4wtTVCFD05Prvs02YF
	 jLLk54G08UwlThkawrau0hVOMoANUFxDDyd0L7UJn0VRoibaagbW758wy2oQNmqatQWXKY4ycwzo
	 HV1/Fw8XWJV0Ep17P8zwFqtrGc7KKMhFgcCQOmNi+Wr+Elg58iTX/xjY8VSJI8Gd0rGSQ0MM76fK
	 dGY6HrsRncuRAzb9ae8kV16t7edI1FtzLyoNZHGaIeubpR5hxrUzgJNbruqyfUF+n24kF9B0XT3v
	 /HKBls+dIS0cQ8dIpnw9cJ95OEjri3E7cOJ+iXBfIH8Ct+tE2p/2JFITsPUPqTqHu8YAZTgnkbXI
	 or+4IDvznk9TZMisqPQmIQHMobddlVGicV5R0tlnAfHFUHc6twg7jrZpSr/TuDcF6BHMh0QjBcXj
	 E0DGJQeML5dA0IzBtRtaT5nloMfr0aP5sQwUTur8SeZJJzL4l6HsJXU1lmepTQX+steTQ/prNqC/
	 7VC86yQCipXLJBt+brFpafk6OMb6F7qHNP0g8h23atyULJlan5COwBdrkWLnxHhGwmMj0cmppZt9
	 n2Xr2UXJlgmQE5/UJKS0mAaKnE8xCE0pDxZVzTML6kzkeOGwqzUFjgBJcpPZWZ0KIxmx0A+ZW1y/
	 L9BJj1MgPiSqwAnsw6GGbpCyS06omK2ozvs8DxUgqmld2jdCu2dAgB0YnYdnge0k3XqVKQWMKdFE
	 Mv2VyPnpffHocogPpFonA5/csLGKoBJlgyPPU2zU8iXmsRWxBlkoB/INC1QYA6JXKfFDWYW60MdI
	 0OtAHFThkoIaqGhaxl8/JXomuaziGroERMzWhBzLzJ04LZxlzrsjaeUn53B2QIVgjp+nNFN6G8R4
	 H+/SLIqT9WGaaAeaU69nunNWZFlhndRVrX21pUcbF3w9VT3ddfmthO9FwroqWOBbF7GQg3R6G5FK
	 N7UPxWkqx6+7nkdPzGj3+pFx1df8g3dCapve1QonUYRrfULX/HWmuoZP2KIjETlRZDjwovnvtJ1i
	 p2/v53TUKlhTaAOdJW/UheTH04Ji3RLdsW6XGMGmYtfYh5fuBHx8hklIptnXg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <c6a42566-0503-7491-083d-a90bb7a21f35@foxmail.com>
Date: Fri, 22 Mar 2024 23:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/9] sysctl: support encoding values directly in the
 table entry
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, Iurii Zaikin <yzaikin@google.com>,
 linux-kernel@vger.kernel.org
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
 <CGME20240309103218eucas1p12d642356f7e90ebdf6a7a3101688f55a@eucas1p1.samsung.com>
 <tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com>
 <20240321162758.tkituzvff5rwnvd2@joelS2.panther.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240321162758.tkituzvff5rwnvd2@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/22 00:27, Joel Granados wrote:
> On Sat, Mar 09, 2024 at 06:31:18PM +0800, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> Eric points out: "by turning .extra1 and .extra2 into longs instead of
>> keeping them as pointers and needing constants to be pointed at somewhere
>> ... The only people I can see who find a significant benefit by
>> consolidating all of the constants into one place are people who know how
>> to stomp kernel memory."
> I'm assuming that this is the "why" of the commit. Please change it so
> it is more direct. Something like "Directly encode numeric values in
> macros in order to ...". If you want to add Eric's opinion please add it
> as a link (Please follow Documentation/process/submitting-patches.rst)
> 
> 
>>
>> This patch supports encoding values directly in table entries through the
>> following work:
>> - extra1/extra2 and min/max are placed in one union to ensure that the
>>    previous code is not broken, then we have time to remove unnecessary
>>    extra1/extra2 progressively;
>> - since type only has two states, use one bit to represent it;
> Please remove this optimization from your commit. This will conflict
> with work that Thomas is doing here
> https://lore.kernel.org/all/20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net
> 
>> - two bits were used to represent the information of the above union( 0:
>>    using extra1/extra2, 1: using min, 2: using max, 3: using both min/max);
>> - added some helper macros.
>>
>> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Iurii Zaikin <yzaikin@google.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/linux/sysctl.h | 108 ++++++++++++++++++++++++++++++++++++++---
>>   kernel/sysctl.c        |  61 +++++++++++++++++------
>>   2 files changed, 148 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index ee7d33b89e9e..1ba980219e40 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -61,6 +61,25 @@ extern const int sysctl_vals[];
>>   
>>   extern const unsigned long sysctl_long_vals[];
>>   
>> +#define	SYSCTL_NUMERIC_NEG_ONE			((long)-1)
>> +#define	SYSCTL_NUMERIC_ZERO			(0L)
>> +#define	SYSCTL_NUMERIC_ONE			(1L)
>> +#define	SYSCTL_NUMERIC_TWO			(2L)
>> +#define	SYSCTL_NUMERIC_THREE			(3L)
>> +#define	SYSCTL_NUMERIC_FOUR			(4L)
>> +#define	SYSCTL_NUMERIC_ONE_HUNDRED		(100L)
>> +#define	SYSCTL_NUMERIC_TWO_HUNDRED		(200L)
>> +#define	SYSCTL_NUMERIC_THREE_HUNDRED		(300L)
>> +#define	SYSCTL_NUMERIC_FIVE_HUNDRED		(500L)
>> +#define	SYSCTL_NUMERIC_ONE_THOUSAND		(1000L)
>> +#define	SYSCTL_NUMERIC_TWO_THOUSAND		(2000L)
>> +#define	SYSCTL_NUMERIC_THREE_THOUSAND		(3000L)
>> +#define	SYSCTL_NUMERIC_16K			(16384L)
>> +#define	SYSCTL_NUMERIC_U8_MAX			((long)U8_MAX)
>> +#define	SYSCTL_NUMERIC_U16_MAX			((long)U16_MAX)
>> +#define	SYSCTL_NUMERIC_INT_MAX			((long)INT_MAX)
>> +#define	SYSCTL_NUMERIC_LONG_MAX			(LONG_MAX)
>> +
>>   typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
>>   		size_t *lenp, loff_t *ppos);
>>   
>> @@ -131,6 +150,18 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
>>   #define DEFINE_CTL_TABLE_POLL(name)					\
>>   	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
>>   
>> +enum {
>> +	SYSCTL_TABLE_TYPE_DEFAULT,
>> +	SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
>> +};
>> +
>> +enum {
>> +	SYSCTL_TABLE_EXTRA_PTR,
>> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,
>> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,
>> +	SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX
>> +};
>> +
>>   /* A sysctl table is an array of struct ctl_table: */
>>   struct ctl_table {
>>   	const char *procname;		/* Text ID for /proc/sys, or zero */
>> @@ -138,20 +169,39 @@ struct ctl_table {
>>   	int maxlen;
>>   	umode_t mode;
>>   	/**
>> -	 * enum type - Enumeration to differentiate between ctl target types
>> +	 * type - Indicates to differentiate between ctl target types
>>   	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
>>   	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
>>   	 *                                       empty directory target to serve
>>   	 *                                       as mount point.
>>   	 */
>> -	enum {
>> -		SYSCTL_TABLE_TYPE_DEFAULT,
>> -		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
>> -	} type;
>> +	u8 type:1;
> As I said before. Please remove this from your patch.
> 
>> +
>> +	/**
>> +	 * extra_flags
>> +	 * @SYSCTL_TABLE_EXTRA_PTR: flag indicating that this uses extra1/extra2.
>> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MIN: flag indicating that this uses min/max
>> +					      and min has been initialized.
>> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MAX: flag indicating that this uses min/max
>> +					      and max has been initialized.
>> +	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX: flag indicating that this uses min/max
>> +						 and both have been initialized.
>> +	 *
>> +	 */
>> +	u8 extra_flags:2;
> This extra_flag is needed because now you have lost the extra bit of
> information that the NULL pointer gave you. This is effectively adding 2
> bits per ctl_table element for all ctl_table types; event the ones that
> do not need min max. So how much will we actually save with all this?
> once you have added these 2 bits and removed the static variables from
> the files that are not using the pointers? Is saving read only memory
> the only reason for this? If that is the case, please add some
> calculations of how much we save to see if it actually make sense. To
> calculate the memory gains/losses you can use the bloat-o-meter script
> under the scripts directory (something similar to what we did here
> https://lore.kernel.org/all/20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com)
> 
> I'll hold off on reviewing the other patches in this set until this is a
> bit more clear.
> 

Thank you for your comments.

When we started this work, we had not yet seen Thomas's patch, so by 
borrowing the existing enum type‘s field, we can achieve directly 
encoding values without increasing the size of the ctl_table.

We really appreciate that you pointed out this issue. It will take some 
time for rework and the v3 will be sent out within a few weeks.

In addition, the patch below is not related to "kill sysctl_vals". It is 
just a regular optimization and was sent over 10 days ago. We also hope 
to receive your kind advice:

https://lkml.org/lkml/2024/3/8/871

[RESEND PATCH v2] sysctl: move the extra1/2 boundary check of u8 to 
sysctl_check_table_array

--
Best wishes,
Wen


>> +	union {
>> +		struct {
>> +			void *extra1;
>> +			void *extra2;
>> +		};
>> +		struct {
>> +			long min;
>> +			long max;
>> +		};
>> +	};
>> +
>>   	proc_handler *proc_handler;	/* Callback for text formatting */
>>   	struct ctl_table_poll *poll;
>> -	void *extra1;
>> -	void *extra2;
>>   } __randomize_layout;
> ...
> 
> Best


