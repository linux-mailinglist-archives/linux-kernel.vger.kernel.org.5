Return-Path: <linux-kernel+bounces-13086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C651681FF84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046F11C215F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB16111BD;
	Fri, 29 Dec 2023 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtaRb/39"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1A111AB;
	Fri, 29 Dec 2023 12:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163AAC433C8;
	Fri, 29 Dec 2023 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703854512;
	bh=aTnhvu/a+fFNZukUNewDL5zHRCt6veGzDwTQmZE1yCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtaRb/390cdHST6fnrqYgXaUibt7YvkRfVDPi1Jp6sEFDB6QnIIbmHNeQF3Sawd76
	 Y5QQMZE6nFztN9CW1cQqLF4BPJg0SSfi2+uqcuixvn3mq0OdcBJN83w5z5gqgMELnm
	 aS/lHcZb8OBTcYVnpla+ghHCZXFO9AU6HcYRVKNmo25cYVuI1YTApav7yPIe9A94Eq
	 70SKjqSHOG4EIQ3FVvy0rMdv5P0zB8+qRKjpWRrrby+T5eLEwmChyKLRFFL4T3XbHp
	 mRn3+r3zDTFL3U9UaOtkgmOXRcM6YMozGywFDGEgpS5AOkP4LxgZEBCIJBIj+9Tb+Z
	 4i/9kVrbiBIEA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJCOG-0007ge-0r;
	Fri, 29 Dec 2023 13:55:05 +0100
Date: Fri, 29 Dec 2023 13:55:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp-crd: Add PCIe CLKREQ#
 sleep state
Message-ID: <ZY7BqLJZ0btpuL4b@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-3-13d12b1698ff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227-topic-8280_pcie_dts-v1-3-13d12b1698ff@linaro.org>

On Wed, Dec 27, 2023 at 11:28:28PM +0100, Konrad Dybcio wrote:
> The CLKREQ pin should not be muxed to its active function when the RC
> is asleep. 

You forgot to explain *why* you think this is needed.

Note that this is only appears to be done for one upstream Qualcomm SoC
(msm8996) currently, and that, notably, there is no driver support for
actually changing the pin state.

> Add the missing pin sleep states to resolve that.

> Fixes: d907fe5acbf1 ("arm64: dts: qcom: sc8280xp-crd: enable WiFi controller")
> Fixes: 17e2ccaf65d1 ("arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem")
> Fixes: 6a1ec5eca73c ("arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD")

So not sure these Fixes tags are warranted either.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 78 ++++++++++++++++++++-----------
>  1 file changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index ffc4406422ae..58c0c2d10cb3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -530,8 +530,9 @@ &pcie2a {
>  
>  	vddpe-3v3-supply = <&vreg_nvme>;
>  
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie2a_default>;
> +	pinctrl-0 = <&pcie2a_default>, <&pcie2a_clkreq_default>;
> +	pinctrl-1 = <&pcie2a_default>, <&pcie2a_clkreq_sleep>;
> +	pinctrl-names = "default", "sleep";

Johan

