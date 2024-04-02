Return-Path: <linux-kernel+bounces-127552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D1894D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD63F1C20E88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EA4F217;
	Tue,  2 Apr 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="MPya0UeM"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD31E4A1;
	Tue,  2 Apr 2024 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046716; cv=none; b=jDtKWGEz1l7/oljiECPKeCTz05p0t3yIVOx1ihepnV7gu+uiHRt6Agyr/jxkSchRxqHODJP9Gmox+UVa7ZoqcLi+wJS9Nkk5aWSnk8ywnWGLLHmNTZjQP2gbpYp9TmNSbo/0gNWSChhHMnmANHRuEzM7rkGV++7W5d3PbJ9t0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046716; c=relaxed/simple;
	bh=Z/qLSoyxcqYY45vOcGBrjpYcFtcLiSmPOnablfSkfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4nFl0wJ7nackUfbxWllGcq+NOECgaj9sYJ9NggUplbGDmy4GN+IsWSe/ceg8h5WBOg6y02fOAS13Jc6zA0yEGk8IL+hCATaQD3e7o8OC40f/VaW9Y3hdd+ZVpTAllsQ96XAG5Jn/BJHLIFJmp9YPm02Zyp4tJfbrcVCiIypYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=MPya0UeM; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=apDFZqziJ/YmD7Ot7Oe3WRkx6S7TtVnUEW5HigajFNQ=;
	b=MPya0UeM93328C53lUb1OqxrBn1MIbsPSHF2ROH7rduicC9q5sWhS3XxMlyaRg
	SYc71SweFvwm6blXbyMfulQq1QJqg3Vlly6w8VKH06Lq4WvbcR3Zi4M2sckJ7Vgn
	algtmVHN6I+ViYDjDlS8LcAQlGXAUR9MWLOA3KxUyg/6s=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrAAnjxhOwgtmy4WnAg--.42039S3;
	Tue, 02 Apr 2024 16:31:12 +0800 (CST)
Date: Tue, 2 Apr 2024 16:31:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, peter.chen@kernel.org,
	jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/11] arm64: dts: imx8ulp: add usb nodes
Message-ID: <ZgvCTgB4lp0F83Kn@dragon>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
 <20240321081439.541799-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321081439.541799-2-xu.yang_2@nxp.com>
X-CM-TRANSID:C1UQrAAnjxhOwgtmy4WnAg--.42039S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1kArWrtFy8JFWfJr1kKrg_yoW5CF1rp3
	4DGFZ5Wr48ur17KFWYvF1qkF95JayrCF95ZF1ay3y8tr9F934Ut340q3ZYgr15Zr4xZw4a
	qFn3WF1fKF1qvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrhL8UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRG0ZV6NnBkz1gAAsm

On Thu, Mar 21, 2024 at 04:14:30PM +0800, Xu Yang wrote:
> Add USB nodes on i.MX8ULP platform which has 2 USB controllers.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - no changes
> Changes in v3:
>  - no changes
> Changes in v4:
>  - no changes
> Changes in v5:
>  - no changes
> Changes in v6:
>  - drop usbphy aliases
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> Changes in v9:
>  - no changes
> Changes in v10:
>  - no changes
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index c4a0082f30d3..7da9461a5745 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -472,6 +472,68 @@ usdhc2: mmc@298f0000 {
>  				status = "disabled";
>  			};
>  
> +			usbotg1: usb@29900000 {
> +				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
> +				reg = <0x29900000 0x200>;
> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_USB0>;
> +				power-domains = <&scmi_devpd IMX8ULP_PD_USB0>;
> +				phys = <&usbphy1>;
> +				fsl,usbmisc = <&usbmisc1 0>;
> +				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x8>;
> +				rx-burst-size-dword = <0x8>;
> +				status = "disabled";
> +			};
> +
> +			usbmisc1: usbmisc@29900200 {
> +				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
> +						"fsl,imx6q-usbmisc";
> +				#index-cells = <1>;
> +				reg = <0x29900200 0x200>;

Could you move 'reg' above so that it's after compatible?

> +				status = "disabled";
> +			};
> +
> +			usbphy1: usb-phy@29910000 {
> +				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
> +				reg = <0x29910000 0x10000>;
> +				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_USB0_PHY>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			usbotg2: usb@29920000 {
> +				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
> +				reg = <0x29920000 0x200>;
> +				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_USB1>;
> +				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
> +				phys = <&usbphy2>;
> +				fsl,usbmisc = <&usbmisc2 0>;
> +				ahb-burst-config = <0x0>;
> +				tx-burst-size-dword = <0x8>;
> +				rx-burst-size-dword = <0x8>;
> +				status = "disabled";
> +			};
> +
> +			usbmisc2: usbmisc@29920200 {
> +				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
> +						"fsl,imx6q-usbmisc";
> +				#index-cells = <1>;
> +				reg = <0x29920200 0x200>;

Ditto

Shawn

> +				status = "disabled";
> +			};
> +
> +			usbphy2: usb-phy@29930000 {
> +				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
> +				reg = <0x29930000 0x10000>;
> +				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pcc4 IMX8ULP_CLK_USB1_PHY>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
> +
>  			fec: ethernet@29950000 {
>  				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
>  				reg = <0x29950000 0x10000>;
> -- 
> 2.34.1
> 


