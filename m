Return-Path: <linux-kernel+bounces-22253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433A829B76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B481C222D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D625495C8;
	Wed, 10 Jan 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cjhvpNdh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6E482FC;
	Wed, 10 Jan 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CGipzwmsk8GGrGy6RS4n9wqxF3gERAs+e7hl4xmVs50=; b=cjhvpNdh1Pg3VHmHc52LlJgJA8
	T41y0J16B/PhSp3H41AjkCnUID81U4Y2z5zCoumWo0viiddBIRx/n7EbLVzpAByFgyBuEfNORpZBw
	lchEVuRgWavLTvX3Hrj7+OZx8uqSai+wvZFwK3JgW8dgboCuABfuMAeLoegLbw2qPDUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNYje-004vZF-Vd; Wed, 10 Jan 2024 14:35:10 +0100
Date: Wed, 10 Jan 2024 14:35:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_soni@quicinc.com, quic_pavir@quicinc.com,
	quic_souravp@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Message-ID: <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110112059.2498-4-quic_luoj@quicinc.com>

On Wed, Jan 10, 2024 at 07:20:56PM +0800, Luo Jie wrote:
> Add the MDIO device tree of ipq5332.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index bc89480820cb..e6c780e69d6e 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -214,6 +214,38 @@ serial_0_pins: serial0-state {
>  				drive-strength = <8>;
>  				bias-pull-up;
>  			};
> +
> +			mdio0_pins: mdio0-state {
> +				mux_0 {
> +					pins = "gpio25";
> +					function = "mdc0";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				mux_1 {
> +					pins = "gpio26";
> +					function = "mdio0";
> +					drive-strength = <8>;
> +					bias-pull-up;
> +				};
> +			};
> +
> +			mdio1_pins: mdio1-state {
> +				mux_0 {
> +					pins = "gpio27";
> +					function = "mdc1";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				mux_1 {
> +					pins = "gpio28";
> +					function = "mdio1";
> +					drive-strength = <8>;
> +					bias-pull-up;
> +				};

I don't know why i'm asking this, because i don't really expect a
usable answer. What sort of MUX is this? Should you be using one of
the muxes in drivers/net/mdio/mdio-mux-* or something similar?

    Andrew

