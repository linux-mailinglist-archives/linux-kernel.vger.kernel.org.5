Return-Path: <linux-kernel+bounces-60376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF84850431
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F31C0B24A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BD3D971;
	Sat, 10 Feb 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAGAOVfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF963D963;
	Sat, 10 Feb 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707564598; cv=none; b=H0IXH9Q2dY1pbuCnxMWuobwpqgXiV9FybmxygokZvN7XakJOgLk0KtckdV6UKb2g4IWIOa4F3bWzi4mxBcpKEArYOxw+D77XWOhiiczSgJo4Nuh4ONcLmWroR8nfbXcneimdORWcEy0gOuqzN8oLTDb/hWuJma0Ii9zPuuOw0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707564598; c=relaxed/simple;
	bh=QPq+DDQenD7wYGR+UAIMms7gSHhkD+KoiV31Ufw3Nzw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LYxPf88Av/cvFwCMO+i7xqZ1RieBeBRABt8g0AlVORlwo2rRW7V6j6Xk0H4uzQIeMBNw2Sv86AJBsHCWyYgbkiS77NUrVdkuUezb6rjt5B/yWblU5ZNsq3T3rCJx+M0YB1LiILfghTvhVwwcBskEdRf16dBhz0la3VvMH5Fu9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAGAOVfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3509C433F1;
	Sat, 10 Feb 2024 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707564597;
	bh=QPq+DDQenD7wYGR+UAIMms7gSHhkD+KoiV31Ufw3Nzw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VAGAOVfzZpGMK/xx4ddU9AAJ8yuv1ld6pdNVt0gVjJs2aM9+Bcy30RtMdH3g0NbsT
	 of2bg3qiOpCTIXzKvA05KOm8JGwVluv4XaTHwgcehsvJHeWsdBbq+UG7jQfXlS5/HZ
	 quhN4IRKW7nBloCPA5DMnsjFP3x//HIy0F75phrJiG7wqBKfGF2oX3R53rzbhgAtO8
	 yYuVsHlGtOTqVbLq5Dk0Rrh6oT4z+7q3SvTvTYBsLEAF+DeYncHRztYBM8zdpU6NaT
	 U2QJFc0zuarCYwSVJf7JZPtcy8ONggqqsLI8gFPKNKLFcjVlryq29KL2QezhaGUH9t
	 rGbi98jJX8JHw==
Date: Sat, 10 Feb 2024 11:29:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-usb@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Douglas Anderson <dianders@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Matthias Kaehlcke <mka@chromium.org>, patches@lists.linux.dev, 
 maciek swiech <drmasquatch@google.com>
In-Reply-To: <20240210070934.2549994-4-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-4-swboyd@chromium.org>
Message-Id: <170756458668.4188811.2636543966305409757.robh@kernel.org>
Subject: Re: [PATCH 03/22] dt-bindings: usb: Add downstream facing ports to
 realtek binding


On Fri, 09 Feb 2024 23:09:14 -0800, Stephen Boyd wrote:
> Add a graph with 4 output endpoints to this hub binding to support the
> scenario where a downstream facing port is connected to a device that
> isn't a connector or a USB device with a VID:PID. This will be used to
> connect downstream facing ports to USB type-c switches so the USB
> superspeed and high speed lanes can be put onto USB connectors.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Cc: maciek swiech <drmasquatch@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/usb/realtek,rts5411.yaml         | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dts:32.21-31: Warning (reg_format): /example-0/usb/hub@1/device@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dts:30.26-33.19: Warning (avoid_default_addr_size): /example-0/usb/hub@1/device@2: Relying on default #address-cells value
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dts:30.26-33.19: Warning (avoid_default_addr_size): /example-0/usb/hub@1/device@2: Relying on default #size-cells value
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dts:43.23-50.19: Warning (graph_port): /example-0/usb/hub@2/ports: graph port node name should be 'port'
Documentation/devicetree/bindings/usb/realtek,rts5411.example.dts:46.28-49.23: Warning (graph_endpoint): /example-0/usb/hub@2/ports/port@0: graph endpoint node name should be 'endpoint'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240210070934.2549994-4-swboyd@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


