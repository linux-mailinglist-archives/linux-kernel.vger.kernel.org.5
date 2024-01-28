Return-Path: <linux-kernel+bounces-41849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57483F89F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA565283D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8AE31A94;
	Sun, 28 Jan 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGi5L6LD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3D2E852;
	Sun, 28 Jan 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463961; cv=none; b=n52rMBQJ3T30yHv1RBw6TS5YOYY9kaab7fGlorHXsAnm6JfKeFjLvkJRXN3kXVgq1HcEMreXyUznNfquRf8gcCVS+Cy2Y0Lu7HMktAvQYGcTwQNFAb92h8Z20cbIHXYela0710gdOSz5qRn2CjjsdUO1jLeCdf1udfAxfOJqKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463961; c=relaxed/simple;
	bh=gKKsPVz/3F1TGRz3YEKHV4jbhK9f92tQ6MnSAcJU7Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNpuh6U38+EEKVrPxtsm1FTEx7kmJLVHEHdlz748hV3/p2nbPIkBK9LhS/QUkzF4ktWfDsCqbW/boEG+qh/5zy7Nq7POPKO2KCKD5i44lcqa1tuPfA3+3X9f3i861vJyKeVons9SAxz/yz8o5Dt/Ebxhu170KCq+0SahvPxanTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGi5L6LD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C299C4166C;
	Sun, 28 Jan 2024 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463961;
	bh=gKKsPVz/3F1TGRz3YEKHV4jbhK9f92tQ6MnSAcJU7Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGi5L6LDSrUIPWsYsIShMLAojemlYl1CHH6hnDSe5MFXk6h02c/bkwjF2IRi0PGeT
	 KkGUeDkKl8y6BnKuwW2Iz4CFqyd8HLdY0r4d6j2IVRuU8rz6Wa7QjiSYHfCiGkT8GA
	 Ew65wnIuK+PdH3UDfL9i60UQN6KE5TvjShCnWg1opWNByIeizEZF1UOUnoMzKwKA/b
	 0/grDXaeswqxGNI3qMtCzaOq8Oq5h6VoGqT2o6tY/owhwiuvb1IddzJI5YgwXVO9HG
	 JgRwn6eZoWBzTIgLqO2ek/DksYzetWzdPm30p6F0yku5Mh2KeZsbCEKlvxfPEXRvns
	 GHFtCHwZk9tSg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/7] arm64: dts: qcom: describe all PCIe MSI interrupts
Date: Sun, 28 Jan 2024 11:45:44 -0600
Message-ID: <170646395033.64610.15920639966440223174.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
References: <20240126-b4-dt-bindings-pci-qcom-split-dts-v2-0-0bb067f73adb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jan 2024 10:38:29 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> 1. Add tags.
> 2. Split interrupt-names: one entry per line.
> 3. New patch #7.
> 
> Bindings now expect 8 interrupts in PCIe nodes:
> https://lore.kernel.org/r/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: qcom: sm8150: describe all PCI MSI interrupts
      commit: b6b75a4c037a718eef986adf1e4935329a11ea37
[2/7] arm64: dts: qcom: sm8250: describe all PCI MSI interrupts
      commit: 534ecb509d77475db6cefcf831ffa3a67349bd24
[3/7] arm64: dts: qcom: sm8350: describe all PCI MSI interrupts
      commit: f9a7f70093da0e60b34013435bddad3dd0b470a6
[4/7] arm64: dts: qcom: sm8450: describe all PCI MSI interrupts
      commit: aa87ad5575a125968896820c82a458a63615c8b8
[5/7] arm64: dts: qcom: sm8550: describe all PCI MSI interrupts
      commit: 79d99c74c6e865694a0e4d0bc5d2059a7def1f5a
[6/7] arm64: dts: qcom: sm8650: describe all PCI MSI interrupts
      commit: 7ee7c0f326d6c93831930c3adf1c820d57dc238b
[7/7] arm64: dts: qcom: split PCIe interrupt-names entries per lines
      commit: 7f650472310478f8ac4167ea04bd346d42e783a5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

