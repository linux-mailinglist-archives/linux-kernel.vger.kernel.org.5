Return-Path: <linux-kernel+bounces-152341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C48ABCA2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECBC4B20D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF43BB35;
	Sat, 20 Apr 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewurhUIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B72032C;
	Sat, 20 Apr 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713636311; cv=none; b=FoVY79iQ+UeOOn98DMibRJYG7Wa637d/0AWPDC7h3PjDcg0abFgPx6qn5vsEmqDXcq/ojFFhXbAL1qEOa39hFc0FWcdAZAJZNa5ZyKFetlY5gC6y42QfK4UtGeIjNU50peRrU6YWRVVNoNkKNmBrjQrO3WU2qxN11Cp4k5Ox3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713636311; c=relaxed/simple;
	bh=TuXNUH5RDD848QvCR30xBttt0uVqKcfNZhdQm68GaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpAamCwnATss6LGBidsyvDT8CT9EYgjr42krmFCf9ZDdDtFirXx/79TGm3IIDI8ceiJpnJ9/IcoHz5FWL7ZW295mXwBxzXNniormKnx0hfol0NTI2aaLW7G/Y69T/osN3Jkg8YOh8V49zedBiCPsLvTng7pWMQWLEHVTg/plLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewurhUIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83393C072AA;
	Sat, 20 Apr 2024 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713636310;
	bh=TuXNUH5RDD848QvCR30xBttt0uVqKcfNZhdQm68GaxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewurhUIj08jWGxmOx1xk5un6TOl0HZyo1j+ZYq/ro26Ch/IIXBEMLO0DhMT5cOgZn
	 Ta+XDnDiCfR0HlVATMtRvZP1JHulBYF412gm5eNmbew5eF6N2QGKMyjivyMVEs3Qcz
	 Ht8j95lqwffs7FtSa3fSndlZhJYWXugPjcApjrH9guFYPLTFB9oquBYi1lmYXx/2Ov
	 TqQSwQBZ/oZwE4421bBgZ2Ris1Cgluppr+3PdoAcAyB7OTBkoNdX1H1c37xCysWvjm
	 A2nzSPsWfXpLMPyFD/kjwMcPCZRQRAq8O9eowK9fbPkS9hqWe5RMiiRyLuvaMLOjht
	 m5Nyu3WIRFbkg==
Date: Sat, 20 Apr 2024 13:05:07 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: qcom: dispcc: fix DisplayPort link clocks
Message-ID: <jwjrnxboz2cdkkrufxhpvxhueqdvswil3ffn47wo4gwmt3r3tz@jm6cduxcd6my>
References: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>

On Mon, Apr 08, 2024 at 02:47:03PM +0300, Dmitry Baryshkov wrote:
> On several Qualcomm platforms DisplayPort link clocks used incorrect
> frequency tables. Drop frequency tables and use clk_byte2_ops instead of
> clk_rcg2_ops.
> 
> Note, this was tested on SM8450 only and then extended to other
> platforms.
> 

As Stephen points out, it seems from the commit messages that this just
cleans up the code because it's wrong. But both Luca and Neil points out
that it resolves a visible issue/error.

Can we please have this (the actual problem being resolved) captured in
the commit messages?

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (4):
>       clk: qcom: dispcc-sm8450: fix DisplayPort clocks
>       clk: qcom: dispcc-sm6350: fix DisplayPort clocks
>       clk: qcom: dispcc-sm8550: fix DisplayPort clocks
>       clk: qcom: dispcc-sm8650: fix DisplayPort clocks
> 
>  drivers/clk/qcom/dispcc-sm6350.c | 11 +----------
>  drivers/clk/qcom/dispcc-sm8450.c | 20 ++++----------------
>  drivers/clk/qcom/dispcc-sm8550.c | 20 ++++----------------
>  drivers/clk/qcom/dispcc-sm8650.c | 20 ++++----------------
>  4 files changed, 13 insertions(+), 58 deletions(-)
> ---
> base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> change-id: 20240408-dispcc-dp-clocks-5ee5d5926346
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

