Return-Path: <linux-kernel+bounces-121552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3988EA22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE17B3DF35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847D12EBCE;
	Wed, 27 Mar 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ETZVaO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DB12DDA6;
	Wed, 27 Mar 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554199; cv=none; b=mjCTqzsAjzdiRCIAN7kqbqNvQdLKPgEoGc4r9iAoDKyk+1vU6MrlV4yO1mC7cf/HAXrICMoPzBXUFjWEi0xqNhhRrATZbuXvF5OrZgYrDojNGarYTgy9MSUnKJiha20dU9UPfL6SeuY73kiCgimNEni7e2ELyyD2Oo1qaxvqJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554199; c=relaxed/simple;
	bh=aBbxarP4jaK4Vd3GsndlzhtjPh19wImbPPVLqBPo3Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6O7TfMYRFNMHTc6inPIFc3z9mT6azMMuyK2gwfMms58hja5iq5M/kUEBaDu6IjY/rANWrbqt2DfXMuvsPOvT5p4EI376f+c21FwTXK9JVkh3VmMTCmJUmaz5yTyWkGCHNdQ9VwGWl88QFXpTwsqi8UCmCv2f/TMTwfMaCgdFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1ETZVaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEE2C4166A;
	Wed, 27 Mar 2024 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554198;
	bh=aBbxarP4jaK4Vd3GsndlzhtjPh19wImbPPVLqBPo3Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1ETZVaOGmLgyK6y5BEngFQ7ogBt81FdTsOEwzKmc+Z6S7n2IMIb04Oqx4EEsellz
	 TleDgc+tLzLHY2Dqb8AjQygzL0RPVJ4hNknke0FDWVQHVTkbv1jmR/IFad4Wjd6LE1
	 wudwH2HdkvVWozDsCxoypt6vwZ71yHa5FozIppzux2irppfwjQcPdQniivxasEmx65
	 fnw3hxCNdlcfxSEN4AxjbFRpj3L8VSwbMDs1SqUgqAWmM85nRNhqMldIg0K1WnpXqh
	 PKUk+WLuQj2+XOQVxNuaEYhO3bMKbey8Vw2pnki3yu9QX8z7a3Wqb3qJFQS9gQU6bF
	 kVxdD0sGNFKnQ==
Date: Wed, 27 Mar 2024 10:43:16 -0500
From: Rob Herring <robh@kernel.org>
To: Raymond Hackley <raymondhackley@protonmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] dt-bindings: qcom: Document samsung,fortuna
Message-ID: <20240327154316.GA3453016-robh@kernel.org>
References: <20240326141222.200452-1-raymondhackley@protonmail.com>
 <20240326141222.200452-3-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326141222.200452-3-raymondhackley@protonmail.com>

On Tue, Mar 26, 2024 at 02:12:58PM +0000, Raymond Hackley wrote:
> Document common binding samsung,fortuna used by the following
> Samsung Galaxy Grand Prime devices below:
> - SM-G530FZ (msm8916-samsung-grandprimelte)
> - SM-G530H  (msm8216-samsung-fortuna3g)
> - SM-G530W  (msm8916-gprimeltecan)

Commit messages should answer "why?". Why do you need this?

Please test this binding change against your dts changes. I think you 
will find it fails.

> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 66beaac60e1d..2db776d78d22 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -204,6 +204,7 @@ properties:
>                - samsung,a5u-eur
>                - samsung,e5
>                - samsung,e7
> +              - samsung,fortuna
>                - samsung,fortuna3g
>                - samsung,gprimeltecan
>                - samsung,grandmax
> -- 
> 2.39.2
> 
> 

