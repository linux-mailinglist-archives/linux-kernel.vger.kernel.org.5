Return-Path: <linux-kernel+bounces-2756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25A816161
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFCB1C2099F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C89546B90;
	Sun, 17 Dec 2023 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/3XyNUe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1B1DFE9;
	Sun, 17 Dec 2023 17:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E9C433C7;
	Sun, 17 Dec 2023 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702835181;
	bh=S/2wAk1uCnOrAZbHHoeWhyhqfRpMSGqjU1MgyCkHfn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/3XyNUemtrxcr04kVm14K9CEPkkW/5XjD5/StgY3JCuljo8SyOcBsS8iWdd4O45G
	 JeF59Dyw1wGTefssDgrkIYcSz36xWIXYTPvXAhFdYUHmCBd7K2cVDofv4JaFZba9g8
	 EZO/lItWezlk1xHdvHBeTG2DjATeEdXGGkx23pHFhXkdAESgdzVO/QDXZp/oNuf7/M
	 ePLwkqrW6fgWdlLl3Hh8/kIV03rQtkoJFOLS1mlQipqBV2PGLblE5AQfPWx8bauqdy
	 RFoPRlbnO82XT8ET61ZBhKQ5G0kP2BVpoHKGJFNtXL41ZMLc6Exll6iZE/RD1QDnC2
	 6/jdP0nwH/wjg==
Date: Sun, 17 Dec 2023 11:46:17 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	cros-qcom-dts-watchers@chromium.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] media: venus: core: Set up secure memory ranges
 for SC7280
Message-ID: <cfdrv7mf24lm7tfcnlqkjeu3zyzzdphdgvvob2uhysiyofckn4@dz6q3xvydboc>
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
 <20231201-sc7280-venus-pas-v3-1-bc132dc5fc30@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-sc7280-venus-pas-v3-1-bc132dc5fc30@fairphone.com>

On Fri, Dec 01, 2023 at 10:33:18AM +0100, Luca Weiss wrote:
> Not all SC7280 devices ship with ChromeOS firmware. Other devices need
> PAS for image authentication. That requires the predefined virtual
> address ranges to be passed via scm calls. Define them to enable Venus
> on non-CrOS SC7280 devices.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Mauro, this series looks ready to be picked up. Can you please merge
this driver patch, so I can pick the two dts changes?

Thanks,
Bjorn

> ---
>  drivers/media/platform/qcom/venus/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 9cffe975581b..a712dd4f02a5 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -881,6 +881,10 @@ static const struct venus_resources sc7280_res = {
>  	.vmem_size = 0,
>  	.vmem_addr = 0,
>  	.dma_mask = 0xe0000000 - 1,
> +	.cp_start = 0,
> +	.cp_size = 0x25800000,
> +	.cp_nonpixel_start = 0x1000000,
> +	.cp_nonpixel_size = 0x24800000,
>  	.fwname = "qcom/vpu-2.0/venus.mbn",
>  };
>  
> 
> -- 
> 2.43.0
> 

