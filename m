Return-Path: <linux-kernel+bounces-117086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEC88A6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48BF323E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42176130AD8;
	Mon, 25 Mar 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AwX6bukZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5840BE7;
	Mon, 25 Mar 2024 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371995; cv=none; b=YVxISrLXjSptQDs3MZz7zChaDHtFxLy9wWlehLlDklUTf1k5F1i2gRc1s7AwJfUSpz7xK5KRuxtji1iNDT94yWAt4yClzU4AXB2eYPcpNYgiL1lvAIXNayDQOA8GRRK0xxSuQXz7dJrCBisyTd2A0xUJzV9vWOGEW7h+BWCln60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371995; c=relaxed/simple;
	bh=y41ZUo//R1PFlTZZBp6OISCB8XZyhdqerzYG0tK4h84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSFjzfeM42AAeC3T+2x/ttFaripHdIKOqMN0BqF4eMJZSTU33uZIsHgUj7y+QdSGTe3ZusvgPhOtyWQdfVG7xgAPRMLRVRJJ1/4JSIsOl9pxRGcmZpRUdHG07cdeWPslxKMzimrgFcDsqz/yPMh9oK5LRaQ0i29nlzdAVM1f1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AwX6bukZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711371992;
	bh=y41ZUo//R1PFlTZZBp6OISCB8XZyhdqerzYG0tK4h84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AwX6bukZx35XtczvSYUlGvxfUuq/ynvrxShktE9Ug4+6f6WqsKtlBHio6PNittTaT
	 kJgFP96UNjt/zIufP5ssM0wvAe/8YetuWcgPl38y7W8Ojrr7ACbJM4TRGscxJiyJMH
	 Dj9S+4+zL5ZPSxEuY0Q4w29SNV9IzMz4LM2bTl87dXpGjZRcumk6dT8t7EmRQpBtFG
	 dTfWlwuI/cxuKtaFieVRYUm9H0OUAKdFWUTwdZIpaMvEUhSlBV5xqmaOrTWmN6onVM
	 HkjfDZJDQ8/ZKTdc3SYc+SB0cU8Dm1AlBmKORLdHETtCryt3E8LywypIWElPFbkBMX
	 HC575lGmdMdnw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CF571378209A;
	Mon, 25 Mar 2024 13:06:31 +0000 (UTC)
Message-ID: <2625bf93-1501-4e5d-b492-de9bcffa93ec@collabora.com>
Date: Mon, 25 Mar 2024 14:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] soc: mediatek: pm-domains: solve power domain glitch
 issue
To: "yu-chang.lee" <yu-chang.lee@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, mandyjh.liu@mediatek.com,
 fan.chen@mediatek.com, xiufeng.li@mediatek.com
References: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240325121908.3958-1-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/03/24 13:19, yu-chang.lee ha scritto:
> Hi,
> 
> This series aims to solve power-off failures and occasional SMI hang issues that
> occur during camera stress tests. The issue arises because, when MTCMOS powers on
> or off, signal glitches are sometimes produced. This is fairly normal, but the
> software must address it to avoid mistaking the glitch for a transaction signal.
> 
> The solutions in these patches can be summarized as follows:
> 
> 1. Disable the sub-common port after turning off the Larb CG and before turning
>     off the Larb MTCMOS.
> 2. Use CLAMP to disable/enable the SMI common port.
> 3. Implement an AXI reset.
> For previous discussion on the direction of the code modifications, please refer
> to: https://lore.kernel.org/linux-arm-kernel/c476cc48-17ec-4e14-98d8-35bdffb5d296@collabora.com/
> 
> 
> yu-chang.lee (2):
>    soc: mediatek: pm-domains: add smi_larb_reset function when power on
>    soc: mediatek: pm-domains: support smi clamp protection

Can you please change both commit titles to use "pmdomain: mediatek:" instead of
"soc: mediatek:"?

Thanks
Angelo

> 
>   drivers/pmdomain/mediatek/mt8188-pm-domains.h |  69 +++++-
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    | 206 +++++++++++++++---
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    |  13 ++
>   3 files changed, 255 insertions(+), 33 deletions(-)
> 


