Return-Path: <linux-kernel+bounces-167398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF958BA8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE201F219D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8314EC6A;
	Fri,  3 May 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lZSLAXFc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166514F11E;
	Fri,  3 May 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725700; cv=none; b=Ya7bzgNaZ+pv06cVcJ/xfdfkq4+S97B8m1yGXp811pCYDosansodXvIPGHzRsWI0AIhAvLhjlhtdrkoLwNmbeSV+zOzugmHZOWLaxHYgkQP8vwheL5LpsB0wlifvZLPGQMTuuulWgQvklzDIAMPuLa1KkJm2CUlK/C/2/h4tnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725700; c=relaxed/simple;
	bh=FGtuc8fN+adV5IdcKxxzcZiz/3q8oYorz13jCNFz09Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:CC:
	 In-Reply-To:Content-Type; b=L5GtqgDlwYEkoTJ+GWqj8IjsDsBw7a1CEtezF7X1lKGJMWZRU7Ob2WIj5XUYrMbYCgpAb4VHvDL8c2foiFJgpvGI9FLi4AovjUCtQ1r/3o3mkaSnxtnf25TgbwRxQC6tvSH+acYfOfexMqtqLLIT0BctUB7nX4A/M9Y51HUPmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lZSLAXFc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4437eMtk025388;
	Fri, 3 May 2024 10:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:from:subject:references:to:cc
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=UqDgrPAApxhY5AFKzDUvYTeIrPyzOChzVfZX2ndZdd8=; b=lZ
	SLAXFc8ZaPw/F40VwTCkKuILxd7zPuN7TJee3s5P3yMh7bO5k0u5y8Z8gf+d9PvA
	hT9d5MfjRoHTkRMTFMSCPVqvgf39YdVgtsrysRT/v6WdZ9FSILhiEItpG9ygbG/H
	i2Ga6HJ38bF9VQeyQO2oRWc9aFllBOXmHEaiOBP70EuPrTvZ9QVZTOXhPqqXbvhh
	IztHteZUy6in0ccYYfgGR9fGNbmYE0sgTi5/Ve+eWk2C04LILI4u2lLF4tsKoKHt
	CsxzAiI0H3vkhKCUarKsW6e9A2MNfG9wk2QX5PMjJJONxlTfy4ltvS0TIPTSVosP
	3LE+Ytk61irPr6DcAEhg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xsax1ek5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 10:41:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C9154004B;
	Fri,  3 May 2024 10:41:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B90A211601;
	Fri,  3 May 2024 10:40:34 +0200 (CEST)
Received: from [10.252.22.51] (10.252.22.51) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 10:40:33 +0200
Message-ID: <26520ee7-3c0d-497d-b4d7-6e1300ba07dc@foss.st.com>
Date: Fri, 3 May 2024 10:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sylvain Petinot <sylvain.petinot@foss.st.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: Add ST VD56G3 camera sensor
 binding
References: <20240417133453.17406-1-sylvain.petinot@foss.st.com>
 <20240417133453.17406-2-sylvain.petinot@foss.st.com>
 <Zilvm98FNzWoGFL_@valkosipuli.retiisi.eu>
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@iki.fi>
CC: <benjamin.mugnier@foss.st.com>, <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Zilvm98FNzWoGFL_@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02

Hi Sakari,

Thanks for the review.

On 4/24/2024 10:46 PM, Sakari Ailus wrote:
> Hi Sylvain,
> 
> Thanks for the patch.
> 
> On Wed, Apr 17, 2024 at 03:34:52PM +0200, Sylvain Petinot wrote:
>> Add devicetree bindings Documentation for ST VD56G3 & ST VD66GY camera
>> sensors. Update MAINTAINERS file.
>>
>> Signed-off-by: Sylvain Petinot <sylvain.petinot@foss.st.com>
>> ---
>>  .../bindings/media/i2c/st,st-vd56g3.yaml      | 143 ++++++++++++++++++
>>  MAINTAINERS                                   |   9 ++
>>  2 files changed, 152 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
>> new file mode 100644
>> index 000000000000..6792c02fea5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright (c) 2024 STMicroelectronics SA.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/i2c/st,st-vd56g3.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics VD56G3 Global Shutter Image Sensor
>> +
>> +maintainers:
>> +  - Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>> +  - Sylvain Petinot <sylvain.petinot@foss.st.com>
>> +
>> +description: |-
> 
>> +  The STMicroelectronics VD56G3 is a 1.5 M pixel global shutter image sensor
>> +  with an active array size of 1124 x 1364 (portrait orientation).
>> +  It is programmable through I2C, the address is fixed to 0x10.
>> +  The sensor output is available via CSI-2, which is configured as either 1 or
>> +  2 data lanes.
> 
> The flow of the text could be improved by wrapping the text before 80
> columns (not earlier). Most editors can do this.

