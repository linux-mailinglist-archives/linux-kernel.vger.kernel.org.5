Return-Path: <linux-kernel+bounces-59175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35584F297
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F616B241BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B167E65;
	Fri,  9 Feb 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dHKxph8B"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1056664A3;
	Fri,  9 Feb 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472116; cv=pass; b=JQdijwNKNvXDTf2i1RbPvUigLSVJymDk4EGgfNmXJEFAPDvmlhEQRU5D2E4DlZaDg14o3RwphjXfrmR81drmaTG6EtY0Z7p/WxAtqosVoqzbY7d1/tnGUL5HkOMWYVGPqdFrtYuU5hGm2GPLuJ8QtWqv0dyKXn3jZQQW+/3gHEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472116; c=relaxed/simple;
	bh=vORW683FBpA+qrF+C2rCdYcNkhpTAxupmgbECNkzkjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoAMVP32VBen10kzTlB2ggByu8MGgeVUOmBNa9iHayk0TFN1uxzXe4Qtu/J5VOYEQTYaqNxZYOJmRP/3hiX0NHMlBvh+sJyc2KX+rw73B1JXZVbeQDWTsnbFFJitNuPxG2BtSogGKUu1osEHE053GQFL2VsIv55hJQOCDtIfLDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dHKxph8B; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TWTZ72Gb1z49Pv3;
	Fri,  9 Feb 2024 11:48:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707472111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xFovG9lh/igg6TJvOZbqG+Gi6zv4L7L9QJSaWfDgik=;
	b=dHKxph8BRn2FL1fXiqmFYYJA3QDqoNST+8rhSKiW1HnR+YtNZ8evvPWr1jvo/gOuyIIPeS
	R/dbatG7hktt8B3LDLkrGMx+24vho6zj8upOR8jE4g/dgWcosyNfevUT6nu/eDbomwmkRf
	uAoDZ8NCwNYWDUnoJ0wkweKiu8vc2xTezgr/ef5t705Sg/RN3MtZBdl1ZuInGjUaX7j8q3
	vhvIWqgMNOuIb9MR/gK1a4KXJFImjt31Gg2W2D2mJK869iBT7H9Ym7TaBKzjPuAa65eKCK
	nH7RrCkQE3JPtfNO1ebBB4SH5944EgvgUuycE7FG2THCB7VwknOREmATr1TeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707472111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xFovG9lh/igg6TJvOZbqG+Gi6zv4L7L9QJSaWfDgik=;
	b=QBs9IKW6kyN8V2owFCCaVBOtIYdQKGeoSKB1jE3BmG2qrWf4wkFwLEN0m1SWniP8ysuyBu
	u4X9jMYBp0TKtERVsvjcWo7erDU4QOZyy01fxMxW2R9lCAdFqodrBHXknikT1dFgsuZZ7W
	YvCrYKy6ahVzlQFmkEf3/9zaDOQ1l7fYT81dBGfD/Ft8MaR7xRHVnwCnaqILMOipp5OGby
	/ZTxddacH99NDLg9Lv3UA9CMfMMunHZc+VFfY6X+6iMVhI5wrcWIBhRqYWUgrBM/k7y39L
	fz/KYVZTFKwtHZtLvYExCvsbKoJHop59m6wH0oYa9OTrlG+/AEh6A85eMPZ6nA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707472111; a=rsa-sha256;
	cv=none;
	b=rq5uc1wBx5zIgHw+CbDMnV61QX+6SRd+ulAPoPJ1QfUHnFu3cnmknvnydJ18mnThCbsZxw
	PP16GvPu0rBqdK2pgK8mJuiRcmWa1vDn7shFFxGAL517niJb+6FiYpibXBtRSXbqCJLEB8
	0UU4RpjhU/HlyYSPMWd4yuc71WHfER7pJ+0I1o58a/pWR8sGaykJt5x6fucJqPGgy5gKyv
	hjwEl9moQVk1mXV9fMWR0nX+AhwrqwIfioTrYuxrbZhxIlWmv6OVVEO8GBwugHsx2mQSAG
	+hPMsI/NyahIIhFCvkJ26KljeFRKRE9YFGnQ8lJQO/07DixgulFwkHwQS7SaxA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 16548634C93;
	Fri,  9 Feb 2024 11:48:31 +0200 (EET)
