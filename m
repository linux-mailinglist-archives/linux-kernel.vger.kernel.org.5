Return-Path: <linux-kernel+bounces-150134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96FA8A9AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6764B2848BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7A15AAC1;
	Thu, 18 Apr 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm4Xj+Gz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1313C3FF;
	Thu, 18 Apr 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445759; cv=none; b=P3rosMWwJjVLkZNQySb2BlkNYZxGj0qiZN+2fKBmgCfxJRHfjtein96eh6vZv6YQMMU4U9gW3GSMsvViZ3K2OFlsNicMZZPk4LF2NPsHmdORIqU2afeJgx5G4nxGeuvPhCU6jqfAvPlRBsBWyxx0eohcBE+GjvvfG8xgwYUWVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445759; c=relaxed/simple;
	bh=hvKGkHxZPIW4Pt6T/rjRhahcUnodHa40YaR7g0BoD4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPixayGkQRoIXTB0Q8TOu2kIfMRz8wAxAyjTwPCKkKlzKnBPFH+ABeQufnkznYYRHCGdX+esyY37KXqNie4y8S6SNrGH4S/FHRS5hGYURUlhx6frTG1a/qjiOEnrU2cwPehioqlEIjdcw1/FGkUxWR/gvjsgipF5v7ovNPw+Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm4Xj+Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02941C2BD11;
	Thu, 18 Apr 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713445759;
	bh=hvKGkHxZPIW4Pt6T/rjRhahcUnodHa40YaR7g0BoD4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sm4Xj+GzFlBaqZBkolIpZr8PxUyKoQG2PVErnF19y8dLXpdLOPkOtl2FJ37ynV7/X
	 LxUEh7KqcTARhBsu7h9l2UroGgxcfjcN9gZoNqlk8P+qmD5USeDLUoV89CNBu4KRHn
	 qaRqDWMEqquDO4KoXwWPhWoxDJ+RH5WIWSTYrA91J2WEUVA9da5ybx8KlDQScMgSHe
	 udbgm4Ng1TxyQM/pwyPxeRT+zPSDKfNdXj167YzuRYbZJ5ZCyr6L+oTSZy3jgnsuqy
	 IKj7vH7rbs10Z0aOCXwdCrYR3Ip7RdV2vK2E6EhWp7Qn9uO5g324KBbUGBWeeXHebt
	 Z581LFFCjFAyw==
Date: Thu, 18 Apr 2024 08:09:16 -0500
From: Rob Herring <robh@kernel.org>
To: Sylvain Petinot <sylvain.petinot@foss.st.com>
Cc: benjamin.mugnier@foss.st.com, mchehab@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: Add ST VD56G3 camera sensor
 binding
Message-ID: <20240418130916.GA1016598-robh@kernel.org>
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

Convention is lowercase.

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

If required and only 1 possible value, why does this need to be in DT?

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
> +
> +          lane-polarities:
> +            minItems: 1
> +            maxItems: 3
> +            items:
> +              enum: [0, 1]

video-interfaces.yaml already defines this constraint, so you just need 
to define how many entries.

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

Drop unused labels.

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

This should be covered by the media maintainer entry.

> +F:	Documentation/devicetree/bindings/media/i2c/st,st-vd56g3.yaml
> +F:	drivers/media/i2c/st-vd56g3.c
> +
>  ST VGXY61 DRIVER
>  M:	Benjamin Mugnier <benjamin.mugnier@foss.st.com>
>  M:	Sylvain Petinot <sylvain.petinot@foss.st.com>
> -- 
> 2.17.1
> 

