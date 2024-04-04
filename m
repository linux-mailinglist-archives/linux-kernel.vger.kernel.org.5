Return-Path: <linux-kernel+bounces-131336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB04689866C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4171C216E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8F86656;
	Thu,  4 Apr 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k5Cz74tf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746886630;
	Thu,  4 Apr 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231376; cv=none; b=AwndxSXxvBtdnkErtJhsOf9rQXCxzbTEgDhPtaZ6c8tS574q9FoeK06jxSp1JNKOcBEouATHbD4KU3q0G1/+zdCOcCxswGRlQmTzDff+Jvdi4PAYZjlaDJmj6qzAEBSHQmSGyvEmDwANozyvYtS7qj1vLrQBrOWCBFMgm7Ivgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231376; c=relaxed/simple;
	bh=yVE6soaiuubo6FwqB1b2RlNAfh1E2hAC+6bdTlmFD4M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VQJIg14KU2FhiWSEB1f+KNUO1d+NGxSUoXOC7CUog1e+o+TLUTaOtan8PCLzunmxDsUy73H7U9t9eLaGtYYjHUb/9+xq96KmsOs35MZB6wl6ZBn8I/aUBJBIbHf59hRVpzNwylOXDVU9mcYJs4EC1cgo3QcAKvNs5LEpwFPGApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k5Cz74tf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712231372;
	bh=yVE6soaiuubo6FwqB1b2RlNAfh1E2hAC+6bdTlmFD4M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=k5Cz74tf/dgUW5zQbrAB9mloDLLTkX/YloFmSi3LzjRaGVDtLkU09bVD1zoiEe6S7
	 iaYDqdtTdLz/8X/f6tzHGmoeAvS4StZKStAO4hUMmma3H9RtjLpF+478YGwrVRyWnz
	 6vCNusGyDzyMFN4hd4Ri+S+++zKwfD/eELz6ufegR5lr7ggJVT4DAXNbBUcxrbXZ1a
	 ybk+45n7nyg/siyvKSEworlOpRY2BPgTDHoNbnF0EX27MD6YdsguOYCViU5zFYlSdT
	 mt0lUp+ZVy6TkBsDSD0pF2KGn16AHlpn2XbBs4MPehq/4seuowKHR3DilJ6rjGGb3s
	 EQqY5UWoy6BVA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 90AFE378200D;
	Thu,  4 Apr 2024 11:49:27 +0000 (UTC)
Message-ID: <1dd3cead-6251-425f-b050-582892da0800@collabora.com>
Date: Thu, 4 Apr 2024 16:49:59 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: connac: check for null before dereferencing
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240301144406.2808307-1-usama.anjum@collabora.com>
 <ab6b08c5-86a2-47e3-8683-28cdbe5be7cf@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ab6b08c5-86a2-47e3-8683-28cdbe5be7cf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 3/11/24 10:11 PM, Muhammad Usama Anjum wrote:
> Soft reminder
> 
> On 3/1/24 7:44 PM, Muhammad Usama Anjum wrote:
>> The wcid can be NULL. It should be checked for validity before
>> dereferencing it to avoid crash.
>>
>> Fixes: 098428c400ff ("wifi: mt76: connac: set correct muar_idx for mt799x chipsets")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index af0c2b2aacb00..7af60eebe517a 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -283,7 +283,7 @@ __mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
>>  	};
>>  	struct sk_buff *skb;
>>  
>> -	if (is_mt799x(dev) && !wcid->sta)
>> +	if (is_mt799x(dev) && wcid && !wcid->sta)
>>  		hdr.muar_idx = 0xe;
>>  
>>  	mt76_connac_mcu_get_wlan_idx(dev, wcid, &hdr.wlan_idx_lo,
> 

-- 
BR,
Muhammad Usama Anjum

