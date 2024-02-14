Return-Path: <linux-kernel+bounces-66061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE6855614
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD001C246FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404F18639;
	Wed, 14 Feb 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvVULrNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC313DBA7;
	Wed, 14 Feb 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950177; cv=none; b=rS1BlMhjEe8BRiGHN7vok9FNxnBoMyRI5bhkBnrAOs8JwaDPOe82s9I2Md/vp3jlaBjyK8dvI1uqTTfP8xr/qU4KhdUQoRpeRgbQDoagG/R650YP4pFl/KoH3mLd1BUR2JbK/5qczDYknuFxokeYTqpdhYm7wlVwxTVhtBP4HEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950177; c=relaxed/simple;
	bh=cuk5v3UVSkias2/T3msBj4KycCIN+ZE+xQFPHrHtltA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=laX3wBdKSpYAeYtN312etp2ZzD2t9gniryvfgKpGwIbn0nmIqtRDdeBFDdaN0BEqCsUvoOW00ycWQo534/7awd+t0IqQS/lQitm3vRB61VQNAMffQVAA5QK4FI0CCKaAqg7g7cb8tGAT5oWYGMLkjEhl0K7vMrOk6hsFEKwFlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvVULrNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45377C433C7;
	Wed, 14 Feb 2024 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707950176;
	bh=cuk5v3UVSkias2/T3msBj4KycCIN+ZE+xQFPHrHtltA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nvVULrNWO6OHTXzeiA/aff8L7LAVeWUldrf30FQbige0JDpC3WwsYRZsvat9sOW91
	 uSTBn96wSSdhMBzhx3t7P0dzky5G/CFngUBeKGeR0hkBpOUz9VTrr0eMoKOEehK7kb
	 tRDvgTs4QNS0cAf88ILs2+OCO9dBew5MinzwhX/7Mqb+haqsQnXzo2sPuKn+pN3j+0
	 C1C+4lRQa++p5t6B9fvyXra5R3uuOHBaMFBIOxohr1v8R3s4wD8bQdAFu1xBHkvddl
	 61AzLJY4T4VTYbXirpTt2GbplAM3W7xkmmgL1ctN54jTy645vqc0Qrm/d3mLhmIP1C
	 dmXKHlSwcCXgQ==
Date: Wed, 14 Feb 2024 16:36:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240214-x1e80100-display-v2-1-cf05ba887453@linaro.org>
References: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
 <20240214-x1e80100-display-v2-1-cf05ba887453@linaro.org>
Message-Id: <170795017346.2201348.120007615715215491.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: display/msm: document MDSS on
 X1E80100


On Wed, 14 Feb 2024 23:24:30 +0200, Abel Vesa wrote:
> Document the MDSS hardware found on the Qualcomm X1E80100 platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 252 +++++++++++++++++++++
>  1 file changed, 252 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dts:24:18: fatal error: dt-bindings/clock/qcom,x1e80100-dispcc.h: No such file or directory
   24 |         #include <dt-bindings/clock/qcom,x1e80100-dispcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240214-x1e80100-display-v2-1-cf05ba887453@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


