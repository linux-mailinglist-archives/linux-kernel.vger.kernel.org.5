Return-Path: <linux-kernel+bounces-47078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3958448D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033E81F27EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FEA82869;
	Wed, 31 Jan 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfQ3PWl6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EE405DD;
	Wed, 31 Jan 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732722; cv=none; b=NkajXRj5ajXV4dJeGW5pJsFM7m+nUQwz0Qeeu+mERMOHDxIgOW88AUZ0OmDfH4UlKAdpgIJRVV16sd6ad1OuzMuB5G31oDZAos3+SqPHlpRiRwTsXIHQtD5O6skgFVHHUPNAqR1GZ+0q91HAjUKF+7BfxfjxizH0BB9DX32QPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732722; c=relaxed/simple;
	bh=adwQTBsELG6IcUpc/2BvWJPBMElyuZywwj6CtPi8rAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN0yyrj6fagJCstC9tMSPJlEedOIGkss4S0xGPpjQ/rgYaiSYUdIXzTxEQ/L4PRTcDijrKkPUDJks41ZYRLa6hMccbFnIW1i0KN82j48YijJL2n87Dfh3huWXM67JOxdqa+7H5+76iUEFYIix6epunG+9o0Ih2o06q8oGzRUqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfQ3PWl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C4C433F1;
	Wed, 31 Jan 2024 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732721;
	bh=adwQTBsELG6IcUpc/2BvWJPBMElyuZywwj6CtPi8rAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfQ3PWl67yoCo7KBDU/gpnSRg48r2ztxAib2ticidVXNkTX0QOn6nRWIMGFQpJryV
	 BJo3GhznvsCSL5W27wseLcQnxPQnDN3pEjAMbiet33G07CQ47RJfe+OsR/jy+EkF3T
	 fjhF+Xwoi4cw2N49fHybqIDs8x0Hi4dI82VlKu/jnr7y8r60OGSnuCqbdRvNH6XYMG
	 XwUBCXZ/qWHbrXlU6JyEJYSIIhgUGJ6aFU7hQLAIG9K7lkqLUB5pOzCT3ujnupP8QC
	 QHB/794IdABRfiZrDNy+/cnOLc5YZns+Hb4LLVN2Xcgt23Zi9xwE13ipjm6HTC5SA5
	 A7L5paB5NtLxA==
Date: Wed, 31 Jan 2024 14:25:19 -0600
From: Rob Herring <robh@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <20240131202519.GB2222869-robh@kernel.org>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
 <20240129-x13s-touchscreen-v3-2-c4a933034145@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-x13s-touchscreen-v3-2-c4a933034145@quicinc.com>

On Mon, Jan 29, 2024 at 08:47:48AM -0800, Bjorn Andersson wrote:
> The touchscreen present on some SKUs of Lenovo Thinkpad X13s is never
> detected by Linux. Power is applied and the device is brought out of
> reset using the pinconfig in DeviceTree, but the read-test in
> __i2c_hid_core_probe() fails to access the device, which result in probe
> being aborted.
> 
> Some users have reported success after rebinding the device.
> 
> Looking to the ACPI tables, there's a 5ms after-power and a 200ms
> after-reset delay. The power-supply is shared with other components, so
> this is active all the way through boot. The reset GPIO, on the other
> hand, is low (reset asserted) at boot, so this is first deasserted by
> the implicit application of the pinconf state.
> 
> This means the time between reset deassert and __i2c_hid_core_probe() is
> significantly below the value documented in the ACPI tables.
> 
> As the I2C HID binding and driver support specifying a reset gpio,
> replace the pinconf-based scheme to pull the device out of reset. Then
> specify the after-reset time.
> 
> The shared power rail is currently always on, but in case this ever
> change, the after-power delay is added as well, to not violate the
> power-on to reset-deassert timing requirement.
> 
> Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index def3976bd5bb..33731b95ad51 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -620,7 +620,6 @@ &i2c4 {
>  
>  	status = "okay";
>  
> -	/* FIXME: verify */
>  	touchscreen@10 {
>  		compatible = "hid-over-i2c";

Please add a real device compatible before you need the next power 
sequencing property I'll reject.

>  		reg = <0x10>;
> @@ -630,6 +629,11 @@ touchscreen@10 {
>  		vdd-supply = <&vreg_misc_3p3>;
>  		vddl-supply = <&vreg_s10b>;
>  
> +		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> +
> +		post-power-on-delay-ms = <5>;
> +		post-reset-deassert-delay-ms = <200>;
> +
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&ts0_default>;
>  	};
> @@ -1450,7 +1454,6 @@ int-n-pins {
>  		reset-n-pins {
>  			pins = "gpio99";
>  			function = "gpio";
> -			output-high;
>  			drive-strength = <16>;
>  		};
>  	};
> 
> -- 
> 2.25.1
> 

