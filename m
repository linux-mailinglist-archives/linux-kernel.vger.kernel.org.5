Return-Path: <linux-kernel+bounces-2735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68ED816126
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B728274F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA15D8FC;
	Sun, 17 Dec 2023 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TogdyLks"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5B5CD04;
	Sun, 17 Dec 2023 17:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA89C433C9;
	Sun, 17 Dec 2023 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833741;
	bh=S1SxxEG5l57G7Xc0xEM2OlKRohxwEkI7OFYAIwgo02A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TogdyLkszpLAPTyqciFhOUHrv/cEP1fHX07vvf7CVwn4fPaGuaX9Iqqfzzk4NdAdu
	 FlwqHAN+vJ52Q7JzEpgzcb1Q/B71aOB8kzeBTqL4D4SEMTMpO9hWQwi2/unZR4Cq1f
	 dUXitt7lsJ8i8NUcfmH68ddAS2ZPC9zYTd1yBNX/0G3SVaga+co2P8f+wc1cC2Py6t
	 7xP1Wr94UhhAqsT9j/1BgdQ1ZDa6SojkzCJZExWs1HkRvfioSUJ+kOi8xmMtf6rGda
	 y5xk2W15kXkvgEthAVJR055/V2f0VkfDvirGMbKIB9Dzy8fqXlvjGtNWcpxA2iFBf3
	 QLrJMWuFZ5i3Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: qcom: msm8916/39: Make blsp_dma controlled-remotely
Date: Sun, 17 Dec 2023 11:21:29 -0600
Message-ID: <170283349411.66089.7157787854311273289.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204-msm8916-blsp-dma-remote-v1-0-3e49c8838c8d@gerhold.net>
References: <20231204-msm8916-blsp-dma-remote-v1-0-3e49c8838c8d@gerhold.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 04 Dec 2023 11:21:19 +0100, Stephan Gerhold wrote:
> The blsp_dma controller is shared between the different subsystems,
> which is why it is already initialized by the firmware. We should not
> reinitialize it from Linux to avoid potential other users of the DMA
> engine to misbehave.
> 
> In mainline this can be described using the "qcom,controlled-remotely"
> property. In the downstream/vendor kernel from Qualcomm there is an
> opposite "qcom,managed-locally" property. This property is *not* set
> for the qcom,sps-dma@7884000 so adding "qcom,controlled-remotely"
> upstream matches the behavior of the downstream/vendor kernel.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely
      commit: 7c45b6ddbcff01f9934d11802010cfeb0879e693
[2/2] arm64: dts: qcom: msm8939: Make blsp_dma controlled-remotely
      commit: 4bbda9421f316efdaef5dbf642e24925ef7de130

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

