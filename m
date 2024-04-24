Return-Path: <linux-kernel+bounces-157705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A78B14DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D81F23FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE56156978;
	Wed, 24 Apr 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GAav2AQv"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26E1772F;
	Wed, 24 Apr 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991586; cv=pass; b=NUNJ1r0PQk4W2QnQ+JcvMdgNiwMh1vM5YntjoUkC4EnRprIKHORN4RqD6hQ0COnyajTbuSeVVSi3eszTx3RN9Ir+RvyDxL9f3Ih623HUKF34oJshQK76iVncouNv/+/qxywHDBR/J4nGYAKeKfk2FvZYzVfzs8X6oVWvncmbw68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991586; c=relaxed/simple;
	bh=Za8essE1jwdIXvxMhQKUOCruzXPmu9sSKRXZnQaC/04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4rIjBBcDz/s/oh21wOsnsaTWeVMlOzpjgsqyM6Q7TkDqswWEKxpTW06gjZ1hYIkzd5w4PDI9O5AmbZtf/ah+GlPtZX6s9v2XUtWzLte978Y0MjMXPryuY2FFcq43MN+fRDaIkRiZs6mQ5Y4IvSfup84J7Ds9Gpdu0hEx6WQrlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GAav2AQv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VPrcY0Z8bzyS9;
	Wed, 24 Apr 2024 23:46:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1713991581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueBAWNliVb+VwYWcNCW4oPB3DbovNowk0vSZn5YeC5A=;
	b=GAav2AQvk6wp8UACJNAfTGeZW/rfzYBrZmfq2WWWciDYQyXGEzRpy1LPzeNmxwlmsOWCow
	s8EfObeDmqa90y4MpGXnD+v7NtOBzH2ejmF+928zPpgBz+ovCku59IQoU4KLwnOzf7lTjg
	attx6CtUUBz6IEE0hQ2X5B+8geP5ihk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1713991581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueBAWNliVb+VwYWcNCW4oPB3DbovNowk0vSZn5YeC5A=;
	b=bDBs9eWWpWFJtV6jjgNZPGPuyBuJ1aCgoVHhhQ5C+B1dEet8lvWYy1DSkiDd5BvH+rMdR0
	Hzb+foAtADbqM1Qx3lfTJ5gv1PnnfwGKmrvPSqozruqjXiu/KCqEKYuIe9umxkAGTXNuFw
	7IXfQP7tR/O4Vy8bf0s23w9bAd7i1og=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1713991581; a=rsa-sha256; cv=none;
	b=oy5IIIBDtP7A1QwyhL++/T72Z1qleI+b3YkrxI2v1CJ8itMIjoCJ1PX9NxTZYSe/VGKQFJ
	ZfVJx0kwK1ueA7bgaZs3fREY9oTQqHXh6nUTGS+AZASizoh17MgJcGCHxkxbstR6kqPIZT
	4tC0n5mlFeg85M6US4uRMJLbNP9vQgk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B596B634C96;
	Wed, 24 Apr 2024 23:46:19 +0300 (EEST)
Date: Wed, 24 Apr 2024 20:46:19 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Sylvain Petinot <sylvain.petinot@foss.st.com>
Cc: benjamin.mugnier@foss.st.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: Add ST VD56G3 camera sensor
 binding
Message-ID: <Zilvm98FNzWoGFL_@valkosipuli.retiisi.eu>
References: <20240417133453.17406-1-sylvain.petinot@foss.st.com>
 <20240417133453.17406-2-sylvain.petinot@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417133453.17406-2-sylvain.petinot@foss.st.com>

Hi Sylvain,

Thanks for the patch.

