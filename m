Return-Path: <linux-kernel+bounces-152626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF268AC1B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EDF1C2084D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50AE47A79;
	Sun, 21 Apr 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUDh8C37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E546BA6;
	Sun, 21 Apr 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738578; cv=none; b=ggAJFWAvoGYtSEjk/st7q6Des3w+D4BvUyBioswyGLBKyefKL3uP9imuHPugXKN8FZVdfuK1Pe1R/mIgVCjCSas9UK3Oc+pDenYQApZL+YL2W8SK3TN9+gIkbqIml/XgbFTMbZbjf7k8HHk3hcHgLXc0k6CLRGVGbHpGakmvozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738578; c=relaxed/simple;
	bh=PtClOLhWrT0at9+8rKDASrqhjdQHM+qJAfpiCXzllwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYWoPHBRHb1ZEU5sbyvo6Du20qgYHkjsay9bQzErngvMhP8DhtedPGasKHXJiFhKTTrGzqKIyV/nDDrnetF3BmYXbaRPY6bAN0XLxftZTbNJQY1LilTT/EJ3OgCarwFjbyox+oEje1sj/5xGOZSfDsoEjIm+bLtvo4foOrl6HAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUDh8C37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF92C4AF08;
	Sun, 21 Apr 2024 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738577;
	bh=PtClOLhWrT0at9+8rKDASrqhjdQHM+qJAfpiCXzllwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUDh8C37llJCe0N28rJTeLzyn//JumxP/ZFRPJXEO3SEyvBMX9rHnOsuHb0iOFjCg
	 ppY28q3h1WYuDdPEjpPTj0FfkQGE2rLABHpzfZEbExBG0KBezw7yjr8ew1FqY2vmth
	 N8WEjGrqZNhxYcWeD159YgDuVjq+XtGvlasAFS3fUW1J4Q2VvkhV1chYwC38y02AQw
	 V+Dz1XheTmPSAwQwzbAwuxL7jweWNm2xUrqcFKsxfUkQ81TpwtOAnnOJECpH4cSbmN
	 tTj44QCpo6/AyzBr3gupU3x2ExE7HxxokkHYu0KTNVhpO2wJnnE0Kczp34/u+LGljT
	 w6qKwtI+zrM2A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan R <quic_srichara@quicinc.com>,
	Kathiravan T <quic_kathirav@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: qcom: clk-alpha-pll: Stromer register cleanup
Date: Sun, 21 Apr 2024 17:29:11 -0500
Message-ID: <171373856766.1196479.16635456847362240117.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
References: <20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Mar 2024 19:45:18 +0100, Gabor Juhos wrote:
> This small set contains two patches which are intended to clean
> up the Stromer specific register offsets in 'clk_alpha_pll_regs'
> a bit.
> 
> Based on v6.8.
> 
> 
> [...]

Applied, thanks!

[1/2] clk: qcom: clk-alpha-pll: remove invalid Stromer register offset
      commit: 4f2bc4acbb1916b8cd2ce4bb3ba7b1cd7cb705fa
[2/2] clk: qcom: clk-alpha-pll: reorder Stromer register offsets
      commit: 8c48466cd7eda9afb37f26c8c9a68f39fae5ef32

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

