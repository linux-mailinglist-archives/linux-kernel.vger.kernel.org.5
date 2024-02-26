Return-Path: <linux-kernel+bounces-81771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABE867AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4831CB29E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101912EBF8;
	Mon, 26 Feb 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="XEjx0Rcs"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93B12E1F5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960418; cv=none; b=PRbPx2QRW5MXqinu2TlXgMN77MTz+73ywWw7UBZ3yVpjvAJ2rfyejAxEoTpiJD/9Wuvga8uC3fLnPfxLQG0y0F3DLaA1PhSQI5ew1zqJkpTMhDl/hjZnqdrWYlFk7XS9ttVrMo8Q3LNH3UrVL0Af8L+5k0s7+ERFeS6PHWA1I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960418; c=relaxed/simple;
	bh=a9sZHmPNSYvvyUMk4Np5KpW40DeiD2XNdE5nxzux6lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmVwiAWalSOO6G134zZgJTzs1cFITnmodVeZkwD4eu+Q86599xK5wFtsrASxU6pHI4rxjc1dzeZVsDNBjwEct4nQRLc+uzw5w9VnGZg2tFU1GX77bnhgOZyvsiL2tOpJq0o20pPNdfklCetI6VSHE1nmM00R7ZR1ZnRtJeA9Hwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=XEjx0Rcs; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708960108;
	bh=SFq2hFhcGb2YTeIjHHRolKVfmkIoy9z4z01z4CBSmzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XEjx0Rcs4ROQXwyOu6hD/m/lK9RNcVrCpFahwC4rpXkFtnVfYQlcx9FWd4Cjl1tRQ
	 8BD1Xt7JaDmbe6RRWU6SoLrVVVci2DBebFKSkh8QBjOi+qP2zoCpWQL1FIXCL/XR6J
	 fnK7S3yXk8ooVehdEBet7ngx+cE8A7fAhCtOoXpc=
Received: from [IPV6:2409:8a60:2a61:ef40:fbe0:92b2:c969:6174] ([2409:8a60:2a61:ef40:fbe0:92b2:c969:6174])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 1B73D6B6; Mon, 26 Feb 2024 23:06:55 +0800
X-QQ-mid: xmsmtpt1708960015tdgk9p8qf
Message-ID: <tencent_B7413C3B5419512F059D4D86A5CF301FFB0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9dUGGEyuM81QZpJGtcuH4n5XQlnzX+hwajLhuO+z2gg+F7lHwyR
	 daesKfcRuM5OV5F7yB5P7xEpzhOu1HgEX/R61c+OqiWOCwIOunSY6L3Y0L+E5HUz/RAwE7p+HUyK
	 k+XDVZAvu1ZhG0yRIiGKcub9xIFNIHi2v19MW8wD1GSYqSOjTxCkJbbRyqOTG2RJ1b1EFs0pPBZb
	 niODCA72BRHtbRrwv8Vc07nY1Ha+W/GfAl2TYn9+AFFBbkISL5Psz4l3elPJk8PPa3Lw2Q/tiiOy
	 ffdQjVQrDJpBWivy0m/rjFfAeGV5H6WZq3UtOzfHfcEil0l92zBwt8y47Dqbp+abG7iritYhb9ve
	 U8qKvb+BP/NbqFO+VKl2Dlhe5R9TPU01mpHp8qlUBY9MP/H/+MxvdKTKRfSd8inMKiK1H4vlLnRG
	 YpHfDgrz0L+MlSNFzqcy/zSroZhflbejmQ9kq6Se2WQMgegvP4z/n4Ap8Dg21T/nAJMaHsP3acEh
	 J9TsAjbaplJ57KdZE1cFLgGPWcQbatQxyY/autyPTzj5l01OPaPUQ0cKZv3hxsNORBZaWF30E4mm
	 R/N2Xp5FT5uOW2prhfGYrJJMxHdB+sGAJN1r7lOO5HVV9X2uRyQtpF8odqI6M1/MuUbqfcHJD/F4
	 niVNnJy9ugV59xEG5gTSh0RLu0mH7goq5C7A+kJYXOedw4PeCfiqMMP6swJGndDecWi9gDkX+0ka
	 3sbZO25T8mHuSsJ3uhVrUCz9mRu1oEaw67FNIAjO1ex4H27VZHUXq74wwVpt7cnTBZQauNppJx1L
	 z1RR9moi5aK8nuvqXORttCJoauCTZWzXI+Sm+u71jhhbsmYnuXUQSGpkWiMvQ+D3hiG2RKUpLxg0
	 f9blwavHiCQ7lrywk8PUYq3q1RlNofGKML3kUpROZ6qmKdy9jJ1YFhoJfct/CgQqPcXHl43grdVr
	 CdMfdo5dBDgj+8QDBjWkKZq2eww4ZV6oRtEHisZkX+P7R+IQcvpGVFSO9GeOb4hk9N7FBpSRI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <562b4bbe-53a4-5073-30ce-eaa8bba1a5ba@foxmail.com>
