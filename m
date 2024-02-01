Return-Path: <linux-kernel+bounces-48901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5A3846304
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD00B27FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CC46B9B;
	Thu,  1 Feb 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erXDY+/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555EA4644C;
	Thu,  1 Feb 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824442; cv=none; b=npG02KNltm4VCj5gp5VHGc3EpUp7CHwwbcOdQ4kZsLe/2mxgMMoR9N+OaXhTtC6VM0mB97xYM0NZqoQyAIwsoocOQxPpJp1pXjsYGl7miFFGwFKFywzyJQwkutFl1bT/e4rWuTK9PIweSOVIh/CXVLCmi5Ee670UpPZfka07iKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824442; c=relaxed/simple;
	bh=6HuV3IIZv6Gf48oHjnacch7E8ba8dfFz7iHDkHJ9gJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDrDJnAghmbXdTZy87VGZsgzTk9aoUhzyZ25GUHDJXviFznUjL7m/f2B59iCCwB2tkTBR+ZwBdvLD1ozCw/DwEp7BPZsTYjcJsBF25BHyitbdU4JYEK82MjvWOunmYiXgiZo5CO86zD82H0l+MJ6h9UKaRS682tZbKi4U2J1Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erXDY+/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46DFC43390;
	Thu,  1 Feb 2024 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824442;
	bh=6HuV3IIZv6Gf48oHjnacch7E8ba8dfFz7iHDkHJ9gJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erXDY+/Bb93G2WJSSqUUkhCiY/ubBVOs8IA8L4TUx2CHlO8Syb1DeHTebG66YUdxO
	 REQb3miA8wyyztzLNnF3q144P+9BMBH8lRYVC++miKROrpJvwcWPorNv3/KJVcHEbr
	 jPrZ3QwKqG1bD56dj6pc9x7udg0/kLuZguSBjM07O5z7ywb3L88N6hi/33ynFulnDo
	 HXWz0mEGnd73ychg51zppt/MfQhq9Z5fph5Ew01A6ZnmaoJN5Tc9kjnsBUO1Kzl/2+
	 YPvDOywCGK5b0qS+GqxKEu8itj3BabKtNmblp+EhuEkMNOjJOHW23GImV+bl96zth/
	 SxhrparPbyZWg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: (subset) [PATCH v4 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Date: Thu,  1 Feb 2024 15:53:51 -0600
Message-ID: <170682442869.248329.14691453184149397609.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 13:05:06 -0800, Bjorn Andersson wrote:
> Due to the different PMIC configuration found in the SA8295P platform,
> compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
> MAX20411 LDO.
> 
> Support for expressing the regulator supply is added to the binding, the
> support for enabling the parent supply for GX is added, the missing
> gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
> enable the GPU in this configuration.
> 
> [...]

Applied, thanks!

[8/8] arm64: defconfig: Enable MAX20411 regulator driver
      commit: 42945eb663d88471a0c394d9f466401b1a8d791f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

