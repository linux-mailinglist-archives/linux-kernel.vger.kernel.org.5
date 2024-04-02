Return-Path: <linux-kernel+bounces-128314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54B789593D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590B01F2264F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32551142625;
	Tue,  2 Apr 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQLj9Vkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572013F44C;
	Tue,  2 Apr 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073948; cv=none; b=birTFyLJS9Q0EwzztbB8udfFzTpFym7n4CH0pDY5G4+EWxYp7PqBDWS8zmuz7ceVtpRJ4b3uhMZD3Ui0P2Gk0NQIgWxZeLWXhcqv8IYvR6mQY9yWgyq50iSM/vx0ZGFuwBW1OsBcjlaennU/z8Sw5SUvzdMVqq8Bovi/G6LlzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073948; c=relaxed/simple;
	bh=7cOFNsG+sn2clFX8iSG+nyW2cjK90YkAvpcESEHfbyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XieNO0mBE7zXtfyhRV1UC/aiYw89AwCg/04LJBDfKZaRyTMqxfhKed0wPuAtORoAEEn1kPTmDSZ5fESJsEat6Dbd1agzbtxevoKdCO3E7zAXyZm/8gsIP1x+mHXrG0ToTquTE2Df8EFBmwlN4Knyeyxm3iqGEBEOJYsBJe1UkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQLj9Vkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964B1C433C7;
	Tue,  2 Apr 2024 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712073947;
	bh=7cOFNsG+sn2clFX8iSG+nyW2cjK90YkAvpcESEHfbyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQLj9VkqL3Yd4bSTm8AXVoKsGxa3g49q6+f+v62RoIq0pOxCw55n5OU32s1E9xsoM
	 vV16QvE/R1ptCV/dQahrvTwSdkqXDpHHNV6d+mAmEMy0qeZvS21T05jfUYN13kzRgB
	 BdsoSnIMyCdSOndCPyt9lDfujYsAiPcV+FZH/sy/7uoB5gd4MmyrorTPHY8/aH/6VL
	 F7727KkSiANEH2iTd4cWiI/u+EjNQJHLDDoDTnYy3Fh8PQ3nYOLDxgaJH76VILSxyV
	 WmWFh7YAbrZmODjN2Mn/ML259REGCAnDwKZ3Y0TVzigI58N6Q3ZLvhXjcQ4SRZWSiz
	 /TsTw2GOH8ozw==
Date: Tue, 2 Apr 2024 11:05:45 -0500
From: Rob Herring <robh@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Message-ID: <20240402160545.GA223060-robh@kernel.org>
References: <20240401-videocc-sm8150-dt-node-v2-0-3b87cd2add96@quicinc.com>
 <20240401-videocc-sm8150-dt-node-v2-1-3b87cd2add96@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-videocc-sm8150-dt-node-v2-1-3b87cd2add96@quicinc.com>

On Mon, Apr 01, 2024 at 04:44:23PM +0530, Satya Priya Kakitapalli wrote:
> Update the clocks list for SM8150 to add both AHB and XO clocks,
> as it needs both of them.

I read this as you are adding 2 clocks, but it is really just 1 you are 
adding (iface).

This should have more detail on why breaking the ABI is okay here.

> 
> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,videocc.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> index 6999e36ace1b..68bac801adb0 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> @@ -75,7 +75,6 @@ allOf:
>            enum:
>              - qcom,sc7180-videocc
>              - qcom,sdm845-videocc
> -            - qcom,sm8150-videocc
>      then:
>        properties:
>          clocks:
> @@ -101,6 +100,22 @@ allOf:
>              - const: bi_tcxo
>              - const: bi_tcxo_ao
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sm8150-videocc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: AHB
> +            - description: Board XO source
> +        clock-names:
> +          items:
> +            - const: iface
> +            - const: bi_tcxo
> +
>    - if:
>        properties:
>          compatible:
> 
> -- 
> 2.25.1
> 

