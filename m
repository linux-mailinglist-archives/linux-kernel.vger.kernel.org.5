Return-Path: <linux-kernel+bounces-142556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69788A2D19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A5C1F21ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21D54669;
	Fri, 12 Apr 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kByBG0EC"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F551C54;
	Fri, 12 Apr 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920248; cv=pass; b=KSrwMXC6c5Q6cn7RO05MB7n928BNKEAPGzztkvVZP5T/BRHppVUMwbHIw2YiMSmoVjjTNDBTk8at1bal9/rLvnFOb2wk18CHAXFeZHGVBM5w6X6oL2G8t4xBfIfxnx033Wwle7Kgxxo6H0T8s6UYo0OG8cYcRdbq6TFCILDRdvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920248; c=relaxed/simple;
	bh=sm4OME+SVtDtwtFX9ZHMiNSXlJrN06erUyBu6fEqpDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReLpdW6lNz04WO3mqs8UIacz9ZJcQTfAw3+Rpqq+pRVhkQxMTmXIqhOyoFZaMCj3y8nXr6D9iL5mpoHWTsARYr5rETg3zj+B2d448HDIxC1H+15pzGsM+S1c96fs0SOetbeIv8jwg25sZhlNnDjCJG/ClnGSjX2JxGtkURiKgkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kByBG0EC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VGDPl3DC4zyRj;
	Fri, 12 Apr 2024 14:10:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712920235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLRG4cK7PaR45L7fZmpXa+sQpzcokirYHNzWvW3y/9o=;
	b=kByBG0EC+sDpuFvBpD0s/PmeoBrSKrlsu2nqN8pj++WNZTB1/JI8tUKFXnZrhu9fILVLM3
	YWRwggCrobxuTPEER/rQOMpo/D7LpSPztTooHQC+r23vteMKhePMuxao7DlRCL6JLS+uPz
	9IeJjwRoxnJ6X8B73sOc4Ew33JFrpSI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712920235; a=rsa-sha256; cv=none;
	b=n6/dBjIDbtgSv4LoTbBOd28swjhwmkQZnXsmLNm3L9kRwZ/AairsXmN/sFmZ41pji9QDoP
	bXS3Burufrmd2I2TvB2xL+mVYgxxyo3Ur2njd07J+aDrg32I2EJYKYiJRuSCHCMBiXRf9t
	aH6hkIcJFNls1YuDX9XsV8H7I+c/uS4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712920235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLRG4cK7PaR45L7fZmpXa+sQpzcokirYHNzWvW3y/9o=;
	b=mwXqEpkRjGe1jrejzl+aqYeSNMTYG18NU104EF/rSl8qrkQnG3tDhPuwj3huYY7fabFSD5
	SavNQr0N3MwYVj+cakidfTADSIwGJtY5+xYXv7H7uTE9SqmLMF/yIAQTBjyMEmoQUILCDl
	igswbE5B2IqwaTloMfukP8uyxKDYMWE=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2217B634C96;
	Fri, 12 Apr 2024 14:10:33 +0300 (EEST)
Date: Fri, 12 Apr 2024 11:10:32 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2
 Serializer
Message-ID: <ZhkWqEAN4RozmPlT@valkosipuli.retiisi.eu>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-2-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325131634.165361-2-julien.massot@collabora.com>

Hi Julien,

On Mon, Mar 25, 2024 at 02:16:31PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96717 GMSL2 Serializer.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v5:
>  - Reverse the fallback MAX96717 can fallback to MAX96717F
>  - Use const instead of enum for MAX96717F compatible
>  
> Change since v4:
>  - Add compatible for MAX96717 and use it as a fallback for MAX96717F
>  - Remove extra '|' for decriptions
>  - Reference 'i2c-gate' instead of 'i2c-controller'
> 
> Change since v3:
>  - Renamed file to maxim,max96717.yaml dropped the 'f' suffix
>  - Added lane-polarities and bus type properties to the CSI endpoint
> 
> Change since v2:
>  - remove reg description
>  - add data lanes min/maxItems
>  - Use generic node name 
> ---
>  .../bindings/media/i2c/maxim,max96717.yaml    | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
> new file mode 100644
> index 000000000000..ac8bf11a6fa5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Collabora Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96717.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX96717 CSI-2 to GMSL2 Serializer
> +
> +maintainers:
> +  - Julien Massot <julien.massot@collabora.com>
> +
> +description:
> +  The MAX96717 serializer converts MIPI CSI-2 D-PHY or C-PHY formatted input
> +  into GMSL2 serial outputs. The device allows the GMSL2 link to
> +  simultaneously transmit bidirectional control-channel data while forward
> +  video transmissions are in progress. The MAX96717 can connect to one
> +  remotely located deserializer using industry-standard coax or STP
> +  interconnects. The device cans operate in pixel or tunnel mode. In pixel mode
> +  the MAX96717 can select the MIPI datatype, while the tunnel mode forward all the MIPI
> +  data received by the serializer.
> +  The MAX96717 supports Reference Over Reverse (channel),
> +  to generate a clock output for the sensor from the GMSL reverse channel.
> +
> +  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
> +  forward direction and 187.5Mbps in the reverse direction.
> +  MAX96717F only supports a fixed rate of 3Gbps in the forward direction.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: maxim,max96717f
> +      - items:
> +          - enum:
> +              - maxim,max96717
> +          - const: maxim,max96717f
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
> +              lane-polarities:
> +                minItems: 1
> +                maxItems: 5
> +
> +              bus-type:
> +                enum:
> +                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY

Now that you have C-PHY here, does the hardware support data line order
mapping? Just wondering. The bindings can be added without that and support
added later on---that's what the video-interfaces.yaml is currently
missing.

lane-polarities is only valid for D-PHY. What about the data-lanes, the
maximum is probably different for C-PHY?

> +
> +            required:
> +              - data-lanes
> +              - bus-type
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
> +    $ref: /schemas/i2c/i2c-gate.yaml
> +    unevaluatedProperties: false
> +    description:
> +      The MAX96717 will forward the I2C requests from the
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
> +                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
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
Regards,

Sakari Ailus

