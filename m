Return-Path: <linux-kernel+bounces-144909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFC8A4C80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF961F238CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F558ABD;
	Mon, 15 Apr 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bANNOlL6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAC5811B;
	Mon, 15 Apr 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176851; cv=none; b=VJqvLR5t0SYV777g8SGA+yvEkk3P0qLW6EYq1Tr9Nv/eD0a32McKUtYJvaFBsQQFdBp6FbDqRnp6KcBuH7RdtleQ6a4AMiL1ia/DW9twDpr/3UPycdXREc8x2/maqkuIPCFDLlBw5kJpm8lQwhNfBFqMdTZzvXbKPe+CtDrdFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176851; c=relaxed/simple;
	bh=QTaNE6v9yitIg/5Jk0vp633X8veBSijdhDfr5Qjx7vk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZKc/rJxLFWzFs6WL3+Kk4KAIz7qSWOBygqW5+1IZemG/NigaNUFMX9oxMikdR/XJw/hbEZMVyFGlK8hGuB0pYar7cExi/HKJ3pw1Zc3F6fgw1/Pc2FGF6yuP3oQ33DvXTFKzH50SDyyAf1XQyn8i0cPLCcCMaiwnd25890tg7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bANNOlL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159A9C32781;
	Mon, 15 Apr 2024 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713176851;
	bh=QTaNE6v9yitIg/5Jk0vp633X8veBSijdhDfr5Qjx7vk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bANNOlL621BAycIRNCS9TRMeFEGfc0t4zzHHJbNC58uNPnYg3mKANMFVwejD114gX
	 0KFY6NHw3x/4nXSjccLiR2G0fF5f5I5653VklH0cdGNm6czAnE5sFxOxdyhjp0inno
	 L2QfwxJkjKYZ66uKssxBpkNnDGHdEbwBd6YGyLi7jRM73289JSh6SVTFNCMwn+N/cp
	 Ve4I9mCvDYQwHyRuA7G3j4Y2sEnRWpIjVxfyo2ULGSprA/ZQtQT5owtU7Kk8k+vSWq
	 TSeQTwEwHDS+XkvBaQuLetH2Zqk63Hvmjte3MSvL698ueJru8ohDhPtk1zDbT1FcQl
	 8f9rWIimTQAnA==
Date: Mon, 15 Apr 2024 05:27:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415093211.809927-1-hugues.fruchet@foss.st.com>
References: <20240415093211.809927-1-hugues.fruchet@foss.st.com>
Message-Id: <171317684894.2177567.12294607430511830863.robh@kernel.org>
Subject: Re: [PATCH v2] media: dt-bindings: add access-controllers to
 STM32MP25 video codecs


On Mon, 15 Apr 2024 11:32:11 +0200, Hugues Fruchet wrote:
> access-controllers is an optional property that allows a peripheral to
> refer to one or more domain access controller(s).
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml: access-controllers: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415093211.809927-1-hugues.fruchet@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


