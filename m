Return-Path: <linux-kernel+bounces-64068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F408539C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90FF288D58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3723605CE;
	Tue, 13 Feb 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2+R2c+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B0605C2;
	Tue, 13 Feb 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848437; cv=none; b=o4fD1EWjhsovkguOQbUX65OLUZI2HSrFTWr67KJVFLRW88LhP4C4ZsRVWNie5J85iWICkdHEkFQwC5mom0ajgoN9CIyGiN8xbtB0ppPqKRJ2qdBl7IdME+lj9iiwMzgiRwuasGAuAttNewtU6UkLY1/Hwo0udz5RCuUaPVrI73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848437; c=relaxed/simple;
	bh=jM7dXl5LOmYSLQCAKr0ReoM+Q27WMpqj7Jf0ZNYbPa0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GAJDp0AriHoI+cKZNBMDlkDvi6JDmJ+NxQlKXzZ7UMqhpwnJKZSXyaD0tRDB4PjLWebr5i34Y3kItUvrmSTUBYTXgAAA1Cw1boU5BLPIRm71cFIt3A1pRs/MTLEzcq1cxLu7ScUaLofPyRQQJgfB72yxqfwCQx0PEclVz/U8Gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2+R2c+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D0FC433C7;
	Tue, 13 Feb 2024 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707848436;
	bh=jM7dXl5LOmYSLQCAKr0ReoM+Q27WMpqj7Jf0ZNYbPa0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=f2+R2c+SJoM0DWezS8SNeSmY5y0hwz2sWSYbSSBkj+yN8aXavZr6+t6XZp7kMYEZr
	 MPoZnHnRuNNYIGw6GdPLnoQt2rupozmkj28JA2c1or9Yte54SNrk97aSZeOl4eVFbL
	 Dk6aSK3kRTpDfQCcYOHRweWxTN6dvCNlBW2Ig8MCMGmujsD/YqvGqS0Nnd+z9SzysE
	 8U1PdXVOdIBrCXBv1bs7xQbNd2+z9BtdrbHm3SGEFW3UqqcUrVSSLWYdXtSqGwhp+7
	 v0UxAmSwHPi7pbabpOovLrjT0fhOwE0J/VJGx/ukwxhwQWC5qwaEmIwxby9tEaLxTh
	 MAba1pkwAd41g==
Date: Tue, 13 Feb 2024 12:20:35 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Mike Leach <mike.leach@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org, 
 Tao Zhang <quic_taozha@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, James Clark <james.clark@arm.com>, 
 linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org, 
 devicetree@vger.kernel.org, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240213160521.15925-2-quic_jinlmao@quicinc.com>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
Message-Id: <170784843419.1735886.14696780778135755616.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size


On Tue, 13 Feb 2024 08:05:17 -0800, Mao Jinlong wrote:
> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
> bit.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml: properties:qcom,dsb-element-bits: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: qcom,dsb-element-bits:0: [0, 0, 0, 32] is too long
	from schema $id: http://devicetree.org/schemas/arm/qcom,coresight-tpdm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: qcom,dsb-element-bits:0:0: 0 is not one of [32, 64]
	from schema $id: http://devicetree.org/schemas/arm/qcom,coresight-tpdm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: qcom,dsb-element-bits:0: [0, 0, 0, 32] is too long
	from schema $id: http://devicetree.org/schemas/arm/qcom,coresight-tpdm.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: qcom,dsb-element-bits: size is 8, expected 32
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240213160521.15925-2-quic_jinlmao@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


