Return-Path: <linux-kernel+bounces-66062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B3855617
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F58828D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87E9145327;
	Wed, 14 Feb 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km3p9V3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE621420C4;
	Wed, 14 Feb 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950179; cv=none; b=DOKdsiV1ZSYVsn8THKNcooN5KdDw43Fv+mZ7ZdTC+nubyMzY/TXITjG96etERF/Dzul4WccmERgeskXtqt5FrcFcLN6BQHoMhjQ1h0sA4AYRj1R3sqKYe5goHFNQeMtehTBAi7r759+IxBnAQimuxDvz8BKz2YODO1JMc8ssC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950179; c=relaxed/simple;
	bh=HCthTh2EHFiykooSADJUqIjdFXj2miq8U9qp/oonkpU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=mBPLV/w2l0E5jr9y6sMAfxtx93lCq0+SXIHtGzHP5iTniQGQqXFEhKFTVnzZKKBoYqDw9nXuASUFPGySkF3F81VqIPqgv6BWMY5NGEQmp3XNdrkl8G8FA6bjIkA/bUUnpw/VX2i6KN+WfbqoIK1cyFp2pvNt2CvBL5mF/T+Xnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km3p9V3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE028C43390;
	Wed, 14 Feb 2024 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707950179;
	bh=HCthTh2EHFiykooSADJUqIjdFXj2miq8U9qp/oonkpU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=km3p9V3noxQ1ZIql9oPAAJNkN82df2B+dTnOlCaozOme/mIueOuFFLUlOjaQcpHan
	 gZwam76ZriDpwAbvAc37Ttc0K2BBYpZVGDyrXm+/AHylMuLHB/ZuywqVWPhAjNxUhA
	 jYDoxAeOBjD0FrlYRHfvpiaQjfImiOlDOw3VIbQFqZ1954BLeDlq8JV2NUsGN3dC/Y
	 ihhRfkLqG77zNIKQV4fpvj2MNyEK7YUtt4u90FqXmgSn4pUAZPfGkIxieojLMNO8/M
	 h3CUoZJW84MCqw9D09tC/xdIXEJXLA53BOeccE4Vzety2hN6OblSpvsLIZfQf3QzTp
	 MQS9HrwvpULEA==
Date: Wed, 14 Feb 2024 16:36:17 -0600
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
Cc: linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Clark <robdclark@gmail.com>, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Sean Paul <sean@poorly.run>, Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org>
References: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
 <20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org>
Message-Id: <170795017402.2201397.8209800287591911549.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: display/msm: Document the DPU for
 X1E80100


On Wed, 14 Feb 2024 23:24:31 +0200, Abel Vesa wrote:
> Document the DPU for Qualcomm X1E80100 platform in the SM8650 schema, as
> they are similar.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


