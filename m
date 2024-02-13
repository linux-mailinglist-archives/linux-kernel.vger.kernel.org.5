Return-Path: <linux-kernel+bounces-63477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32A853029
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC81F25541
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EDC39FE2;
	Tue, 13 Feb 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tA4/TsMB"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C542C697;
	Tue, 13 Feb 2024 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825913; cv=pass; b=Vzugyu7gVQbjj9BEtnh/sF+S05qlwO1Hs+AsWolhZGqn0uoL4eOQu0Gxem/LcH/7K5JmMvT5TCvYQESFT3iAqehd2PbhLNOB/vjFh3wMUYjnbCNXEntwKZgoK+Yud1mNDWytx9dNJnv+MQtdvY5P2DPkuQbyQlGK1YjkOnXsfLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825913; c=relaxed/simple;
	bh=8OkoQz8ES9UkCj9vBvR+d75EqRHjA64RcQNleAzUOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv9HdoBxD1vO3pKatusqK/ChLTQaXXHibksEpAErbWxTKTkmUF1Zxqae90rwjaivphD9c13cfd97GtSyVxrI5zopQfmavMZeB5uEE90B4MJnKa2FxoE3cZTrVEFxFkc115WDB7CS288/2m4oGlTJ0Yx7/TGAdMM0h/YFpkpBHyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tA4/TsMB; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TZ0Pn4D3pz49Q3r;
	Tue, 13 Feb 2024 14:05:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707825902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu+DAqM0vLbVqdWvGB4a60F6/2Pa4siZTHbYrPWKyAc=;
	b=tA4/TsMB61erjvY8wN3FM1mD3ADVlcIPF9IRLWd/ElCPf3lquCdjszJhzTav4TTfVrbkwC
	iAaidtXKLMPXBS+/5xjMQBHr9/94C+/7ZVAVYkhfqSaVRX03bIrE74CnKGSvPwGjUD7PFU
	FuFEBegYNW+fXk64CfJIFd6RyZxobO/DDxD6IkKQiID3SH2//sViJ8sLfTheaVRxAQSwvl
	Q5kvngcm0CN3m2Ruu9q6lxRs0U/7Br8SLKv+RtlmbWj++5N1f2kObThRCogbhBMk27zyMs
	/AhFsR47GlAB+L5X8JTbVLBLwuh0rphzZuXCdsrhQtqI0UW5YuGQ8qD9FN6zxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707825902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu+DAqM0vLbVqdWvGB4a60F6/2Pa4siZTHbYrPWKyAc=;
	b=rUbWzrvuREMVhCfMuBwSuCPvUUTCetlwleOxXYljRpAnlN++BCukKIH6cmpRm0A2AVuL64
	8Ky7Pv5w2iA3sNtT+FQnhUl2puDXcjSwlkKMuU1ykHwkx8GGpYGS4oGc4Z0jtiW2F7y/Iv
	h73PNh5sXT6/wdlP8KYFq6niEADpgSH8itd30jGe5PIa7JXbnW88bQjMAupuxrOHKeSQBD
	Ls9KfTfPLr8GylrA1i5g1eW9R8MqvOcQQwUS3M4RonIiP/0BA0s+K9ubovMFb7rLYIYvPt
	A/hBmujsmfmHxMKLInZSkOoZsKf8qJxJV3SzQ3LQIAf1ZqAUTAzBuBn0y0cRyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707825902; a=rsa-sha256;
	cv=none;
	b=CLPVwuFUFUoQeloXutgTtInKNqSTMWBW6lNTRidMwUEmcmfdwebA7D5Cjsgvjqgmb//JSR
	49s+czty+WiMzMLairSfg3k1KGC/8OZg+vjIaEFF6+kg11R2Mm23/fZZoOTtQRxEy93Rd1
	fcujjdeka85SQJwUoH1L2Gsnr9E4bUYulBtznLK2cGuEd2LQiPO0hKXn2s/XSvbmljASKa
	NOj6MIuyWfv626jj3RG9J87+X6I40R4sjDRrRsUEIdEDfI883mIpj3+9jrJKvRn/3Hjlfi
	hA3ocqgRvseqMwd0iZvh8QNm6XvfFuObpIIurbRSfbrJ3z60rQr2o6YQn+q1mQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 31D7E634C93;
	Tue, 13 Feb 2024 14:04:59 +0200 (EET)
Date: Tue, 13 Feb 2024 12:04:58 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Mehdi Djait <mehdi.djait.k@gmail.com>
Cc: mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net, laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND Patch v13 1/3] media: dt-bindings: media: add bindings
 for Rockchip CIF
Message-ID: <Zcta6hhSio67ahKs@valkosipuli.retiisi.eu>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
 <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13deb8c5cb58e08c1b47decd112b51e8e0b6c4dc.1707677804.git.mehdi.djait.k@gmail.com>

Hi Mehdi,

Thanks for the patchset.

On Sun, Feb 11, 2024 at 08:03:30PM +0100, Mehdi Djait wrote:
> From: Mehdi Djait <mehdi.djait@bootlin.com>
> 
> Add a documentation for the Rockchip Camera Interface binding.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml     | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> new file mode 100644
> index 000000000000..6af4a9b6774a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Camera Interface (CIF)
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description:
> +  CIF is a camera interface present on some Rockchip SoCs. It receives the data
> +  from Camera sensor or CCIR656 encoder and transfers it into system main memory
> +  by AXI bus.
> +
> +properties:
> +  compatible:
> +    const: rockchip,px30-vip
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ACLK
> +      - description: HCLK
> +      - description: PCLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: AXI
> +      - description: AHB
> +      - description: PCLK IN
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: pclkin
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: input port on the parallel interface
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                enum: [5, 6]
> +
> +            required:
> +              - bus-type

What about the vsync-active, hsync-active and data-active properties?
Aren't they relevant for this device? Are there default values? This should
be part of the bindings for the device, shouldn't it?

> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    parent {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        video-capture@ff490000 {
> +            compatible = "rockchip,px30-vip";
> +            reg = <0x0 0xff490000 0x0 0x200>;
> +            interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +            clock-names = "aclk", "hclk", "pclk";
> +            power-domains = <&power PX30_PD_VI>;
> +            resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
> +            reset-names = "axi", "ahb", "pclkin";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    cif_in: endpoint {
> +                        remote-endpoint = <&tw9900_out>;
> +                        bus-type = <MEDIA_BUS_TYPE_BT656>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...

-- 
Kind regards,

Sakari Ailus

