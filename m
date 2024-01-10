Return-Path: <linux-kernel+bounces-22043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C982985A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89A31F20F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89346BA6;
	Wed, 10 Jan 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D/6yxlr8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3C47762;
	Wed, 10 Jan 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704885005;
	bh=opfjRhVHCA5uWTnxeh45vbr3mHfSSMHaqalR6SccCOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/6yxlr8V5vU3xvkd9oO0PJqihGbovndB0pXsrcsxWe5fhIBvnSnP+ktzFPVlUeWE
	 RDnmBNBCDYlq2MKxs++cBLGHfptUKdCLbwP5rabk2dDDmOx77m/2kUF+2t0dglKpP2
	 BI8Lb6IKkBeO6U+TwjbEnTqjSC3T0bGu4R5L5GILqJaier/HyaRUfv/ZhtIKSPQsY4
	 Z4zr6ZD2ijVcJN6HJRHzy0CYN6ecNiFZScA6ajXxzRxNutgl6HiB2HEZTdaizxnnfT
	 EW2znBdh5ogyKNLt/mnWI9jezRRurlUFdrez1Yk1DIccZuArMslJNRmY3cgrfyxfxq
	 ChSxIxyqPy/tw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 40B6A3780C21;
	Wed, 10 Jan 2024 11:10:05 +0000 (UTC)
Message-ID: <679f35f9-3265-4b2f-8de5-df9460881de6@collabora.com>
Date: Wed, 10 Jan 2024 12:10:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
To: =?UTF-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
 <Chun-Jen.Tseng@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230914121035.17320-1-chun-jen.tseng@mediatek.com>
 <20230914121035.17320-2-chun-jen.tseng@mediatek.com>
 <c9881e63-a52a-4d14-895e-9a14d31004e3@collabora.com>
 <894594bd2adb156fa8f290f4e603edbccdbbcdab.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <894594bd2adb156fa8f290f4e603edbccdbbcdab.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 10/01/24 06:44, Chun-Jen Tseng (曾俊仁) ha scritto:
> On Wed, 2023-11-29 at 14:22 +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/09/23 14:10, Mark Tseng ha scritto:
>>> The original CCI OPP table's lowest frequency 500 MHz is too low
>>> and causes
>>> system stalls. Increase the frequency range to 1.05 GHz ~ 1.4 GHz
>>> and adjust
>>> the OPPs accordingly.
>>>
>>> Fixes: 32dfbc03fc26 ("arm64: dts: mediatek: mt8186: Add CCI node
>>> and CCI OPP table")
>>>
>>> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
>>
>> You ignored my comment [1] on the v1 of this patch.
>>
>> Besides, I think that you should at least keep the 500MHz frequency
>> for a
>> sleep-only/idle OPP to save power.
>>
>> It would also be helpful to understand why you chose this new
>> frequency range,
>> so if you can, please put some numbers in the commit description,
>> showing the
>> stall in terms of requested BW vs actual BW (as I'd imagine that a 2x
>> increase
>> in CCI frequency means that we need *twice* the bandwidth compared to
>> what we
>> have for the workloads that are stalling the system).
>>
> Hi AngeloGioacchino Del Regno,
> 
> Thanks your reminder this issue. After ajdustment CCI OPP, we also do
> power test benchmark and the result is PASS.
> 

Sorry but `PASS` is not a number; I actually wanted a before and after power
consumption measurement in microwatts.

> The original CCI table has stall issue.  When the Big CPU frequency set
> on 2.05G and CCI frequency keep on 500MHz then run CTS MediaTest will
> system stall then trigger watchdog reset SoC.
> 
> The CPU and CCI frequency setting are not in the same driver. So it
> will have timing issue cause CPU stall side effect.
> 

Are you trying to fix a frequency setting delay/desync with raising the
frequency of the CCI?
That's not the right way of doing it.

Asserting that we have a timing issue because the two frequency settings
are not done by the same driver is borderline wrong - but anyway - if there
is a frequency setting timing issue because of the interaction between the
two drivers (cpufreq/ccifreq), the right way of eliminating the stall is to
actually solve the root cause of that.

I'm insisting on this because if there's a "timing issue" this means that
even though the "base" CCI frequency is higher, during a scaling up operation
depending on how much the CCI gets flooded, you might *either*:
  - Have this same stall issue again, and/or
  - Have performance issues/drops while waiting for the CCI to scale up.

Even though you may not (or may...) get a stall issue again with this change,
you will surely get (very short) temporary performance drops during scaling up.

...and this is why your CCI frequency increase solution does *not* resolve
this issue, but only partially mitigates it.

That should get solved, not partially mitigated.

Besides that, can you please tell me how to replicate the stall issue, making
me able to better understand what's going on here?

Regards,
Angelo

> BRs,
> 
> Mark Tseng
> 
>> [1]:
>> https://lore.kernel.org/all/799325f5-29b5-f0c0-16ea-d47c06830ed3@collabora.com/
>>
>> Regards,
>> Angelo


