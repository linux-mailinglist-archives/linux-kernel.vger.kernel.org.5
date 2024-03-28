Return-Path: <linux-kernel+bounces-123642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D363B890C20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED42A7FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3DF13A3FF;
	Thu, 28 Mar 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmadlwR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AC13667F;
	Thu, 28 Mar 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659671; cv=none; b=DAfEXvSG01HABwB1ohki49LsEuczOjo3clUJc8W0DFuxzMadfuvzSD0AELL+qrjh49xcc+Yh+cABaZxjSVHxGb3TpiTf/XvPwQhZbbICYrKi5JPJtoXC0agT2ct11PNraGG6Sdc38TSjkQIlbpuP3B8EZZJ3HbZ8gojrjzkcFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659671; c=relaxed/simple;
	bh=9tI10ajN+JijMfK6bOhgV+LGZE7UBieQZIKMF2CWjK4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uIZnLylWneksHyGgwGBe3fk/EldvU9eWfFMnkmFIbYYs7Bmt4dEOil4RAWRi4DTRIpTxd2qG7+sp9v/e/N9AACB80kBPFscVX70iC/+fNgSbSd8iHgNgUxUlMMtld1qI5ukF+rtiTn3BZw1H521k77JzIJT8Fec9eILrM92FmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmadlwR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D46C433C7;
	Thu, 28 Mar 2024 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659671;
	bh=9tI10ajN+JijMfK6bOhgV+LGZE7UBieQZIKMF2CWjK4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PmadlwR18Uqa0t7sR34+JCHWqf2SG4NUWAiLSKN0PEYbMvmBDFriUNOnPq96yaMvq
	 Cf3tTRazSCN8ANmbcNsuR8NAyCnYLkJ7AuIEJliUwfw4gAdx9fpbb17l4EQtsm5hmv
	 pyOKu9woDsxpdG65MhhbO3yk5E9V0mhwTBOM5RRQuy6NvISeSNuKcS4XsLis5zpMbS
	 tB8zPYteQPboMQfFjkWdG9pCuBXLC/8q+vJ81cQjL5mL2m0WTm+qZmcZ34QFCL3wjL
	 u8B8E8F9zW2c0ZdVo3nkl8zqf4pTBuwEHGOweRObHkSdY4wJx9SaAeXSfC/v8XeJ8u
	 HkuGLOkolK/gg==
Date: Thu, 28 Mar 2024 16:01:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240328-arm64-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9434150d0465@yahoo.com>
References: <20240328-arm64-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9434150d0465@yahoo.com>
Message-Id: <171165955986.338182.13447687008547587577.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: Add support for Samsung Galaxy Z
 Fold5


On Thu, 28 Mar 2024 15:57:44 +0100, Alexandru Marc Serdeliuc wrote:
> Add support for Samsung Galaxy Z Fold5 (q5q) foldable phone
> 
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |   1 +
>  arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts | 616 ++++++++++++++++++++++++
>  2 files changed, 617 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/sm8550-samsung-q5q.dtb' for 20240328-arm64-dts-add-support-for-samsung-galaxy-zfold5-v1-1-9434150d0465@yahoo.com:

arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dtb: /: failed to match any schema with compatible: ['samsung,q5q', 'qcom,sm8550']






