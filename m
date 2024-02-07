Return-Path: <linux-kernel+bounces-55945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E595C84C3E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25F328AEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543F12E7F;
	Wed,  7 Feb 2024 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU5sLBPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BF12E5D;
	Wed,  7 Feb 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281217; cv=none; b=ZkFSDGfvJaD2eKUwbapPlP9CMppNUiuVtj+D4vMNTEdBWhW0SMh6oWMYEmjzb+aLgjHqAEx3uMKGnowinmqC38PqeErSA+2aZTfzmlikqbMFYcdg0y6J58wOshHvl6oqFsis1t7Yknyqy/+iVhnjsIAboMEY6lXfuloH9DtCMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281217; c=relaxed/simple;
	bh=CP5ohI1fd60+unOrz5KQxM3NupdVu/QZC8pQFKfOZCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D85x8XAByNpcc2jRz8azD4022Owexh3A3CpVFX4BKtmOGn3jYl+MzcJ9aQQUZqcw6Hz9nG4ScBmSaFNQY2fIuWWGwUPbJKCBcQB+QxqWofBz4FXNMpGozEdIpTBjt3tqfyCIuWzC8u3I+urA/meRNfKWrIaozZ4YIvbz3hBxYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU5sLBPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC12C43390;
	Wed,  7 Feb 2024 04:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281217;
	bh=CP5ohI1fd60+unOrz5KQxM3NupdVu/QZC8pQFKfOZCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YU5sLBPblyz/cK3syEFzJKebd1aWL0e2UOlIk9doTwgwb9oAZHR23WyXbAB+dnrKY
	 lyqTcqffmLHlaRPd7855ohs5syYkzhJh63fULi0e6V0CbOsXsgpO3drAKeyZhHdCmF
	 lhWvq1s/zkmcbu87GFs2Dms+X9gnRfTF58EJwGItcVctG3wZP+Dirmw/z1OSAhjo0n
	 qaPJVQfBvqwKsH86eUMJCe7co9sK+kCGKON0dwd+HzjB31lZT80GmlAw0fFj3v+XbZ
	 f0kS8MzVpZ3ZwxBjnFnq/9jU363TDKPjl7xAK3rVxR7KHBHQZbl1w0C0TF/5yMAih6
	 NL7750de49Lhg==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 00/18] Qualcomm GCC/VIDEOCC reset overhaul for Venus
Date: Tue,  6 Feb 2024 22:46:20 -0600
Message-ID: <170728117670.479358.17590271434964788867.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
References: <20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Feb 2024 19:43:33 +0100, Konrad Dybcio wrote:
> Some resets associated with venus require a larger delay for the hardware
> on the other end to function properly. These seem to fall into three
> categories:
> 
> - 150us for 8250 and earlier
> - 400us for 8350 and friends
> - 1000us for >=8450
> 
> [...]

Applied, thanks!

[01/18] clk: qcom: reset: Increase max reset delay
        commit: 316861f383176c6360dcffecceb1f843d860faf0
[02/18] clk: qcom: reset: Commonize the de/assert functions
        commit: eda40d9c583e95e0b6ac69d2950eec10f802e0e8
[03/18] clk: qcom: reset: Ensure write completion on reset de/assertion
        commit: 1bd8c3ad02b1aaa9163a72fece2c28360a52b345
[04/18] clk: qcom: gcc-sa8775p: Set delay for Venus CLK resets
        commit: 6c0530974183709e74c3e809d4f0df386a23465b
[05/18] clk: qcom: gcc-sc8180x: Set delay for Venus CLK resets
        commit: 627fcb22966d9e7dcfcc040f3895e5da7f64fb9c
[06/18] clk: qcom: gcc-sc8280xp: Set delay for Venus CLK resets
        commit: 446b8e191072b78de4af16f5288dcdbfbda78dd1
[07/18] clk: qcom: gcc-sm4450: Set delay for Venus CLK resets
        commit: eff85a0f548e536563d57d42bdd6c215031e8c84
[08/18] clk: qcom: gcc-sm7150: Set delay for Venus CLK resets
        commit: b8b2343112083f76a4183aa2acdfe861dcc1bb6b
[09/18] clk: qcom: gcc-sm8250: Set delay for Venus CLK resets
        commit: 2013a0bca5679dab16fc0f4b7dde4cf8b15b7621
[10/18] clk: qcom: gcc-sm8350: Set delay for Venus CLK resets
        commit: cecdccc3e50924a09411f8f9af760f4d1ef8b5c6
[11/18] clk: qcom: gcc-sm8450: Set delay for Venus CLK resets
        commit: 6ad1da7c0f2317ceffdfe50ac913b6123cd6ff71
[12/18] clk: qcom: gcc-sm8550: Set delay for Venus CLK resets
        commit: d64c6880c44e3a6d52b97dda1082c17317c82c74
[13/18] clk: qcom: gcc-sm8650: Set delay for Venus CLK resets
        commit: 6efbf3e21211ece0b49bb75499398f9f08fb9cd6
[14/18] clk: qcom: videocc-sm8150: Set delay for Venus CLK resets
        commit: 23fd517957693846ed279cb86f30f548aed01fda
[15/18] clk: qcom: videocc-sm8250: Set delay for Venus CLK resets
        commit: 726184dd7b2f7c41a7007a1c1add301ddf173cf2
[16/18] clk: qcom: videocc-sm8350: Set delay for Venus CLK resets
        commit: b68d14f84c2c179d0f56588bda2e3a2675dd6d28
[17/18] clk: qcom: videocc-sm8450: Set delay for Venus CLK resets
        commit: ed17763a24f22d04e8da104715eb48ba69989dfa
[18/18] clk: qcom: videocc-sm8550: Set delay for Venus CLK resets
        commit: ba4354f6ae160609aea8f7adec22ce1a9d0f586a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

