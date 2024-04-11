Return-Path: <linux-kernel+bounces-139881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA78A08D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D952810FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BEB13D8B1;
	Thu, 11 Apr 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="TJ8Txo6a";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="TlARS+X0"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488F13CA96;
	Thu, 11 Apr 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818326; cv=pass; b=tbBlYTJrggmvGa3GQS6r4dREjmlU5KjrmBoZE3sTFbagqeosV7ez1HoOSbWVngrFdgUhQQOYxOyYU1M8Te0leYS25ufz5WwNLLgGplm50Ee1lHrMEVf6K800R5Mk/hDGmO+LYWcq/SEtqcwM7iqJH70IECng6Ox8CR+a3N5hXcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818326; c=relaxed/simple;
	bh=TH4HZtEjG/LwmYSC5o0HNA9LRh0YL4WwK9LPpSWAYQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUKSqm5zQlzyuy9ZwPXXAV9VG/vHQNWVCXU+jlzQLnDRC+FYihgH4WVcSkhRJ8BvkTRK7cPWFVul6gRrMxiWVoWvQIB3XXJ1Js9nqRMq6GQkQDBBz1jAkydxc96/XCmafG/yqvwbNLXOgR2gozguqc1gnqPsN00iVqDsjxZEhAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=TJ8Txo6a; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=TlARS+X0; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712818320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V8iXPikpPqqlqbqu21p8ivJsMap4iH5bHN34ekv/bkLFtYgssRbJ7pGHD22mzdcqQi
    ffgimiMvGc7rUVBWQMVfW3V9Nuxqa/OAYmDE00RzGrqFuJGaGtTOVpuE5eL0cGC5BT6B
    s4tbElyr9WPRMdYsgJ6sfNcuLtj7kU5SMdQE3Iy5F1hbcZiybTTwRn+iGpXNAC56XZ0k
    BD1IzCguRYe4w2ifTzwSf1lBMSOsn2Lu8IwYxs9c/LoO6iTWCi9GpsDZyTCBqRMBV0PF
    hiQz+1NDoBEGsqQpQW50O6lGgSWyjOriQw4jyocnMg32xOZpm2aMtH3c3QRi3JujPomE
    AB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712818320;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JFtOoHWMyTr+PHKm8LuDpKKbuPuSWvT6kPgYbpFClyk=;
    b=nYYqb0WjX+sbyEZ6l2AhqT+K+zvqsGtCBfCjrVtGLHAUOE7KPiUWVJh2ko/Vwhq28J
    xrUwW8sYUraNb16Sev8LNYP7Ey9PZxPMyWZ6Nbcwy/BQJB+mwBzF6IqJ4l/v27LWVv4V
    Mv/gdwqAogMjbdsM/Mh0902E5ZXAc0RjDhgITx25WWdZTIBxhkLi6JZPxf6QuXPpFhmt
    CBvOjhZfuvAMSfzn2Mi6hD27lz9+Dpt0yTLAZsog7gIyAy9ta7gHuiyokobBA1DLApmH
    iBOxOq28jk4W9LIktBlffGOFAcmy+oENwdM7xvavLryAKlzDx+htZvN8WJ1nIK22P68a
    qg4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712818320;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JFtOoHWMyTr+PHKm8LuDpKKbuPuSWvT6kPgYbpFClyk=;
    b=TJ8Txo6auZYNQskve2e7sgGquK91scpaPth3RPe2juBtECrwBe9mEqeXDU7HALcTHb
    UvHoFvyVcsjBFiXXwAQ6IKrr4VNIFGH3AKsW+BuWJMWN+gi7rlOQ1c0V/yBLhW2O5Gf/
    6uQAYhZTAiuNm2L3oQmCHnxTzN6BK8kEK7uOd9ih5j1MvFOg45+2rJibQrGZ3TaHlXLA
    ny+OO0WgKW6PYke3UTW6QgVTqXVVkMRKjXH0tp1fMsM0EmvqZPD/mZjauvD+hZh3fWwv
    AFtJD4g+05H1Yrcu90LV74duopFJX8CR118bzBcF8fUz1V43SiXrjCQlgLKQswO85ev4
    /HkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712818320;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JFtOoHWMyTr+PHKm8LuDpKKbuPuSWvT6kPgYbpFClyk=;
    b=TlARS+X09eyH+QShynE0SPXdrh+WqcO8SyyFxOT8Ie8o5HDHKX4S9Tl/FWRxnjND5l
    RZBvuDrTcrSYZaGxImAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503B6pxZm2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 11 Apr 2024 08:51:59 +0200 (CEST)
