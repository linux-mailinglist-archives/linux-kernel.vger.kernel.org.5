Return-Path: <linux-kernel+bounces-140000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB38A0A21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56F71F21F11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218A13F45D;
	Thu, 11 Apr 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zJTpkWsP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0813DDB2;
	Thu, 11 Apr 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821171; cv=none; b=tqxHFRKL9bR3S3OCpsewMFSkaclKVgGk4+x6KC9X5bRLKaNa1nl/npTc5bo75l+yIq0KHJUPk1hgt8dg6+bMwqxH/bcf4Eb+Dfx+w6LuKnxbGmOiPliLRrGzCaO7mzErqutlqMzESmU7k40KX4RuW+ZDWBH0srfuijhkg1AYYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821171; c=relaxed/simple;
	bh=hsuaPyyXe500cwQ9jJuWJ0HPIXunGpuk5Dto5iwuLao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N4uZnjmI++12yNH//QWNlegGhnRjZ38x+WHH24PXrzG9ncsD5uMGYmt5cU+1vjPajef6q8cgMdrZjuW8OQkom2nk1FaO+keUWVF/GMsOa+a/78Z8pqueZMVUAp+kr3M6DIP0qDlnNFIizfXdbtGfoFnlRpzK8hQEEJLkvt3bWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zJTpkWsP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712821167;
	bh=hsuaPyyXe500cwQ9jJuWJ0HPIXunGpuk5Dto5iwuLao=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=zJTpkWsP+ijw64CxiA+6UhA5cy26ShfKAQCEvdPBmas2QwsdDornHYdz8tvpl/gRg
	 au2FO2XY3m9/E4q9S+G4VVCldwx8FhIXrgyY7KgXKmsopveF9WJx8x8/jv0YsL/6UO
	 5Z/EnfcCLkUlFR1rPo5Ho6F7uBVEb22DLhSgFaaRun64GqT6Gq9wR8ChI6gfH364Jm
	 9N082Zcrci3QA4LM8SUL4fem/WBrGYIRJU2uoOf16jPl5isGYfkon/HHJF7JP6DmU9
	 SjTPRvzyj8Vtv2k74JlmGsEsJbUdBoctkZVxJabWM40TBHLnuv9BAseVDPZoo1uAJM
	 7gIjxCzWe55Lw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B4CD3781107;
	Thu, 11 Apr 2024 07:39:26 +0000 (UTC)
Message-ID: <6e8e553b-8c5f-404a-a396-17d8b3440d93@collabora.com>
Date: Thu, 11 Apr 2024 09:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: "olivia.wen" <olivia.wen@mediatek.com>,
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
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
 <20240411033750.6476-2-olivia.wen@mediatek.com>
 <5cf005b9-d737-4509-a9fb-f0e59465482c@collabora.com>
Content-Language: en-US
In-Reply-To: <5cf005b9-d737-4509-a9fb-f0e59465482c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/04/24 09:34, AngeloGioacchino Del Regno ha scritto:
> Il 11/04/24 05:37, olivia.wen ha scritto:
>> Under different applications, the MT8188 SCP can be used as single-core
>> or dual-core.
>>
>> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>
>> ---
>>   Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml 
>> b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> index 507f98f..7e7b567 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
>> @@ -22,7 +22,7 @@ properties:
>>         - mediatek,mt8192-scp
>>         - mediatek,mt8195-scp
>>         - mediatek,mt8195-scp-dual
>> -
> 
> Don't remove the blank line, it's there for readability.
> 
>> +      - mediatek,mt8188-scp-dual

Ah, sorry, one more comment. Please, keep the entries ordered by name.
8188 goes before 8195.

> 
> After addressing that comment,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
>>     reg:
>>       description:
>>         Should contain the address ranges for memory regions SRAM, CFG, and,
>> @@ -195,6 +195,7 @@ allOf:
>>           compatible:
>>             enum:
>>               - mediatek,mt8195-scp-dual
>> +            - mediatek,mt8188-scp-dual

same here.

>>       then:
>>         properties:
>>           reg:
> 
> 


