Return-Path: <linux-kernel+bounces-56590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0238684CC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CDFB211D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D477630;
	Wed,  7 Feb 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4cnwQE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AF7A702;
	Wed,  7 Feb 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314483; cv=none; b=oq5uDQfUWTXQiIOTRGU0Wc+wPWeSJC6h4QsPBbWyc/NECeHb8NOJUJMII+wrdXg1uAk+NO0p0bYpVuu+tbEJSw9GdJXQgNJ7iq9FPiPKZStk5V9CyEvbe2fQC1OCqotc/OJkup2LP1Suwb5prXIggndPMLD7V7CJbTGrYj8RH4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314483; c=relaxed/simple;
	bh=/sde8nj0AruifCnxUEsSucAxWC/DrKQeRHqzY4J5e2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VGHzZeNsH69nwXUjvE+ul+sBPSpHT/n0g56eqAgATpOkw60g0oXcUlZSyaq1R/N7dy5H3ig8y33FsmA2qJnE0K1nD8jn+DrCVNW4ur4+uNN3+4v0sVJHfBoOu4F5FIpehtUQyvTZYPFXl+rYGzA/S1oTFp8ZQ22BF/upxoaKeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4cnwQE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB04AC433C7;
	Wed,  7 Feb 2024 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314481;
	bh=/sde8nj0AruifCnxUEsSucAxWC/DrKQeRHqzY4J5e2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s4cnwQE7RpfM/ykNtfdDbC3HeXScAhKK97KbID6lq2EaKm0Z0btdX94stFXU0sXG0
	 nNAJpRS28muuedEn1y6R2ACtJ1PPJAAVx9KzdhqM13PH/yhklMQAmqoKx7+qKHTtZA
	 aQ8ArH5h1+nTlgkCntUT7kfK1iv/bfuKBcm0mDtI02Ni5GLDVjzUAJCBp8J+EnkYGX
	 3ZFUA12cWayRfE6wAyXbkl1WfWY0xUoFtJgUM4kM2TXX7/JuexOwvc6F3LWMDkWFII
	 QCzH2g1ddzAwyZfU+Xy+mcppi32gM+g9dVdTNJYY9HJgHrnUY/aKnkGWCRCyOolx9V
	 ICLn93YdGCz2w==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, sboyd@kernel.org, 
 mturquette@baylibre.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, quic_cang@quicinc.com
In-Reply-To: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
References: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
Subject: Re: (subset) [PATCH v2 00/16] Fix Qcom UFS PHY clocks
Message-Id: <170731447862.147119.7425320983212079444.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 18 Dec 2023 17:36:56 +0530, Manivannan Sadhasivam wrote:
> This series fixes the clocks supplied to QMP PHY IPs in the Qcom SoCs. All
> of the Qcom SoCs except MSM8996 require 3 clocks for QMP UFS:
> 
> * ref - 19.2MHz reference clock from RPM/RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC or TCSR (TCSR since SM8550)
> 
> [...]

Applied, thanks!

[01/16] dt-bindings: phy: qmp-ufs: Fix PHY clocks
        commit: b0bcec86f47b44c98a23c31d54dd3963e27761a2
[02/16] phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all() API
        commit: 2668cae8b64bf25c4c7a39eb2cb0012c92153c11

Best regards,
-- 
~Vinod



