Return-Path: <linux-kernel+bounces-71482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0C085A5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A80A1F262B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C11EA84;
	Mon, 19 Feb 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NII8P/Jv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EE1DDFC;
	Mon, 19 Feb 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353138; cv=none; b=ZbmAYzrO42oe8xCx6lVk61FZcmUsCAJ2iOT+Zjh3W6aEyT7iQ8TIl6ZHKQZ1YPJBOsZ1iQu7UYre8ojTdwL3wXEAE3ausb/IZikkhne1fjP9kowXewzL5Fl00Th41zHd9dhHGvEZfnWlFpbsAtnf+CfyYTqjWmjm7eKBf4CZ6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353138; c=relaxed/simple;
	bh=p7CKu3q3ddLdu/9KSihXnzeOfwJAXWsmYHQH7vap+SM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=KldDQIJLD/7TVKiciSWCOvRNQiral1jxl4DY9bWAFeIaGXb63b4HQLLhW+nXzSKAuDfEPLYN9PtYdxDwtOaQcuy18CSKSEeNAkDWzVeKJy9J4hpORQcg9iUD0S6kGUgq9pPdu7q1vK1uFTSgyITIwOYtenDRXJp3uIhp+kwzIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NII8P/Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3FEC433F1;
	Mon, 19 Feb 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708353138;
	bh=p7CKu3q3ddLdu/9KSihXnzeOfwJAXWsmYHQH7vap+SM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NII8P/JvDIQSdS6jY3XVqY9OwEYbCNImuVFaDu7HQh8UC/uvUsJ/tkH4r3cwOJ+pL
	 zJC9tno6EAU0Rwg3c2/M9j9dKoVcp+yyaxWmbqEk5xDYdsbNzfdFWzGDPZCWUqf1UT
	 1XOTqVxZ30LixtHGzYdSUyM9WfyPAE52bNCuTsaC37iFtygZ/aVqmpAT/F3888Qoi7
	 28SlXXlJIKfquDWCKFgsdWWDg2t7yhd8iE4bHlpCx0GWBGRxq9TCSBZPeC/qmjKIsy
	 cVHutL99zjZP+dIprMmy7elANko4CEteHsdjrXyt4h5KHYPUhO2VE6+H361hGc5AyS
	 HKW39QrDx9ExA==
Date: Mon, 19 Feb 2024 08:32:16 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>, 
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Joerg Roedel <joro@8bytes.org>, linux-clk@vger.kernel.org, 
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-2-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-2-d260fa854707@linaro.org>
Message-Id: <170835313573.3576894.7520977778258170562.robh@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: clock: Add Qcom QCM2290 GPUCC


On Mon, 19 Feb 2024 14:35:47 +0100, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for Qualcomm
> Technology Inc's QCM2290 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/clock/qcom,qcm2290-gpucc.yaml         | 76 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,qcm2290-gpucc.h     | 32 +++++++++
>  2 files changed, 108 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml: properties:compatible: [{'const': 'qcom,qcm2290-gpucc'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml: properties:compatible: [{'const': 'qcom,qcm2290-gpucc'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/clock/qcom,qcm2290-gpucc.example.dtb: /example-0/soc/clock-controller@5990000: failed to match any schema with compatible: ['qcom,qcm2290-gpucc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240219-topic-rb1_gpu-v1-2-d260fa854707@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


