Return-Path: <linux-kernel+bounces-151136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE578AA991
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C0DB21F01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065764AED9;
	Fri, 19 Apr 2024 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kgGLnf3i"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D247781;
	Fri, 19 Apr 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513247; cv=none; b=i4v0n7RK7YDSKCxgBrtflcwpBe4VsgccObeby6jRi1UcVp9pVTnkTS2ZrCl/vBmz/ffwLmqkW1saGTfGrLDQ2VVFxl9uu77tWDWaXVpn51b67FXUmoIEfYWWLJJr3lhUvgoZYMyp7Huzga8R+edZoPhIwEvT4Z7o2lu/GkxV/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513247; c=relaxed/simple;
	bh=XNjaagRG9HKGPXCD4NFNDozHtEtNCZhSQLrYfOGDUFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnBH6fD3GjKCundHrTtfa57KsuaTXeNNAegZLRmCTxK8mehJSw5MuWJ5853xs5E1Hp/o6ZBg23msgO+0LWrIXfFblZP2Mua+mIVoXulHbWx0vQfsbC6YTcR0zCRTrIN9RQISSdeva7W+dldOKeULOA6ydzbdKQiuSTC0rxHO3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kgGLnf3i; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713513243;
	bh=XNjaagRG9HKGPXCD4NFNDozHtEtNCZhSQLrYfOGDUFo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kgGLnf3iWCBYa2O8IuukcmY0plEAa+VQM/fi7CeRQbQwJJ0A0jEHbuJW1Xad9+oWg
	 gqNFtRBi7mX789sr1YbjJmWCiK2VXzI1sKzO5CnCSIlwPCKyFGsqIfX+tYo6vQ3xEr
	 Qj+rTevV7awJ7Ixa5CVLTTmwkjWPBLylCdWwdngNMLCg8aMEeKzRHnKIfri1LqzcSD
	 dCTt2cdJX3jDtdFW1YcfLkpAPaZRwjmgnNrrZeuS8/StnTUUfpVk2cST4Dg3LY5V8R
	 Unfe4AwiSlaHfD4NdtkmCseGZL2TMw7k2f0Cf9YFcnDjIfbNHMuFvEVgycxDoduvmV
	 aEVQs6Zu3EtKg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A8FBE3781116;
	Fri, 19 Apr 2024 07:54:02 +0000 (UTC)
Message-ID: <4ca51396-3ccd-4346-b777-9b42842cb26b@collabora.com>
Date: Fri, 19 Apr 2024 09:54:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: Rob Herring <robh@kernel.org>
Cc: chunkuang.hu@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, matthias.bgg@gmail.com, shawn.sung@mediatek.com,
 yu-chang.lee@mediatek.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
 kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
 <20240410191524.GA903053-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410191524.GA903053-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/24 21:15, Rob Herring ha scritto:
> On Tue, Apr 09, 2024 at 02:02:10PM +0200, AngeloGioacchino Del Regno wrote:
>> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
>> per HW instance (so potentially up to six displays for multi-vdo SoCs).
>>
>> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
>> so it only supports an output port with multiple endpoints - where each
>> endpoint defines the starting point for one of the (currently three)
>> possible hardware paths.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> index b3c6888c1457..4e9acd966aa5 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> @@ -93,6 +93,29 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      Output port node. This port connects the MMSYS/VDOSYS output to
>> +      the first component of one display pipeline, for example one of
>> +      the available OVL or RDMA blocks.
>> +      Some MediaTek SoCs support up to three display outputs per MMSYS.
> 
> I'm have a hard time understanding this, but is it 3 outputs
> simultaneously or connect mmsys to 1 of 3. Generally it's multiple ports
> for the former and endpoints for the latter.
> 

Yes I feel you, MediaTek SoCs are a bit strange, but I do have a reason to
use one port and multiple endpoints, instead of multiple ports and one endpoint.

On MediaTek SoCs, there are multiple ports: those multiple ports are represented
by multiple MMSYS or multiple VDOSYS (depending on the SoC), which do then have
multiple endpoints.

However, the multiple ports, at least for now, are represented by multiple MMSYS
and/or multiple VDOSYS nodes instead of one MM/VDO node with multiple iostart for
the multiple blocks in `reg`.

The multiple iostart "thing" was the initial design by MediaTek, but there was no
way to get them really connected the right way unless adding an iostart restriction
in the driver itself (so that the mmsys driver would check an iostart to probe the
mediatek-drm components for the right IP number), so, after quite many reviews and
many series versions, they had to resort to use multiple nodes for each VDO.

I think that, after this series, we could also clean that mess up (sorry for the
strong words) and make it right - assigning the MMIO for all VDOSYS blocks to one
node, and adding the multiple ports - however, that will require a bit of work that
is simply too much for this series alone.

Summarizing, so that you don't have to carefully proof-read all this wall of text:

- MediaTek SoCs have got multiple `port` for MMSYS and VDOSYS
   - Currently the driver implementation doesn't allow that
     - MediaTek had to work around no OF graph support!
   - Multiple ports are the multiple MMSYS/VDOSYS
- One MMSYS / One VDOSYS have multiple `endpoints`

That's how the HW is.

Hope that's clear now?

Cheers,
Angelo


>> +    properties:
>> +      endpoint@0:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the primary display pipeline
>> +
>> +      endpoint@1:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the secondary display pipeline
>> +
>> +      endpoint@2:
>> +        $ref: /schemas/graph.yaml#/properties/endpoint
>> +        description: Output to the tertiary display pipeline
>> +
>> +    required:
>> +      - endpoint@0
>> +
>>   required:
>>     - compatible
>>     - reg
>> -- 
>> 2.44.0
>>