Sure, will be fixed in V2.

> 
>> +  The sensor provides 8 GPIOS that can be used for either
>> +    - frame synchronization (Master: out-sync or Slave: in-sync)
>> +    - external LED signal (synchronized with sensor integration periods)
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - st,st-vd56g3
>> +      - st,st-vd66gy
>> +    description:
>> +      Two variants are availables; VD56G3 is a monochrome sensor while VD66GY
>> +      is a colour variant.
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  VCORE-supply:
>> +    description: Digital core power supply (1.15V)
>> +
>> +  VDDIO-supply:
>> +    description: Digital IO power supply (1.8V)
>> +
>> +  VANA-supply:
>> +    description: Analog power supply (2.8V)
>> +
>> +  reset-gpios:
>> +    description: Sensor reset active low GPIO (XSHUTDOWN)
>> +    maxItems: 1
>> +
>> +  st,leds:
>> +    description:
>> +      Sensor's GPIOs used for external LED control.
>> +      Signal being the enveloppe of the integration time.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 8
>> +    items:
>> +      minimum: 0
>> +      maximum: 7
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces.yaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          clock-lanes:
>> +            const: 0
> 
> If the clock lane is always zero, you can drop the property.

I added it to be consistent with the data-lanes that can be
reordered/swapped. But yes, it serves nothing.

Does it make sense to keep the corresponding dev_err() message in the
driver ?

> 
>> +
>> +          data-lanes:
>> +            minItems: 1
>> +            maxItems: 2
>> +            items:
>> +              enum: [1, 2]
>> +
>> +          link-frequencies:
>> +            minItems: 1
>> +            maxItems: 1
>> +            items:
>> +              enum: [402000000, 750000000]
> 
> Is this a property of the sensor or the driver? Presumably the driver?
> 
> What about the input clock frequency?

Here are the HW constraints :

- Input clock must be in [6Mhz-27Mhz]
- By design, Pll Clock must target 804Mhz : the driver set some
prediv/mult to achieve this
- Then the MIPI frequency can be configured in the range [125Mhz-750Mhz]

That being said, the common usage (and what is implemented in the
driver) is :
- 1 data lane -> MIPI freq = 750Mhz
- 2 data lanes -> MIPI freq = 402Mhz

> 
>> +
>> +          lane-polarities:
>> +            minItems: 1
>> +            maxItems: 3
>> +            items:
>> +              enum: [0, 1]
> 
> The items are already in video-interfaces.yaml.

Ok, will be dropped for V2.

> 
>> +            description: Any lane can be inverted or not.
>> +
>> +        required:
>> +          - clock-lanes
>> +          - data-lanes
>> +          - link-frequencies
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - VCORE-supply
>> +  - VDDIO-supply
>> +  - VANA-supply
>> +  - reset-gpios
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        vd56g3: camera-sensor@10 {
>> +            compatible = "st,st-vd56g3";
>> +            reg = <0x10>;
>> +
>> +            clocks = <&camera_clk_12M>;
>> +
>> +            VCORE-supply = <&camera_vcore_v1v15>;
>> +            VDDIO-supply = <&camera_vddio_v1v8>;
>> +            VANA-supply = <&camera_vana_v2v8>;
>> +
>> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
>> +            st,leds = <6>;
>> +
>> +            port {
>> +                vd56g3_ep: endpoint {
>> +                    clock-lanes = <0>;
>> +                    data-lanes = <1 2>;
>> +                    link-frequencies =
>> +                      /bits/ 64 <402000000>;
> 
> No need for a newline after "=".

Thanks.

> 
>> +                    remote-endpoint = <&csiphy0_ep>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7c121493f43d..991e65627e18 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20868,6 +20868,15 @@ S:	Maintained
>>  F:	Documentation/hwmon/stpddc60.rst
>>  F:	drivers/hwmon/pmbus/stpddc60.c
>>  
>> +ST VD56G3 DRIVER
>> +M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>> +M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
>> +L:	linux-media@vger.kernel.org
>> +S:	Maintained
>> +T:	git git://linuxtv.org/media_tree.git
>> +F:	Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
>> +F:	drivers/media/i2c/st-vd56g3.c
>> +
>>  ST VGXY61 DRIVER
>>  M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>>  M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
> 

--
Sylvain

