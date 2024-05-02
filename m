Return-Path: <linux-kernel+bounces-166154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C4C8B96DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977A82849CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF35337A;
	Thu,  2 May 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ASzglJyC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06E51C52;
	Thu,  2 May 2024 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639857; cv=none; b=qcjTIqsoqcJqG0PpwU9DwltLa2JoFh3oQCZaNLduEnT70aCy0vXjVzmn83JKWWCPpZGLPNUMYcUFZXeaolsoSIt3Yb0CHNWsVVQVfXF50zuQJja+w2PiARYirJ0hSh2TPkZrdyA7CR5fgv2X2kaud/kCrwl2UbvckRqz7Z1S7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639857; c=relaxed/simple;
	bh=+Lb7J1gmlvIpsXKmJHjaAl2BUALuNXoInVJs8yhviak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtpQWcreK8Qhr/pdjv+Afpa6RRaGHC453+9i6HjoD6s+wfpRCUbhAcGrEXQ736aoTuK6Wh1l3nP5kZqp2OtOdk9jw2YdXrrOv9BD6AOKZIRiePXQIQPUuM7AcDRWnFXj4nvkKNd37ii3DnWlT+3Z7ihNpQ/pA1gi91LsNxqGihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ASzglJyC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714639854;
	bh=+Lb7J1gmlvIpsXKmJHjaAl2BUALuNXoInVJs8yhviak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ASzglJyCUneV4xe5N8g29/uZljb8ODoTyebr/uFYbBkUljBsgxkIely3MH0C4GHsH
	 TLWRcvz1bWUXgO9S108/DbZB51kkrUC9IFBjvgGmytwCMUuWYNwOCUafbgJUliqKtK
	 po54belYQIctldmUvYi6C0To9PoVwgJjYX5srxPVazkiAWpf3jCLHVfJzGNVqEpBLm
	 5U/sVQj3HN9tXekw0Lrhl/h8kLoDt5Kz9Ru2US+pBKLLVUXm1FUQhMMQ+JZgdG7wPU
	 TdV6j4REC+tJwtXHyx/LbBt8hsaHWU/m7WycT0eif8ZSzSPxy6nxFvu8/PV/ucemGQ
	 6mlcsx7MCpyLA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3E953781013;
	Thu,  2 May 2024 08:50:52 +0000 (UTC)
Message-ID: <becdc2e5-4a1d-4280-b6f8-78d4903be283@collabora.com>
Date: Thu, 2 May 2024 10:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
 <aa7e3bcf70383e563a65919f924ec2e5e4cd778c.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aa7e3bcf70383e563a65919f924ec2e5e4cd778c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/04/24 04:23, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Tue, 2024-04-09 at 14:02 +0200, AngeloGioacchino Del Regno wrote:
>> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP
>> paths
>> per HW instance (so potentially up to six displays for multi-vdo
>> SoCs).
>>
>> The MMSYS or VDOSYS is always the first component in the DDP
>> pipeline,
>> so it only supports an output port with multiple endpoints - where
>> each
>> endpoint defines the starting point for one of the (currently three)
>> possible hardware paths.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23
>> +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> index b3c6888c1457..4e9acd966aa5 100644
>> ---
>> a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> +++
>> b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> @@ -93,6 +93,29 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      Output port node. This port connects the MMSYS/VDOSYS output
>> to
>> +      the first component of one display pipeline, for example one
>> of
>> +      the available OVL or RDMA blocks.
>> +      Some MediaTek SoCs support up to three display outputs per
>> MMSYS.
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
> 
> mmsys/vdosys does not output data to the first component of display
> pipeline, so this connection looks 'virtual'. Shall we add something
> virtual in device tree? You add this in order to decide which pipeline
> is 1st, 2nd, 3rd, but for device it don't care which one is first. In
> computer, software could change which display is the primary display.
> I'm not sure it's good to decide display order in device tree?
> 

Devicetree describes hardware, so nothing virtual can be present - and in any case,
the primary/secondary/tertiary pipeline is in relation to MM/VDO SYS, not referred
to software.

Better explaining, the primary pipeline is not necessarily the primary display in
DRM terms: that's a concept that is completely detached from the scope of this
series and this graph - and it's something that shall be managed solely by the
driver (mediatek-drm in this case).

Coming back to the connection looking, but *not* being virtual: the sense here is
that the MM/VDOSYS blocks are used in the display pipeline to "stitch" together
the various display pipeline hardware blocks, or, said differently, setting up the
routing between all of those (P.S.: mmsys_mtxxxx_routing_table!) through the VDO
Input Selection (VDOx_SEL_IN) or Output Selection (VDOx_SEL_OUT) and with the
assistance of the VDO Multiple Output Mask (VDOx_MOUT) for the multiple outputs
usecase, both of which, are described by this graph.

This means that the VDOSYS is really the "master" of the display pipeline since
everything gets enabled, mixed and matched from there - and that's in the sense
of hardware operation, so we are *really* (and not virtually!) flipping switches.


Cheers,
Angelo

> Regards,
> CK
> 
> 
>>   required:
>>     - compatible
>>     - reg


