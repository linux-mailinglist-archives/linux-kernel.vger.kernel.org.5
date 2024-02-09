Return-Path: <linux-kernel+bounces-59159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8A84F24B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F311F2173A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58167A09;
	Fri,  9 Feb 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rDp8UGfC"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDF66B2C;
	Fri,  9 Feb 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470925; cv=pass; b=TkNfN0E4svGaeuCqkFQ8wXmkOCF79IRb+Zk2euCet0xi0QJ3HjlgqwFXe0CpHSm3IUxYkaNQMuQhS9i8C9OaK4ZwHqBwJOk4LUXIVvRu4koOQCp2bX5mJjxFyoP2JerzKSCOFmjfs6gsWY9uU4sS/eXlVjSa43zm2sEraw0GE6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470925; c=relaxed/simple;
	bh=L5f4APd0uaZvkdFCaL72gp3Z/NFm0xLnVgomHN3AAQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP1Kt5woDLLmauLNOUThI6FxF1Mn7XdMpOZR+7qXV5ywjWTkDkOLig4pyKWuPGH6o7TwhQHypT+tkjmHnTfrmUO/+LwWojIYHN+MJWnlntFXX947svbi6PztMYrR8mJXgMlyWlsK1kdbNF+fXQcNwxGuQOReTJFlwGOFK5/Aid0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rDp8UGfC; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TWT750Ghpz49Pv3;
	Fri,  9 Feb 2024 11:28:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707470913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od5oreMF7LSJoZ5E7e8qfjLHLaZ52GFaLl3Biqo5qgw=;
	b=rDp8UGfCvqRqxqcst7tnaH9TFm6qZBcQddNqlanCnYUd+ujS4xn/hAN/ZxAcOCOW0Glb5v
	X7mDGLw941eA8niYbXpCMWZS/yGuAzjOyZkXfliJJcmw2VbINeA6fmDyuuMwS6fdhSaWqh
	6VxXpKZBJTy2pjkfXJgBK1oGmK1Bqt/PtQTYGcJibF/1CqOp13ySFNpFiPfNGqsDjvKM2R
	yWfv8++32FGlNwc4Sfyr5dNCOJ3TgqgKk+FIT746+KaUDvHh82CkSXXb3ICuzAredrSmkN
	aiU+kf/vrHfSOy0zoM0ydq5pm1TP4987ubp+FSsnS3hl3HJXt7aiarMrw7H5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707470913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od5oreMF7LSJoZ5E7e8qfjLHLaZ52GFaLl3Biqo5qgw=;
	b=h9LZYz6x9JdJeINobJbOAlMjrwQ9xhjDogRHTmUErjMKk70WI1HXMzPNp1byee2HLVnrcx
	I0SIuI3r7Kx0/3eqjCMyZnD/7DAV0hYFGKqv8e7Q64+D0qEOp+M+UucR/ii3OrsYDH/4P4
	JQ8Iu/QrlM3p3IrGv8zJsryjX1+FokdcIfQntQgWhXLMeL1D50UNGAxvyW60O1aQxc7DmH
	76w6r/uLk/+QyMfVv5ylFJWlVgDSrtb257H6Vo6W8y+gJs+M0EPVLgS0es4wu6ogotAMHL
	sZa2JsPrnlCvC7etxdoqXqya9JA+nns79IEWcUayrBl56sYzjqaC6S7qRHRcIg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707470913; a=rsa-sha256;
	cv=none;
	b=RKQ56Hz5Do1u9kZkkdriiD8xZ1+Ez/ACg56IoSYzivlQ20y42Sk6MfrCAIYm94NrYjuZhz
	XMZGbANcfWjKcujSs2jmTWq8ZNpfz16nTJMp9Yr8UuCAom73JyQVRj5N8QU/+nntrHv/Ek
	Rc+xVl8D8rstLVKdF8fShHXtr9L1CbEePPC3z06tCm9Dfk43L1f5ustabEVM/xUiyXo6pa
	DxgIqVfrlLVtRFipxXIsB7OcXXxHGQJkXhIbCmhB0URAkKvIZcC3A09NP+APthXsdNyxOm
	eDF3rkMII0Sv6y6WlZPlDT0cOu/ncZldoTsaC9B+MZKliJgwUtYHLWROJ7+WOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A6D54634C93;
	Fri,  9 Feb 2024 11:28:32 +0200 (EET)
