Return-Path: <linux-kernel+bounces-123465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564DB890901
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA73CB23055
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CEE137928;
	Thu, 28 Mar 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuT4GdfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7262137930;
	Thu, 28 Mar 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653565; cv=none; b=ieOduGlz3DiAXfLxifNFNm0iKa2yuFvGw08E6cNb1rXXhGz7CMQzbeLgnteGl9+bH11RwUo0NJnNdAxOncmglDCGw7LmGFGtML1AWx/eWhHF4UP92mSiSIDz5L3PJyyUaMQBX7b9PZ5ogFZZBvZ5KS8cBKSOmYcsW6LN439ou2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653565; c=relaxed/simple;
	bh=9rSs54F7ZgwC+c2F1DSDwjt+yL3zgaczT0DclqpgzZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAFDo9Phz9HFipwL9sLVifA2hg6ovBq7+FrOk/uQHw760/G7AFLa5CQKJrcQ/SJE5Thm1MeMJrBMH7GhtmM7LxqL55akzEciTqlWyGu0ynDWEEXWIfJCSbo9Z0a97/z1yhVpA6nVf9I227M30BX2rpazUkI/TzFW93+0a+z+cvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuT4GdfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483AC433A6;
	Thu, 28 Mar 2024 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653564;
	bh=9rSs54F7ZgwC+c2F1DSDwjt+yL3zgaczT0DclqpgzZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IuT4GdfLZUiKXvH68hPk7+TUBzQrfhHY+0gtHedpTdYbKtogEQM5AHMDJKtpCNwtB
	 6MV0CLsyLMtagaOoK9lyqEFQgHyo9y7tyER/xdF+/q9kQsG9+KcmGN+heLlwuFVxvm
	 Ddq6HGwyjx8u9takAwnzRl8fTg+3/qj949E6Ag2IyGd0dik6UF6vX2GIVF2Pyeg9eR
	 1RGVyenx665ICMYiW2wEBcO8qCy0S2lJbYnsN6X4k2CjBro7s2+CBRFc9zELfqQFG7
	 L//UJ8VIOXYfEsqVWA90N2yoj58MHTK5fslFRNBo1I1qeQjVWChlU2PL4rQJInYXCm
	 j1n5OuNtanBAg==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org>
References: <20240221-phy-qualcomm-edp-x1e80100-v4-0-4e5018877bee@linaro.org>
Subject: Re: [PATCH v4 0/3] phy: qcom: edp: Add support for X1E80100
Message-Id: <171165355868.152390.13304083799152803709.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 00:49:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 21 Feb 2024 00:05:20 +0200, Abel Vesa wrote:
> This patchset moves the v4 specific bits into version specific ops,
> adds the v6 specific version ops and the compatible for X1E80100.
> 
> This patchset is dependent on:
> [1] https://lore.kernel.org/all/20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org/
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Abhinav Kumar <quic_abhinavk@quicinc.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Johan Hovold <johan@kernel.org>
> To: Rob Herring <robh@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles
      commit: 5d5607861350db4020b3d74c02837ffc008701d9
[2/3] phy: qcom: edp: Move v4 specific settings to version ops
      commit: 9eb8e3dd297f976aec24e07c5e3ca1e79629140b
[3/3] phy: qcom: edp: Add v6 specific ops and X1E80100 platform support
      commit: db83c107dc295a6d26727917dc62baa91a1bf989

Best regards,
-- 
~Vinod



