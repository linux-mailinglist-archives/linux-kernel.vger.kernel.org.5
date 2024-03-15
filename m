Return-Path: <linux-kernel+bounces-104564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76A87CFFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EBAB23841
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471A3D542;
	Fri, 15 Mar 2024 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp7lWExy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFF3CF6D;
	Fri, 15 Mar 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515777; cv=none; b=Ye0u7Ss5Y1NYFjLy2r8zyF25LUaCYmvSN1DY9UVxIkEj6IzUZ6YBro0Sh95CwhzSSFlsgFkEDEcOHuRZgjWWc7dVIhDF/TTst066ZQkPI4CDPR19z5qMDLpnP26Bu513WrwLwRkfsChzM/eeKIvGvrAbwYwYJTFmv+IKm9aUsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515777; c=relaxed/simple;
	bh=rW2HryGSEjzyD6FFEg2XJKkSr3CLQOCxWR3nI7wapa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnPblLscaFzGGRlDSiZ9cSIX4er4hCvTwd/k8Bz/AZYsv9p35obMMODAKOg7jGM70fXLx1/EjQlpsli9Q92AxN9LMyEY8hwuZxyvazp/hDb1gJWK6zX9F4rffsvoaapJ6icXcgB8k82nIg0CV8d34iOUizE1RTjTOZtDyDXDl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp7lWExy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641E3C433F1;
	Fri, 15 Mar 2024 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515776;
	bh=rW2HryGSEjzyD6FFEg2XJKkSr3CLQOCxWR3nI7wapa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp7lWExyYs0p6QUXGBUvtMo/qelfJaX913MzZnctePLBSTOregYZpaVKajIcFIFAF
	 qOcltgdIXI2njthpjricvHzsMLTWSadOaeb39hK6dzzfQ/8JxLEyUkxZKjVj9T1Ubj
	 oauz5bHHnMBz0yi9jBrxck+W9LUcwIQiTxT3cCWaR8jAPct/IEan6QfQe4vUnxeC3b
	 l4RdD+AjrtxpxWrgcL8jt+lLcu5cFS0RBQ10DIO/uVBIuSBLoVgo5WqupbVh8PjapB
	 N1MSK1FYx+j4+maqeqYK7111jx/QiiSKqkA341X6XYPPkSmeSaK/ZC2H+TudhEhAMM
	 qaLNJ6r9L7VwQ==
Date: Fri, 15 Mar 2024 09:16:13 -0600
From: Rob Herring <robh@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: qcom: Fix x1e80100 camcc
 power-domain declaration
Message-ID: <20240315151613.GA1256230-robh@kernel.org>
References: <20240313-linux-next-camcc-fixes-v2-0-9426da94ae37@linaro.org>
 <20240313-linux-next-camcc-fixes-v2-1-9426da94ae37@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313-linux-next-camcc-fixes-v2-1-9426da94ae37@linaro.org>

On Wed, Mar 13, 2024 at 05:53:52PM +0000, Bryan O'Donoghue wrote:
> camcc on x1e80100 requires two power domains MXC and MMCX. Define those as
> part of the schema.
> 
> Fixes: 76126a5129b5 ("clk: qcom: Add camcc clock driver for x1e80100")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8450-camcc.yaml          | 37 ++++++++++++++++++----
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index fa0e5b6b02b81..1f62139426845 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -19,9 +19,6 @@ description: |
>      include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>      include/dt-bindings/clock/qcom,x1e80100-camcc.h
>  
> -allOf:
> -  - $ref: qcom,gcc.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -38,9 +35,8 @@ properties:
>        - description: Sleep clock source
>  
>    power-domains:
> -    maxItems: 1
> -    description:
> -      A phandle and PM domain specifier for the MMCX power domain.
> +    minItems: 1
> +    maxItems: 2
>  
>    required-opps:
>      maxItems: 1
> @@ -50,6 +46,35 @@ properties:
>    reg:
>      maxItems: 1
>  
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-camcc
> +              - qcom,sm8450-camcc
> +              - qcom,sm8550-camcc
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: MMCX power domain.
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,x1e80100-camcc
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: MXC power domain.
> +            - description: MMCX power domain.

Add new entries onto the end of existing ones. IOW, MMCX should always 
be 1st. Then you can move the descriptions to the top level and just put 
minItems or maxItems as appropriate here.

Rob

