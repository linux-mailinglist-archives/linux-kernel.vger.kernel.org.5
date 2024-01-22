Return-Path: <linux-kernel+bounces-33727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995E9836DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3881C265F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1AC4123A;
	Mon, 22 Jan 2024 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnC1gQp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292693FB39;
	Mon, 22 Jan 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942361; cv=none; b=lllAnf3w9cgz80YlhY1mJpI8uWqLdf/KOgZfvnrivbCOAXDqLNYBRnNb+c1MZ6uGc7z8S9BdRRpbO/ddByxeTbwHt8yUvtAhFF3LqoUDMZHbPFGT+pZgT4VyjmodMzFnDG09g9mO4KoEKklLJ7AVS2rTlcj+PtO+5LmMNsFe5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942361; c=relaxed/simple;
	bh=tNDolk7G27RDHAAmFkC/lBY6IbNU5P8tZGZLlNtwrXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLw0megkZ5aBcSUlXZAFyn8QgFfS6xkRf6q+ebO/56qreKD6bXHJBShpCAkVAtFtfjdIXm/H//dgXv5ATVQIF5FfWKAIdoUrkSPT0ax2ZP/81D//DGkfOti2XpQRDtLt26tx+mnHSFMdeIapnDSVuhgyGbGc8JqC9grGiFzt/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnC1gQp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0563C433C7;
	Mon, 22 Jan 2024 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705942360;
	bh=tNDolk7G27RDHAAmFkC/lBY6IbNU5P8tZGZLlNtwrXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnC1gQp9+xzRof4stDpgs56vbV+MtAF6qr3ybCYv0zGujMzJqC++Ei6AzH0bl1Wn5
	 lcHEjeIK7uqDzSZtQQUGbVyfDZVKwGZJhKYL9Tc3zc6aLgFormWz63Jdw6SwVKPE40
	 QsCmCAe2McfImzw4KzGiapKUo7B9TPhnD4iEl1Dv7/iE7yx1CcBOmOhd2KhZPZ2yOe
	 SFk8G2X1VhwTgyfEXRwWurx3Twd0pDQktOHNwBsF/jVFEaP7IjPulrFSD/SBJTcBMB
	 8yW4xodlIQu09kUUn8c+GKq88Nv4aMXO6/cQfy2y/toLvL5SbMo3fMhJsxJ+q57i1F
	 ZWGWiNwhXae6A==
Date: Mon, 22 Jan 2024 10:52:37 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document the HDK8550 board
Message-ID: <xlg7ddxr6d4fcbpcaacrkvcxucuhm7af4till4t7xxfaw5fpx2@pmbs22brqvqe>
References: <20240122-topic-sm8550-upstream-hdk8550-v1-0-bff7eb3a17eb@linaro.org>
 <20240122-topic-sm8550-upstream-hdk8550-v1-1-bff7eb3a17eb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-topic-sm8550-upstream-hdk8550-v1-1-bff7eb3a17eb@linaro.org>

On Mon, Jan 22, 2024 at 11:19:19AM +0100, Neil Armstrong wrote:
> Document the Qualcomm SM8550 based HDK (Hardware Development Kit)
> embedded development platform designed by Qualcomm and sold by Lantronix.
> 
> [1] https://www.lantronix.com/products/snapdragon-8-gen-2-mobile-hardware-development-kit/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 1a5fb889a444..5a4b267e332f 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1037,6 +1037,7 @@ properties:
>            - enum:
>                - qcom,sm8550-mtp
>                - qcom,sm8550-qrd
> +              - qcom,sm8550-hdk

Alphabetical please

Regards,
Bjorn

>            - const: qcom,sm8550
>  
>        - items:
> 
> -- 
> 2.34.1
> 

