Return-Path: <linux-kernel+bounces-156694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649398B06E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F92DB26B28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79D159560;
	Wed, 24 Apr 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0eGGlTX2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6D15920C;
	Wed, 24 Apr 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953102; cv=none; b=cD9gL+gUdQ8zHfnDNjR+2ojUhjgRtIxUhm2oQjXvKcl27yknnJt9AqGf9XIYK2dBwrAim0qiPdlhviu6Gkv3WQZGfmh797Ueuap3hlHnrr0DiW4/9ezKcLX+hnoP87EWuTVQWkynuxhUpnj8shgukVhXqz4G8M3CZgt/TtKQxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953102; c=relaxed/simple;
	bh=Dttdz89FIcwSI+qU5QOqEj7dsUHDKBbSrFIK3xtH5GI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qFpiqQmFzmM67Y2UDsh8Y9zw7Jak79IGnlJn/PDs54JyFV1mZzxNIZfPbpNuMJW9vyPc3C71sRtbSZePtbKhuatF99rDSRKk2NAImLowgxy/GW/7txdEm14al826Y4UUEXD9oIV6KsFuwUpoI9CNjqTWxi34hUk3GLNoOFDtmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0eGGlTX2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713953096;
	bh=Dttdz89FIcwSI+qU5QOqEj7dsUHDKBbSrFIK3xtH5GI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=0eGGlTX2P4iDYJDDhzfSb/E3Ax5+NobVXVUIICoaLko7Nxr5TajiNpS69ohdVVWIg
	 uL1nOqKdgQhj1JdK/yryl1h9Et2TgROJH7d/WXYUb4hkbAfm0Yk2HXrAi1vUHlp6r7
	 mgNm7rSEUfc88c5ZIWg3u5NaYmdbLC6tIav9PT+xLpRcYCJxOH40V4OGy+uRfY4oUB
	 BZX/8gKT3vWwKVo/mv+xtqlAZ5LJtfEpayziBiGqPjf4RjuYUETkAWBMw/iCQgzICM
	 N6inOyg7qnPxIHhNtRu28OADXtOwsuSx8eNfNVnwUdM6qoygiXp17hGVxsajvAmeVT
	 kDhuV7bAXSRYQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6882A378107C;
	Wed, 24 Apr 2024 10:04:55 +0000 (UTC)
Message-ID: <fd24398f-a915-4e9a-9c19-4eb644178987@collabora.com>
Date: Wed, 24 Apr 2024 12:04:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] media: mediatek: imgsys: Support image processing
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
 <20240424030351.5294-5-olivia.wen@mediatek.com>
 <ba25cb7b-ff93-4fcb-b943-154e960d45a0@collabora.com>
Content-Language: en-US
In-Reply-To: <ba25cb7b-ff93-4fcb-b943-154e960d45a0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/04/24 12:02, AngeloGioacchino Del Regno ha scritto:
> Il 24/04/24 05:03, Olivia Wen ha scritto:
>> Integrate the imgsys core architecture driver for image processing on
>> the MT8188 platform.
>>
>> Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>
> 
> This should be reordered before introducing the 8188 scp core 1 support commit,
> but let's check with Mathieu before sending a v4.
> 
> With that reordered,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Wait, no. Sorry. I just noticed that the commit message is totally wrong.

This is not a media commit, but remoteproc, and you're not adding support for
image processing with this commit - not in media at least.
Also, you're not adding any imgsys core architecture driver.

Please fix both commit description and title.

Regards,
Angelo

> 
>> ---
>>   include/linux/remoteproc/mtk_scp.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
>> index 7c2b7cc9..344ff41 100644
>> --- a/include/linux/remoteproc/mtk_scp.h
>> +++ b/include/linux/remoteproc/mtk_scp.h
>> @@ -43,6 +43,7 @@ enum scp_ipi_id {
>>       SCP_IPI_CROS_HOST_CMD,
>>       SCP_IPI_VDEC_LAT,
>>       SCP_IPI_VDEC_CORE,
>> +    SCP_IPI_IMGSYS_CMD,
>>       SCP_IPI_NS_SERVICE = 0xFF,
>>       SCP_IPI_MAX = 0x100,
>>   };
> 


