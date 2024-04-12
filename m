Return-Path: <linux-kernel+bounces-143276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87D8A369F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411821C21C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A31509B9;
	Fri, 12 Apr 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="cM9RmZ7I";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="WcfDuctI"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3814EC4E;
	Fri, 12 Apr 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951896; cv=pass; b=FGvRkt12+aMrZpguaQl9QY0cdE7wkgqjp9uYYUmfSTZRSuONhFZsHHBeMcgq1WIxkuEMU6QBizq1YyCGOFcXDnkD4FrOZVa7Y/IMjMK6MXOaw7EujAofip3iQ/PK38lXk/T5gIWLRVN6Y3CASPBy2yavtuUy1GIGC7t3RT351cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951896; c=relaxed/simple;
	bh=/Hfa0pk/8TRhz/aD5yPxTO5tbmw87XsGClapxWJ6kzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgjVCv2B0zdXLmqmpLJL1+zqYqdTjtVhRHya/0NtNgnKsBzgbo8YxNHsnPtt3Ui7Lbm///8P6gtzVQkj+y6344uAWvhKfITLMU7Hnpqrd6SEQoOpekWfnAYpeKTfpgXIHnfkDG0dPNOpZ9Go6d5OjzxhE8IPJXzwY2sI1jWoiMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=cM9RmZ7I; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=WcfDuctI; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712951879; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MNwXDAeuAM5OlQUPvXecTVuzPdIx1e5ezey250l2sVc/Aj3aH/6DB3t5oCoyD48Dok
    YK2o96+FjDMi0peqEcgsJZPKciW+1wI4U8chbGBqjqV6BBlLeKJ75JbRtBEUvLBz9wha
    xminNmRjhLDMjGpXPEDMOjRm/oAvXMZ8gg6qDgLG2bhYDbAZ6PZKpOIDvG7HQoaMrPS5
    yfxAwK+V0zJru18qKZAnjjYuLhu36RpJ/019sig1vRmqjWCPmHQU6gIChgaYIqdvSa/2
    3MM+Zbd5pArzXCOjWQFqTb7mmIabMxsz2EMAHaW7tI1zI5EUacqZiOdmLPesGZgL5gF9
    jq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712951879;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mpdrnGFXjbwGd37UfMZp+KiINlofTHsCaGVvFFusP0=;
    b=PpeL1a/rS0p2JsvAT4o9SoVQYF2Xo1o4qPzbNume7VipJG2IMetAFQK3V1Lh9k1tS1
    M/gy0lXKn/QzQ2bVl1owyAx6EGPexThlfHAOgirLpJBfHflQFmmr4ExegmjV6+YLoYPU
    BvzMtr9NZCozNklGThKq67v8/GrJh5p9nKHUqkfzte59OvzLd+y8w9xiS7rTdXrfaf7+
    5wuLH/0upWf/51HONj3oboizZUJBSWl9IkawhHncA+FkWmYXSGDiykfyhm1QsdZqf4Az
    PUWVBqOZJMBnbXMTyCBcaznsuQJzvSQN5s1JsFLi65FlINO9jvJP6dYq7X4+zDim8Tku
    HT4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712951879;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mpdrnGFXjbwGd37UfMZp+KiINlofTHsCaGVvFFusP0=;
    b=cM9RmZ7IJ1RuNn8IVcYXCx/g+//VNrduGBnNyjquWaN9kLak6xHt5SikK9tXRRhmZ7
    lr2/+JhjAIE2Mb+gO3NzkOnUA9b0f6FQXW5NHESgvZ/TuzRCv6PRqfVWqH21GRHv1b3x
    gaZY0jDbqUb60CaYSozbkzIkx6YRZx1VR7Lu53vjAu2VUgGiO8y7yhAaolK1uhl+H2sq
    zXMKP/g/DIFGDFOQFlJJvmL/bkj4JP4P1ryOWeYL5HClriIa6AH9gUibp1kGsQofQZjp
    8/XmGf50qCutGPRaFnzgL9/ZFI+d+e3nw2I2MbTmAYfQqWITQDC7CRputvCzhlCuSNxA
    lnCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712951879;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4mpdrnGFXjbwGd37UfMZp+KiINlofTHsCaGVvFFusP0=;
    b=WcfDuctIyxshGCgdMye4zwBy+06SyOZ45b9uhNiE53VzcmE03DHWTkZBSukS+kbBB2
    akmSf+elbD9KDvFNqMBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503CJvwodo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Apr 2024 21:57:58 +0200 (CEST)
Date: Fri, 12 Apr 2024 21:57:57 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin
 configuration
Message-ID: <ZhmSRSY8CSUGC-FS@gerhold.net>
References: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412190310.1647893-1-volodymyr_babchuk@epam.com>
Content-Transfer-Encoding: 7bit

On Fri, Apr 12, 2024 at 07:03:25PM +0000, Volodymyr Babchuk wrote:
> There are two issues with SDHC2 configuration for SA8155P-ADP,
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
> This patch fixes both mentioned issues by providing correct pin handle
> and pinctrl configuration.
> 
> Fixes: 0deb2624e2d0 ("arm64: dts: qcom: sa8155p-adp: Add support for uSD card")
> Cc: stable@vger.kernel.org
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

Thanks for making all the changes and fixing all these issues! FWIW:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> 
> ---
> 
> In v3:
>  - Moved regulator changes to a separate patch
>  - Renamed pinctrl node
>  - Moved pinctrl node so it will appear in alphabetical order
> In v2:
>  - Added "Fixes:" tag
>  - CCed stable ML
>  - Fixed pinctrl configuration
>  - Extended voltage range for L13C voltage regulator
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 30 ++++++++++--------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 5e4287f8c8cd1..b2cf2c988336c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -367,6 +367,16 @@ queue0 {
>  	};
>  };
>  
> +&pmm8155au_1_gpios {
> +	pmm8155au_1_sdc2_cd: sdc2-cd-default-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		input-enable;
> +		bias-pull-up;
> +		power-source = <0>;
> +	};
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
> @@ -384,10 +394,10 @@ &remoteproc_cdsp {
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
> @@ -505,13 +515,6 @@ data-pins {
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
> @@ -532,13 +535,6 @@ data-pins {
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
> -- 
> 2.44.0

