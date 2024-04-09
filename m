Return-Path: <linux-kernel+bounces-137201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3C89DEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA142980BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C913AD09;
	Tue,  9 Apr 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXphSvrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F9130A4D;
	Tue,  9 Apr 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675848; cv=none; b=Mq0ypqgf+4jZqHmLSS6gb0t4gFXeMT8FJmKe7M10k6JU8B61uQR1gAxmtX/gTOZBOj8Jm4CsNte0RAZqfY/xoVP4fnWkN6Kj7F2285Qb00srEboG+dovJXbSQJDeyhAllSStzK4mXueKw1XIlbnVvbOHdoihLghGEKGArA5qdOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675848; c=relaxed/simple;
	bh=es1MYjnQwIto0uL6LwEAbpD4rpRO8wPyukz2ygDwB38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0WrIV1EluUIcm19F+i6drI8exf+BO014NxBmuvjbiZBP7JokExukrRrYYRY3NaOgomP7gOBo9dL6H+63Mtcs+95dvj0VCXmTD6hPwXCuUOP2YBj2Fq6ghBDEs2ubFdThh3HAu6Vem80r7dmptxHnt1D1LMEFrWtfOyU3kIySqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXphSvrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C993FC433F1;
	Tue,  9 Apr 2024 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675847;
	bh=es1MYjnQwIto0uL6LwEAbpD4rpRO8wPyukz2ygDwB38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXphSvrzfQlLteAwykxf90vsjX5sUCf6QZhMeJwnnwi9wV+OmF/zPeaoj2vwU2Ipg
	 PgcuWz01XA6QLO3UAPPG3L6WuHO+VFv3Fexn829rfFRET7sRdyWXI9HJGz3BLGsV7s
	 oGGVDPD3PBbsZNu93DoKaixR6BHvuybLTAxabFJgzvWwLU3HTNQYIltK3iR4cHspr2
	 9J/3c9SiUJ48odINzX09ZEmIHIrYx2mHnREDbFMnVkxRpOWCpGwr2SoeSILYhQj093
	 isp6yPLT3JgaqYd4MdBHMWAXrDSDbdYou5WFgkJPk+R26fHbHPiLSvCQdy7XkAsoo1
	 8k9pTlmxbZ4lA==
Date: Tue, 9 Apr 2024 10:17:25 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Umang Chheda <quic_uchheda@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcs6490-rb3gen2: enable PMIC
 Volume and Power buttons
Message-ID: <6b3gqfrvljvlfaf365l55kjcbjd4rfmw223tro6rqy5crykxgb@l66dptcrujip>
References: <20240403132839.2117675-1-quic_uchheda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403132839.2117675-1-quic_uchheda@quicinc.com>

On Wed, Apr 03, 2024 at 06:58:39PM +0530, Umang Chheda wrote:
> The Volume Down & Power buttons are controlled by the PMIC via
> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> 
> Enable the necessary hardware and setup the GPIO state for the
> Volume Up gpio key.
> 
> Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
> ---

I suppose this isn't a "resend" either, so please send me a new version
of this as well.

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 63ebe0774f1d..73f6d18d2331 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -9,6 +9,8 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>  
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
>  #include "pm7250b.dtsi"
> @@ -39,6 +41,22 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&key_vol_up_default>;
> +		pinctrl-names = "default";
> +
> +		key-volume-up {
> +			label = "Volume_up";
> +			gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +		};
> +	};
> +
>  	reserved-memory {
>  		xbl_mem: xbl@80700000 {
>  			reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -471,6 +489,25 @@ &gcc {
>  			   <GCC_WPSS_RSCP_CLK>;
>  };
>  
> +&pm7325_gpios {
> +	key_vol_up_default: key-vol-up-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +	};
> +};
> +
> +&pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&pon_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> -- 
> 2.25.1
> 

