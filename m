Return-Path: <linux-kernel+bounces-74503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C577685D536
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AD61F22082
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FA3D996;
	Wed, 21 Feb 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XuTqiKMz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9D3D579;
	Wed, 21 Feb 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510254; cv=none; b=QasbQILH1naAAxxcd/Z9KJ8c9IG5agV9nDR9u08t9NAxqxT2LhmvMsOOb+95qqhaUGHtiJV094o0uUkTXaujVAZxAPkVkJ0SxWY9o3m8JPgKIYr2Y7xk/aHiMO4o2JZjZjcq0k2KhZbBCXyCObA/A/WPmoWlP1MgD5Izki5Hu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510254; c=relaxed/simple;
	bh=GJIp+9N0ALQw1lB2vtmc1T3t+c7YOiY0zhce7sagHxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYb/i+Jv0ey33B2B5dt0uczzIk8NXGDQVghJq40HLZmu8RVrOiPprlSqGw3o4rp1dRTc94qxTf6zfgbZUc5FpCZnUwpuElMuVoZCI5QU37ZbhffPTTQDqiJBApBdIAyiNaoE4uaVCTbyCCLN7ONQPwVPRvijMMsLwqgmhzE1Llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XuTqiKMz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708510251;
	bh=GJIp+9N0ALQw1lB2vtmc1T3t+c7YOiY0zhce7sagHxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XuTqiKMzmLxYXeBAL5SwHYfzYW/gXwuX/5wUA3QUnHu3mTCVUthqhrz9lQ+qAad5x
	 Y5MhoQIR2ylrj/FjXVVIXkSu8hCFtGhKtrDl+ZCVcTSMGRVOFusJIdsSbEK/ZnkZ14
	 qPdAWmoVmIGKWZn46Ej5gLcJYVvGIK4uapkY9kH9owE1ZwMMkWEF+7AV25wORDaymq
	 gawnNJxMHqKRvmWt84hO4dHdAnCLT/8LBTkmOZquYTeiDMKu17dug+UiM+gJ5gk9XP
	 4TMwALene5ubkBMwkuEblwoYXGUQ1wrJoGW1zvj/tcWa3koJxTXl2FZEoeM6gt79Gv
	 pOI8Kbr8vYXVw==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C818E37820C8;
	Wed, 21 Feb 2024 10:10:50 +0000 (UTC)
Message-ID: <81c7fa86-a794-42a0-ab19-172fa1f1f34b@collabora.com>
Date: Wed, 21 Feb 2024 11:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: media: add Maxim MAX96714F GMSL2
 Deserializer
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-3-julien.massot@collabora.com>
 <ZcX07nUiI4IUuReP@valkosipuli.retiisi.eu>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <ZcX07nUiI4IUuReP@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

Thanks for the review!

On 2/9/24 10:48, Sakari Ailus wrote:
> Hi Julien,
> 
> On Thu, Jan 11, 2024 at 02:03:47PM +0100, Julien Massot wrote:
>> Add DT bindings for Maxim MAX96714F GMSL2 Deserializer.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>>
>> ---
>> Change since v2:
>>   - remove reg description
>>   - rename enable gpio to powerdown
>>   - use generic node name: i2c, serializer, deserializer
>> ---
>>   .../bindings/media/i2c/maxim,max96714f.yaml   | 171 ++++++++++++++++++
>>   1 file changed, 171 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
>> new file mode 100644
>> index 000000000000..2423d166c954
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
>> @@ -0,0 +1,171 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024 Collabora Ltd.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96714f.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
>> +
>> +maintainers:
>> +  - Julien Massot <julien.massot@collabora.com>
>> +
>> +description: |
>> +  The MAX96714F deserializer converts GMSL2 serial inputs into MIPI
>> +  CSI-2 D-PHY or C-PHY formatted output. The device allows the GMSL2 link to

Description is wrong if the MAX96717F is supporting C-PHY MAX96714F doesn't.
I will remove the mention to C-PHY sorry for the confusion.

