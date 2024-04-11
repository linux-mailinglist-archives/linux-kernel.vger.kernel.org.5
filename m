Return-Path: <linux-kernel+bounces-140433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CB8A1462
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8441C22022
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482F14AD3D;
	Thu, 11 Apr 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="gKstezKD";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="rooxR1Vj"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF814A618;
	Thu, 11 Apr 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838266; cv=pass; b=q/fLXgORd7oe7OpVM4SOJg05xM/5zT26yIeB08V27F+J/wW8eA9gF3zxJMigdcj6fTfWLsgp6NnnxDNJicsTZU4GcsbFE+MttcTyBVJ6PD7do1qVyu3u2q0Fr3+GDvC0pjRQjtYHk5oXMUmOFDj7VCd7XHHodlsVRskdlN8xkuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838266; c=relaxed/simple;
	bh=jxjQrutkS0QSDPxdDwN89QMeToUj5RfRvAH7a9ATGS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKWxZhf0nV4QON34nXRvQim/T1owG+CDTP5sOV9/hVj6DR7SKqKg/p22t7pfwacSh432wz8P0vhhmEhMKDtkNocYBI67yQNdrI3swdkVMbBehmuWsjSwoXPgUQgDXnDBo2rTu8dXX5MSf1T0Yz2GJiPZkpTaO6Swg/L4N8tXJKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=gKstezKD; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=rooxR1Vj; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712838073; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=InQx95xAc4L6biXu2OgUkreAtSraUppMwRNSn5SZ6zITosGWsm71L+nuNwEetQTGza
    KlqjOSGtA8C79LJmqJguaDB8qwREjlPVXsEi6TWJkwma3YMKfPI8ZA8w7sCafm+T5QDr
    CForCpf98S9CITaSLzNHVvWcJRfgldhu3YU7l/Yj1p9ETKHwm9SfA7xuec2x+P8E6QYj
    og3qL16Thn/hgUrUNmD+/7PZg2WYGsv3+M1RpZdMMvXVs1MAzly61wsztoMEFfoSXaio
    W/UyRSQsdlSKYN0rX4p9rBohYFlsHAPc6eudbnMT5HGh/s1Y5H38pD/4tnARp1qjv+J9
    KMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712838073;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=91/+JORYq9Vk3O48jL+rWZC6A47c0kJxSMnJ7mQVasw=;
    b=alQ+osTqueBdKBWZPdlg/DMcR4zymdq8AHYlvUYiRnkX2jF5HdG/NUwwB1qyEk+V8w
    0q+Y+kmIpcbseTDLNnPtbdrN9vc3OFibNLx6DM+OWzrgST1hAbKCTZuK9WvqJ4qla6Sb
    ALHiM0uN5EhFFA2T0AbjJBFqrrcP/shRzjiR84W522yLGGGt+Ep9z+Fwu6+aYOezkbNy
    MW2t/OyIv8OrapZGIRzj0A1sEh3Lz8twjzBPRxC53MuZ5hugiVayF7VCviZHsmGe1E2Y
    /Dy/VvKMBB4Wxs+QABhyP7vMiFzVsjFXsoyE25jC+ekOjhUK2aPYy5ZWsZsWG0Ays9fB
    /37w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712838073;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=91/+JORYq9Vk3O48jL+rWZC6A47c0kJxSMnJ7mQVasw=;
    b=gKstezKDNUMPCiuOMOkgrqC6PaZ/o/C6UZ10LdVT7n20LIMKiG6cJcDHzGxVuYZ0Gy
    mtxBXyDz8RutYiZMP/IKsJUoz5ujWg7jI/o2/jm7iP+s/iVjh4D1iPb7Im1OHCBeS19d
    sa0ehe919kza6BiFpmdEajnyK3Zusa3jHOIDpzgdRib1vFi2Tq1SGur9SG1AJvYfSqNT
    HCquT9R498sTu3loeVf2wKQGIYlKhRff1QutdXZ1H+l3ZY1Ekh++SiNj1qJV3nhBw0CI
    9inB/T2pJ/DOPkWpayilrSk1TZyY8LrygIxmQZIA9ePQPjRrfiw76z9roRAjJ/CzjA0E
    xvBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712838073;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=91/+JORYq9Vk3O48jL+rWZC6A47c0kJxSMnJ7mQVasw=;
    b=rooxR1VjT/AXQigk1HaPqEBxwaK6FAgAhWWMPhI3FExUBVAcavHCop/nqi//NvvPWs
    ydgQMVQWKfWyQqACumDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503BCLCcfz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Apr 2024 14:21:12 +0200 (CEST)
