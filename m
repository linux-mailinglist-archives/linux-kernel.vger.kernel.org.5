Return-Path: <linux-kernel+bounces-163276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C118B6816
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14430B22D60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC510A36;
	Tue, 30 Apr 2024 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ielezc6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635310799;
	Tue, 30 Apr 2024 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445606; cv=none; b=I5UnhZJ3f39hJF4s4OjtYQOM0pPfHSjoDg2u+ZSv5yWGah0eAwYqBjq3G4cL7TcXDFLFw8DodkY5s9oiAGkLjOGjmCQMne7Yud4CseJjRatN47jA5/LCrBaED8MaKje+A4T4xRFSON3hbbCjFAz7wEXoFHTGRvn/LzZhdrjCySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445606; c=relaxed/simple;
	bh=LkqUxMJI3hQBY2Q9vRftthMS6Eg5NaoMzQyUOIwrhYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBd/+81q3pHz6FfsYvaM6/BhKDd2VyoB+88zepAYNWFtQlSmQuyr/+LDsIBybe51abT/P2WQrb2KV7UlwYJ0Hztq6Gpt0UODttlWYrELDXNQ/idLZc0sdpaxdeAOf/HGyjpeAudYxBLVys7UQMUsbRv7tb+E45LDZiTOkuK8bG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ielezc6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128CDC116B1;
	Tue, 30 Apr 2024 02:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714445606;
	bh=LkqUxMJI3hQBY2Q9vRftthMS6Eg5NaoMzQyUOIwrhYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ielezc6mRJ+qBvuNkvcqe56A4U1h0nqbkw5Z6EAmADbrzdaIMyCBaFTu3N4OrrIsD
	 Jy4a7cHO/mF184X1ZNfoL6gjA0ooDStmGv+hOEcq5TvitFawC/CNYXpDS6N+eWaLTi
	 n5qbSB8trmbMeb4k3k5AKL4IZ1enSNv/bFfdbbJZAGzN2AhM3zy3rPcHmtS9rGDq1J
	 SHb2ci8vtBgFm39lCmrdxprFFlURlEZEvTjl1jo9kcuYNaxcoKl6C/lzSThK3aWtC5
	 ZsCkHWWlAXnJZ6sJUWpW12qrFLs+LK0nkubpMaIgryZxXGZmrLQvNrVp3pMrmRglcG
	 ZdGVMCutN0JEw==
Date: Mon, 29 Apr 2024 21:53:22 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sm8450: remove
 pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
Message-ID: <ugqukizt7eclhtgogizrzbxjie4s6x746voajn2ivxhtwid3tu@pzezgwy3jcsj>
References: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org>
 <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-1-868b15a17a45@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-1-868b15a17a45@linaro.org>

On Mon, Apr 22, 2024 at 06:16:18PM GMT, Neil Armstrong wrote:
> Remove the dummy pcie-1-phy-aux-clk clock and replace with the pcie1_phy
> provided QMP_PCIE_PHY_AUX_CLK.
> 

This looks applicable to the other two patches, but I don't see the
pcie-1-phy-aux-clk being removed in this patch.

Furthermore, the cover letter does not make it into the git history,
which results in rather lacking documentation on the reasoning for the
change.

Can you please update the three commit messages?

Regards,
Bjorn

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 616461fcbab9..71797f337d19 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -754,8 +754,8 @@ gcc: clock-controller@100000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
>  				 <&sleep_clk>,
>  				 <&pcie0_phy>,
> -				 <&pcie1_phy>,
> -				 <0>,
> +				 <&pcie1_phy QMP_PCIE_PIPE_CLK>,
> +				 <&pcie1_phy QMP_PCIE_PHY_AUX_CLK>,
>  				 <&ufs_mem_phy 0>,
>  				 <&ufs_mem_phy 1>,
>  				 <&ufs_mem_phy 2>,
> @@ -2000,8 +2000,8 @@ pcie1_phy: phy@1c0e000 {
>  				      "rchng",
>  				      "pipe";
>  
> -			clock-output-names = "pcie_1_pipe_clk";
> -			#clock-cells = <0>;
> +			clock-output-names = "pcie_1_pipe_clk", "pcie_1_phy_aux_clk";
> +			#clock-cells = <1>;
>  
>  			#phy-cells = <0>;
>  
> 
> -- 
> 2.34.1
> 