Date: Mon, 26 Feb 2024 23:06:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] get_signal: simplify/cleanup the the usage of ksig->info
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
References: <20240223105025.GA4542@redhat.com>
 <tencent_7C50F304C14CB2A5133317F8A13D1F544D0A@qq.com>
 <20240223141928.GB8267@redhat.com> <20240223143131.GC8267@redhat.com>
 <20240223144458.GD8267@redhat.com> <20240226095240.GA9510@redhat.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240226095240.GA9510@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/26 17:52, Oleg Nesterov wrote:
> OK, lets forget about "no need to initialize ksig->info" part for now.
> 
> Yes, PF_USER_WORKER's never dereference ksig, but I agree this doesn't
> look clean without other cleanups. I'll probably return to this later
> when other pending problems with PF_USER_WORKER are fixed.
> 
> Wen, thanks again for your review.
> 
> Oleg.
> 


Thank you very much, Oleg,

We greatly appreciate your comments and the discussion has given us a 
precious opportunity to understand the linux signal.

--
Best wishes,
Wen


> On 02/23, Oleg Nesterov wrote:
>>
>> On 02/23, Oleg Nesterov wrote:
>>>
>>> On 02/23, Oleg Nesterov wrote:
>>>>
>>>> On 02/23, Wen Yang wrote:
>>>>>
>>>>>
>>>>> On 2024/2/23 18:50, Oleg Nesterov wrote:
>>>>>> +			/*
>>>>>> +			 * implies do_group_exit(), no need to initialize
>>>>>> +			 * ksig->info
>>>>>> +			 */
>>>>>>   			goto fatal;
>>>>>
>>>>> There is little question:
>>>>> If the this conditions is met:
>>>>>     current->flags & PF_USER_WORKER
>>>>> It may execute “goto out“ instead of do_group_exit().
>>>>
>>>> Yes, but vhost/io workers do not use ksig at all.
>>>
>>> Ah, wait...
>>>
>>> I forgot about the ->sa_flags check before hide_si_addr_tag_bits().
>>>
>>> OK, thanks... I'll send V2.
>>
>> Tomorrow.
>>
>> I'll recheck, but I think we need the patch below as 1/2 regadless of
>> this change
>>
>> Oleg.
>> ---
>>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2897,13 +2897,13 @@ bool get_signal(struct ksignal *ksig)
>>   		/* NOTREACHED */
>>   	}
>>   	spin_unlock_irq(&sighand->siglock);
>> -out:
>> +
>>   	ksig->sig = signr;
>>
>>   	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
>>   		hide_si_addr_tag_bits(ksig);
>> -
>> -	return ksig->sig > 0;
>> +out:
>> +	return signr > 0;
>>   }
>>
>>   /**
> 


