Return-Path: <linux-kernel+bounces-160912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323358B4471
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BD11F22D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C640847;
	Sat, 27 Apr 2024 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cF2sR36W"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E671E4A8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197508; cv=none; b=u83bG98nh2To3hrcc91Cr5pyeQRNCYeQQ6byXChGyb9tyGG/qR4/ZIl77eWh7NgTmWm4vx/JuqHn00Gi4qLHKoUVL4GN7fRIhISO2pP1SCrd9FmxvkAkgHxsYBZzOWm372jN54gJvSTqtf8SzYzwWn/9movxLfzkg8hzIJRc0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197508; c=relaxed/simple;
	bh=kXoZjLFn59koFc28BQ9bqNwWral4V6ynyEbfza2RnrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnGPJN3YqlqSqlOkmSBMxYPA5b4OoR8oOSJaek4FBwJsbl0Q/KQIHx1UZXlC7dYek9VdUS/xD1ZWbnj/RPyleniEMRypbf2Cag5qIc/L6cub5P8A56DVPf8E9YN8/YVn76C4YQvv8t9EYqYnYMEcP17DzX+khddqrLxr98dGcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cF2sR36W; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <509b3822-dcf6-45eb-9516-ba8ff2cc4382@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714197503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxlklMfBDzUJzfzH3D9A2wRzbh/nwoFGA5lYNX7H0P0=;
	b=cF2sR36WA5QZw0FBHgOJ0ruxDsHJ0SIZ69AjdZ6LFB6lwTkj0I/zcr1BZkalt9X24iVj+F
	7xmzjBDQEO8LWg8qk0SR2+hi5FwxcmozZdUCfFwieX+ywOFT3waCBsHeUcJpfDoh/pUlsK
	fBl47oVHcIW+Lyn3IMvWt/VrKHXSFMw=
Date: Sat, 27 Apr 2024 13:57:46 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240426-married-augmented-mantis-ff7edd@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/26 14:23, Maxime Ripard wrote:
> Hi,
>
> On Fri, Apr 26, 2024 at 04:43:18AM +0800, Sui Jingfeng wrote:
>> On 2024/4/26 03:10, Andy Shevchenko wrote:
>>> On Fri, Apr 26, 2024 at 02:08:16AM +0800, Sui Jingfeng wrote:
>>>> On 2024/4/25 22:26, Andy Shevchenko wrote:
>>>>> It seems driver missed the point of proper use of device property APIs.
>>>>> Correct this by updating headers and calls respectively.
>>>> You are using the 'seems' here exactly saying that you are not 100% sure.
>>>>
>>>> Please allow me to tell you the truth: This patch again has ZERO effect.
>>>> It fix nothing. And this patch is has the risks to be wrong.
>>> Huh?! Really, stop commenting the stuff you do not understand.
>> I'm actually a professional display drivers developer at the downstream
>> in the past, despite my contribution to upstream is less. But I believe
>> that all panel driver developers know what I'm talking about. So please
>> have take a look at my replies.
> Most of the interactions you had in this series has been uncalled for.
> You might be against a patch, but there's no need to go to such length.
>
> As far as I'm concerned, this patch is fine to me in itself, and I don't
> see anything that would prevent us from merging it.

No one is preventing you, as long as don't misunderstanding what other
people's technical replies intentionally. I'm just a usual and normal
contributor, I hope the world will better than yesterday. Saying such
thing to me may not proper, I guess you may want to talk to peoples
who has the push rights, just make sure it isn't a insult to the
professionalism of drm bridge community itself though.

We still grateful for you help and admire you numerous contribution,
thanks.

-- 
Best regards,
Sui


