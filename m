Return-Path: <linux-kernel+bounces-155291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5778AE850
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A911B2162F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCB136988;
	Tue, 23 Apr 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mUR834tX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B918E28;
	Tue, 23 Apr 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879404; cv=none; b=nvRgrs+9eqe97U2W1mYZGB27ZsCnEs+KYZfRctYJ7OIinpZsr+68+A8GXz5ZrMyWD+LfTNyISmRal2bMBtuc5Ya9srW2Lv0o26Vl0NdowCuLXak5bcFDeaaZcWp0vHnIGPaY6hECSzXeqG9tqWkqc3RkJaVKJzQ9tupBAEItZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879404; c=relaxed/simple;
	bh=6T2svg46b0iSYrobBU7rygdpCxxdDju+onJHDDgFxkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8giNdpd8GN686m4tIShQvcyGaPZbOkrwOtyMRDSNJzQB96FA+SOFDX4oCN22fL5HUjY5PfYsADcdSdCpVZBjOVseqxu03qS+ZRJa7++l/an8VHKU5nGZyv5jVSaQePiGToOFgzmHDxmiE3lVrEUHko0C8hv4nZ6NSh2O7Q0sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mUR834tX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713879401;
	bh=6T2svg46b0iSYrobBU7rygdpCxxdDju+onJHDDgFxkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mUR834tXeSfz4u6Rh+opHET9TkCB892OokzoeoEl9Dwg9By4zW+sAAxqlm34owZFL
	 hjTgcEVpFe8n3Qg/Y5dABUSXkWXp477D85Vgy/9LNJJ37drRjmEYv7cNqrxzdV30lI
	 iydG9ASyg3V1dtnu8fIK3pWGxrYFCQex0NVRikcxhOl7vUkvRKcZG+TSqZxkh4bDft
	 Br9v7M9yOJSZBr12dRn7/HXJJEMwb4V+jjncXimbUOpp/do6eo4lXLostAAJfF12OD
	 l+VH+55sYho2nz3MxXVNh4UqiUGizUhXy65t+5KRT7Mhlh7RDttcuowkz+uHkMDgYr
	 AEuXXRfQYqICw==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 827D63782136;
	Tue, 23 Apr 2024 13:36:40 +0000 (UTC)
Message-ID: <f5a178b9-2eeb-4737-a051-b43cde9fae20@collabora.com>
Date: Tue, 23 Apr 2024 15:36:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2
 Serializer
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org, mchehab@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-2-julien.massot@collabora.com>
 <ZhkWqEAN4RozmPlT@valkosipuli.retiisi.eu>
Content-Language: en-US
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <ZhkWqEAN4RozmPlT@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

Thanks for the review

On 4/12/24 13:10, Sakari Ailus wrote:
> Hi Julien,
> 
> On Mon, Mar 25, 2024 at 02:16:31PM +0100, Julien Massot wrote:
>> Add DT bindings for Maxim MAX96717 GMSL2 Serializer.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>> Change since v5:
>>   - Reverse the fallback MAX96717 can fallback to MAX96717F
>>   - Use const instead of enum for MAX96717F compatible
>>   
>> Change since v4:
>>   - Add compatible for MAX96717 and use it as a fallback for MAX96717F
>>   - Remove extra '|' for decriptions
>>   - Reference 'i2c-gate' instead of 'i2c-controller'
>>
>> Change since v3:
>>   - Renamed file to maxim,max96717.yaml dropped the 'f' suffix
>>   - Added lane-polarities and bus type properties to the CSI endpoint
>>
>> Change since v2:
>>   - remove reg description
>>   - add data lanes min/maxItems
>>   - Use generic node name
>> ---
>>   .../bindings/media/i2c/maxim,max96717.yaml    | 164 ++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
>> new file mode 100644
>> index 000000000000..ac8bf11a6fa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
>> @@ -0,0 +1,164 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Collabora Ltd.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96717.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MAX96717 CSI-2 to GMSL2 Serializer
>> +
>> +maintainers:
>> +  - Julien Massot <julien.massot@collabora.com>
>> +
>> +description:
>> +  The MAX96717 serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input
>> +  into GMSL2 serial outputs. The device allows the GMSL2 link to
>> +  simultaneously transmit bidirectional control-channel data while forward
>> +  video transmissions are in progress. The MAX96717 can connect to one
>> +  remotely located deserializer using industry-standard coax or STP
>> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
>> +  the MAX96717 can select the MIPI datatype, while the tunnel mode forward all the MIPI
>> +  data received by the serializer.
>> +  The MAX96717 supports Reference Over Reverse (channel),
>> +  to generate a clock output for the sensor from the GMSL reverse channel.
>> +
>> +  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
>> +  forward direction and 187.5Mbps in the reverse direction.
>> +  MAX96717F only supports a fixed rate of 3Gbps in the forward direction.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: maxim,max96717f
>> +      - items:
>> +          - enum:
>> +              - maxim,max96717
>> +          - const: maxim,max96717f
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +    description:
>> +      First cell is the GPIO pin number, second cell is the flags. The GPIO pin
>> +      number must be in range of [0, 10].
>> +
>> +  gpio-controller: true
>> +
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        description: CSI-2 Input port
>> +
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
>> +
>> +            properties:
>> +              data-lanes:
>> +                minItems: 1
>> +                maxItems: 4
>> +
>> +              lane-polarities:
>> +                minItems: 1
>> +                maxItems: 5
>> +
>> +              bus-type:
>> +                enum:
>> +                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
>> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> 
> Now that you have C-PHY here, does the hardware support data line order
> mapping? Just wondering. The bindings can be added without that and support
> added later on---that's what the video-interfaces.yaml is currently
> missing.
> 
> lane-polarities is only valid for D-PHY. What about the data-lanes, the
> maximum is probably different for C-PHY?
My mistake here; MAX96717 doesn't support C-PHY; I think I was confused 
by some of the schemas implying a deserializer with C-PHY support.
I will drop the bus-type property in v7.

Regards,
-- 
Julien

