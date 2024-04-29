Return-Path: <linux-kernel+bounces-162714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB28B5F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CDB28415D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FD8595A;
	Mon, 29 Apr 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A62KNs5X"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FA33C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409695; cv=none; b=g0Nb23xBCnCu1mZEhmDXfelQAYemvMliKJgiYixeve+wiggk5AV/6sn4ScqGG+vC2VJ7GaJqAUJsDTnaw3LJN+ZNZJQzAU488ZtfYBvcKBwyi4WrvV/mJYUkQwy2FF3QTcQ4Gn8HtrSTwAWpTwU0YBbW7eV0qGEXZ969n1ntzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409695; c=relaxed/simple;
	bh=MbpqLIOqlMzRR/AblELpECM0WzRQ6+qleaLLlj0WoSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5k5gWEFjQJXZ2nB10vvqq1TbhKPRoff5NUpCHkVgcmPYLagoBVdPTibLbx56dqPHtlVmeVnJFarsL8LKLyRNN4TnPM60STBOt8AGllnr1WEFrez7KRnBaubkY7YM5VfnonFBQYT8zGQarAkW9UcuW0MaT13K+nWupjc4uV3vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A62KNs5X; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <795bec5d-c7ba-4fc2-9be9-78c4063743d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714409690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZcRLqCKZ99s9BPl9IWgxkXzMSNJVxZZp+zfZTMxHbQ=;
	b=A62KNs5XmNHHpyGS9t1N4WYIPaZ86jsZuc3vSXflNzOpYnPNWpmOvsosZCSNYzCK1jkxzh
	l4BZM4M7+e83rU7xsVteYzX5EmYPHe48Pq2f2cfIWbKZudpo6UG/1x4MF0sfR2YtzCxXUO
	HMk014Gl8vOJMxcvR8o6OO5ag+0WDOs=
Date: Tue, 30 Apr 2024 00:54:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
To: Maxime Ripard <mripard@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
 <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
 <20240426-married-augmented-mantis-ff7edd@penduick>
 <509b3822-dcf6-45eb-9516-ba8ff2cc4382@linux.dev>
 <20240429-bouncy-attentive-vole-9964f1@houat>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240429-bouncy-attentive-vole-9964f1@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/29 19:55, Maxime Ripard wrote:
> On Sat, Apr 27, 2024 at 01:57:46PM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>>
>> On 2024/4/26 14:23, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Fri, Apr 26, 2024 at 04:43:18AM +0800, Sui Jingfeng wrote:
>>>> On 2024/4/26 03:10, Andy Shevchenko wrote:
>>>>> On Fri, Apr 26, 2024 at 02:08:16AM +0800, Sui Jingfeng wrote:
>>>>>> On 2024/4/25 22:26, Andy Shevchenko wrote:
>>>>>>> It seems driver missed the point of proper use of device property APIs.
>>>>>>> Correct this by updating headers and calls respectively.
>>>>>> You are using the 'seems' here exactly saying that you are not 100% sure.
>>>>>>
>>>>>> Please allow me to tell you the truth: This patch again has ZERO effect.
>>>>>> It fix nothing. And this patch is has the risks to be wrong.
>>>>> Huh?! Really, stop commenting the stuff you do not understand.
>>>> I'm actually a professional display drivers developer at the downstream
>>>> in the past, despite my contribution to upstream is less. But I believe
>>>> that all panel driver developers know what I'm talking about. So please
>>>> have take a look at my replies.
>>> Most of the interactions you had in this series has been uncalled for.
>>> You might be against a patch, but there's no need to go to such length.
>>>
>>> As far as I'm concerned, this patch is fine to me in itself, and I don't
>>> see anything that would prevent us from merging it.
>> No one is preventing you, as long as don't misunderstanding what other
>> people's technical replies intentionally. I'm just a usual and normal
>> contributor, I hope the world will better than yesterday.
> You should seriously consider your tone when replying then.
>
>> Saying such thing to me may not proper, I guess you may want to talk
>> to peoples who has the push rights
> I think you misunderstood me. My point was that your several rants were
> uncalled for and aren't the kind of things we're doing here.
>
> I know very well how to get a patch merged, thanks.
>
>> just make sure it isn't a insult to the professionalism of drm bridge
>> community itself though.
> I'm not sure why you're bringing the bridge community or its
> professionalism. It's a panel, not a bridge, and I never doubted the
> professionalism of anyone.


I means that the code itself could be adopted, as newer and younger
programmer (like Andy) need to be encouraged to contribute. I express
no obvious objections, just hints him that something else probably
should also be taken into consideration as well.

On the other hand, we probably should allow other people participate
in discussion so that it is sufficient discussed and ensure that it
won't be reverted by someone in the future for some reasons. Backing
to out case happens here, we may need to move things forward. Therefore,
it definitely deserve to have a try. It is not a big deal even though
it gets reverted someday.

In the end, I don't mind if you think there is nothing that could
prevent you from merge it, but I still suggest you have a glance at
peoples siting at the Cc list. I'm busy now and I have a lot of other
tasks to do, and may not be able to reply you emails on time. So it up
to you and other maintainers to decide.
  
Thank you.

> Maxime

-- 
Best regards,
Sui


