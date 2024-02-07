Return-Path: <linux-kernel+bounces-56591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6884CC45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EDF1F21F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498C27C092;
	Wed,  7 Feb 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5mFNOvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C17C093;
	Wed,  7 Feb 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314486; cv=none; b=blt+7hq0uI0dzC7chjdGPHxkehGYlfke5gxfYTDy5x41cG1AWt+Hrf4U3CVl92ubg+pruH4WwsZM7Qbk5Jt7iNTJYloqBQJCLZZ+YLvOC+05dAyjkQQ7ypdO2eeS/TeE5r0c0W+A5E/wcZLalDU3LfhxA/1E0k1H2gSpXGwudzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314486; c=relaxed/simple;
	bh=/rjz977jP5mBXgImd5nP7xr6MiG0JWxvSEkRfP3XuVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bzDmVBRi+/sv1R8oHrLz1TOFmZ6Yvs/L5WVvV4yw9sOS9JNRncqozRnThG9eNoWSkAiWvkJ7PKOQXYd+HUJo82Fze3N7SWUdTyBBXjiFuUI0FO+VR32np8C20nFZKGbDjlZ8m5G+cuAMuRSqoQJCRFWOWIxayvo6Hrn3xeueg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5mFNOvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC1CC433F1;
	Wed,  7 Feb 2024 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314486;
	bh=/rjz977jP5mBXgImd5nP7xr6MiG0JWxvSEkRfP3XuVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B5mFNOvWiLN6Y3rPY+t8oyEEDw2UkAISJ0+KzhNU6q4zQqt/dLgVdpkBT8MJg5XFo
	 BsJje3G4S9cRxzw0kmZnmWY82oJMl280mOdE4sv0pVLjbbU9QeBkLxZhE1jK1g/8Mq
	 Y4GRBB7vqgk6OixKHtwrglFqZeZ/k4G1u3oPxB1738tB5DhaVp363/0maruniQc8ob
	 jdMiN7LsDDOvB1E5wNgKpoS425tXMMgE/rTwkL3uza2X+7fCPfCMDvMBWMP+4b2/8i
	 v0W+8cIRnKYqgGINddvE0Skdfu5BslVyoFLc4SRbFicAO3t4pKoi9NPARk/sGK6OU3
	 xX4mSiXnlzeUA==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, quic_cang@quicinc.com, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
Subject: Re: (subset) [PATCH v3 00/17] Fix Qcom UFS PHY clocks
Message-Id: <170731448191.147119.10372838414675777682.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 31 Jan 2024 12:37:23 +0530, Manivannan Sadhasivam wrote:
> This series fixes the clocks supplied to QMP PHY IPs in the Qcom SoCs. All
> of the Qcom SoCs except MSM8996 require 3 clocks for QMP UFS:
> 
> * ref - 19.2MHz reference clock from RPM/RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC or TCSR (TCSR since SM8550)
> 
> [...]

Applied, thanks!

[01/17] dt-bindings: phy: qmp-ufs: Fix PHY clocks
        commit: b0bcec86f47b44c98a23c31d54dd3963e27761a2
[02/17] phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all() API
        commit: 2668cae8b64bf25c4c7a39eb2cb0012c92153c11

Best regards,
-- 
~Vinod



