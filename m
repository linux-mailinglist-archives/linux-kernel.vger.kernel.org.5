Return-Path: <linux-kernel+bounces-133401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82389A348
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C639E282DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2864173355;
	Fri,  5 Apr 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYEEQr90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B36AB6;
	Fri,  5 Apr 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336958; cv=none; b=pej7rIb+duprqoHWTyxMp0Yk2naYoPfICmuUvVxDoujlkeqMv65OuOvbL2/hkAwR5ck+rwfagC2c+rst5YeFENxhhTW5ItWHrl9m7vJWRMFbSPCmq5sGdQD75cnrl/H7DMXs6dWGDh201uB9dnrIMo5wZLGKHqYHDehgSMC/uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336958; c=relaxed/simple;
	bh=f1kvZGzRe2SXSRDmHY4ReUMQwtDg/dGy62MWDdLbfWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PBOSu98iv1TkyZhFm2E5k7tCkxpuq72zMq2tGtlH/veOrCe72CuyjGWmeGe0LZt+2cAounLNdg0OD0TZE5Fl74Z5ZN7jr04M9Wc/mTDk5jm4P+lBPEgx9C5OIOaocsX4kbpeWuGs+3E0Sb4M08eVx1vXqkBtIQsf+FRRZyUA5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYEEQr90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD8DC433C7;
	Fri,  5 Apr 2024 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336957;
	bh=f1kvZGzRe2SXSRDmHY4ReUMQwtDg/dGy62MWDdLbfWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WYEEQr90KrTbu0rcJ2vk3kkx8nQl2+emnZrsljq8sA3FDapGTh+zx1Z2rrR49oiLV
	 y7DwtCH4DIxhX6XGKABTF4LIyngi5fJWRd/01VPFpst8FRfRJiLoWMtUbrAJgqwa1j
	 dVdFq8ieqGjTawNwtTgINJZCj3cGzWeLJFkjAelB/svo9PZekKomha8WAdIMP7z40A
	 Y+MyuHI9N/mxJxye2hiYlKqxR9v8XYQDP+ZOV+Acs18iZ5HzlIQLKX+4LOSFV2bUi4
	 sM7SbQ9Bb0BYzUfvz4DwUpJ6xIAWNuV2LfNNg6tqzguQ0QM5D3OhS1xC+QAHUKJPxz
	 S7yT20yE2gl1Q==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
References: <20240322-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v2-0-3ec0a966d52f@linaro.org>
Subject: Re: (subset) [PATCH v2 0/7] arm64: qcom-sm8[456]50: properly
 describe the PCIe Gen4x2 PHY AUX clock
Message-Id: <171233695315.304553.592159497575428525.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 22:39:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 22 Mar 2024 10:42:37 +0100, Neil Armstrong wrote:
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
> "PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
> is muxed & gated then returned to the PHY as an input.
> 
> Document the clock IDs to select the PIPE clock or the AUX clock,
> also enforce a second clock-output-names and a #clock-cells value of 1
> for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs
      commit: 72bea132f3680ee51e7ed2cee62892b6f5121909
[2/7] phy: qcom: qmp-pcie: refactor clock register code
      commit: 677b45114b4430a43d2602296617efc4d3f2ab7a
[3/7] phy: qcom: qmp-pcie: register second optional PHY AUX clock
      commit: 583ca9ccfa806605ae1391aafa3f78a8a2cc0b48
[4/7] phy: qcom: qmp-pcie: register PHY AUX clock for SM8[456]50 4x2 PCIe PHY
      commit: 5cee04a8369049b92d52995e320abff18dfeda44

Best regards,
-- 
~Vinod



