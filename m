Return-Path: <linux-kernel+bounces-90412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A086FECC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758151F2388B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFBC2C696;
	Mon,  4 Mar 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rS0o+c5P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB30224DF;
	Mon,  4 Mar 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547399; cv=none; b=fapYEaiOMOhzu2H0wLO3N/tEFqq9G4opcjdDtPfoAxS3y/LkZWXKPWFmg4//UhCpv4oeOSeEj9TSeuv5gYzdqHIirm0g/PV6Kp6J1BtY3XvXZuNM7wq+md3V16irnABM0poO2/s9BMq7P9NMJWo/X+tPGcYtxznpYhvlgctiClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547399; c=relaxed/simple;
	bh=fUVIo8oYMkddeREdeHAUMsLE87NZnHK18xStRoanGpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc5puZ7/DHyKSzIj2hVj8F/pReSiS3xcbr8ItXR1XoeQFOOfNQZhLvAnqYtJ7V0IFGWBhmKZ/dU/1tHH51yQ1FnQsLKcL+3My4PWZFV2/Ek4fBGAbYfVmxj4/1FA435BkEoh0NWKj9TAasww9voGj7TpRybSurRPV+iczuXvOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rS0o+c5P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709547396;
	bh=fUVIo8oYMkddeREdeHAUMsLE87NZnHK18xStRoanGpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rS0o+c5PAr7sQNA0z7g5e4yGNpNnAz2aG1gDopp4IULeGi015H7awhAX/uQjmv43+
	 RSarmHrK8yIsk4kROtJWmerQ+qrEbS+Dycg9781fLwsanidLOfgNvrkKydgKQjKo9/
	 kDiQZCrHuUUqKy1166/dfVscy7JIn+anQZWIY5nBVTXV/HqwWVE06nUfdxlFikAIxh
	 o8jr4VtP2+dG0qih7lle5j/GIvxy3h5XGVMcqSzlen9FB0e8rAP/aGSOkA76xvLBuu
	 eL53PN/HNDcHV34E1HFtqQV6CpBRFZ08FXYXE9gFNNZ0Uicc032u4HAO95n4qBlbaR
	 +TZ76Zdg3I9Ug==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3E38337803EE;
	Mon,  4 Mar 2024 10:16:35 +0000 (UTC)
Message-ID: <22110872-8915-43cc-b074-112644b16e3b@collabora.com>
Date: Mon, 4 Mar 2024 11:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to vpp/vdosys
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 "Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
 <20240229-gce-client-reg-add-missing-mt8192-95-v1-2-b12c233a8a33@collabora.com>
 <22e2cf1b-9560-4f4b-b08b-a112e8e272a8@collabora.com>
 <40ae06f4-0cbe-40f0-84c8-9b57dfbeb91f@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <40ae06f4-0cbe-40f0-84c8-9b57dfbeb91f@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 15:39, Nícolas F. R. A. Prado ha scritto:
> On Fri, Mar 01, 2024 at 09:50:31AM +0100, AngeloGioacchino Del Regno wrote:
>> Il 29/02/24 20:44, Nícolas F. R. A. Prado ha scritto:
>>> Add the missing mediatek,gce-client-reg property to the vppsys and
>>> vdosys nodes to allow them to use the GCE. This prevents the "can't
>>> parse gce-client-reg property" error from being printed and should
>>> result in better performance.
>>>
>>> Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
>>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> Can you please squash patches 2,3,4 in a single one?
>>
>> It doesn't make a lot of sense to have them separated in this case, only
>> generates commit noise for no practical reason imo.
>>
>> arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdo/mutex
> 
> I split them like this so that each has its own fixes tag and can all be easily
> backported (as mentioned in the cover letter). That said, the commits fixed in 2
> and 3 both landed in v6.1-rc1, so they could be squashed and still easily
> backported. But the commit fixed in patch 4 only landed in v6.4-rc1, so if we
> squash them all together, the first two won't be backported to v6.1.
> 
> Let me know how you want to proceed.
> 

Oh, I'm sorry I didn't notice that. Ignore my previous comment then, I'll take
those for the next fixes round as-is.

Cheers,
Angelo


