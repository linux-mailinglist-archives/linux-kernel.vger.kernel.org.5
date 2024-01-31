Return-Path: <linux-kernel+bounces-46549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA5844137
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACFF2878F8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CD8287D;
	Wed, 31 Jan 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4QN5TZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20B8286E;
	Wed, 31 Jan 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709598; cv=none; b=W+QKsh2/EBlAdn/XNtUfzeMkL+RFACJ1JBJPmrz4vxbIYmCeeKP8HwiwU6zBAsrMdjuJfFJjFn76UVwX5zrGv9b3MPNVBs3wTDWSn6o+41icpnP5SQjry/Q1076cx4vVb39JRoR9BSNSy/UO5geomU5lf6yAOHbbOqcaWgDef8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709598; c=relaxed/simple;
	bh=cX2K5w9GWrdNEUyfrUG6IelYh8NLqv5j8lI66oywVPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQrLHWtd1ENuRaXwUUHLluwUMfTYI2CbMnWMczArTNmrcy8xszeHYh6Lg/s/F0cGqM1l7k40L/wXtvpvCCqZgq4/7n6I+egr4Mb9vZfdC6Tt4W6RfxDcm6x0H+W7n/AA1NGnL/xfDk1hw2rCllH5wTbrtCvb5hFCdZ7+Fx6Sj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4QN5TZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3262FC43142;
	Wed, 31 Jan 2024 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709597;
	bh=cX2K5w9GWrdNEUyfrUG6IelYh8NLqv5j8lI66oywVPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4QN5TZCtY7/sLO9kwHjCm1yV84yTjejctGfEctgi6U1G8d+B+ls+W+CURrrZMweO
	 Xg3My6YVDAGTjBxtTIHoPpI8b0HPctgJgxXU0JvN7qnIOpZSKVWDtLmfZT9CAPjJ8w
	 IuGiaX3U/9QbPXiXpDiHg1MEPxXne9lHEFvg27Iv0sv1SRydlUDYUH1fZ8OHrZk3g+
	 nbr+GxJRgv9cJ9uosjPtuhNnPAy1fCXo4m1pmBZzQuS9TWL2yes3WVMQI/79OLEM++
	 mROaw2KnRrEDPKuHV6XGdjVhUxAUaIaxjuxeAHk1UkWZ52NSWx8itb9pL/CFeXdUEP
	 TuyrF7Y/oXPyA==
Date: Wed, 31 Jan 2024 07:59:55 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	mripard@kernel.org, markyao0591@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] dt-bindings: display: rockchip,dw-hdmi: add
 power-domains property
Message-ID: <20240131135955.GA966672-robh@kernel.org>
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
 <1ba8b40d-005a-4665-afd9-a4eacf3e3031@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba8b40d-005a-4665-afd9-a4eacf3e3031@gmail.com>

On Tue, Jan 30, 2024 at 03:57:23PM +0100, Johan Jonker wrote:
> Most Rockchip hdmi nodes are part of a power domain.
> Add a power-domains property. Fix example.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml   | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> index cd0a42f35f24..6f421740b613 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> @@ -94,6 +94,9 @@ properties:
>        - const: default
>        - const: unwedge
> 
> +  power-domains:
> +    maxItems: 1
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> 
> @@ -141,16 +144,18 @@ examples:
>      #include <dt-bindings/clock/rk3288-cru.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/rk3288-power.h>
> 
>      hdmi: hdmi@ff980000 {
>          compatible = "rockchip,rk3288-dw-hdmi";
>          reg = <0xff980000 0x20000>;
> -        reg-io-width = <4>;

It makes more sense to keep reg-io-width together with reg.

> -        ddc-i2c-bus = <&i2c5>;
> -        rockchip,grf = <&grf>;
>          interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>          clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
>          clock-names = "iahb", "isfr";
> +        ddc-i2c-bus = <&i2c5>;
> +        power-domains = <&power RK3288_PD_VIO>;
> +        reg-io-width = <4>;
> +        rockchip,grf = <&grf>;
> 
>          ports {
>              #address-cells = <1>;
> --
> 2.39.2
> 

