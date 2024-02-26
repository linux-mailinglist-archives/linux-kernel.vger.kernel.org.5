Return-Path: <linux-kernel+bounces-81750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BC8679B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C7029DA08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1C12F36B;
	Mon, 26 Feb 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cUp00fLH"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810312AAC8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959566; cv=none; b=ATf3BqSoCAW/qzfdAVZ7cU8H3/Sm2Nw6OoKdQ6mJ1A3TxPnzsoECb6FUmmowU78NzatAuoV+ELyRiDQu6FxbEgwqHEjderBd2XYmijzsW2XoZnOLRF7pRtD6MRxWaJjS5naqiEJ/8UHYxFGNP8ccqt0ip30YAA2VL/YgX3q7AAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959566; c=relaxed/simple;
	bh=mdVebCpu4Xy9sWyn2xDniVFB3otacDrIOVWW5mMn9l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo/gG8faaLQmN0A6szSUDVT7jRM+7kX1/f/ezNF3n91qZiuqAzP9W1b9AxV3Y/rCEkV+U1bBvbSzvFFXn+nalFWEV1P1Il5YSRgxa0JhNRcrhjofjk3LRJ5DJEBBn6eSa9IEqH/zQ7qobPQTmz6k4Gekob+fQyuIKyPO5DjFWG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cUp00fLH; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708959554;
	bh=enUPXy9gs1l+3uFAQuBBAMNY03dyHfpXueTAioiTz0k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cUp00fLHknBHuyZSJLVA3Btf2VzLyrlhGLcN2eDvcu7nn3Ere9hiGNVZFiJCNjI91
	 Bcn865bYbQyNUiBsejDZAqfofTs+u3Py7RoKhG1l1ag4LtUtI6J+XeMwjPyJ+xtag2
	 Dpnf5LQSDIu0r2BewT3BnhsPHDri9Z5+o25D0jrM=
Received: from [IPV6:2409:8a60:2a61:ef40:fbe0:92b2:c969:6174] ([2409:8a60:2a61:ef40:fbe0:92b2:c969:6174])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id ECB83AD4; Mon, 26 Feb 2024 22:59:11 +0800
X-QQ-mid: xmsmtpt1708959551tj8mah0pu
Message-ID: <tencent_3716CF645529D4674138937EE94FCC737E08@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS5QyFC/t/p7AKkt/npAuDoSr8o5dPhHz+ta5TkMMGoingNjiYE2
	 P7WXZtjOX07Hi/6h5gTIaKX+O16nuAKmeBxwRu+2/OW+8/RPDYpMqXpHloFGjrs7Fwy92BXSOzDh
	 LBsl1885T2FOAQ0ndajCMCHbhneAvs24pT8wqsoR950QM16AGAl3EwFWLnSVGDPv2XeeABd4kSnH
	 Ta9osK0DpQnycAtjZq6Nw8KT1iOZ7vR6cZK9GbaH0jRo/qIQK6En4CxMCi7k8lTkrfjpsgXCpd0e
	 Epx1yqMmXtjYyCALRH3kSWOaYXqVsGeRJLnx7ZwfiviZEAqnceklce4KfbRiD9hW+Tnq2FEu6axe
	 yUE9QOA2yEPE1L7gZSg1+lfzFVX7jv83aOt3Mvw/wv46nqqjc1xT/mzukJuNSRaW6m6ARIRIoaye
	 yhwwwOHiZB1BL8+RyGmDCNqT+aeQlMPnGbUzl+lnFqy1/La3QDQL1j/LT0iBswhKO3fVmNdEGJNT
	 p2fFEjIDktLO6VqgdutgfEfsrEyrCbyUkRkJkoMJ6vSj6Dj/VTYzhDYEqqbVIZBMJBtgOX9s9mTu
	 L/IGEGSQqD9cdf6J1cgRPg766hIiF8P1147bZin6Zqw2I4UBHGxbfLA0B7KeVlktkyl49mLE+GFe
	 vmeUSU3Uk25h8m0LhiJ5lRFppTdvIbuoDu8QXb59wRBtHile6LJoVaefeZ9Qz8DmhI2Kw67+hffH
	 uzZEXT+2XztmCLI09+PRdgHCAkVcnW3rtRls1Aq6MvSAnUYaIQjkqIC4th1Red9LmLe4UQlpCKas
	 jNXfjDHzaMeczZL6hhlSilh37zyR5cjQ8AdQTgA69aTNfNXXVQ+Ms87z4cMV3oTbmSXgA4WHsshF
	 vxCPplt9T1w43j9LemoUSP9uDMhAyynG/UwL6hHk+ZceZ0pbofm2aBxNm0dCgN3/gefVmRymQaqr
	 jBhHz4IXCWg0Bze3hRr2+W2xdX//AjcjkB4hN2uqbCCCAtntpkGO90O2RrKCOxIpwAu2aEsZ4=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <d7a2d03a-6086-9cf0-f0d9-012e32cfef81@foxmail.com>
