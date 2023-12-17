Return-Path: <linux-kernel+bounces-2732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5D81611B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A21281FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95259B65;
	Sun, 17 Dec 2023 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs/ToJlm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25A59B50;
	Sun, 17 Dec 2023 17:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C38C433D9;
	Sun, 17 Dec 2023 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833735;
	bh=S08U/8QY4xKf/my78fGewT/X/Z7/h+dUEruTrZf2pe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rs/ToJlmlfFhR2bM9eS2NGSd8esxnuFGDBXtkpv+k7OhoClI4Z0UrfvF9UhAjLT4n
	 DdPYEuYlyz4AdIyfZkM2Yx7yz33lQoQ60jfXv/OY38pQHOxoKvASqgaPsXuolOVVjd
	 5xDHJnoIvOGy/EVfAsC5Em3IeoAq1RjX2TmY1u3V88SzLgrItwOYJxaBuX8SiVpb2x
	 vCGO3xekH6alYZ2A6gtX9T1VQ3ijxgl14HuiUv2L+dHj7ClrJOolsI4eIowYH5Lnfm
	 /GKRTlo04sxTvkaOdZYmZXBB5Y3ItWORYploZLFNm03rWbjnCYL8NhtOPlqAXG7N4Y
	 2yLw37+axnKpg==
From: Bjorn Andersson <andersson@kernel.org>
To: Om Prakash Singh <quic_omprsing@quicinc.com>
Cc: neil.armstrong@linaro.org,
	konrad.dybcio@linaro.org,
	agross@kernel.org,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marijn.suijten@somainline.org,
	robh+dt@kernel.org,
	vkoul@kernel.org,
	cros-qcom-dts-watchers@chromium.org
Subject: Re: (subset) [PATCH V3 0/2] Add QCrypto support for SC7280
Date: Sun, 17 Dec 2023 11:21:26 -0600
Message-ID: <170283349430.66089.15994478058203053990.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214103600.2613988-1-quic_omprsing@quicinc.com>
References: <20231214103600.2613988-1-quic_omprsing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 16:05:58 +0530, Om Prakash Singh wrote:
> Document SC7280 support for QCrypto driver and add QCE and Crypto BAM DMA nodes
> 
> Om Prakash Singh (2):
>   dt-bindings: crypto: qcom-qce: document the SC7280 crypto engine
>   arm64: dts: qcom: sc7280: add QCrypto nodes
> 
> .../devicetree/bindings/crypto/qcom-qce.yaml  |  1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: add QCrypto nodes
      commit: d488f903a8600203dc367985a0a7a742b530adc0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

