Return-Path: <linux-kernel+bounces-50026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE62847345
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D38B23BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14551146902;
	Fri,  2 Feb 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9OtYv18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0A22085;
	Fri,  2 Feb 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888091; cv=none; b=lmPqfKPnMnsX1EC4e/LqBAwfE4YzgDJD1GPtM7Ih8WknGtPEGPaw7Kfj9maCr9nnJLw8ZLmBxiEkna4FJuoVqiWQ4VT/Yk3O069MzQ8B4s2zLJ9wKU989YnesYPiGYOFNdVj9bEOLgdM51TbxrS98pHIetG654143zFjkQnFBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888091; c=relaxed/simple;
	bh=wA8q+NWXD8iUBHJe+sGaSntuvCbHOmfvH0NJFBAmCPE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nTl7aIqU1X6RjfWEce8xmwh9F8Qt/DpsggFdDes7gJGVIsodTp5k9Xce0bzr0ICR6zhohYEAoxX4s6ZD4oR5zwKAor3+T27A6ePYxgk7u5Ik0T1KPw89cRk0fWxU+PRzUPPy/9EZUABIE6nuVNZC4vxdHXF/jwfL9sWXmj61dUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9OtYv18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7397DC433C7;
	Fri,  2 Feb 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706888090;
	bh=wA8q+NWXD8iUBHJe+sGaSntuvCbHOmfvH0NJFBAmCPE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=C9OtYv18u4czVWqGzrLHX524pBF8iU+UpFASxyZQFFyXt9YPg0WBLX+tqf20LlvFl
	 y/ZJjXUtMrtgAsSyHJb8Hxe2r5n8V4M2B9vKGUeyiJVvFYgY5x+qYQQnHBvhFTBr/7
	 aMNenURkxqNvydyVcDHPy87Z0Iv7hjapskDBEMVdENIOFCvU7c4I9JH5nTWoJLGEDr
	 d4YxULpxOh8Q25i7yWKtqxosswgQhDyX3UC/24BCLW+RGzWK3W/2g7TFH0saZ84NvA
	 3giq9P31GdQI96yw5VKcdexY3GGweNZIopSvRj8OHzkrWx/VmQDSz6x8+GKKALu0pl
	 DuvnGqCA1ZGHQ==
Date: Fri, 02 Feb 2024 09:34:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Alessandro Zummo <a.zummo@towertech.it>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Nishanth Menon <nm@ti.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20240202-add-am64-som-v3-2-2f44023d50e9@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
 <20240202-add-am64-som-v3-2-2f44023d50e9@solid-run.com>
Message-Id: <170688808822.43802.6252377513690551092.robh@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: rtc: abx80x: convert to yaml


On Fri, 02 Feb 2024 15:22:18 +0100, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
> 
> In addition to the text description reference generic interrupts
> properties and add an example.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ----------
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 31 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dts:30.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240202-add-am64-som-v3-2-2f44023d50e9@solid-run.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