Date: Mon, 26 Feb 2024 22:59:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/8] sysctl: introduce sysctl SYSCTL_U8_MAX and
 SYSCTL_LONG_S32_MAX
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
 <CGME20240225040629eucas1p12649e57aa00bbabc99c525b98eb74670@eucas1p1.samsung.com>
 <tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com>
 <20240225201658.h6nod4c4uxclq53a@joelS2.panther.com>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240225201658.h6nod4c4uxclq53a@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/26 04:16, Joel Granados wrote:
> On Sun, Feb 25, 2024 at 12:05:31PM +0800, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> The boundary check of multiple modules uses these static variables (such as
>> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
>> Therefore, add them to the shared sysctl_vals and sysctl_long_vals to avoid
>> duplication.
>>
>> Also rearranged sysctl_vals and sysctl_long_vals in numerical order.
>>
>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/linux/sysctl.h | 15 +++++++++------
>>   kernel/sysctl.c        |  4 ++--
>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index ee7d33b89e9e..b7a13e4c411c 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -45,19 +45,22 @@ struct ctl_dir;
>>   #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
>>   #define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
>>   #define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
>> -#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
>> -#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
>> -#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
>> +#define SYSCTL_U8_MAX			((void *)&sysctl_vals[7])
>> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
>> +#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
>> +#define SYSCTL_U16_MAX			((void *)&sysctl_vals[10])
>> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[11])
>> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
>>   
>>   /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
>> -#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
>> -#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
>> +#define SYSCTL_MAXOLDUID		SYSCTL_U16_MAX
>>   
>>   extern const int sysctl_vals[];
>>   
>>   #define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
>>   #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
>> -#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
>> +#define SYSCTL_LONG_S32_MAX	((void *)&sysctl_long_vals[2])
>> +#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[3])
>>   
>>   extern const unsigned long sysctl_long_vals[];
>>   
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 157f7ce2942d..e1e00937cb29 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -82,10 +82,10 @@
>>   #endif
>>   
>>   /* shared constants to be used in various sysctls */
>> -const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
>> +const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, U8_MAX, 1000, 3000, 65535, INT_MAX, -1, };
> Why do you insert the new values instead of just appending?
> I figure that the patch would be much smaller if you appended.
> 


Thanks.
We originally intended to rearrange this array in numerical order, but 
now it seems unnecessary.
We will follow your suggestions and send v2 later.

--
Best wishes,
Wen


>>   EXPORT_SYMBOL(sysctl_vals);
>>   
>> -const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
>> +const unsigned long sysctl_long_vals[] = { 0, 1, S32_MAX, LONG_MAX, };
> Same here. Why insert instead of append?
>>   EXPORT_SYMBOL_GPL(sysctl_long_vals);
>>   
>>   #if defined(CONFIG_SYSCTL)
>> -- 
>> 2.25.1
>>
> 


