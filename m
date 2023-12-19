Return-Path: <linux-kernel+bounces-5693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52676818E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854F01C20AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1931A61;
	Tue, 19 Dec 2023 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlliHq00"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BD23769;
	Tue, 19 Dec 2023 17:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C040C433C7;
	Tue, 19 Dec 2023 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703006919;
	bh=8TuU0oe0LbO+acqN+pqnfCG+NSaucnfshHhar0JIOlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlliHq005okAcoPftMRNYs7+HDEfWUQB6Ki7sjre9//dE4orsrQOQOpYRBQJgMH8d
	 t/rRSkDxSPQ2ATisRO9PDYY76kL3nI3bXULxn+RW9gHwrh5vwaewAEcAQF2j4QWESh
	 lYN/AkcXsjq340ktSqERNzkXkEZ3jqRNnWoGuVo3WFLBDVI9LT8A5xw8tncBVuC9zt
	 ktag4TofaTonJTaW7gcyKJHE5iAjIjCPxM6IWa4FssxWVCmyhp5Wz5gTkrwd4+Q2+Z
	 3ZbDkI41klXgef4R//mZh+gJFExWYnaf2NHYcGTBZFFN+rxn+FqWX775x/Bj8b/QuU
	 olbSKccRN0PJg==
Date: Tue, 19 Dec 2023 11:28:35 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/12] interconnect: qcom: sm8550: Enable sync_state
Message-ID: <eh6loxqxvkhdqh3lbn5holqotm6jrnwp6l3by44bes3ddtt2aj@h7sdrgue3hnw>
References: <20231218-topic-8550_fixes-v1-0-ce1272d77540@linaro.org>
 <20231218-topic-8550_fixes-v1-2-ce1272d77540@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-topic-8550_fixes-v1-2-ce1272d77540@linaro.org>

On Mon, Dec 18, 2023 at 05:02:03PM +0100, Konrad Dybcio wrote:
> To ensure the interconnect votes are actually meaningful and in order to
> prevent holding all buses at FMAX, introduce the sync state callback.
> 
> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/interconnect/qcom/sm8550.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
> index abc52ad3d1f2..4d0e6fa9e003 100644
> --- a/drivers/interconnect/qcom/sm8550.c
> +++ b/drivers/interconnect/qcom/sm8550.c
> @@ -1649,6 +1649,7 @@ static struct platform_driver qnoc_driver = {
>  	.driver = {
>  		.name = "qnoc-sm8550",
>  		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>  	},
>  };
>  
> 
> -- 
> 2.43.0
> 

