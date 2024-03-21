Return-Path: <linux-kernel+bounces-110279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE3885C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA7A1F230BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEA8625F;
	Thu, 21 Mar 2024 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HhUFPzpk"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A1E879
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036076; cv=none; b=PIPWgG/AEKwkUrYx6ZiJUyrwUsNFDp619Ipojqw5r2cJsWem2sLeBYXy33xIiKHoki9lViSBbVSRyjSdWluUGIOhBGLBGnBZGqsZS9aeOHEEe7rKR7+Oi9LEcmENgVOt95T8wUz8QZkBwqYBhJ3X3neX2FjOEHNNj0o9aNF8rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036076; c=relaxed/simple;
	bh=jeeFGFpFQcMeiPnqG1XhNR17H2LPGzyB/MVHRtQ7nxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY10qaRPTMcivkGCBt9+8q4QsRO1a3Myk8PnYyNdIycei+Eq7M2AgQZCpFkWL7eh+wG2fZwCoB5Io4ip+KlSXE3UZrDoQSW3kMWLTkVcPiG/BW1Mb7eRm/GXcGLKD+tYc/83jdX/AIOXEUf5gw8Ddh4KTL8cn00Yp7QW5jUV5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HhUFPzpk; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1711036064;
	bh=eFb5mGkBNhSImhI4kWEKhUE6z0crGzcN6/hptGkBZi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HhUFPzpknp/Nrd9zQtSJBBPC9/4ryBOd+sXJEUVmFTs5iKC2r9XvANoNn/zXpSFza
	 yFNdePCAlbDjjLWNNpSsi3Y59dv1N+cslmejn2l3BDWrmSl9wb3glyj5xMwdyH6uaf
	 m/7+XyEaQj5wxS30vkJ59AI39dW69CImwNMtGAmY=
Received: from [IPV6:2409:8961:2b17:549c:98ce:49d:c167:4134] ([2409:8961:2b17:549c:98ce:49d:c167:4134])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 9CAAC4C3; Thu, 21 Mar 2024 23:39:10 +0800
X-QQ-mid: xmsmtpt1711035550tfx2v8zko
Message-ID: <tencent_583360D51D354010FEE44A3A3B739D5FF506@qq.com>
X-QQ-XMAILINFO: OFXVMg8LeyWMW6CuZuhrlYUls5evNkZeZR7IwrVp+YzTm/M0xFaWG9TSeMujhq
	 ZYZacY2WgZPrUfRq9J48NYt9QMpF0t3jHP3nbRBfVyODkrj5TRPTsFxvQxRGa2U/2ZMAfxbEUved
	 n4cCty2V7pz/3H+FPgaa78YlATHLAY2MYX6GkdHfvUEAr/TK2o9h1gYxNVJc4N3w9aVi+FqVn5Nm
	 SMQvPUIn0y86TcW6L7KZfnpY8ngdWQclZL5xW1IG5cPHFFnkIwR0eatJp/1AAaZ4YG8U/nwrPGLN
	 YDgexG5/zHls93yYpuAwh0j2a1DYBiad/I7fQGHhFCj87gZwXm1LGISg5XifO5wH2qcUPXmVN0hg
	 s8jn2aYTQ+8X1mkLrY2qUy05ydf08ODrhU5cNFJY5uaswuHDyZy67Yj0MXuj/dooDuye1LMQ5+tm
	 4sNFNtzuiX0ayYuu2OfzoIKJoV1pBQOefajgN6UvNoVFFOkT0lrG8vTZAyaIYjZqf4FRC5N5jzC0
	 hRf/35jdUYG1joN94Jhuq2D8K8yx7+dYa+HUhraep1j7ktUil7QnJhQUWF799i+5VOYOjIZq3FYP
	 R3ax4bgNvw90VTM4gmIQCAj3mRsvuFoDMHEaty6IFcJKlza0ikrzmMsCiWw6OQ875xs+LdkaEcuT
	 f5EYyIaLKMHKX+d2vlUPtMC7Y+EDuQOH1OySDr1jvgKmepi/CGyEtUOBpTyBmKWkpbQ0ietds0OV
	 X6z4wyxs4CT6LnYR/wkI4OhHdZE14gQigHmr5dJeSzXKg8+EqznXqwZB3KEmW8afV1xlDXtvOC34
	 qJp+1kVZIxW1T5qxfK0wlmx2MTbzkpz8j8SJbcH9kDgnVlYzgrfTk3Y6wrpQhWNU3viy04tZxC9t
	 REV6KPuFlYHSB7DEb86IghR8zL24BRfBXysXlA0ezGIgGxiSJ6xh1sVS+aK5e+/MyT5MVaExIWSX
	 HMGb9kkEg+hW/mVL4CrO24LOBsrMk1HPB/MJuPB74bKg/nT9W5yxKr941bA9UTAtbacZv4CLfoxa
	 JVp4pTVrq4eaqnSVdZA/98J6duxOV58asZ9D2hsq0AgDubeSDDwPXtNFhiPnvEpoRjkaptSgfi5z
	 5B5j/9XJuGchNE4gQYhr/9Sxr01OiPA4Zw+t0d
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <d82d69fb-0e2c-8a11-94b9-14763b411fd7@foxmail.com>
Date: Thu, 21 Mar 2024 23:39:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/9] encode the values directly in the table entry
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
References: <CGME20240309103209eucas1p25311b485e321e701eeacbdb3e2ba8758@eucas1p2.samsung.com>
 <tencent_C5E6023F97E7CC2A046AAEA09BC9ACF43907@qq.com>
 <20240321152143.yxoonjy3m6bdddkf@joelS2.panther.com>
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240321152143.yxoonjy3m6bdddkf@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/21 23:21, Joel Granados wrote:
> On Sat, Mar 09, 2024 at 06:31:17PM +0800, wenyang.linux@foxmail.com wrote:
>> From: Wen Yang <wenyang.linux@foxmail.com>
>>
>> The boundary check of multiple modules uses these static variables (such as
>> two_five_five, n_65535, ue_int_max, etc), and they are also not changed.
> This message is a bit cryptic. I had to do a fair amount of research to
> get what you meant here. Having the context in front is OK with me, but
> I would add a bit more information so the reader does not have to go to
> the code and grep for the variables that you mean. Something like this:
> "When using a sysctl proc_handler that requires a boundary check (like
> proce_dointvec_minmax) it is common to use a const variable like n_65535
> in net/rxrpc/sysctl.c or OTHER EXAMPLES...). This is suboptimal because
> YOUR REASONS HERE"
> 
> 

