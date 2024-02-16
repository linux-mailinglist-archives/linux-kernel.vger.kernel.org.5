Return-Path: <linux-kernel+bounces-68573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA6857C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCF9287E09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E680639;
	Fri, 16 Feb 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ57pPHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29218061F;
	Fri, 16 Feb 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086664; cv=none; b=nNOuKgQmRX/eXAfFbHUtinRAe6GIS6MWLm8FXI556yZySoD5NSHAD3Kjd6a6kRWwcG39RtGa9RUrGnP1kUvUr7bsc49oMizc0cGmThQHdNL4N6CXAgJS1Mav1pSySLKr7YOqbVPoAO7MdnHFS6nzIpYad02nA5hvHyyRc3QMbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086664; c=relaxed/simple;
	bh=fWCFoMtLRfMkNlc//mj7gnFsA5y423VmibMTNziBoc8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MulvblN7pe4x5avokUCrpiAcv9T/qvcGqEK8DDdx5o/8Vm1VHtMYbw7EyNXuJW1TUfwNTKE/v9ZHTAfgQS1R8HarMTyPDtcTZlUfAM2UzqOyQOifP7aHYGBK820keAiBsxSLwduNxwDvCMRIGJ6NwUNXCcmT1w3/zRvYj6z3b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ57pPHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE7C433F1;
	Fri, 16 Feb 2024 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086663;
	bh=fWCFoMtLRfMkNlc//mj7gnFsA5y423VmibMTNziBoc8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eJ57pPHOH7NvZDeB8KaqTplTailpGRK+eSbGMukm6I1nyKdbprDOOxDgbDLIMfmpc
	 v4rCgjTOvKdmSsf5MAkfyMJch+mWAMMXeW6b7/FOgJJxnOj8guSHGDj3jduhbunW+X
	 hPAwNTdKZA/K7GfzoVJ9O1rDNsOMLcldHI+Fldss+KthA/nyi/Yt5PdcCQqO8hWKw6
	 xic8RGvzZFJLJelTjifkbwxkiBpCThBmiUj+uNjAG6aoD3XFeAYhEHRyeKDrG5KyzM
	 GhgTiP482jPjJZwy6V1CeLI9hi85JJnstsAbRZvrGb2o1tRu5hrHd6TD/qj3BUxo+G
	 f/Gl4imDmsuvw==
Date: Fri, 16 Feb 2024 06:31:02 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 David Yang <mmyangfl@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tianshuliang <tianshuliang@hisilicon.com>, 
 Igor Opaniuk <igor.opaniuk@linaro.org>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v2-4-010d63e6a1d5@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v2-4-010d63e6a1d5@outlook.com>
Message-Id: <170808665861.2530423.15497833321413187475.robh@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc:
 hisilicon,hi3798cv200-dw-mshc: rename to hisilicon,hi3798-dw-mshc


On Fri, 16 Feb 2024 18:38:02 +0800, Yang Xiwen wrote:
> Add binding and an extra property for Hi3798MV200 DWMMC specific extension.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  ...-dw-mshc.yaml => hisilicon,hi3798-dw-mshc.yaml} | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml: properties:clock-names:items: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'ciu'}, {'const': 'biu'}, {'const': 'ciu-sample', 'description': 'card output sampling phase clock'}, {'const': 'ciu-drive', 'description': 'card input driving phase clock'}] is not of type 'object'
	Additional properties are not allowed ('description' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-b4-mmc-hi3798mv200-v2-4-010d63e6a1d5@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


