Return-Path: <linux-kernel+bounces-91294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88341870C64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5341F27101
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C27BAFF;
	Mon,  4 Mar 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFCi8Uyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218847B3D8;
	Mon,  4 Mar 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587433; cv=none; b=RggLz8dq4j8+0APcPp8H6iE/r7kOxW8Vkgz7Hh6tbQoOFzJI/N1dhO36eayBzWb2IpZahV0N4FK8FY8irL6T87JXAQeyUIC73XS74MGZ9P7EDTROUOgbHXw5DpmzutyZFjfXoIOf7i6vK30QT9yW2ygVwoFcjOgmlz79vCmAB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587433; c=relaxed/simple;
	bh=e+uhzj7/3Eqd4IkhPoYoWucFlfHs3vnWKJTKRl5RYXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hofzegWs6EiTy/i2BGOcHJ+VJ7CR+5j3IqgpIfgLr8ZOzO+pPlpyZ2TZZ0hURWCo+Pa8S8EcU0CRkpGnzN462XGkFVLSpcJ7QOWRyFYeH9++Au2IJp+d/n+LslSVTC/1RNrC1mXSd4jhY949pKOh75w/Pt8I/9pMYOZ6KpQxdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFCi8Uyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE122C433C7;
	Mon,  4 Mar 2024 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587432;
	bh=e+uhzj7/3Eqd4IkhPoYoWucFlfHs3vnWKJTKRl5RYXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFCi8UyqPru8S/DhqhLeppvJk3knxbvrPge0G6ij3xTI1DN6vCLriJE3LOOFg99jF
	 GgBqdv2HvcdYrL/1OmOoIlBFXmW6qqHibTvzU3Wct0ilfQAXOZW5v9yf+L5gZO/dGd
	 v18ycJ1WnvoZYd2B4UBZBm38OBsFkHlT+odsK/hTJl2T4Py+LGrN4i1DBVkwHXXnnI
	 EbA4xS8DUzPTVjU6pd62zkJ+GXtELWxkH27flXxVYBK76IuSYFxGf21Dbg0XrRJx8R
	 9MfU4Lu+wTIbr0T4KSt87vXoAp0MnQ1yPDQR4N98PfNFNMZ7Rt/fXuXp/py2I8W8b9
	 Vbacmpgrf02IQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: qcom: gcc-ipq5018: fix some register offsets
Date: Mon,  4 Mar 2024 13:28:41 -0800
Message-ID: <170958768039.1828118.10538816942556893478.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 25 Feb 2024 18:32:53 +0100, Gabor Juhos wrote:
> The purpose of this small series is to fix some, presumably wrong
> register offsets in the 'gcc-ipq5018' driver.
> 
> The patches are based on v6.8-rc5.
> 
> 

Applied, thanks!

[1/3] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
      commit: f982adcc1b1c02a3114f68ac73c811cbfabe90fa
[2/3] clk: qcom: gcc-ipq5018: fix 'halt_reg' offset of 'gcc_pcie1_pipe_clk'
      commit: 11b752ac5a07cbfd95592fac5237a02f45662926
[3/3] clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset
      commit: 7d474b43087aa356d714d39870c90d77fc6f1186

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

