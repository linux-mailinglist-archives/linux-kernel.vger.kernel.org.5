Return-Path: <linux-kernel+bounces-140725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C08A184A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0521C21FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC914A83;
	Thu, 11 Apr 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ze59wmX4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB6E552;
	Thu, 11 Apr 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848266; cv=none; b=l2elj8Z3iSvw3fBbfAshTIyaSxWN1Q/+iKcSw+dBv31kQGJXNwOgA6MCNJjMgkoZ/8/TfcI/EE2TK/HDpdVHrm3pM6gsj9wWKRPbsSks0ESCSEbVZJgXJrtqvJOmsQL/z6B2kqWjR1v/vlM7rU51B6By+7/69a1Yxq/XUT/qK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848266; c=relaxed/simple;
	bh=RsqRhsbh+ql74xg+OGS8w63Yx5baDe14/QMzlPFyRdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tro2BKo+8Ga+hZa5DjYEfTnfr0KTlEp1X4XdmbBR6PyBnla2PIG06wGtemVgaxkOtlVzWJrgmC+DY3/AeTMT31Sv64vpCnU5leK3mRKP2Vk/ak8Qe1sSkrLff3Cl+BkcwOW1QfM2bwGsLOCwnrN5ZdGq2KbNkNmM7VX09KQMS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ze59wmX4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712848262;
	bh=RsqRhsbh+ql74xg+OGS8w63Yx5baDe14/QMzlPFyRdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ze59wmX4SgV+C5LpyhnKcn2+dlVu/odsRx8HhOk566qpSLEIPzHn6nctxweg5VywM
	 A44+nhTjaM2QLBPWabdKnqPY2smWLSZlYYEulN6AP8Oc6qo04CWgcGWjOiRYmQZmlP
	 VLTnxjR2eWPfLzSsX+wL6ZokZpxq5CEKt9LiMpwswSa/HPkuq6voNxTDJ1NssovkRH
	 ThHw8SbBO/Uvr4b4FpfM5zFFYh4BcbqabpzM5RF5aMl5yq7LIngSeVc48f5BQTEsOS
	 XKX/w6JxEyMZH1yj5dSa1hPvDG06SbCGErjnYM6nHQvqFFsCmtb2de8CxNRtSZU5qs
	 gD/QYSR2vijWA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B756937813C0;
	Thu, 11 Apr 2024 15:11:01 +0000 (UTC)
Message-ID: <0e0da850-e810-4559-8086-99333e775d9b@collabora.com>
Date: Thu, 11 Apr 2024 17:11:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192
 compatible with MT8183
To: Conor Dooley <conor@kernel.org>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 bvanassche@acm.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, peter.wang@mediatek.com, chu.stanley@gmail.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, lgirdwood@gmail.com,
 broonie@kernel.org, matthias.bgg@gmail.com, stanley.chu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-6-angelogioacchino.delregno@collabora.com>
 <20240411-owl-euphemism-955ca43b5190@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411-owl-euphemism-955ca43b5190@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 17:07, Conor Dooley ha scritto:
> On Thu, Apr 11, 2024 at 01:42:57PM +0200, AngeloGioacchino Del Regno wrote:
>> The MT8192 UFS controller is compatible with the MT8183 one:
>> document this by allowing to assign both compatible strings
>> "mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.
>>
>> In preparation for adding MT8195 to the mix, the MT8192 compatible
>> was added as enum instead of const.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/ufs/mediatek,ufs.yaml        | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> index 32fd535a514a..adcd13023866 100644
>> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> @@ -14,9 +14,15 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - mediatek,mt8183-ufshci
>> -      - mediatek,mt8192-ufshci
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt8183-ufshci
>> +              - mediatek,mt8192-ufshci
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt8192-ufshci
>> +          - const: mediatek,mt8183-ufshci
> 
> It's a bit more distruptive since you'll have to modify a dts, but why
> permit both of these ways of describing the mt8192? Could we drop it
> from the original enum and no longer allow it in isolation? There
> shouldn't be any compatibility concerns with doing so.

Yes, will remove that in v3 :-)

Thanks!
Angelo

