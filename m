Return-Path: <linux-kernel+bounces-40346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B083DED5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91591F20F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E681DDC9;
	Fri, 26 Jan 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTlmYaPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63391DA22;
	Fri, 26 Jan 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286960; cv=none; b=lTHtuJmTGpSUA3+yhtEKHbJ0PxPX7B9sDN9pJlr0XymKSCnMoQ4CskgsgQsj9uOJtOXWDwd3m80a3TYbI6IzKqss6K5p4y6oyTS8NfqP+bY4Ex5FNVaisUoyk+Jo55m46QRU+P5M9QEpFIOQhuspjhQFIh5dPKbKstBRQ7ZpC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286960; c=relaxed/simple;
	bh=1CvEZcDRXJkLYSzovAlFWb7VTNYLLAWd7l3AIviMY/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFeEh/aFFjqB6Y/NYY5W2xitgPu7puixn11Nq80Mux9jp0vWinprmIwSFoO/jTxqAaWml94CZ6t8weiOJlscVOwbXWeVIhZYHNWNO0HW+DvgesoqVQ36KIM7nR+9gm/tTTbnKWoXKEXt1qChyX6VBpzixiSLTyq2GWvgPg0+gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTlmYaPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E45C433F1;
	Fri, 26 Jan 2024 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286958;
	bh=1CvEZcDRXJkLYSzovAlFWb7VTNYLLAWd7l3AIviMY/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTlmYaPZfmk0WzHXYdceMMa/gKFOZmoiQQeszLWFCww0as7M20/nv+JeMMwgXU1t8
	 0Ocpmgjbg3Hfxyq56UzmzAji+I5+BfkmssrLQmGXH91zqHF4Vl8aTaZV7uWl1jMLY8
	 SAHKlwS7lXgTm1ZP8hwVePGQzGxCh4xIKMctxnHl23wtrP6IE9O5gl0aQ03urPZt1Z
	 1mzHGgAUmksymZl3wRtQoZF5ZjDtC0C2a2dhDwZ4P1IYGdXmBk+qUzMKeo3sBRTTVR
	 EZjs5yn5oMEpM+IpbSZR713pFDKjc6rw6WU0txTmbI9NxviioBtVBRYiG7IO4ZjqBc
	 8f3fgxpGaswEw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTPBa-00000000808-1LoK;
	Fri, 26 Jan 2024 17:36:11 +0100
Date: Fri, 26 Jan 2024 17:36:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional
 tsens instances
Message-ID: <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>

On Fri, Jan 26, 2024 at 07:12:45AM -0800, Bjorn Andersson wrote:
> The SC8280XP contains two additional tsens instances, providing among
> other things thermal measurements for the GPU.
> 
> Add these and a GPU thermal-zone.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> Changes in v2:
> - Drop TM/SROT comments
> - Remove polling delays, rely on interrupts
> - Link to v1: https://lore.kernel.org/r/20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index febf28356ff8..7bfbb1bd8f4a 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		tsens2: thermal-sensor@c251000 {
> +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c251000 0 0x1ff>,
> +			      <0 0x0c224000 0 0x8>;
> +			#qcom,sensors = <11>;
> +			interrupts-extended = <&pdc 122 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 124 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens3: thermal-sensor@c252000 {
> +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c252000 0 0x1ff>,
> +			      <0 0x0c225000 0 0x8>;
> +			#qcom,sensors = <5>;
> +			interrupts-extended = <&pdc 123 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 125 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};

These should go before tsens0 based on the unit address.

> +
>  		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
> @@ -5212,6 +5234,21 @@ cpu-crit {
>  			};
>  		};
>  
> +		gpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&tsens2 2>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};

Shall you submit a follow-on patch to set the polling delays to zero
for the other thermal zones (cpu, cluster, mem) so that we don't poll
for those?

Looks good to me otherwise: 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