Date: Fri, 9 Feb 2024 09:28:32 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: media: add Maxim MAX96717F GMSL2
 Serializer
Message-ID: <ZcXwQA3IiDu1etH1@valkosipuli.retiisi.eu>
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-2-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111130349.2776699-2-julien.massot@collabora.com>

Hi Julien,

On Thu, Jan 11, 2024 at 02:03:46PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96717F GMSL2 Serializer.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v2:
>  - remove reg description
>  - add data lanes min/maxItems
>  - Use generic node name 
> 
> ---
>  .../bindings/media/i2c/maxim,max96717f.yaml   | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
> new file mode 100644
> index 000000000000..f31517b1dbc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Collabora Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96717f.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX96717 CSI-2 to GMSL2 Serializer
> +
> +maintainers:
> +  - Julien Massot <julien.massot@collabora.com>
> +
> +description: |
> +  The MAX96717F serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input

Presumably this will need to be configured on the device? You should thus
require the bus-type property in the endpoint.

> +  into GMSL2 serial outputs. The device allows the GMSL2 link to
> +  simultaneously transmit bidirectional control-channel data while forward
> +  video transmissions are in progress. The MAX96717F can connect to one
> +  remotely located deserializer using industry-standard coax or STP
> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
> +  the MAX96717F can select the MIPI datatype, while the tunnel mode forward all the MIPI
> +  data received by the serializer.
> +  The MAX96717F supports Reference Over Reverse (channel),
> +  to generate a clock output for the sensor from the GMSL reverse channel.
> +
> +  The GMSL2 serial link operates at a fixed rate of 3Gbps in the
> +  forward direction and 187.5Mbps in the reverse direction.
> +
> +properties:
> +  compatible:
> +    const: maxim,max96717f
> +
> +  '#gpio-cells':
> +    const: 2
> +    description:
> +      First cell is the GPIO pin number, second cell is the flags. The GPIO pin
> +      number must be in range of [0, 10].
> +
> +  gpio-controller: true
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI-2 Input port
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
> +            required:
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        unevaluatedProperties: false
> +        description: GMSL Output port
> +
> +    required:
> +      - port@1
> +
> +  i2c-gate:
> +    $ref: /schemas/i2c/i2c-controller.yaml
> +    unevaluatedProperties: false
> +    description: |

I think you can remove ' |'.

> +      The MAX96717F will forward the I2C requests from the
> +      incoming GMSL2 link. Therefore, it supports an i2c-gate
> +      subnode to configure a sensor.
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
> +        serializer: serializer@40 {
> +            compatible = "maxim,max96717f";
> +            reg = <0x40>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            #clock-cells = <0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    max96717f_csi_in: endpoint {
> +                        data-lanes = <1 2 3 4>;
> +                        remote-endpoint = <&sensor_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    max96917f_gmsl_out: endpoint {
> +                        remote-endpoint = <&deser_gmsl_in>;
> +                    };
> +                };
> +            };
> +
> +            i2c-gate {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                sensor@10 {
> +                    compatible = "st,st-vgxy61";
> +                    reg = <0x10>;
> +                    reset-gpios = <&serializer 0 GPIO_ACTIVE_LOW>;
> +                    clocks = <&serializer>;
> +                    VCORE-supply = <&v1v2>;
> +                    VDDIO-supply = <&v1v8>;
> +                    VANA-supply = <&v2v8>;
> +                    port {
> +                        sensor_out: endpoint {
> +                            data-lanes = <1 2 3 4>;
> +                            remote-endpoint = <&max96717f_csi_in>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

-- 
Kind regards,

Sakari Ailus

