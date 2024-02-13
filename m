Return-Path: <linux-kernel+bounces-63808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9391F8534B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E9283042
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805615EE87;
	Tue, 13 Feb 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTDiGHXV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CE5EE62;
	Tue, 13 Feb 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838345; cv=none; b=OmBcAwCEH1dc89kQDEyMSRhg1o7hy/dQ1Yw3UKY9RgrbXfWcI5JFlSihBlifDWsqk8Gj1kHmuLv24u5ruWn6VAw8Fb5B1Xsjp6fngVXIOPU9sw/7lFY4sz3bs7/qWy4L2Fz5HjHg2b+Mc0R12criMu7dzm2jybULTElA5DfSRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838345; c=relaxed/simple;
	bh=/9+yZy9vqCMDyXJC6a9Rn+/0ekeUlaGK/0cw1Q1T5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buRi/Syq8cZnI0By9y1yTcq4mm+6b+upqqjuTF1DhBQiXFjoPGb7JUZXF/10a5KIFGSO9WY2OavqS3A5f74RiipPvgluR6t/hNYb71Wx9VF/RB6/fLlMxV2wAXEcvxS0s/raPdhijnsN0Kfg+GWxPI/BRkJlB55vZOGv0oHGB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTDiGHXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644E0C433F1;
	Tue, 13 Feb 2024 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838345;
	bh=/9+yZy9vqCMDyXJC6a9Rn+/0ekeUlaGK/0cw1Q1T5/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTDiGHXVrDbi/P30WJStoHW6bpcHZ/3WbrqEbbIdXUy0VpdVMiMNhEUkIGoO1jIGx
	 DzLnROy4Vnm0s8CXsX8u1SAo8slhaUUG7Bsfno8CYGmy1hFNzSORMVQFokiCHPErBM
	 Xy/hMtze3wk/g35NhJDxMPM3V0zb+UIavYUtdTcgwhlIf791HdXwgLH0003u7nznN9
	 RhF47qP9ojtwDQ+UqSNPD7I+bO//P//dBidD+IsRHmTUH2TQDzSoJZCnqSi1+OT43f
	 SPSkMQoq8RzQVJlDn1yPBOX7i9syTQwZIlXpTQ7HRKtKJ/834Qf1bs6/8CvFfcdrZU
	 u6TNKV3PQCveg==
Date: Tue, 13 Feb 2024 09:32:23 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <20240213153223.GA1409056-robh@kernel.org>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-6-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-6-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:21AM +0530, Krishna Kurapati wrote:
> Add the compatible string for SC8280 Multiport USB controller from
> Qualcomm.
> 
> There are 4 power event irq interrupts supported by this controller
> (one for each port of multiport). Added all the 4 as non-optional
> interrupts for SC8280XP-MP
> 
> Also each port of multiport has one DP and oen DM IRQ. Add all DP/DM
> IRQ's related to 4 ports of SC8280XP Teritiary controller.
> 
> Also added ss phy irq for both SS Ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 63d150b216c5..cc7cf592c029 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -30,6 +30,7 @@ properties:
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
>            - qcom,sc8280xp-dwc3
> +          - qcom,sc8280xp-dwc3-mp
>            - qcom,sdm660-dwc3
>            - qcom,sdm670-dwc3
>            - qcom,sdm845-dwc3
> @@ -282,6 +283,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sc8280xp-dwc3
> +              - qcom,sc8280xp-dwc3-mp
>                - qcom,x1e80100-dwc3
>      then:
>        properties:
> @@ -470,6 +472,37 @@ allOf:
>              - const: dm_hs_phy_irq
>              - const: ss_phy_irq
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-dwc3-mp
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 18

Need 'minItems: 18' as well.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

