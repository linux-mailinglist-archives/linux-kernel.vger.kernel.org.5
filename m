Return-Path: <linux-kernel+bounces-85210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1478086B24A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F73289CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781F15959F;
	Wed, 28 Feb 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dd23GAgT"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035612E1DD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131716; cv=none; b=kbTYrL55bxGe9nP68PQLh/mzuM4G8Wx4YNjMVvlCT/35xE6MbuvaZ86BQ///MTIzcI2kKE28O+3h1wbJbZyy54oik+pHnCyGn334RSa/VUnKt2oIegn/NkuECsbxZqGAj27Uwjm1kOvDtpO6GVM4YB/RtBLsK3eP8VAheKQUQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131716; c=relaxed/simple;
	bh=VntlTqk4dAW5pNGdEhOBOEA7DgQanApR+ugvNClxd6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG8aaUhNryf8+/iq5udrz8ji4MeaHFxOru3vZdOb1oZFZblDvD2EnnfytWWX2T9Cs2AbsfCl3wvR8uSSFLLhRaoOYDWOYi5VYLAJZi6uEMLp3OQ0EiJRMEKTvOW0BYYC0504JPIJQ19OuQSdkMAc6faZIIQdGJ07/8Crx2VXPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dd23GAgT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709131713;
	bh=VntlTqk4dAW5pNGdEhOBOEA7DgQanApR+ugvNClxd6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dd23GAgTS9BawtCzIkD8Us/K1vt2Q+o8hjpHdQE48l5W4J6EN6Q2rywaVRKKan1SX
	 LWhtFvmUj+oMXY3ffkVILG4GCCJC9/K1cpohOaftPTIUeuV8RF9e4JrZV/2cS/IVHL
	 Nussf8p8iDmBV47phMrGJZSDlajVnFmy/3XjKrYTIObh3BAtxDXl0fWJO03Ac74u+2
	 OAVWsXnXNO8eUoBvaSWSNcbnOyZrec+2aaejSxLyzV7EyDdXh3MYQquowEu1AN5qY7
	 mOcjRa+EghFwYjWrl4mczI6uht1I5Wbsno3E/5EhWGM4mnTU1LFiaTpOIpO8KDxjbh
	 vLHSkbKKue8bQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F198B378204B;
	Wed, 28 Feb 2024 14:48:32 +0000 (UTC)
Message-ID: <7860ea98-da64-4722-8521-ad75c9123f42@collabora.com>
Date: Wed, 28 Feb 2024 15:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com>
 <6389f1e3-57b2-453a-af6f-6bc7f725ad31@collabora.com>
 <957b44d3-ef48-4682-8db5-3261e582ac8f@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <957b44d3-ef48-4682-8db5-3261e582ac8f@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 28/02/24 15:44, Nícolas F. R. A. Prado ha scritto:
> On Wed, Feb 28, 2024 at 10:41:15AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 26/02/24 22:31, Nícolas F. R. A. Prado ha scritto:
>>> Most of the callers to this function do not require CMDQ support, it is
>>> optional, so the missing property shouldn't cause an error message.
>>> Furthermore, the callers that do require CMDQ support already log at the
>>> error level when an error is returned.
>>>
>>> Change the log message in this helper to be printed at the debug level
>>> instead.
>>
>> CMDQ is optional, yes. At least, for some devices it is.
>>
>> Full story, though, wants that if you use the CPU for register manipulation
>> instead of programming the GCE (even with threading, fantastic!) you will
>> trigger various performance issues.
>>
>> In the end, you *don't want* to use the CPU if GCE is available!
>>
>> The reasons why the CMDQ/GCE is optional are:
>>   - You can check register-by-register r/w for debugging scenarios by using
>>     the CPU to manipulate them instead of having something magically doing
>>     that for you at a certain (pre-set, yes, but still!) point;
>>   - Not all SoCs have the same amount of GCE threads and channels, some may
>>     support writing to IP block X through the GCE, some may not, but both
>>     may support writing for IP block Y through this mailbox;
>>   - MediaTek chose to support both ways, enabling means to debug stuff upstream,
>>     the other choice would've been to never support CPU register R/W on some IPs
>>
>>     ... and btw - about the last part: Kudos, MediaTek.
> 
> Thank you for all the insight! :)
> 
>>
>> Now, I also get why you're raising this, but we have to find an agreement here
>> on a different way to proceed that satisfies all of us.
>>
>> First of all..
>>
>> Which device on which SoC is missing the GCE client register DT property?
>> Do said SoC really not have a GCE client register for that device?
> 
> This is what I see:
> 
> On mt8192-asurada-spherion:
> mediatek-mutex 14001000.mutex: error -2 can't parse gce-client-reg property (0)
> 
> On mt8195-cherry-tomato:
> mtk-mmsys 14000000.syscon: error -2 can't parse gce-client-reg property (0)
> mtk-mmsys 14f00000.syscon: error -2 can't parse gce-client-reg property (0)
> mediatek-mutex 1c016000.mutex: error -2 can't parse gce-client-reg property (0)
> mtk-mmsys 1c01a000.syscon: error -2 can't parse gce-client-reg property (0)
> mediatek-mutex 1c101000.mutex: error -2 can't parse gce-client-reg property (0)
> 
> So yes, there are a few missing. I will send patches adding them so we can get
> the best performance possible upstream.
> 
>>
>> Is any upstream supported SoC really lacking a GCE register for the upstream
>> supported IPs?
>>
>> I'm not sure.... :-)
>>
>> P.S.: I guess that the alternative (that I somewhat dislike, and you can probably
>>        understand why after reading the reasons above) would be to turn that into a
>>        dev_info() instead...
>>
>> P.P.S.: Having no GCE usually means that there's a performance issue! In that case,
>>          it's ... a mistake, so, an error, kind-of.... :-)
> 
> Given the performance impact, I agree that debug, and even info level is not a
> good option. At the same time, the hardware still works correctly without the
> GCE (as we have been running it so far without even realizing!), so I think
> calling it an error is too much, and a warning would be the most suitable level,
> as we just want to warn userspace: "Hey user, be advised that you're missing
> GCE, so you'll get worse performance! It will still work though". What do you
> think?
> 

Agreed.

Cheers,
Angelo


