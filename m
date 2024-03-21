Return-Path: <linux-kernel+bounces-110175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50536885B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094F62847C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355985287;
	Thu, 21 Mar 2024 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="U+wC312y"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A1E53F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032406; cv=none; b=ONPvw5l50gGR6+RyxyVB2qbvWtt9o9XY1gWmwC+hEtGQvxZbkfmsy6DEc4xYtc3y4vWwk3UvNtgJoxJTqNu1eJ2JKbD5YJEIOkdK4pTxM8Q74OqhiDFBC0gN0i4pDVr7tqCCt+215ek9ecTNAWp5XdAjY1mX92lBzFxOi0OAq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032406; c=relaxed/simple;
	bh=zxhRwOsFyhVRegkN33+YoEjELQmIBtiaTY2brmh+8B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1WyKe0GzzppSQ4R3rPkSt6IIwiZKfgmFwnKsi9FFI2D/d+9VqHxOkq4vZ0RNXCS5LPCQpgsacPIxe686k/llEfVVkhmXtKUHMegitszzrv/a88GJE92s4+Z4OFMiHrOPIn1t9UfOP1z38keXAR/vMET9a5MxtuOTjECKUjCIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=U+wC312y; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1711032091;
	bh=vTWFz+Pw5yojbV5cXwUOynQbY7P0Q2w1AOEzaUfmi8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U+wC312yV1bY1vcDpjuQ/Q00ABWcsVAtIef/eZQAzUWPTagUtJwkpubNvmeXjFwOr
	 Ape42FyHLqleUB5Da2OPCQu1IYcEMx9UUZ1qFaQzC5nt2kTABPFTAj7K5lIErMPIJJ
	 /0v0TAvRF8jqT3oGzfxpl6X54o5VNPpCZN0fyicE=
Received: from [IPV6:2409:8961:2b17:549c:98ce:49d:c167:4134] ([2409:8961:2b17:549c:98ce:49d:c167:4134])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id A5B91E86; Thu, 21 Mar 2024 22:41:27 +0800
X-QQ-mid: xmsmtpt1711032087tw819upuw
Message-ID: <tencent_5C3A21886D522B5D9DF9CAAFF499AB6A9805@qq.com>
X-QQ-XMAILINFO: MIOa0ndEC0Bb5qTuuc2aknIKy4bUopvlJvEGPl3FLQhh+gjZDoBz/giuHq6feo
	 8aHsrCVwfjESp5ZjDonDzpFWBudu5KCBdIl5s6wOTS9Zq8E4s0wJnVn6JUOly6QbFA3Y5uQAnYzj
	 9Uh4AotqTzWSIScJD4DQQBxOXHdgEVnTt7lleiOzq9FW74QmvWXuBZPJS8lBXB9W1jYrCTw+YnBT
	 2xB0+vhlX3lhObu+7sYWamOCzMzkUJr5ilI7ISGg3ddsjTh764teJaZfEfDcGk6db0f2k4cxOdFh
	 B2mj9YG4eAlzOp4YUL2k4StxA9Y3fwvb0MsKRvy242kO1gxn0GCTQdLn7L5u+1kAfYjUzzabff0A
	 WgRrSLH8Fwpn4+ByJfj9jy3UAp6t28XxA3SW2YLbOsiLGbEB7bpiDCSLRTZeyMkllyi1LFM8lJvA
	 cEf7d2vV83iKQJs18SBRCBNuQMaBRs1nMVOnULtf/HtHJozUPvbA+cGS93v4HnjFeYBMI1l3Mixt
	 ks92K4g3UU2ZzaQ/rKEu9ZoNo19Hlk2wRNEKQEFWkzTn2RQZG9ckB3U7Igs6loTEoa2ymh73RJH7
	 0PR/Vxsb2/afN2hDLhK9PBAG1p+VvNF0ckk1gGS4na7INLQQRlHpCcephKHTbo+rf78Izj5mByYB
	 mRa6MZqrzLLgogdBSvsQeJbRAI9W7nXEW+Q+yavHy5bfRru/bzObWnBMIUeumlt2ajTH9g+xu17T
	 pb5qhhq1Nzu8kkmBlSZqz/L6wqI3GRYoy2T1UgHXQrF3NYJbLQPtqKK3L/0KAtiMxzvZl8JgqP3B
	 s956vHvbOutb4YB5UKBZgNj8htif2A1ynjwODKKhWwPkwOwL+eOqATpiWkMaRX498ZvBWgmto7+m
	 f7EfZQjG5qDfRjn4NxjvvjmiLQEifg9rUkPwkwGjgz5JhQF8x44uoc56H3ngOxPGX8lx4B6HU4KT
	 CL87+1LGydJ+Qd+IGSBBk8AIkvGv37oQMbvZircHqB1gO7upilWFS/giydX6kgNIW+16PYF+p8m6
	 sag3FF42xfmeGV2MHzovL7jK9vC10=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <2b1414b1-b5ac-58cc-185f-19bb4f47d76a@foxmail.com>
Date: Thu, 21 Mar 2024 22:41:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Joel Granados <j.granados@samsung.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
 <tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
 <CGME20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6@eucas1p2.samsung.com>
 <20240320103603.u6uqhk6viu4qkaht@quack3>
 <20240321105555.f4qg5g3wbe57mzzx@joelS2.panther.com>
 <20240321113849.hfzmnz6p3cjbmmwt@quack3>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240321113849.hfzmnz6p3cjbmmwt@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/21 19:38, Jan Kara wrote:
> On Thu 21-03-24 11:55:55, Joel Granados wrote:
>> On Wed, Mar 20, 2024 at 11:36:03AM +0100, Jan Kara wrote:
>>> On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
>>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>>
>>>> Delete unnecessary static variables (it_zero and it_int_max)
>>>> and encode them directly in the table entry.
>>>>
>>>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
>>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Joel Granados <j.granados@samsung.com>
>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>> Cc: Jan Kara <jack@suse.cz>
>>>> Cc: "Darrick J. Wong" <djwong@kernel.org>
>>>> Cc: linux-kernel@vger.kernel.org
>>>
>>> This looks as a sensible cleanup but I don't see the first patch in the
>>> series (and neither it is archived at lore.kernel.org) so I cannot really
>>> verify whether your conversion is correct...
>> This was my original comment. If you want to see the cover letter
>> look for this mail ID tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.com
>>
>> Not sure why it separates the cover letter from the rest of the patches.
> 
> No, that is actually a different email :) Based on lore the message ID
> should be:
> 26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com
> 
> but the email is not in the archive...
> 
> 								Honza

Sorry, my email box changed the message ID when sending, but it can be 
found in lcore:


or
https://lore.kernel.org/all/tencent_0D6ABA209A4980742DE6003FBFE7FE2A3207@qq.com/


If it causes any inconvenience to you, I can resend it. After some 
experiments, I have finally found a way to send them in a thread.

--
Best wishes,
Wen