Thanks a lot for your very considerate input – this is highly 
appreciated. We will revise the change message and send v3 later.

--
Best wishes,
Wen


>>
>> Eric points out: "by turning .extra1 and .extra2 into longs instead of
>> keeping them as pointers and needing constants to be pointed at somewhere
>> ... The only people I can see who find a significant benefit by
>> consolidating all of the constants into one place are people who know how
>> to stomp kernel memory."
> I think it would be better to just link to the lore discussion.
> 
>>
>> This patch series achieves direct encoding values in table entries and still
>> maintains compatibility with existing extra1/extra2 pointers.
>> Afterwards, we can remove these unnecessary static variables progressively and
>> also gradually kill the shared const array.
> Two things:
> 1. Please name the const array: sysctl_vals
> 2. What is missing from this patchset to completely kill sysctl_vals?
> 
>>
>> Wen Yang (9):
>>    sysctl: support encoding values directly in the table entry
>>    kernel/sysctl-test: add some kunit test cases for min/max detection
>>    rxrpc: delete these unnecessary static variables n_65535, four,
>>      max_500, etc
>>    net: ipv6: delete these unnecessary static variables two_five_five and
>>      minus_one
>>    svcrdma: delete these unnecessary static variables min_ord, max_ord,
>>      etc
>>    sysctl: delete these unnecessary static variables i_zero and
>>      i_one_hundred
>>    epoll: delete these unnecessary static variables long_zero and
>>      long_max
>>    fs: inotify: delete these unnecessary static variables it_zero and
>>      it_int_max
>>    ucounts: delete these unnecessary static variables ue_zero and
>>      ue_int_max
>>
>>   fs/eventpoll.c                   |  19 +-
>>   fs/notify/inotify/inotify_user.c |  49 +++--
>>   include/linux/sysctl.h           | 108 ++++++++++-
>>   kernel/sysctl-test.c             | 300 +++++++++++++++++++++++++++++++
>>   kernel/sysctl.c                  |  61 +++++--
>>   kernel/ucount.c                  |   8 +-
>>   lib/test_sysctl.c                |  12 +-
>>   net/ipv6/addrconf.c              |  15 +-
>>   net/rxrpc/sysctl.c               | 169 ++++++++---------
>>   net/sunrpc/xprtrdma/svc_rdma.c   |  21 +--
>>   10 files changed, 571 insertions(+), 191 deletions(-)
>>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Joel Granados <j.granados@samsung.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>>
>> -- 
>> 2.25.1
>>
> 


