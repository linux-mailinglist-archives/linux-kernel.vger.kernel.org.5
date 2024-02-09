Return-Path: <linux-kernel+bounces-58951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354C84EF13
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5641B1C25D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9034A33;
	Fri,  9 Feb 2024 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi6M1XcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A663FC8;
	Fri,  9 Feb 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447264; cv=none; b=MZ1Y9imny2bQ+FtOcFVqnogmg49TRoptbkGVxAgJv/13WvDQ1sQlt072BGANB4/UJzCCoVSE21egMUPtMsT/18X09yFMDAHeq7tF5td1CP9d3gAEEAut80evDBujnM/PCfaliggnjmpYBhZSfAI1owv00VDFT7F7g8nVBtFRw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447264; c=relaxed/simple;
	bh=8j9vQmKd5AvP+gMOWNWCOrsIyrZlEy/UEBbaSNZ5Fts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIo5x+aLfS1UDwhGIdfO6GC5FB3uV4svcXHcU+Yn1lAb5r1BXo1b2wtQuZT6djknuMKKHUnsr2jBOgAgo4Nw9NnVMzJcPA58Hyjh5B4HvJU/xZjIn+33LGRwpD7KHmtskVu3AbX3cb2Ntwg3xYCft6AEvoSinxnoYRAzr13JUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi6M1XcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F6C433C7;
	Fri,  9 Feb 2024 02:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447263;
	bh=8j9vQmKd5AvP+gMOWNWCOrsIyrZlEy/UEBbaSNZ5Fts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pi6M1XcKXbV40FSC3xcrBdLq3I/CKJfEKsbrbFidKybJPuPKiG8TuEhKGmffymXFf
	 l9DjJ4HBM5S2sUGmWh+ORuUIsoWeMaW2gTwqSJyc5HLyl/Mj4LEbZcENThLww6eYVf
	 RO/56iRcFMnyMvcMQVAhEIx41dlWZofvh5HRhfzOFORgdEIk0snIEZioTnhZBY4eSp
	 eBF7WEgg6XcfgDBQIO++AdwCMLaKKWMttjIU7toT+4P3jCdv7JuVNoQrVC2a34dRSO
	 1xzw3XvooFHEQgQ01o33UG95pWuvRJA9RGaS0WnW8kwq/vmKc5yf1PMSqZUAI4q8ow
	 5kSOueh35lQyg==
Date: Thu, 8 Feb 2024 20:54:20 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Message-ID: <vfj35g5adifmbqsajqikk4dat4nq4ysdcyajc62ux2srjgeonu@vaohvjkvvog6>
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

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

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
> +        interrupt-names:
> +          items:
> +            - const: pwr_event_1
> +            - const: pwr_event_2
> +            - const: pwr_event_3
> +            - const: pwr_event_4
> +            - const: hs_phy_1
> +            - const: hs_phy_2
> +            - const: hs_phy_3
> +            - const: hs_phy_4
> +            - const: dp_hs_phy_1
> +            - const: dm_hs_phy_1
> +            - const: dp_hs_phy_2
> +            - const: dm_hs_phy_2
> +            - const: dp_hs_phy_3
> +            - const: dm_hs_phy_3
> +            - const: dp_hs_phy_4
> +            - const: dm_hs_phy_4
> +            - const: ss_phy_1
> +            - const: ss_phy_2
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

