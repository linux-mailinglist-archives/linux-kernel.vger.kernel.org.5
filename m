Return-Path: <linux-kernel+bounces-44813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBA18427BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E821DB22731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15F81AA5;
	Tue, 30 Jan 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQa56v56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43D7F7CF;
	Tue, 30 Jan 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627670; cv=none; b=Hfn8zWnqN/eepNq0rOKxlDAuWVCIvyKzZjphMxnDAGfOrmArOtbaIJEL/2CvftIIDcCJQmbAMVMyduiFmjot7Q2hRHVmoH5yJkiwjxrCtlgTCT8IFp1C0okm/BcdVzh+abTPgxhRX0d0yBOjqdDj8Mx8eAXruYKH95bObJv7qto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627670; c=relaxed/simple;
	bh=gAg8cpP+XJBiM4/rqOBN5Esq/wRJ9lIQmGQX2ctCfRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjPXrayYOjyBHdSUM2ByY1Alcju7VVlo+uoBfNmJKx7CPoAhReQGZu7cRYrAmCZArJUkc+ikdy28KSHTOTG5pjnekqsYXRAI50Yt7ZHfqUrqWd63wKVZ6liJEzVRCn3z1JibFKI9WXes28k1Fbjz9AVpD5EL2qucfrvoYHKIYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQa56v56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D2C43390;
	Tue, 30 Jan 2024 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627670;
	bh=gAg8cpP+XJBiM4/rqOBN5Esq/wRJ9lIQmGQX2ctCfRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQa56v56VzaqeY0atCPHBrESYKWr6KaJO9cgg4jX+INNfhWltGeJgTb6pfBKMR+9L
	 1MQFzeinTyMzvOw6v0hynWEEXlwLh5AfZgxdm41piwc6nrS5pI8Crks9spKnw4j48y
	 cwNI2BVFkjxHyoR/7GuikRJLfrE07Wj0fnNg86n3Z2U2JfddcUJjLqK6E68nAfK6Si
	 AS72I8/FPYSNtnVQ/x3cVBJQ3kjN4MYAZT8SMCsn8eNRJkDtIkDmc1aJoexnt35VMp
	 a0dO16WknmiyTRXbjTtPW4jZlgEG42y3tr+Q8lgNs+oRaDcIIKZ3MTnZsp0gBb1rZI
	 Qce9UWtyh1Rng==
Date: Tue, 30 Jan 2024 09:14:28 -0600
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [drm-drm-misc:drm-misc-next] dt-bindings: nt35510: document
 'port' property
Message-ID: <20240130151428.GA1629184-robh@kernel.org>
References: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com>

On Sat, Jan 27, 2024 at 04:28:08PM +0100, Dario Binacchi wrote:
> Allow 'port' property (coming from panel-common.yaml) to be used in DTS:
> 
>   st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> ---
> 
>  .../display/panel/novatek,nt35510.yaml        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
> index a4afaff483b7..72913719df23 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
> @@ -31,6 +31,22 @@ properties:
>    vddi-supply:
>      description: regulator that supplies the vddi voltage
>    backlight: true
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port

Just 'port: true'

> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - frida,frd400b25025
> +then:
> +  required:
> +    - port
> +
> +else:
> +  properties:
> +    port: false

No need for this. 'port' should be allowed for everyone.

>  
>  required:
>    - compatible
> @@ -54,5 +70,23 @@ examples:
>              backlight = <&gpio_bl>;
>          };
>      };
> +  - |
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "frida,frd400b25025", "novatek,nt35510";
> +            vddi-supply = <&vcc_3v3>;
> +            vdd-supply = <&vcc_3v3>;
> +            reg = <0>; /* dsi virtual channel (0..3) */
> +            reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
>  
> +            port {
> +                dsi_panel_in: endpoint {
> +                    remote-endpoint = <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
>  ...
> -- 
> 2.43.0
> 

