Return-Path: <linux-kernel+bounces-2086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750C8157AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72B81F25E09
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186B134D3;
	Sat, 16 Dec 2023 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsIIViTQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6D134A0;
	Sat, 16 Dec 2023 05:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5556CC433C7;
	Sat, 16 Dec 2023 05:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702703484;
	bh=nrLNbAsUZT8Uv50zbveLnUslPF3P+bLBh/z97ozm5N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsIIViTQ5dWEj8H/9CrZbwpUGxXN0uSAQfdTCm4Ggvse9FMGY+AqJFAy4UC9YaiWc
	 uzlV1IXRl1OpD9IdOXVVIYR92jDazp3AEC5ZZ6KXd2/+lz5h0Zdc8Ie9kpKwIOy3T7
	 Z6UGSYVqnmvyqqdfuUmuu36AIBc5Ri1m+p2Yrz2b+qykOfSjvVKpRwBxl4uwOETwOP
	 XgXheK5NkJxVLHOXX9fhkTZETBZiFIFJDQZTAagRie74f9BKxf9yCmsCxAGZyBVYt0
	 aPgAXT3hiCwbvb3SOK0BIkMasor7AWKsCY4d0/xukkeQjwNxa4eiLyOBmv3vBqo/CX
	 rGeOV6TSIld4A==
Date: Fri, 15 Dec 2023 23:11:22 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable GPU clock controller for
 SM8[45]50
Message-ID: <5kkk7j6425wshf2bmmhrh26jwc3rstcrm6kgxyyzowq2qqrfw2@u2mgm6qefxvk>
References: <20231204-topic-sm8x50-upstream-gpucc-defconfig-v1-1-e615df0c4af9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204-topic-sm8x50-upstream-gpucc-defconfig-v1-1-e615df0c4af9@linaro.org>

On Mon, Dec 04, 2023 at 02:01:47PM +0100, Neil Armstrong wrote:
> Enable GPU Clock Controller for SM8450 and SM8550 to allow using
> Adreno GPU on these SoCs.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5ad2b841aafc..56aebbdcdd40 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1266,6 +1266,8 @@ CONFIG_SM_TCSRCC_8550=y
>  CONFIG_SM_GPUCC_6115=m
>  CONFIG_SM_GPUCC_8150=y
>  CONFIG_SM_GPUCC_8250=y
> +CONFIG_SM_GPUCC_8450=y
> +CONFIG_SM_GPUCC_8550=y

I don't think these needs to be builtin, and if they do I'd like to see
the reason captured in the commit message.

Regards,
Bjorn

>  CONFIG_SM_VIDEOCC_8250=y
>  CONFIG_QCOM_HFPLL=y
>  CONFIG_CLK_GFM_LPASS_SM8250=m
> 
> ---
> base-commit: 9046d05c6ad632a271fc4173624e26f396975a80
> change-id: 20231204-topic-sm8x50-upstream-gpucc-defconfig-3e3dc264be08
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

