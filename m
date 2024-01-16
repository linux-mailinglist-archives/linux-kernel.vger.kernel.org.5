Return-Path: <linux-kernel+bounces-27292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE882ED67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3D1F24451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3471B7E0;
	Tue, 16 Jan 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAwZYrwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1C1AAC3;
	Tue, 16 Jan 2024 11:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5384DC433C7;
	Tue, 16 Jan 2024 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403355;
	bh=YbACdFqvmVRJpaWfnCDjyhC2A6BqnS3dIuKLeFyqFGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAwZYrwkYY9ZmHPTVRAAO/qmsAurhNdVcibidmDes1LNuZBm9UZk3PLTTXxSV0+LF
	 ggHbPTfgPuns4lytOy1shJLvxGBqqfD4azihxSlYWBy25NP+eMJsve9R52eMrbL70H
	 tpY5KCulQgdQDgk4WuC7TM+esP5VYgQzoh68x+UaS2ZjfBheRpn5OqO6gFxoOZ8jdk
	 mPZ4uSCFz4ZfxRQtVW/ypRelkGWZhePtMaTbUMCMhU9p2jkIIwUcLJ1KvwWGl0/cuD
	 s43KfgSMJAGjwHbGzyZK/HExeYurJf3peG8baBhDJjsnDEgxxHpQ0+yHumwqGsR69N
	 YOB025WN0Rk2A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rPhJm-0005dt-1F;
	Tue, 16 Jan 2024 12:09:18 +0100
Date: Tue, 16 Jan 2024 12:09:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 03/12] clk: qcom: gcc-sm6375: Unregister critical
 clocks
Message-ID: <ZaZj3tNzYf-1K_iN@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
 <20230717-topic-branch_aon_cleanup-v6-3-46d136a4e8d0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-3-46d136a4e8d0@linaro.org>

On Sat, Jan 13, 2024 at 03:50:52PM +0100, Konrad Dybcio wrote:

>  	/* Keep some clocks always-on */
> +	qcom_branch_set_clk_en(regmap, 0x17008); /* GCC_CAMERA_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x17004); /* GCC_VIDEO_AHB_CLK */

These two are not in sort order (haven't checked the rest of the
patches).

> +	qcom_branch_set_clk_en(regmap, 0x1700c); /* GCC_DISP_AHB_CLK */
>  	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
> -	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
>  	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_GPU_CFG_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x79004); /* GCC_SYS_NOC_CPUSS_AHB_CLK */

Johan

