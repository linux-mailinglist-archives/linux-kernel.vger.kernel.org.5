Return-Path: <linux-kernel+bounces-136074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611AC89CFCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF234B21909
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690178C1F;
	Tue,  9 Apr 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvNhYGDI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A02F3B;
	Tue,  9 Apr 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626144; cv=none; b=Zg2iJ6wQhdNC/Hrax1m0R31VhJ3r1N9p6WbaxS7Xgt4prkn03rBKCVrS4PnCSu2CR35Suwe/caNrabJRpgx0KJTP8TEC+KbOeeUN60UFqV2JB8Wx8RQPRDjXv4aBwxQSdT3UzcoGKj8R+aHYCXK5mcAueC4tJ+85C6EFY40QyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626144; c=relaxed/simple;
	bh=c8Yo2XAsQZGc5uDL8HxfN5ZZtLS+obj/SZlYC+epWVE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WMqctILjvFpaKsNn31muKgZBIfkw1WUN6URkC+Y7lzT43aO7ouGPMNky2h/QoF3WHJVKovCWegEvlF7nekrkgQ2Rr1OnOIZ+I/TObWIR6tKt8KcKx1lL4gWuerVLASLNfWBW2BQ3+n5Cynb/vX7wndjM9QPnlntnc8Twy8G4jpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvNhYGDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C8EC433F1;
	Tue,  9 Apr 2024 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712626144;
	bh=c8Yo2XAsQZGc5uDL8HxfN5ZZtLS+obj/SZlYC+epWVE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gvNhYGDILKosYsoAAqa7O+vnIML2zKpZ5DAG69m2twyNGTnvJ2BWsSeQp+IUmEJBa
	 iIpdUlHg5AHii8kw0i6YUnbnZgUQQi7KR0QQl0ecywH/7cM+fn/TqSvFsj0RMgl3+S
	 E88nwOB9CJCvLH2WpNnY6pKH4kS1mhJeA4IJomVjvSDIFG0mFc8HbZN9wR3ebV5op/
	 SBEEIfGF1+vJIYBcYTSTjqOlQXUCWS1XrLmG2tBEXieh6OGXC5S8LT9ZM9c2BobKPR
	 n9fpM7lDmj1Ka8I3GhdK2vAZpUY1P7VeTYVb6v9UmHxZyPWLuMEF56bYyfV3V88Vcd
	 QIO61bzermwNg==
Date: Mon, 08 Apr 2024 20:29:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org
In-Reply-To: <20240408054926.3994-1-markus.burri@mt.com>
References: <20240408054926.3994-1-markus.burri@mt.com>
Message-Id: <171262614115.5376.868367860569840766.robh@kernel.org>
Subject: Re: [PATCH v1] rtc: pcf2127: configurable power management
 function


On Mon, 08 Apr 2024 07:49:26 +0200, Markus Burri wrote:
> In the PCF2131 power management the battery switch-over function is
> disabled by default.
> After a power cycle the rtc clock is wrong because of that.
> Add a device-tree property to configure the power management function
> and enable battery switch-over.
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |  3 +++
>  drivers/rtc/rtc-pcf2127.c                     | 22 +++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml: pwrmng-function: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240408054926.3994-1-markus.burri@mt.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


