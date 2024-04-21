Return-Path: <linux-kernel+bounces-152627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D88AC1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C3F1F20FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631EE482DA;
	Sun, 21 Apr 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cor4VFKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B6147A73;
	Sun, 21 Apr 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738578; cv=none; b=ch1xt222Ns3rBp9XFFQOOgmD6SxsZfpT5qpAJSa4zXxgiaNwHZ3QlWkXUSs26jtE2dHDxkgN14iYZHGYrBp0aLGmFc3kcvgOjWuUAwTmLbpnjz9BrKRhxpodYIkkC8g6BstgrTfwZY1IBOpiOhS5p0qsoAkeYAmhA8H45IEkPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738578; c=relaxed/simple;
	bh=96fq5ZTuawreZyoawKHbtliTFYzZv24f73guJfw2E14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvtgaxYfu6dzywfmkOj4iGWpg7pFv3ynj+Ia2FQx6+4YhXKs1zBMH1kzSODGY2UeqQhcBZ3hdLp87tGeaU6qwQSB/H255hASLb02GBXfMlhgTXqZSrBcsmQnUbDUIwVhUSaK2FphkIYEjXICQWwZNyb0WSSzO9BMyooFYJOS26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cor4VFKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ECAC32786;
	Sun, 21 Apr 2024 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738578;
	bh=96fq5ZTuawreZyoawKHbtliTFYzZv24f73guJfw2E14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cor4VFKm3u8zNlFQGLIxha1IdJhyRVDYVDfPV3NMcXLx75LL/HIlD5X96K8NEK8mY
	 P0SrRb5dM+K/xw8rwcU5xfdcEhu/U4dw1buXEJDqDYA/erPg50UytrE+tDn+F1lClp
	 saGWuP8Pawp8YKTe8qRhygN76E+bN8r1g9k2eaBuyBVTcjz5P9tTIsHtxos80sL47y
	 GUsnuD1VZnZwpXoJ+of+9ha3kCV+5gaKUgrI482c+fYq5YFolq2Cc/lDLJGTbzA5by
	 FZl97Ak+IouZntJcPg7ThQ/drR37R8BzM7Pkn2bG2DK2vHAbpuziuNlIWd4TBOZdiG
	 xt4MxO3H6rX0w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: fix kerneldoc of struct clk_alpha_pll
Date: Sun, 21 Apr 2024 17:29:12 -0500
Message-ID: <171373856770.1196479.1190859280862489443.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321-alpha-pll-kerneldoc-v1-1-0d76926b72c3@gmail.com>
References: <20240321-alpha-pll-kerneldoc-v1-1-0d76926b72c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 09:59:04 +0100, Gabor Juhos wrote:
> Add missing descriptions of the 'num_vco' and 'flags' members to
> clk_alpha_pll structure's documentation. Also reorder the member
> description entries to match the order of the declarations.
> 
> Eliminates the following warnings:
>   drivers/clk/qcom/clk-alpha-pll.h:72: info: Scanning doc for struct clk_alpha_pll
>   drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'num_vco' not described in 'clk_alpha_pll'
>   drivers/clk/qcom/clk-alpha-pll.h:91: warning: Function parameter or struct member 'flags' not described in 'clk_alpha_pll'
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: clk-alpha-pll: fix kerneldoc of struct clk_alpha_pll
      commit: 3b985489178cfb545118bd4dbefb6311f4bbfcf2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