Date: Fri, 9 Feb 2024 09:48:30 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: media: add Maxim MAX96714F GMSL2
 Deserializer
Message-ID: <ZcX07nUiI4IUuReP@valkosipuli.retiisi.eu>
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-3-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111130349.2776699-3-julien.massot@collabora.com>

Hi Julien,

On Thu, Jan 11, 2024 at 02:03:47PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96714F GMSL2 Deserializer.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> 
> ---
> Change since v2:
>  - remove reg description
>  - rename enable gpio to powerdown
>  - use generic node name: i2c, serializer, deserializer
> ---
>  .../bindings/media/i2c/maxim,max96714f.yaml   | 171 ++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
> new file mode 100644
> index 000000000000..2423d166c954
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714f.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Collabora Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96714f.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
> +
> +maintainers:
> +  - Julien Massot <julien.massot@collabora.com>
> +
> +description: |
> +  The MAX96714F deserializer converts GMSL2 serial inputs into MIPI
> +  CSI-2 D-PHY or C-PHY formatted output. The device allows the GMSL2 link to
> +  simultaneously transmit bidirectional control-channel data while forward
> +  video transmissions are in progress. The MAX96714F can connect to one
> +  remotely located serializer using industry-standard coax or STP
> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
> +  the MAX96714F can select individual video stream, while the tunnel mode forward all
> +  the MIPI data received by the serializer.
> +
> +  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
> +  forward direction and 187.5Mbps in the reverse direction.
> +
> +properties:
> +  compatible:
> +    const: maxim,max96714f
> +
> +  reg:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      Specifier for the GPIO connected to the PWDNB pin.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        unevaluatedProperties: false
> +        description: GMSL Input
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              Endpoint for GMSL2-Link port.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI-2 Output port
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +              link-frequencies:
> +                maxItems: 1
> +
> +              bus-type:
> +                enum:
> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY

MEDIA_BUS_TYPE_CSI2_CPHY (1) is missing. Even if the driver doesn't support
it, it would be best to list it here.

> +
> +            required:
> +              - data-lanes
> +              - bus-type
> +
> +    required:
> +      - port@1

Why port@1 but not port@0?

> +
> +  i2c-gate:
> +    $ref: /schemas/i2c/i2c-controller.yaml
> +    unevaluatedProperties: false
> +    description: |
> +      The MAX96714 will pass through and forward the I2C requests from the
> +      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c-gate
> +      subnode to configure a serializer.
> +
> +  port0-poc-supply:
> +    description: Regulator providing Power over Coax for the GMSL port
> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        deserializer@28 {
> +            compatible = "maxim,max96714f";
> +            reg = <0x28>;
> +            powerdown-gpios = <&main_gpio0 37 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    max96714_gmsl_in: endpoint {
> +                        remote-endpoint = <&max96917f_gmsl_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    max96714_csi_out: endpoint {
> +                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
> +                        clock-lanes = <0>;

clock-lanes isn't listed in bindings. You can drop it from here.

> +                        data-lanes = <1 2 3 4>;
> +                        link-frequencies = /bits/ 64 <400000000>;
> +                        remote-endpoint = <&csi_in>;
> +                    };
> +                };
> +            };
> +
> +            i2c-gate {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                serializer@40 {
> +                    compatible = "maxim,max96717f";
> +                    reg = <0x40>;
> +                    gpio-controller;
> +                    #gpio-cells = <2>;
> +                    #clock-cells = <0>;
> +
> +                    ports {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        port@0 {
> +                            reg = <0>;
> +                            max96717f_csi_in: endpoint {
> +                                data-lanes = <1 2>;
> +                                lane-polarities = <1 0 1>;

Shouldn't lane-polarities be mentioned in bindings, too?

> +                                remote-endpoint = <&sensor_out>;
> +                            };
> +                        };
> +
> +                        port@1 {
> +                            reg = <1>;
> +                            max96917f_gmsl_out: endpoint {
> +                                remote-endpoint = <&max96714_gmsl_in>;
> +                            };
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

-- 
Regards,

Sakari Ailus

