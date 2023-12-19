Return-Path: <linux-kernel+bounces-5881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A48190EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858691C24FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E278340BE7;
	Tue, 19 Dec 2023 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mItHfAMq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F52405CB;
	Tue, 19 Dec 2023 19:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF60C433C7;
	Tue, 19 Dec 2023 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014432;
	bh=o0+CNZGXbjFl2WvoCYvRIoh66SFydQ+T30cjCNjNEZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mItHfAMqBA1uuHkp3ctyIWJsAwUoawYhfvU41e+ecO4WlHylwk+FH2go2TTMcDRiD
	 U3e/eshK59TqYEt/+kQLUXbOyxoAafjV9WYHwfn/UBNEXPc217UCYavZVaaDMDT6uY
	 q8IaqhPvZqpo3YNg/FCgR41wyxQxivnhAGQeV1szZtUrn2iZnRWDARbtZM2PtBhuTl
	 DkFtc7yQ4MQMQsHPaUPcvdsEasWNJBzcY+dAa5g7bIHm/Cy3TszFEVEx6SEI5OzK3Q
	 Ai76LPADMdGQ1jMLa30sgVwjGjIEYfE2agjSueJiQPdSBgXP8VezmIu94IHm4fB5QC
	 vxauz+nmkZKuA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	catalin.marinas@arm.com,
	ulf.hansson@linaro.org,
	Sibi Sankar <quic_sibis@quicinc.com>
Cc: agross@kernel.org,
	conor+dt@kernel.org,
	ayan.kumar.halder@amd.com,
	j@jannau.net,
	dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com,
	m.szyprowski@samsung.com,
	u-kumar1@ti.com,
	peng.fan@nxp.com,
	lpieralisi@kernel.org,
	quic_rjendra@quicinc.com,
	abel.vesa@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	quic_tsoni@quicinc.com,
	neil.armstrong@linaro.org
Subject: Re: (subset) [PATCH V5 0/5] dts: qcom: Introduce X1E80100 platforms device tree
Date: Tue, 19 Dec 2023 13:33:36 -0600
Message-ID: <170301441253.365364.18205363221847147285.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205062403.14848-1-quic_sibis@quicinc.com>
References: <20231205062403.14848-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 11:53:58 +0530, Sibi Sankar wrote:
> This series adds the initial (clocks, pinctrl, rpmhpd, regulator, interconnect,
> CPU, SoC and board compatibles) device tree support to boot to shell on the
> Qualcomm X1E80100 platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied, thanks!

[5/5] arm64: defconfig: Enable X1E80100 SoC base configs
      commit: 2e86e6300c4a98b1d0c93e03c491b0fd5d552eb5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

