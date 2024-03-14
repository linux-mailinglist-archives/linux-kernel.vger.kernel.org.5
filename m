Return-Path: <linux-kernel+bounces-103307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F085787BDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D6328311E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED96CDC9;
	Thu, 14 Mar 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LucOsMCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EF59168;
	Thu, 14 Mar 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423311; cv=none; b=AIHuHTxplo+q7T5DLK0/f0oWDzRLfgsqLMQUxpQNmDxoPyzsxnEfmS9/kdswPOSY/qKwafy27QqKkfVZTdhX/YJ0zUJ/oxMMMPHWnTvSEnfVeKY/e3st4jOhRuT26uelEGCupD9NMCDhXsG3e2HLasz9a+fQnu3BRvp1UxHcvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423311; c=relaxed/simple;
	bh=7MInMHtoGdehrIAJNogrxHccX5NMyWPQEacFTK2okTo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nK4eEX5iWRSX71ikw/s0xajBbFaA/nahimaU4M0Ia9/ZM+5c9jFOOB+fj4rZkef42Fgq9wg+ITJTwhGkOFu5rkHcgxJFEbHVJWwIqXdstmwMwrmN3UfW89IyxwFCjTNZHA1fy0lqvqR48wXFBGzgD/B22+lVcHZWP1spGHGPVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LucOsMCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997ECC433F1;
	Thu, 14 Mar 2024 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710423309;
	bh=7MInMHtoGdehrIAJNogrxHccX5NMyWPQEacFTK2okTo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=LucOsMCKeLSixnva7ujYgxBrWw8Fb0J0XZmNy0PpGV6FvzJ2ZXLrxheRdhy+iPvUw
	 r96bOg4gCn1STEXXyQpdpJyqJR62RB0rOgBEVzw2bhsvBJf6mW8qdRVKGbLqZZHTkU
	 w85u8/WmhOZRiMGilPXWUbFbNoOq7S8u8YXlgJldYh9Dt384hUTREo3P2h6hHQ9O27
	 CmGsNTDRrlhCqhU9tNoNm4BLisK4GxLj+7eSEPyNh14ToY/s+JsukbO7nvQklGos5L
	 W1v0ucBQBg6peZSLQ8nWKsZhMBx5guUIdNJilF/y2FrqRDbn7/eBylLiFsZ9QHzuG2
	 neUHNxe0b2SpQ==
Date: Thu, 14 Mar 2024 07:35:08 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Amrit Anand <quic_amrianan@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-riscv@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 kernel@quicinc.com, conor+dt@kernel.org, agross@kernel.org, 
 devicetree@vger.kernel.org, caleb.connolly@linaro.org, 
 chrome-platform@lists.linux.dev, andersson@kernel.org, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
Message-Id: <171042330739.2706595.14845037469137084350.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for
 multiple DT


On Thu, 14 Mar 2024 17:41:52 +0530, Amrit Anand wrote:
> Qualcomm produces a lot of "unique" boards with slight differences in
> SoC's and board's configuration. For eg, there can be SM8150v1 on MTPv1,
> SM8150v1 on MTPv2, SM8150v2 on MTPv2, SM8150v2 on MTPv2 with a different
> PMIC, SM8150v2 with no modem support and so on. For instance, suppose we
> have 3 SoC, each with 4 boards supported, along with 2 PMIC support for
> each case which would lead to total of 24 DTB files. Along with these
> configurations, OEMs may also add certain additional board variants. Thus
> a mechanism is required to pick the correct DTB for the corresponding board.
> 
> Introduce mechanism to select required DTB using newly introduced device
> tree properties "board-id" and "board-id-type". "board-id" will contain
> the list of values of "qcom,soc-id", "qcom,board-id", "qcom,pmic-id" or
> "qcom,oem-id". "board-id-types" contains the type of parameter which is
> entered. It can be either "qcom,soc-id", "qcom,board-id", "qcom,pmic-id"
> or "qcom,oem-id".
> 
> Qualcomm based bootloader will use these properties to pick the best
> matched DTB to boot the device with.
> 
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 90 +++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/arm/qcom.yaml:1159:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
/Documentation/devicetree/bindings/arm/qcom.yaml:1162:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
/Documentation/devicetree/bindings/arm/qcom.yaml:1165:15: [warning] wrong indentation: expected 13 but found 14 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


