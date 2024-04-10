Return-Path: <linux-kernel+bounces-139327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564808A0174
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B5A1F21E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED46181CF8;
	Wed, 10 Apr 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="YO9MziK5";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="wwvRbXhR"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD546110;
	Wed, 10 Apr 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782162; cv=pass; b=uKJEdva/in5iTz2b5rMkoupJDIegAgPeDWlEeNCB/5KCIaxcke6zxhi4sut2+hW1580R3VmyxIJfdAlIEGIgZViXelOERJrZAwtrL0wTABg53kv+HFpIMNn8GCDwg107YUZhA3tzxEZ57MWqBoPrrSkd8B1pS5H73DFhlv4jNpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782162; c=relaxed/simple;
	bh=JXzrQDFJA0Gu3q5+SC+IUPYAr8WcoxjCQZzQ+7wZQBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcIeDtxzUz0SOAmX3TFK32xNQ6tec4RbYnHI9F8Mgksxlv/6c/xp4E2i5RR347s+X6in9yB+YL2CuAzpqSLJQaEd4nkq667Pd9ngJtGJImmW21GZ1QAGM8lC6NpvpMB9zpg39j7VESBbX+vE81JsHAMl/VF6E4gPRp3d5MEPmwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=YO9MziK5; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=wwvRbXhR; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1712781796; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VRrGJxDdjSj0eYQRxuN/VAe1NsDhyTIqNYIPVb/8hkcWZnYnwGxexZ0epk2mcy780f
    3SSJIC1UZjL3PqC3Nxr3kWSbHVtUk63Fr6r8g/6nk+5hKVoSm4pPkFl9AAPLPFc3K/r7
    HycRXYASZz12w0EZyed51RmjataQ/jdEUkOsDFG7DxmEZzLUjx3AA5jVjNpdLvZCokCm
    BX+yGmNRzqt2f68O8HhTCvYxXtDq1sATFkrLf8rERH5f+860VZRfrAhv7pqqs6wbtgLH
    6nTf65fCAJJRkwPq8t55nppe9d7umkx+OD4i+ftXUvDOcyKvUozwakZMzBa+ru7SZE5o
    3o1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712781796;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vpm3WBEjx8xKzxZVlVGQ1gTHDj3B3Wv4u8I0wkcfzI0=;
    b=gkZyG4G9JWypkieMj5V/t4+eo+llXYW4tvAiN7h7IPfgATixUO1RCxZVE+sYVt77Rn
    P6emEef6SGNpQ+EpdU6pFpvMN46B4el9N7kyqhPsNwBlWqfPhJXEAczpaf9+30tNdElB
    H1I4AiSrFSDVw0m8eHRBk9TTeCYRZqnROqi1SlqmndIF475ORk57b6oKD5bQVHWcbJts
    P3/8vD9xZFxg1Z7hnWFtFs/BwUnGin2DzAELJEoLFZuCQHgZ0h3Wylr4J7KlcV10dTVr
    OyOd0x9Y7RdgQ8qJEhQ1XFCrmrIbaYAX27BMPvn4riZmJn6SPhi4Ed7BjgcYYliYGKi+
    qVpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712781796;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vpm3WBEjx8xKzxZVlVGQ1gTHDj3B3Wv4u8I0wkcfzI0=;
    b=YO9MziK5sx06hRa5+VPky8b3qszJAGOvCRTCL5ckPLXoNzGda8jhI6mKbu6z37AkLi
    ZflMD+vD53oKx/eWWu0fo+1Wi0wgWoqwico9mT+CLw9+pNbZdd3QFLHtYSMqYgt8V85f
    1ISsBPxzrlcvvbFdWTxGhrQJHTgFidVcAwxd4Gu/y5+l5jQqOak1R0t9/b4u8Fg2uohh
    92TWRiUJNApWb5QD/diCoKjxPcsBCBgsBWzrjkAqW6gkQZKzGmGSj6RGlFKrCZoYGlVq
    kuji2HyeOuA3RxmWyGm49H5LsZyNaO0KXeUn6dFCrJLoXqepooHRHJ3k+jQsgNkw3xWz
    xnFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712781796;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Vpm3WBEjx8xKzxZVlVGQ1gTHDj3B3Wv4u8I0wkcfzI0=;
    b=wwvRbXhRIDqEqW6toXziGAqzIQ4rCOEOHiAbzLbwttV82qUpiQZxaYJYlrCck2s9dx
    sDgfOmoTcDnjSPSTF+AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8pqN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id Raf12503AKhFYPX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Apr 2024 22:43:15 +0200 (CEST)
Date: Wed, 10 Apr 2024 22:43:10 +0200
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
Message-ID: <Zhb53i8-pJhDMVZM@gerhold.net>
References: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134022.732767-1-volodymyr_babchuk@epam.com>
Content-Transfer-Encoding: 7bit

On Wed, Apr 10, 2024 at 01:41:30PM +0000, Volodymyr Babchuk wrote:
> Card Detect pin for SHDC2 on SA8155P-ADP is connected to GPIO4 of
> PMM8155AU_1, not to internal TLMM. This change fixes two issues at
> once: not working ethernet (because GPIO4 is used for MAC TX) and SD
> detection.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 5e4287f8c8cd1..6b08ce246b78c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -384,7 +384,7 @@ &remoteproc_cdsp {
>  &sdhc_2 {
>  	status = "okay";
>  
> -	cd-gpios = <&tlmm 4 GPIO_ACTIVE_LOW>;
> +	cd-gpios = <&pmm8155au_1_gpios 4 GPIO_ACTIVE_LOW>;

Good catch!

>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&sdc2_on>;
>  	pinctrl-1 = <&sdc2_off>;

These two pinctrl configure "gpio96" for "sd-cd-pins". Yet another wrong
GPIO? Should probably drop that and add proper pinctrl for the actual
GPIO in the PMIC. Seems like Qualcomm configured the PMIC GPIO with
pull-up downstream [1] (not sure if this is the right file). It might be
redundant if there is an external pull-up on the board, but only the
schematic could tell that for sure.

FWIW: Looking closer at the broken commit, the regulator voltage setup
of &sdhc_2 looks suspicious too. Typically one would want a 1.8V capable
regulator for the vqmmc-supply to properly use ultra high-speed modes,
but &vreg_l13c_2p96 seems to be configured with 2.504V-2.960V at the
moment. On downstream it seems to be 1.8V-2.96V [2] (again, not sure if
this is the right file). I would recommend re-checking this too and
testing if UHS cards are detected correctly (if you have the board).

&vreg_l17a_2p96 has the same 2.504V-2.960V, but has 2.704V-2.960V
downstream [3]. This is close at least, might be fine as-is (but I'm not
convinced there is a good reason to differ there).

Thanks,
Stephan

[1]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/484af352989c912db8f3b6393fc090006029066f/arch/arm64/boot/dts/qcom/sa8155-pmic-overlay.dtsi#L206-214
[2]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/484af352989c912db8f3b6393fc090006029066f/arch/arm64/boot/dts/qcom/sa8155-regulator.dtsi#L635-642
[3]: https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/484af352989c912db8f3b6393fc090006029066f/arch/arm64/boot/dts/qcom/sa8155-regulator.dtsi#L363-370

