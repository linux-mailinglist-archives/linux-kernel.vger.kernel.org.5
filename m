Return-Path: <linux-kernel+bounces-55953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631384C401
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4DDB26935
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D223766;
	Wed,  7 Feb 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrDk07e0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFC22EFD;
	Wed,  7 Feb 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281227; cv=none; b=U0YFlBP1h5aNY4r/BbWKFR+IWhPPh/QM2GXgNVlVRe9+bWBZixH8bGGAUvMuwaTZGMeW5A2sBYPGBAEox7coBGMgOVesU71+pG1BiDPJlsquaSrQJHB18FOItkudUwV1kugjVrKd3gK3XBHHo4LtUqW0ZbKmqXDL/twyyf1z1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281227; c=relaxed/simple;
	bh=1gP0KeHVS6pUWdj0/YG5QFbHDGuHL/ENkMcDCA0b7UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK8MR0i0J3mZ33sT+6G6JPKAE0ZltW4SWYGPgc+DWbzqXuc5dhGmAuBIwe6Na9Uon4RBl2XiPBycrTShpCOj2x6FrQLq1SYkeSWCOP23KTszr3ZSlrFAza2ifgSQkxhYVBQ05ILN43VaYYjc6Pg1hPlz0izyZ8sll0OWwksOO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrDk07e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D68C433C7;
	Wed,  7 Feb 2024 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281226;
	bh=1gP0KeHVS6pUWdj0/YG5QFbHDGuHL/ENkMcDCA0b7UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrDk07e0qEHKiI4cxhZzHyonMYEH9NV9o2H67zg//ABqWzccqG6PoRjtTeuOMAV4Y
	 YlQEqviJ57wGEFk7JT3nWxzZeZCzBRA9/MovprKUyuPxVBxzT2PRu68zebEZdwVzDz
	 eSddGPyaxrS/0iBEZCGoPhyKnWCNVF3X6LMtBU1a8TAIKGI9Rzbb9uEtzz8l4rlwSO
	 2LLIEEsoRZ7kPG8bakv6XIj/OeRQjRR4YJAb8NA8ua7ZSjwLWv66Uk/m0A/I1jcbKd
	 wfj2MkvnIE2MmI2RSsEohhWy/eEPKj13xTzSq8cSt1AJTx/sMDKE8LBY9xREA7Ni0F
	 69vzVBRwPti0w==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	quic_cang@quicinc.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 00/17] Fix Qcom UFS PHY clocks
Date: Tue,  6 Feb 2024 22:46:28 -0600
Message-ID: <170728117688.479358.12464469047870719963.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


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

[05/17] arm64: dts: qcom: msm8996: Fix UFS PHY clocks
        commit: c83fdb4335cec507d685ba9661ed7c4ccbaf12ff
[06/17] arm64: dts: qcom: msm8998: Fix UFS PHY clocks
        commit: 5e653a7ff4426242f22dd8bc6af7f29e10ee0d68
[07/17] arm64: dts: qcom: sdm845: Fix UFS PHY clocks
        commit: ca8fb2bd2248ae05890c011d691ba5d4a1e7d8d6
[08/17] arm64: dts: qcom: sm6115: Fix UFS PHY clocks
        commit: a820a285ef1b7c7fd94055bbb114c0413c04b96b
[09/17] arm64: dts: qcom: sm6125: Fix UFS PHY clocks
        commit: 3823a877f25baa152e34325818d5140990d6464f
[10/17] arm64: dts: qcom: sm6350: Fix UFS PHY clocks
        commit: 68f9fcba3a0c015d649907805534fe66c9c60865
[11/17] arm64: dts: qcom: sm8150: Fix UFS PHY clocks
        commit: eff7496b72810ca54da8c9c4542bf2aca479dd44
[12/17] arm64: dts: qcom: sm8250: Fix UFS PHY clocks
        commit: 55ee02b10bdd9577b6eabe98ebb383ec4e0674a7
[13/17] arm64: dts: qcom: sc8180x: Fix UFS PHY clocks
        commit: dde771402292ea60f96bfbfae8b130556585ad76
[14/17] arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
        commit: 1d4ef9644e219202ed89ac42f3e1defebcab9c7d
[15/17] arm64: dts: qcom: sm8350: Fix UFS PHY clocks
        commit: 8edbdefee1c9eb24690d5794556af08f00ecc576
[16/17] arm64: dts: qcom: sm8550: Fix UFS PHY clocks
        commit: 746ae23ad02004fe283e2edb45b7a060bbc36d46
[17/17] arm64: dts: qcom: sm8650: Fix UFS PHY clocks
        commit: 0f9b8054bb4abd7b4686cc66b85f71fec9160136

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

