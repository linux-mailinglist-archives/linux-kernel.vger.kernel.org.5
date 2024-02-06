Return-Path: <linux-kernel+bounces-54718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE0084B2D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528AEB22C35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0B12F361;
	Tue,  6 Feb 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LyN7n7NE"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F058101;
	Tue,  6 Feb 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216858; cv=none; b=H3dfP4Ifg9PIiDMUINGRcLUV/vW8LmMaVd3dGj3zkL1jLnGNSNFv3cIhMPeFJ0gyYOhsOZeCiEmRf+fSJ+Qm9q3R/57O2nKByrKgvrX3AFNlE9W8rRyMUrJN/4JWpWAKlwyGgYH09gC7IDEI58E1x3smD+TfzRdXMq6GOid3YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216858; c=relaxed/simple;
	bh=eq1o09ppvptz86ZQlz8Uakg295wPUJONuJsBuVt+BZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyuPkH8E4AL5mLUCPtUTdkzo+tqfG87otFc41vgGMccHhusTx4udx/okp+sRJHn7e58S0TCuZyRBZBcmrG7KdNKXX3x2OX0EzNqg5u8qomHsYcws/dlGczamTsb1muQr4/jaH3nNzddojN7Q8IBdKql9DmAj/GZHT8oce5c7b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LyN7n7NE; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=V3wgQJBc9TAh3reLgQ6RIEOzbkagE4Tp6ZGLh43fz6U=;
	b=LyN7n7NEMMssqA+dRI0WEKk4zAzHsgr8PLcQy3uS/K76QVnVfYge7BPUlbnrDa
	0sQJ1HAotgOXWtQYqorabPdbgwMmA0cjkqHvmI7CRgfkKb2Zz3o6avojh/75j6PM
	wvt7FjwRHoZSTSeY4fhsxe0fTRDKV4cfZMOa3naxxWlMk=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrADnbwmWD8Jln2UCAw--.35794S3;
	Tue, 06 Feb 2024 18:53:12 +0800 (CST)
Date: Tue, 6 Feb 2024 18:53:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8qm: add smmu stream id information
Message-ID: <ZcIPlp7BUxuo/ZeM@dragon>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240201-8qm_smmu-v2-4-3d12a80201a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-8qm_smmu-v2-4-3d12a80201a3@nxp.com>
X-CM-TRANSID:C1UQrADnbwmWD8Jln2UCAw--.35794S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKryfGFWfZw1rWw4fCrW5GFg_yoW8JF17pa
	s5Cr43tr4fWr17AryDXa4vkFZ8GanxuF4qgr17u3y8trnagFyYg3Z0gF1FkrWkWw4rW3yf
	J3Z5Jr13Z3WDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jajgxUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhh8ZVszYTEy1gAAsT

On Thu, Feb 01, 2024 at 03:22:44PM -0500, Frank Li wrote:
> Add smmu stream id information for fec and esdhc.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> index ec1639174e2e5..3cbc861400b43 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
> @@ -6,20 +6,26 @@
>  
>  &fec1 {
>  	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
> +	iommus = <&smmu 0x12 0x7f80>;
>  };
>  
>  &fec2 {
>  	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
> +	iommus = <&smmu 0x12 0x7f80>;
>  };
>  
>  &usdhc1 {
>  	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> +	iommus = <&smmu 0x11 0x7f80>;
>  };
>  
>  &usdhc2 {
>  	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> +	iommus = <&smmu 0x11 0x7f80>;
>  };
>  
>  &usdhc3 {
>  	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> +	iommus = <&smmu 0x11 0x7f80>;
>  };
> +

Dropped this whitespace and applied.

Shawn

> 
> -- 
> 2.34.1
> 


