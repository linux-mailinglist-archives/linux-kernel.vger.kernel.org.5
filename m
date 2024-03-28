Return-Path: <linux-kernel+bounces-122240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34988F3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3152A2F73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B7208DA;
	Thu, 28 Mar 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe9OKEba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C341BC39;
	Thu, 28 Mar 2024 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586652; cv=none; b=p9yTcX/C4X2NuF2ClbqOdattHzaxFrV5suaKuTRVD09Hur1wvVsHx3UCAuGQ7sL9Zmk5ZiuGej2XktzBrJSbOloA/czco5aDi1ulepMXe1HzHisREzlwTIWrJf3AEeOy30ttS5vVKt6pRJKHthlU6dnZ0kMhIJBifwNDIi7Tjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586652; c=relaxed/simple;
	bh=3F6efRAp/CITomWBgwUDR0hLY/ukFkggqmKWWfGDTzc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Sxyzs6BAV4TDo1OLGHVAsitadsVdz8vpiIGGQN/KRWjLe9X37ItCr5heow1O+12AiTJlQeosbOfoceNsd75EtMu3Zb3cB3N4zXym5hIeTQZhteZ2cjzbbn0hq5a4Jtpt0vgLRvkS2GXztr59zKfdbuwhIscwWIVMuKi/DYzXGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe9OKEba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1943CC43399;
	Thu, 28 Mar 2024 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586652;
	bh=3F6efRAp/CITomWBgwUDR0hLY/ukFkggqmKWWfGDTzc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pe9OKEbaWKvhlPVFg6X6s+rbr1IKORVf8QwMShgNddDzmwV8x6tvS7jP2ii6yC5rR
	 vddnUP4ckQ1c/00usn9w2iISSvL8jXYQXaS4WpDZtDQ0jXDUAE7YKy5Ay4vsH4iEfA
	 lAXSShDmpkwL/7X8Wh7WpWs8sjd3dHeCEDUWdfgYb1vHSQ5RQ2pj38cTHL/RIJTPA0
	 qhiedt52oraTIequ1SQT32x4o6fKXI3ceNGiht67U+U6WoGDQsbJTNkNcoLMXKfuKC
	 gBwMCWPeLGV6W05TfaGr5lWwOmQvHg6NYqZeTMQklWWdkfkHc02CqytwIhs1KL75U/
	 jr+3Haq6ml3qA==
Date: Wed, 27 Mar 2024 19:44:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: git@luigi311.com
Cc: s.hauer@pengutronix.de, jacopo.mondi@ideasonboard.com, 
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, 
 festevam@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, dave.stevenson@raspberrypi.com, 
 linux-media@vger.kernel.org, shawnguo@kernel.org, imx@lists.linux.dev, 
 sakari.ailus@linux.intel.com, conor+dt@kernel.org
In-Reply-To: <20240327231710.53188-19-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-19-git@luigi311.com>
Message-Id: <171158664752.823825.12393432684821394213.robh@kernel.org>
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings


On Wed, 27 Mar 2024 17:17:04 -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> There are a number of variants of the imx258 modules that can not
> be differentiated at runtime, so add compatible strings for them.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Luigi311 <git@luigi311.com>
> ---
>  .../devicetree/bindings/media/i2c/sony,imx258.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: properties:compatible: [{'enum': ['sony,imx258', 'sony,imx258-pdaf']}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: properties:compatible: [{'enum': ['sony,imx258', 'sony,imx258-pdaf']}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/media/i2c/sony,imx258.example.dtb: /example-0/i2c/sensor@6c: failed to match any schema with compatible: ['sony,imx258']
Documentation/devicetree/bindings/media/i2c/sony,imx258.example.dtb: /example-1/i2c/sensor@6c: failed to match any schema with compatible: ['sony,imx258']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240327231710.53188-19-git@luigi311.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


