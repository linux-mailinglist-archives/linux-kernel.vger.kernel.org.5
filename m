Return-Path: <linux-kernel+bounces-55958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B684C412
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F41F270F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071DE28DDC;
	Wed,  7 Feb 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqpFpgWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815628DBD;
	Wed,  7 Feb 2024 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281236; cv=none; b=jsYCQ6+5dxlZr4KVpmFoEBLaNTw5+RzB8j3GnyRJ+sDN+5vR40Zy8aV010ar8Z0THL+4DM9JTIbjpBYqgAGLtAj9oHwG3cRQsUCIhbL3AuS3JBp6gLPzWyg3Tr7lIau94y4MYiZoI8gYfvsMjsjoBBEKRbxC9bmcPA9AWEKg298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281236; c=relaxed/simple;
	bh=UYd+KQbWrD/vp6wD1XU/N9A0AH2bAKaYL4bBOyrHZRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LO+6Ii25CXz6aicCF6qW7ZxIruk5tVh5ZWijIf5D6MbMOEH48+u6niAb1+h4Qfnqrxy4iC3ziPQKVKeOMEgr6K2snstogooysSnDp2r0nOmg+WRugY7WDj+vq/fSNJ723yHN1YuBku1Z9VCP4aOaB5FrXT6icQDdnSCiiNPfg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqpFpgWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E818C43399;
	Wed,  7 Feb 2024 04:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281235;
	bh=UYd+KQbWrD/vp6wD1XU/N9A0AH2bAKaYL4bBOyrHZRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqpFpgWBzvYT0jOxt+PDi0gbf2eHb2bQTx6RzexSVUAk+pB1acw+GpAMoUB4dHUI3
	 Gqqcs215BvncX2S2Kg/9ZollqhMI0qHKyFl5xy7UBvQlRPJljfBlvRBQpH+rGoyPar
	 U6wN9fl1QtbTKKS5EpdIc76K8msIzY7m7R8uGm67zaeACVMIR1jYOYH27M3dKFJ5c9
	 TxdKBxfEhlN6HfPI+JSHvyPM+9GXH9zTX4sCOA1mjd3cYDoKc9NK7yJ/gDoD9uzCHL
	 TGE6Jytvh7INZmEM9xl/6ccCBEW2/1g83VsGEGwKZA7LZgK1y8x+SshdelIk8I5UFB
	 gjATWCfjoU8hQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v7 0/4] remoteproc: qcom: Introduce DSP support for SM8650
Date: Tue,  6 Feb 2024 22:46:33 -0600
Message-ID: <170728117675.479358.12858304848396800970.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
References: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 09:51:01 +0100, Neil Armstrong wrote:
> Add the bindings and driver changes for DSP support on the
> SM8650 platform in order to enable the aDSP, cDSP and MPSS
> subsystems to boot.
> 
> Compared to SM8550, where SM8650 uses the same dual firmware files,
> (dtb file and main firmware) the memory zones requirement has changed:
> - cDSP: now requires 2 memory zones to be configured as shared
>   between the cDSP and the HLOS subsystem
> - MPSS: In addition to the memory zone required for the SM8550
>   MPSS, two more are required to be configured for MPSS
>   usage only.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: qcom: sm8650: add missing qlink_logging reserved memory for mpss
      commit: af53ecef19ffab5eed346032a0e79110cb82cc1d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

