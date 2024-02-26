Return-Path: <linux-kernel+bounces-80552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E47866965
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56A11F21D05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78791B279;
	Mon, 26 Feb 2024 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+6UxHEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DE2C95;
	Mon, 26 Feb 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921979; cv=none; b=CEaOaJozDTEA9IkOUXkT/Gu3yn6HAr20ft+PP6RlZXX1g+1crCrdDPfc1iFxt9BeDCFL60jeubjZuXUtzpjBTc/VFUvL8w5m6uv0s8IF1AOB6VQoHnkhlSYSTjx2YGV8gIBk0xYIFAMFQSLZOTVnAnbrQyhEyoVEYpUdQUvuiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921979; c=relaxed/simple;
	bh=UyIFY1ZdOTrpNJDACeBp/smy1YdXjQKO9VX0E9zhzWM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=s/cq/Pi4l+wo8/7tzr2lQ5JVfTFy65gy7pgO1As3bsILjlivd+Y/qPHbE55MuE6rcMFJcoP5LesG4g4PfoXyAeKDVgNK1WFBXQGAVS2KFTeNUnHysu88eRAnHL8Fd2ZdyMTFfu6n7auzhcmRq4eXiCeb6zPiH3b20Wuv5zwBwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+6UxHEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB41C433F1;
	Mon, 26 Feb 2024 04:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708921978;
	bh=UyIFY1ZdOTrpNJDACeBp/smy1YdXjQKO9VX0E9zhzWM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k+6UxHEVHt7MXs9vKkItwmiIQk2kglVUgCWQ//kySatUBnu6y0yxDAvm+z83WphO/
	 Vd0oseZp3aDZk9f2FUL3Zd2RucUiXO1qqJvE8X9BUmHIr3TcOWMBCdhn+/cDZpmUYu
	 OAD2IQDN4BQHStml0ctUmmnYC+ZC/eovI092b0FHZe+W3t06cVoXHzORrkyef5gKLV
	 0wYkTQRThL5Df5rSU+LXQgAJi2oCzx0mDaFd2Xa05sV8fJhqMPwAFOQlk6fGeQf3rt
	 yZEXlQLTMX8POvdtpQlYKqiRl3/om3pt314JhLuUnm6CvTSuZHZ6P9RR4eCtuVw5A2
	 3Gewa0QVACG4g==
Date: Sun, 25 Feb 2024 22:32:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: brgl@bgdev.pl, joel@jms.id.au, robh+dt@kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linus.walleij@linaro.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240226031951.284847-1-andrew@codeconstruct.com.au>
References: <20240226031951.284847-1-andrew@codeconstruct.com.au>
Message-Id: <170892197611.2260479.15343562563553959436.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema


On Mon, 26 Feb 2024 13:49:51 +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e600000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v2: Address feedback from Krzysztof:
>     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@linaro.org/
> 
> v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstruct.com.au/
> 
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 73 +++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 ----------
>  2 files changed, 73 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.example.dtb: gpio@1e780000: '#interrupt-cells' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240226031951.284847-1-andrew@codeconstruct.com.au

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


