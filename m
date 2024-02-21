Return-Path: <linux-kernel+bounces-74507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B42085D543
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6683282913
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBB3D96B;
	Wed, 21 Feb 2024 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5TfZlSyA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD53CF68;
	Wed, 21 Feb 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510366; cv=none; b=HepaNMjB4ZcQwmy5IPrfWY+aBXPR/a/zmlAZKn5h2f+8Q+scRuXuP8bZ09QSAQjBD7uO7Ou/SxgBNN0HGLCPqD7gix3zSePWN37x2uFY7Hz9aga9k0rWkZqzr87hmlu7vz/n0ejbhaA3SEuZJOPNFp8YP3jld+NluxZg1Ca2eXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510366; c=relaxed/simple;
	bh=oC+jcIYHSc5x4O62YHQVIizn+j678uC6MmEDPXx4YMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2yZWk562d5EwdrCvBT0rMtTLSqP91dFjVCxX20Q97RL7bHcIV3qe5GlT+tzETZbDQNfk9L+g1sxdR4PrOXXax6nbmKDOXZhOoejK6faz71STFNudSXZ2gWiFd1RkpaucRTgjkwh/TCNt7IMQFn5vD54rrDJuKft9wBO7/HChTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5TfZlSyA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708510363;
	bh=oC+jcIYHSc5x4O62YHQVIizn+j678uC6MmEDPXx4YMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=5TfZlSyAXlXFW3yVsCdpRGR8hryIUivUj5Y7GzXP2DMznawBuAznD6xMyCQFFeBP5
	 KN1aoq9QyRvawCKj8Uk8foiujmLVnYkohGCr8NvKH78AVwdr/bjbIhWgCovoVKj99/
	 ZEbOvc4bew84BrN26w9z+Oja1qjAhtW/rVWPKyD1F2FBi+3MrcJsYm8l+qC84M7t7K
	 hYk6mypKtxHxl26tJhtOiZOcMbO1R+Z16Gch960iQ/ZZYH4qPuXuTAiIp4TZg+D3Yw
	 2VCIpk+SZwrc6Z9S8tUMwVGHrDbSw/HG/0LKmd3pfsGFouM03qIUEVNx2UtdZbRCzm
	 1PX6WEulNvsjQ==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2230F378107C;
	Wed, 21 Feb 2024 10:12:43 +0000 (UTC)
Message-ID: <c6e51f24-93f6-4b87-9977-71a7a22cc68a@collabora.com>
Date: Wed, 21 Feb 2024 11:12:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: media: add Maxim MAX96717F GMSL2
 Serializer
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-2-julien.massot@collabora.com>
 <ZcXwQA3IiDu1etH1@valkosipuli.retiisi.eu>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <ZcXwQA3IiDu1etH1@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 2/9/24 10:28, Sakari Ailus wrote:
> Hi Julien,
> 
> On Thu, Jan 11, 2024 at 02:03:46PM +0100, Julien Massot wrote:
>> Add DT bindings for Maxim MAX96717F GMSL2 Serializer.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>> Change since v2:
>>   - remove reg description
>>   - add data lanes min/maxItems
>>   - Use generic node name
>>
>> ---
>>   .../bindings/media/i2c/maxim,max96717f.yaml   | 147 ++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
>> new file mode 100644
>> index 000000000000..f31517b1dbc8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
>> @@ -0,0 +1,147 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Collabora Ltd.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96717f.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MAX96717 CSI-2 to GMSL2 Serializer
>> +
>> +maintainers:
>> +  - Julien Massot <julien.massot@collabora.com>
>> +
>> +description: |
>> +  The MAX96717F serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input
> 
> Presumably this will need to be configured on the device? You should thus
> require the bus-type property in the endpoint.

Yes I will add the bus-type propery

> 
>> +  into GMSL2 serial outputs. The device allows the GMSL2 link to
>> +  simultaneously transmit bidirectional control-channel data while forward
>> +  video transmissions are in progress. The MAX96717F can connect to one
>> +  remotely located deserializer using industry-standard coax or STP
>> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
>> +  the MAX96717F can select the MIPI datatype, while the tunnel mode forward all the MIPI
>> +  data received by the serializer.
>> +  The MAX96717F supports Reference Over Reverse (channel),
>> +  to generate a clock output for the sensor from the GMSL reverse channel.
>> +
>> +  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
>> +  forward direction and 187.5Mbps in the reverse direction.
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max96717f
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
>> +            required:
>> +              - data-lanes
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        unevaluatedProperties: false
>> +        description: GMSL Output port
>> +
>> +    required:
>> +      - port@1
>> +
>> +  i2c-gate:
>> +    $ref: /schemas/i2c/i2c-controller.yaml
>> +    unevaluatedProperties: false
>> +    description: |
> 
> I think you can remove ' |'.
Ok

> 
>> +      The MAX96717F will forward the I2C requests from the
>> +      incoming GMSL2 link. Therefore, it supports an i2c-gate
>> +      subnode to configure a sensor.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/media/video-interfaces.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        serializer: serializer@40 {
>> +            compatible = "maxim,max96717f";
>> +            reg = <0x40>;
>> +            gpio-controller;
>> +            #gpio-cells = <2>;
>> +            #clock-cells = <0>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                port@0 {
>> +                    reg = <0>;
>> +                    max96717f_csi_in: endpoint {
>> +                        data-lanes = <1 2 3 4>;
>> +                        remote-endpoint = <&sensor_out>;
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    max96917f_gmsl_out: endpoint {
>> +                        remote-endpoint = <&deser_gmsl_in>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            i2c-gate {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                sensor@10 {
>> +                    compatible = "st,st-vgxy61";
>> +                    reg = <0x10>;
>> +                    reset-gpios = <&serializer 0 GPIO_ACTIVE_LOW>;
>> +                    clocks = <&serializer>;
>> +                    VCORE-supply = <&v1v2>;
>> +                    VDDIO-supply = <&v1v8>;
>> +                    VANA-supply = <&v2v8>;
>> +                    port {
>> +                        sensor_out: endpoint {
>> +                            data-lanes = <1 2 3 4>;
>> +                            remote-endpoint = <&max96717f_csi_in>;
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
> 

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

