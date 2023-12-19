Return-Path: <linux-kernel+bounces-5655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70F818DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF929B25DED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082AE23769;
	Tue, 19 Dec 2023 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLbcc1MT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9453174A;
	Tue, 19 Dec 2023 17:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C68C433C7;
	Tue, 19 Dec 2023 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703005891;
	bh=bHyMqohUpG3TgYf+LaLoP+IOoy7SIqBFB/tROxy5Kps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLbcc1MT8AkJroDXZHNVC4rIGmJ5mSwe4TcZTvDcLnGuJdXJlMnsMuA04rSDu7dvf
	 YNj4lHpGIiPutWsfmhil1SWrhHiQJh1n+oxjdc3R3LMlWF2KIRZrwCpaQS4zvWZyrJ
	 6F9eoKmpxdJG0/biI80m9+ZRCX6Z5wU1VMCLC58oB3yKmTM/X/ytcaBZDZK+pTB6nl
	 4rzbPrVGpRwpsBtQc3SKpnwp/cannJpbvkfpXF+mw7cI3mMJ75RFA/URo6o9c7rDSj
	 jMI+QbtdZQ32xr+m+gYn7m52lju/mjH0Y49L5lif1U7EFV8KntgnYEuJamTDDv6Nsv
	 PsqflFqVEM40A==
Date: Tue, 19 Dec 2023 11:11:29 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yassine Oudjana <yassine.oudjana@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Define UFS UniPro clock limits
Message-ID: <qjz546574l3jp6w7gza7kj43slwotitsrt3rodtp7g5lnqgbhf@2htxa5m4bvtw>
References: <20231218133917.78770-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218133917.78770-1-y.oudjana@protonmail.com>

On Mon, Dec 18, 2023 at 01:39:42PM +0000, Yassine Oudjana wrote:
> These limits were always defined as 0, but that didn't cause any issue
> since the driver had hardcoded limits. In commit b4e13e1ae95e ("scsi: ufs:
> qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES") the
> hardcoded limits were removed and the driver started reading them from DT,
> causing UFS to stop working on MSM8996. Add real UniPro clock limits to fix
> UFS.
> 

Such driver changes are not acceptable, as they break backwards
compatibility with existing DeviceTree.

Can you please try to fix the driver to handle this case?

After that is done, I'd be happy to take this patch.

Thanks,
Bjorn

> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 13667886f50a..4f9939b13c3c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2064,7 +2064,7 @@ ufshc: ufshc@624000 {
>  				<0 0>,
>  				<0 0>,
>  				<150000000 300000000>,
> -				<0 0>,
> +				<75000000 150000000>,
>  				<0 0>,
>  				<0 0>,
>  				<0 0>,
> -- 
> 2.43.0
> 
> 