Date: Thu, 11 Apr 2024 08:51:52 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: use correct gpio for
 SDHC2 CD
Message-ID: <ZheIiMZaTAFrxCOm@gerhold.net>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
 <Zhb53i8-pJhDMVZM@gerhold.net>
 <87cyqw6fvh.fsf@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyqw6fvh.fsf@epam.com>
Content-Transfer-Encoding: 7bit

On Wed, Apr 10, 2024 at 09:57:02PM +0000, Volodymyr Babchuk wrote:
> Stephan Gerhold <stephan@gerhold.net> writes:
> > On Wed, Apr 10, 2024 at 01:41:30PM +0000, Volodymyr Babchuk wrote:
> >> Card Detect pin for SHDC2 on SA8155P-ADP is connected to GPIO4 of
> >> PMM8155AU_1, not to internal TLMM. This change fixes two issues at
> >> once: not working ethernet (because GPIO4 is used for MAC TX) and SD
> >> detection.
> >> 
> >> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >> index 5e4287f8c8cd1..6b08ce246b78c 100644
> >> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> >> @@ -384,7 +384,7 @@ &remoteproc_cdsp {
> >>  &sdhc_2 {
> >>  	status = "okay";
> >>  
> >> -	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> >> +	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
> >
> > Good catch!
> 
> Yeah... It took time to understand why ethernet is not working
> sometimes. It appeared that there were race between SDHC and MAC
> initialization.
> 
> >
> >>  	pinctrl-names = "default", "sleep";
> >>  	pinctrl-0 = <&sdc2_on>;
> >>  	pinctrl-1 = <&sdc2_off>;
> >
> > These two pinctrl configure "gpio96" for "sd-cd-pins". Yet another wrong
> > GPIO? Should probably drop that and add proper pinctrl for the actual
> > GPIO in the PMIC. Seems like Qualcomm configured the PMIC GPIO with
> > pull-up downstream [1] (not sure if this is the right file). It might be
> > redundant if there is an external pull-up on the board, but only the
> > schematic could tell that for sure.
> 
> If I only had schematic for this board... gpio96 puzzles me as well. I
> can understand where wrong GPIO4 come from. But gpio96 origin is
> completely unclear. I have user manual for the board, it mention
> functions of some GPIOs, but there is nothing about gpio96. Anyways, I
> removed it from the DTS (see diff below) and I see no issues with SD card.
> 

I believe this might have been mistakenly copied from some SM8150
example, there you can occasionally find cd-gpios defined as <&tlmm 96>.
E.g. in sm8150-pinctrl.dtsi downstream:

https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/484af352989c912db8f3b6393fc090006029066f/arch/arm64/boot/dts/qcom/sm8150-pinctrl.dtsi#L70-81

> > FWIW: Looking closer at the broken commit, the regulator voltage setup
> > of &sdhc_2 looks suspicious too. Typically one would want a 1.8V capable
> > regulator for the vqmmc-supply to properly use ultra high-speed modes,
> > but &vreg_l13c_2p96 seems to be configured with 2.504V-2.960V at the
> > moment. On downstream it seems to be 1.8V-2.96V [2] (again, not sure if
> > this is the right file). I would recommend re-checking this too and
> > testing if UHS cards are detected correctly (if you have the board).
> 
> This is actually a good catch. I changed the voltage range to 1.8V-2.96V and
> now my card detects in UHS/SDR104 mode. Prior to this change it worked only
> in HS mode.
> 

Yay!

> > &vreg_l17a_2p96 has the same 2.504V-2.960V, but has 2.704V-2.960V
> > downstream [3]. This is close at least, might be fine as-is (but I'm not
> > convinced there is a good reason to differ there).
> >
> 
> Well, I believe that downstream configuration is more correct, but I
> can't prove it, so I'll leave it as is.
> 

Ack.

> Diff for additional changes looks like this:
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 6b08ce246b78c..b2a3496ff68ad 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -283,7 +283,7 @@ vreg_l12c_1p808: ldo12 {
>  
>                 vreg_l13c_2p96: ldo13 {
>                         regulator-name = "vreg_l13c_2p96";
> -                       regulator-min-microvolt = <2504000>;
> +                       regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <2960000>;
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>                 };
> @@ -386,8 +386,8 @@ &sdhc_2 {
>  
>         cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;
>         pinctrl-names = "default", "sleep";
> -       pinctrl-0 = <&sdc2_on>;
> -       pinctrl-1 = <&sdc2_off>;
> +       pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_on>;
> +       pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_off>;
>         vqmmc-supply = <&vreg_l13c_2p96>; /* IO line power */
>         vmmc-supply = <&vreg_l17a_2p96>;  /* Card power line */
>         bus-width = <4>;
> @@ -505,13 +505,6 @@ data-pins {
>                         bias-pull-up;           /* pull up */
>                         drive-strength = <16>;  /* 16 MA */
>                 };
> -
> -               sd-cd-pins {
> -                       pins = "gpio96";
> -                       function = "gpio";
> -                       bias-pull-up;           /* pull up */
> -                       drive-strength = <2>;   /* 2 MA */
> -               };
>         };
>  
>         sdc2_off: sdc2-off-state {
>         @@ -532,13 +525,6 @@ data-pins {
>                         bias-pull-up;           /* pull up */
>                         drive-strength = <2>;   /* 2 MA */
>                 };
> -
> -               sd-cd-pins {
> -                       pins = "gpio96";
> -                       function = "gpio";
> -                       bias-pull-up;           /* pull up */
> -                       drive-strength = <2>;   /* 2 MA */
> -               };
>         };
>  
>         usb2phy_ac_en1_default: usb2phy-ac-en1-default-state {
> @@ -604,3 +590,25 @@ phy-reset-pins {
>                 };
>         };
>  };
> +
> +&pmm8155au_1_gpios {
> +       pmm8155au_1_sdc2_on: pmm8155au_1-sdc2-on-state {
> +               sd-cd-pin {
> +                       pins = "gpio4";
> +                       function = "normal";
> +                       input-enable;
> +                       bias-pull-up;
> +                       power-source = <0>;
> +               };
> +       };
> +
> +       pmm8155au_1_sdc2_off: pmm8155au_1-sdc2-off-state {
> +               sd-cd-pin {
> +                       pins = "gpio4";
> +                       function = "normal";
> +                       input-enable;
> +                       bias-pull-up;
> +                       power-source = <0>;
> +               };
> +       };

Since the configuration is the same for both on and off state, you can
combine this into one node and then reference it twice. Also, the single
subnode should not be needed:

	pmm8155au_1_sdc2_cd: pmm8155au_1-sdc2-cd-state {
		pins = "gpio4";
		function = "normal";
		input-enable;
		bias-pull-up;
		power-source = <0>;
	};

&sdhc_2 {
	pinctrl-0 = <&sdc2_on &pmm8155au_1_sdc2_cd>;
	pinctrl-1 = <&sdc2_off &pmm8155au_1_sdc2_cd>;
};

Looks good to me otherwise, thanks for cleaning this up!

> 
> I am planning to send v2 tomorrow.
> 

Thanks!
Stephan

