Return-Path: <linux-kernel+bounces-68522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34276857BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB71F23CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123277F0B;
	Fri, 16 Feb 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR4aEWQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6528E02;
	Fri, 16 Feb 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083040; cv=none; b=gTi1zmRAvmxJy1ikRVxr3HBNxhUHi7IcRG9PHw940ay6+ZsEbny+7z4/80rj1Vr8JKhiBklc74gAtTby1v1SFPdsQn3qN1t9I6jUEOC3G0vCPzFbuCWPKdM3cL38DbDPt4q3DUs8rq9UipAYDzA8P5lrQoZHIDYzdTD5Hm/86JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083040; c=relaxed/simple;
	bh=Im9oLtqekCjFldegmSJwn6Rnn4sM4mtdARjwn/lI51Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gg7YlSMxB0LYwiRNsOdukWroVWkGbUV0WWGps4sFOfelWs9hnYF8ZwWWkumlmiwKeoU0Lm0OphzGBurCuL4ViO1wFQWTjmZeZ0vfadg7H0Hyi3RPnnm/3LMIpKzTExfRE5qTV1apLhRdcSQOw75egw9abjwJdby7ovdDgQCyyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR4aEWQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801E6C433F1;
	Fri, 16 Feb 2024 11:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708083039;
	bh=Im9oLtqekCjFldegmSJwn6Rnn4sM4mtdARjwn/lI51Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tR4aEWQSnp6Vr3/wHf9zkqffISSvXW9tNn76MjaZwHLlng3tRBS3zhO+l9VXeD3zh
	 lF9Q3ODEv7cM/hx2QPxahtOWK01gr+UvDOOSfUtupjrje3Qz7HLJ3VIELvT5hl/VLz
	 DQRo1txODTjJGtpoboXBAE6e2c43gOXWrVUocRacGlx+m5tKA1tiIewY9QoBB+7i6C
	 w8qNy/JWPmzOB6RGjjHAd6WMFand+LnIX9hJboC2svl6ZRI0pHf7U/sFMl4c+9GWTP
	 Wx8JqUqtJbbiNqkIrxCsT4DQOR/qxt7DYFjgfagmioep+WE6q4c8mOfqW+3l0DMIQV
	 +ZVVhUbVHkAzg==
Date: Fri, 16 Feb 2024 05:30:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, 
 dmitry.osipenko@collabora.com, sboyd@kernel.org, 
 sebastian.reichel@collabora.com, jose.abreu@synopsys.com, 
 kernel@collabora.com, mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, linux-media@vger.kernel.org, linux-dt@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, mturquette@baylibre.com, 
 shawn.wen@rock-chips.com, linux-arm@lists.infradead.org, 
 nelson.costa@synopsys.com, devicetree@vger.kernel.org, heiko@sntech.de
In-Reply-To: <20240216094922.257674-3-shreeya.patel@collabora.com>
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-3-shreeya.patel@collabora.com>
Message-Id: <170808303721.2162868.14811382528537445786.robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: media: Document bindings for HDMI RX
 Controller


On Fri, 16 Feb 2024 15:19:20 +0530, Shreeya Patel wrote:
> Document bindings for the Synopsys DesignWare HDMI RX Controller.
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  .../bindings/media/snps,dw-hdmi-rx.yaml       | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.example.dts:57.47-48 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/snps,dw-hdmi-rx.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216094922.257674-3-shreeya.patel@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


