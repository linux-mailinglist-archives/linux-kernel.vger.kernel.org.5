Return-Path: <linux-kernel+bounces-69171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707E858550
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7A4B25B17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3F145FFD;
	Fri, 16 Feb 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIjUVToZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1A145B21;
	Fri, 16 Feb 2024 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108324; cv=none; b=LfkYluSmg7UnSnP5m4fJbvgufEoPDTKol2ZajxXDg40LbukYl3DYZaRXBGzlqb7ymUZmHEG6Jdkaqb51f/EuaMIVs07/wVa5ZLEsFv1zQS2J58un4UubnXt6Qmc4V0/kHBW8P3Yx5cu9soumAx8yW8RJq4UQrrLyv2At/eM68OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108324; c=relaxed/simple;
	bh=EuQ0oWNycJc6EUI4ZgzFYPB2MfQHGg5k+ggiEumBsng=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XyU6Fa2JLRhIiGE6vuhTBw2LlSlE6nYE/0d3MZEN4hIFeCuAX42xyWJnPmp4Vu/t0lnbMWxXvYLV/F0VQOmdvVyUtcD2FeeAfOTCNLt2caPaSRMhq5aa8C1BjoBVgm+QNjGKQuQRIqihS9u3In+kDDEB80iDXoDJ8OGyIcXW1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIjUVToZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E82C433C7;
	Fri, 16 Feb 2024 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708108323;
	bh=EuQ0oWNycJc6EUI4ZgzFYPB2MfQHGg5k+ggiEumBsng=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JIjUVToZ9OnNPRW7wZ74ZAXQQlIcXyhcK2EAgw6bEzGMA96/l9Xd7ImlVnHC/HSAA
	 AHp2+W08dKHJh4ynlYb8oC1vIqJUnjz/XHaw/Git88hTRb6S7T27UZAlW7HzwbtGaE
	 dm0L+KbwQX9tKFdiwbF3rjc3v9vtOQNzWrSig5Ss89NDi1ArxCLMZynVlP0YG3BOzY
	 VQ5i8oLalUDpiLoMop1oM9vz4DCHALT1OkCJDXKELTO84yhaKTPDsSofHOulle52zg
	 yeFghWg60WN9u/87wAo2PLiNihR7A5n+nIvour5wfyw4UHCFHWpJJy8mttA348xfOl
	 ZxsitMFTnBynw==
Date: Fri, 16 Feb 2024 12:32:02 -0600
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
Cc: Sean Paul <sean@poorly.run>, Maxime Ripard <mripard@kernel.org>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 David Airlie <airlied@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robdclark@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org>
References: <20240216-x1e80100-display-v3-0-28b1c33ac8c0@linaro.org>
 <20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org>
Message-Id: <170810832158.3497594.1997532394027797497.robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: display/msm: Document MDSS on
 X1E80100


On Fri, 16 Feb 2024 19:01:06 +0200, Abel Vesa wrote:
> Document the MDSS hardware found on the Qualcomm X1E80100 platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 253 +++++++++++++++++++++
>  1 file changed, 253 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-x1e80100-display-v3-2-28b1c33ac8c0@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


