Return-Path: <linux-kernel+bounces-161148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B08B47A4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DD2281E35
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32615686F;
	Sat, 27 Apr 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya0yYsUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940C152E12;
	Sat, 27 Apr 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714246471; cv=none; b=vFiIStbkS7Lbz7NBRHj/m346KAxtcRLPlVskY2RGL4Plek1Pfa+56IfrEidN/gchrTNi+wIWJbM1x7kDm2SzY9pYOOkrvZvrB/5z93oPIHnAJnR5SE6CR5LYtUZ8nu23cL3/bDB+S5K98m4B9PamB9VY6oEXZX0azULp8qPjs+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714246471; c=relaxed/simple;
	bh=GJ4yyoIu3opI0rlA1X1l+LfnVlSd9ux3Hwor0JDK1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQPgKjGobILU+nf3I/c7999mTLDudFvptK+eV/KaDn+q1S6ht1D+qvQhz1A1Gbu4NzMQDu40lToacJzwyfZqG/PzECO32Z2phHaTCvP2mxB7SFAgGUIBr8fA7JRaj7VHuuhd5t8zMtGFmp6vW3kqF6yNliakTtDkLOaDdOngOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya0yYsUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9A2C2BD11;
	Sat, 27 Apr 2024 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714246471;
	bh=GJ4yyoIu3opI0rlA1X1l+LfnVlSd9ux3Hwor0JDK1o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ya0yYsUy1tjzCbXgICmq3bcQ9drID+a1OodytNuZA0HtgbllaaR+XyYUUDGC2kmz2
	 rWQG7VZL4ZpcCENGSsQ/igYCD+fH45Yzt7c+nK8sIS1jAN5CdvJV2sciUCUoJZkk02
	 PQ0bXwqCzIjhm9njGhTukUMMVTvVM0yCt8nQILHgJEwZTzgGNO+rJUWWDn4c6d7Ljd
	 jV2eq1OUuwCrnKJJ6N7oq9aS6QFdFYUmVdyaIleGjTkZ0s6wjZryfa2m0FOwQ1g1j/
	 CRGiWr+OZB0Bm++henh0dDDmkwJTKsyGOLUaVlQJVCJW5vqhA+VApne9GdkxM2487y
	 x3VevWqMNHhAA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] clk: qcom: apss-ipq-pll: various cleanups
Date: Sat, 27 Apr 2024 14:34:20 -0500
Message-ID: <171424646118.1448451.7483099530340520123.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
References: <20240328-apss-ipq-pll-cleanup-v4-0-eddbf617f0c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Mar 2024 10:23:09 +0100, Gabor Juhos wrote:
> This series contains a few patches to perform some cleanup in the
> apss-ipq-pll driver.
> 
> The set is based on v6.9-rc1 and it depends on the following patches:
>   - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
>      Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
>   - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
>      Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com
> 
> [...]

Applied, thanks!

[1/5] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      commit: ac3ee364a7312517edf71b1857c0f272919f2374
[2/5] clk: qcom: apss-ipq-pll: move Huayra register map to 'clk_alpha_pll_regs'
      commit: 35a99c6ffa1e9bd8d31ddd3098e6fad7ba884928
[3/5] clk: qcom: apss-ipq-pll: constify match data structures
      commit: 07570342d305d90c1c5dba6d336fb4c8301aef45
[4/5] clk: qcom: apss-ipq-pll: constify clk_init_data structures
      commit: 4a941e436432104ce5ed75bf8c5ba2c8463b089c
[5/5] clk: qcom: clk-cbf-8996: use HUAYRA_APSS register map for cbf_pll
      commit: f3574392290d37647821d40f89136177b28e5f34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

