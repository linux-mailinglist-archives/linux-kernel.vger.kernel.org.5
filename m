Return-Path: <linux-kernel+bounces-2711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A518160DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54430B22B2C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D94B13E;
	Sun, 17 Dec 2023 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq5i9/Sl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD24B129;
	Sun, 17 Dec 2023 17:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D88C433CC;
	Sun, 17 Dec 2023 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833710;
	bh=oRBNPn3jM0MuVI6gPLjlNM6914NY9AAvBnNC19Wdqvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gq5i9/SlFdknY9i1S+CH4/6qApCPzXCEbbIvsfRgondMHqM1Xng9RIfnutZhQAR9H
	 LzgHK5zeSnrqrAc9b382DFpJAUdz9pFm9vsigH9XdEAjMnRYCP+ktiTHZTIgKglQfw
	 DlK3Ws9gZ1CrRvOGf8ijPWVz5FPGGyJbsDnosPAUQsxowBGZxrikFez0fFPpI/XMDh
	 pFwxCsmLCjuxDrETUb1qKdXSTeOrMZTtXvmvwVmUS/e5QpYfCMALnykd2CFAd/RpMa
	 OBr1uGaJXzC5NR2q2BOr7/F8K8r3hvge/7bN5Q/mmOBBsDAaf19vlhfEfxKgHgTJew
	 e0I62a6PJkSDg==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: qcom: fix USB wakeup interrupts again
Date: Sun, 17 Dec 2023 11:21:05 -0600
Message-ID: <170283349428.66089.6197620479209787802.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213173403.29544-1-johan+linaro@kernel.org>
References: <20231213173403.29544-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 18:33:58 +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY interrupts
      commit: 687d402bb350b392fa330e9d9d1b917777ee9ed1
[2/5] arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
      commit: 204f9ed4bad6293933179517624143b8f412347c
[3/5] arm64: dts: qcom: sdm845: fix USB SS wakeup
      commit: 971f5d8b0618d09db75184ddd8cca0767514db5d
[4/5] arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts
      commit: 134de5e831775e8b178db9b131c1d3769a766982
[5/5] arm64: dts: qcom: sm8150: fix USB SS wakeup
      commit: cc4e1da491b84ca05339a19893884cda78f74aef

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