On Wed, Apr 17, 2024 at 03:34:52PM +0200, Sylvain Petinot wrote:
> Add devicetree bindings Documentation for ST VD56G3 & ST VD66GY camera
> sensors. Update MAINTAINERS file.
> 
> Signed-off-by: Sylvain Petinot <sylvain.petinot@foss.st.com>
> ---
>  .../bindings/media/i2c/st,st-vd56g3.yaml      | 143 ++++++++++++++++++
>  MAINTAINERS                                   |   9 ++
>  2 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
> new file mode 100644
> index 000000000000..6792c02fea5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2024 STMicroelectronics SA.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/st,st-vd56g3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics VD56G3 Global Shutter Image Sensor
> +
> +maintainers:
> +  - Benjamin Mugnier <benjamin.mugnier@foss.st.com>
> +  - Sylvain Petinot <sylvain.petinot@foss.st.com>
> +
> +description: |-

> +  The STMicroelectronics VD56G3 is a 1.5 M pixel global shutter image sensor
> +  with an active array size of 1124 x 1364 (portrait orientation).
> +  It is programmable through I2C, the address is fixed to 0x10.
> +  The sensor output is available via CSI-2, which is configured as either 1 or
> +  2 data lanes.

The flow of the text could be improved by wrapping the text before 80
columns (not earlier). Most editors can do this.

> +  The sensor provides 8 GPIOS that can be used for either
> +    - frame synchronization (Master: out-sync or Slave: in-sync)
> +    - external LED signal (synchronized with sensor integration periods)
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,st-vd56g3
> +      - st,st-vd66gy
> +    description:
> +      Two variants are availables; VD56G3 is a monochrome sensor while VD66GY
> +      is a colour variant.
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  VCORE-supply:
> +    description: Digital core power supply (1.15V)
> +
> +  VDDIO-supply:
> +    description: Digital IO power supply (1.8V)
> +
> +  VANA-supply:
> +    description: Analog power supply (2.8V)
> +
> +  reset-gpios:
> +    description: Sensor reset active low GPIO (XSHUTDOWN)
> +    maxItems: 1
> +
> +  st,leds:
> +    description:
> +      Sensor's GPIOs used for external LED control.
> +      Signal being the enveloppe of the integration time.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 8
> +    items:
> +      minimum: 0
> +      maximum: 7
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            const: 0

If the clock lane is always zero, you can drop the property.

> +
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2]
> +
> +          link-frequencies:
> +            minItems: 1
> +            maxItems: 1
> +            items:
> +              enum: [402000000, 750000000]

Is this a property of the sensor or the driver? Presumably the driver?

What about the input clock frequency?

> +
> +          lane-polarities:
> +            minItems: 1
> +            maxItems: 3
> +            items:
> +              enum: [0, 1]

The items are already in video-interfaces.yaml.

> +            description: Any lane can be inverted or not.
> +
> +        required:
> +          - clock-lanes
> +          - data-lanes
> +          - link-frequencies
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - VCORE-supply
> +  - VDDIO-supply
> +  - VANA-supply
> +  - reset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vd56g3: camera-sensor@10 {
> +            compatible = "st,st-vd56g3";
> +            reg = <0x10>;
> +
> +            clocks = <&camera_clk_12M>;
> +
> +            VCORE-supply = <&camera_vcore_v1v15>;
> +            VDDIO-supply = <&camera_vddio_v1v8>;
> +            VANA-supply = <&camera_vana_v2v8>;
> +
> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> +            st,leds = <6>;
> +
> +            port {
> +                vd56g3_ep: endpoint {
> +                    clock-lanes = <0>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies =
> +                      /bits/ 64 <402000000>;

No need for a newline after "=".

> +                    remote-endpoint = <&csiphy0_ep>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c121493f43d..991e65627e18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20868,6 +20868,15 @@ S:	Maintained
>  F:	Documentation/hwmon/stpddc60.rst
>  F:	drivers/hwmon/pmbus/stpddc60.c
>  
> +ST VD56G3 DRIVER
> +M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
> +M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
> +F:	drivers/media/i2c/st-vd56g3.c
> +
>  ST VGXY61 DRIVER
>  M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>  M:	Sylvain Petinot <sylvain.petinot@foss.st.com>

-- 
Kind regards,

Sakari Ailus

