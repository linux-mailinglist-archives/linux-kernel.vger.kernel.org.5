Return-Path: <linux-kernel+bounces-117138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19B88A7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473C7327FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441B14E2FD;
	Mon, 25 Mar 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QEaOdJT2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8805A4D4;
	Mon, 25 Mar 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372941; cv=none; b=NNC+yqonjtcFLx3++hMUrANwIXM45gaogy3yGuSKYNlaOCyca4Slcay6I8gbeev2J0sda0qeBtKrTgZHZpY+s0ERnMTPR3FLwgQ6TEYd2AmGlabLMPbAz/DHjlswbSA+zUaL8HCHUzzzsrQgh898i7TgcxesHe/MVBiLxm/NpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372941; c=relaxed/simple;
	bh=QGvdM7PX97DZulGhq1lE2bXZMhHjYoCmKXt732YoRgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny5L9pzfXPsPzVIijK/LaphJMbJ7MsJ4FFaR8vQSQUr0G0mzRKl8oA9BbHw2xWFtEK8gQxtQvHBMHpfM9BwL1qAeV7akckpQfNyDly2KR8zCmcZ3fyUncuZ7HOQfb9xx1fySIZ6rM8fmtltUC7l30wLYT2YW2XnFeNoBE9W6lZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QEaOdJT2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711372937;
	bh=QGvdM7PX97DZulGhq1lE2bXZMhHjYoCmKXt732YoRgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QEaOdJT2FP0uzaYA3UT7ZzlNdePdtNrNDdh5kkjVUHM5DMN4fMidoFi2Worn4iYo1
	 WZII+j4LGuzNEPPZKyfZzKEXwCjrPZnW6ed8L9e/6DEMpEbXWdDW95T2MjRccxw+0b
	 OufsQzjy37giI6Ad+8aiNaUsD3B4DL9tWuZYq7LzRonZx5mHOdsgru3zbe4FDUc511
	 e5k5hPeoJWD1qMxBVyBQZtaJbdeRD6RLQIbM2UBd4cLy2iFMfOYO3CXhVFx0zF0Cl0
	 n1SV60X9j8RFlxJE90CS+v3rzt8C4NxvGkS1qF+ybB5QNfoH+P5Ne07zz3OPrbnmV1
	 H2rGH5BaVt64g==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BB3C378148F;
	Mon, 25 Mar 2024 13:22:17 +0000 (UTC)
Message-ID: <97e32ac5-7646-4fcc-affd-89abcca2b1b9@collabora.com>
Date: Mon, 25 Mar 2024 14:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
To: Conor Dooley <conor@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org, mchehab@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sakari.ailus@iki.fi
References: <20240313094922.311743-1-julien.massot@collabora.com>
 <20240313094922.311743-3-julien.massot@collabora.com>
 <20240317-petty-backache-b10d0fde62cf@spud>
Content-Language: en-US
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20240317-petty-backache-b10d0fde62cf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

Thanks for your review.
On 3/17/24 16:18, Conor Dooley wrote:
> On Wed, Mar 13, 2024 at 10:49:20AM +0100, Julien Massot wrote:
>> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>> Change since v4:
>>   - Add compatible for MAX96714 and use it as a fallback for MAX96714F
>>   - Remove extra '|' for decriptions
>>   - Reference 'i2c-gate' instead of 'i2c-controller'
>>
>> Change since v3:
>>   - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
>>   - Removed mention to C-PHY since it's not supported by MAX96714 deserializers
>>   - Removed bus-type requirement on CSI endpoint since the device only support D-PHY
>>   - Removed the clock-lanes property in the dt example
>>
>> Change since v2:
>>   - remove reg description
>>   - rename enable gpio to powerdown
>>   - use generic node name: i2c, serializer, deserializer
>> ---
>>   .../bindings/media/i2c/maxim,max96714.yaml    | 176 ++++++++++++++++++
>>   1 file changed, 176 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
>> new file mode 100644
>> index 000000000000..59b116092834
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
>> @@ -0,0 +1,176 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Collabora Ltd.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96714.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
>> +
>> +maintainers:
>> +  - Julien Massot <julien.massot@collabora.com>
>> +
>> +description:
>> +  The MAX96714 deserializer converts GMSL2 serial inputs into MIPI
>> +  CSI-2 D-PHY formatted output. The device allows the GMSL2 link to
>> +  simultaneously transmit bidirectional control-channel data while forward
>> +  video transmissions are in progress. The MAX96714 can connect to one
>> +  remotely located serializer using industry-standard coax or STP
>> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
>> +  the MAX96714 can select individual video stream, while the tunnel mode forward all
>> +  the MIPI data received by the serializer.
>> +
>> +  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
>> +  forward direction and 187.5Mbps in the reverse direction.
>> +  MAX96714F only supports a fixed rate of 3Gbps in the forward direction.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - maxim,max96714
> 
> There's only once device here, make it const rather than enum.

Okay fixed in v6

> 
>> +      - items:
>> +          - enum:
>> +              - maxim,max96714f
>> +          - const: maxim,max96714 # fallback for 'f' variant
> 
> Drop the comment btw, it doesn't make sense given you have an enum that
> will allow for more devices and it being a fallback is obvious. That
> said, given what you told me on the last version
> | Yes there are a few differences visible to the software, for example the
> | GMSL
> | link rate since MAX96714 support 6 and 3 Gbps, while MAX96714F only
> | supports 3Gbps.
> | the registers map is the same, but a few values are not possible with
> | the 'f' version.
> I don't think your ordering here is correct. The 96714 should fall back
> to the 96714f, not the opposite that you have here, as the f is the
> version which supports fewer features.
> 
> I think this should be:
> 
> oneOf:
>    - const: maxim,max96714f
>    - items:
>        - enum:
>            - maxim,max96714
>        - const: maxim,max96714f

I just sent a v6 version with your suggestion. Indeed it makes more sense
to use max96714/7f as a fallback for the non f variant.

Best regards,
Julien

