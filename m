Return-Path: <linux-kernel+bounces-3966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0A8175FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAE5281777
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AB42385;
	Mon, 18 Dec 2023 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWWjVbuq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2E7204B;
	Mon, 18 Dec 2023 15:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4953C433C7;
	Mon, 18 Dec 2023 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702914047;
	bh=kP0KzVP+wAVZYX6I0sfa2j1A+ARxXj0gJm7BlfSRTYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWWjVbuqzUtxKAYbEAcR07YOT+nimr5ntwxRnJE7ByDm2DYEFtTAxVfiYM5c/iAMq
	 BdcywG+sg6Y6ZTe8SS4kY2ssI+yRjD7zCPQkFnJtEu2gXW3kT9/a/WbXI7Ev7czum/
	 /wHEJDAospKTTWePuw3/uxxHStZrIJl7Il3R6hl2D0396o51bXcwOO4Xww6VAHl1ev
	 LNjmVfYAwKrKTlccnjOvbfy3iQlXYbeBPSyO40yWN525mpI1pJzLyA7aA4OC8ITiIA
	 /S0alap2P4PZF8E59YQWf+ziPbkF8peY9P/lLNt4OGU+rgNV5Okk6UpAkRlpOGuoAo
	 rFM7qfH1ZKwWA==
Date: Mon, 18 Dec 2023 21:10:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
Message-ID: <20231218154032.GA50521@thinkpad>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
 <20231213173131.29436-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213173131.29436-2-johan+linaro@kernel.org>

On Wed, Dec 13, 2023 at 06:31:29PM +0100, Johan Hovold wrote:
> The Qualcomm PDC interrupt controller binding expects two cells in
> interrupt specifiers.
> 
> Fixes: 9d038b2e62de ("ARM: dts: qcom: Add SDX55 platform and MTP board support")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> index e30dbf12990a..0864c99a3da1 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> @@ -612,7 +612,7 @@ pdc: interrupt-controller@b210000 {
>  			compatible = "qcom,sdx55-pdc", "qcom,pdc";
>  			reg = <0x0b210000 0x30000>;
>  			qcom,pdc-ranges = <0 179 52>;
> -			#interrupt-cells = <3>;
> +			#interrupt-cells = <2>;
>  			interrupt-parent = <&intc>;
>  			interrupt-controller;
>  		};
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