Date: Thu, 11 Apr 2024 14:21:07 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 configuration
Message-ID: <ZhfVsww6fL3O7tsC@gerhold.net>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411115506.1170360-1-volodymyr_babchuk@epam.com>
Content-Transfer-Encoding: 7bit

On Thu, Apr 11, 2024 at 11:55:55AM +0000, Volodymyr Babchuk wrote:
> There are multiple issues with SDHC2 configuration for SA8155P-ADP,
> which prevent use of SDHC2 and causes issues with ethernet:
> 
> - Card Detect pin for SHDC2 on SA8155P-ADP is connected to gpio4 of
>   PMM8155AU_1, not to SoC itself. SoC's gpio4 is used for DWMAC
>   TX. If sdhc driver probes after dwmac driver, it reconfigures
>   gpio4 and this breaks Ethernet MAC.
> 
> - pinctrl configuration mentions gpio96 as CD pin. It seems it was
>   copied from some SM8150 example, because as mentioned above,
>   correct CD pin is gpio4 on PMM8155AU_1.
> 
> - L13C voltage regulator limits minimal voltage to 2.504V, which
>   prevents use 1.8V to power SD card, which in turns does not allow
>   card to work in UHS mode.
> 
> This patch fixes all the mentioned issues.
> 
> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
> Cc: stable@vger.kernel.org
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
> In v2:
>  - Added "Fixes:" tag
>  - CCed stable ML
>  - Fixed pinctrl configuration
>  - Extended voltage range for L13C voltage regulator
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 32 +++++++++++-------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 5e4287f8c8cd1..b9d56bda96759 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>  
>  		vreg_l13c_2p96: ldo13 {
>  			regulator-name = "vreg_l13c_2p96";
> -			regulator-min-microvolt = <2504000>;
> +			regulator-min-microvolt = <1800000>;
>  			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> @@ -384,10 +384,10 @@ &remoteproc_cdsp {
>  &sdhc_2 {
>  	status = "okay";
>  
> -	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> +	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default", "sleep";
> -	pinctrl-0 = <&sdc2_on>;
> -	pinctrl-1 = <&sdc2_off>;
> +	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
> +	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
>  	vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
>  	vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
>  	bus-width = <4>;
> @@ -505,13 +505,6 @@ data-pins {
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <16>;	/* 16 MA */
>  		};
> -
> -		sd-cd-pins {
> -			pins = "gpio96";
> -			function = "gpio";
> -			bias-pull-up;		/* pull up */
> -			drive-strength = <2>;	/* 2 MA */
> -		};
>  	};
>  
>  	sdc2_off: sdc2-off-state {
> @@ -532,13 +525,6 @@ data-pins {
>  			bias-pull-up;		/* pull up */
>  			drive-strength = <2>;	/* 2 MA */
>  		};
> -
> -		sd-cd-pins {
> -			pins = "gpio96";
> -			function = "gpio";
> -			bias-pull-up;		/* pull up */
> -			drive-strength = <2>;	/* 2 MA */
> -		};
>  	};
>  
>  	usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
> @@ -604,3 +590,13 @@ phy-reset-pins {
>  		};
>  	};
>  };
> +
> +&pmm8155au_1_gpios {
> +	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd {
> +			pins = "gpio4";
> +			function = "normal";
> +			input-enable;
> +			bias-pull-up;
> +			power-source = <0>;

Nitpick: There is one indentation level too much here (remove a tab).

Barely worth mentioning, but I guess there will be a v3 to address
Krzysztof's comments. :)

Thanks,
Stephan