>> +  simultaneously transmit bidirectional control-channel data while forward
>> +  video transmissions are in progress. The MAX96714F can connect to one
>> +  remotely located serializer using industry-standard coax or STP
>> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
>> +  the MAX96714F can select individual video stream, while the tunnel mode forward all
>> +  the MIPI data received by the serializer.
>> +
>> +  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
>> +  forward direction and 187.5Mbps in the reverse direction.
>> +
>> +properties:
>> +  compatible:
>> +    const: maxim,max96714f
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  powerdown-gpios:
>> +    maxItems: 1
>> +    description:
>> +      Specifier for the GPIO connected to the PWDNB pin.
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        unevaluatedProperties: false
>> +        description: GMSL Input
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
>> +            description:
>> +              Endpoint for GMSL2-Link port.
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>> +        unevaluatedProperties: false
>> +        description: CSI-2 Output port
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
>> +              link-frequencies:
>> +                maxItems: 1
>> +
>> +              bus-type:
>> +                enum:
>> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
> 
> MEDIA_BUS_TYPE_CSI2_CPHY (1) is missing. Even if the driver doesn't support
> it, it would be best to list it here.

After verification the hardware only support D-PHY and not C-PHY, will
drop the required
property for 'bus-type'.

> 
>> +
>> +            required:
>> +              - data-lanes
>> +              - bus-type
>> +
>> +    required:
>> +      - port@1
> 
> Why port@1 but not port@0?

The device can be used as a pattern generator, so this is fine not to
have a serializer connected to the port@0, but it makes no sense to 
leave the deserializer CSI port not connected.

> 
>> +
>> +  i2c-gate:
>> +    $ref: /schemas/i2c/i2c-controller.yaml
>> +    unevaluatedProperties: false
>> +    description: |
>> +      The MAX96714 will pass through and forward the I2C requests from the
>> +      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c-gate
>> +      subnode to configure a serializer.
>> +
>> +  port0-poc-supply:
>> +    description: Regulator providing Power over Coax for the GMSL port
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
>> +
>> +        deserializer@28 {
>> +            compatible = "maxim,max96714f";
>> +            reg = <0x28>;
>> +            powerdown-gpios = <&main_gpio0 37 GPIO_ACTIVE_LOW>;
>> +
>> +            ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                port@0 {
>> +                    reg = <0>;
>> +                    max96714_gmsl_in: endpoint {
>> +                        remote-endpoint = <&max96917f_gmsl_out>;
>> +                    };
>> +                };
>> +
>> +                port@1 {
>> +                    reg = <1>;
>> +                    max96714_csi_out: endpoint {
>> +                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
>> +                        clock-lanes = <0>;
> 
> clock-lanes isn't listed in bindings. You can drop it from here.
Ok

> 
>> +                        data-lanes = <1 2 3 4>;
>> +                        link-frequencies = /bits/ 64 <400000000>;
>> +                        remote-endpoint = <&csi_in>;
>> +                    };
>> +                };
>> +            };
>> +
>> +            i2c-gate {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                serializer@40 {
>> +                    compatible = "maxim,max96717f";
>> +                    reg = <0x40>;
>> +                    gpio-controller;
>> +                    #gpio-cells = <2>;
>> +                    #clock-cells = <0>;
>> +
>> +                    ports {
>> +                        #address-cells = <1>;
>> +                        #size-cells = <0>;
>> +
>> +                        port@0 {
>> +                            reg = <0>;
>> +                            max96717f_csi_in: endpoint {
>> +                                data-lanes = <1 2>;
>> +                                lane-polarities = <1 0 1>;
> 
> Shouldn't lane-polarities be mentioned in bindings, too?

You are right I will add lane-polarities to my next patchset.
> 
>> +                                remote-endpoint = <&sensor_out>;
>> +                            };
>> +                        };
>> +
>> +                        port@1 {
>> +                            reg = <1>;
>> +                            max96917f_gmsl_out: endpoint {
>> +                                remote-endpoint = <&max96714_gmsl_in>;
>> +                            };
>> +                        };
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
> 

Best regards,

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

