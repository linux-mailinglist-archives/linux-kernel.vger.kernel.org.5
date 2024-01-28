Return-Path: <linux-kernel+bounces-41507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B683F2F4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A1A282E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF711F615;
	Sun, 28 Jan 2024 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M49fE010"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E31E87C;
	Sun, 28 Jan 2024 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408258; cv=none; b=nf4hnR6sHMO/zuyvMAnp0AARe5DrcGZrHRtgywpFFqN8ei0hwImtmUJkgNBjgK6+gEdkVNUkKdGYzIL7ncVLwnp3NpwYyPZRmvcR5eihXRj14+qLgREauSPfdCC3DL7x0yYF4URqkeeJRewnwe79xUhwUVg0uqYu066vR168SmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408258; c=relaxed/simple;
	bh=fUqXf5yh4SAYlnmMF0vGpPT7gOPfROFk0mVA5sFaJCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSzbayvgxrgD0IPCLN576t/rvfdGK5+k8dsYqzyRTNoPW4lGtyZFKaOW1EpY6hh5QFRLb2BS4tlphgqVJLzTbPPFCKsKVsWnPNkGrrTlisGzLv0+OCiGecF17APXsvnoZbcFg+HdjCk8m08m8JEHqQRSwvw/3A7rHUaiM9X0HPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M49fE010; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66228C3277A;
	Sun, 28 Jan 2024 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408258;
	bh=fUqXf5yh4SAYlnmMF0vGpPT7gOPfROFk0mVA5sFaJCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M49fE0106oTRGUeSfnpipb86b3X3/fC2HRiOCe/Z3ep2xyyudnHeNxwcKU5O7IvYf
	 V6jDXjgWftzlzAL1dEZ/bLqipfQ/mzgqXTea4a/D558yRuooEqY2pi6p/6HPOPF28w
	 1f31uU2I22WtPmN0plhHKwz51hYhR6o7k1kz+OZQxM1VpAdlBac739i13Kmhb0yV3G
	 r9jxofM0IIW1ET1WFoMuLKYGkHC53YV/F4i+5yLkEirGDFG/qvUh6UsVSTp1IhJeZb
	 ze7S3sbx3J7AQ9moFbRNsO3b8A4i9oyNSIIcQnJL7TvUdTZvUPizYrtkW8V+kUPxYd
	 Yr6f62up6FiCw==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v3 0/4] Fix USB Interrupts on Qualcomm Platforms
Date: Sat, 27 Jan 2024 20:17:24 -0600
Message-ID: <170640822835.30820.106456682983877313.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125185921.5062-1-quic_kriskura@quicinc.com>
References: <20240125185921.5062-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jan 2024 00:29:17 +0530, Krishna Kurapati wrote:
> Currently the interrupts mentioned in most of Qualcomm platforms
> are partially faulty because of following reasons:
> 
> 1. hs_phy_irq mentioned on QUSB2 PHY targets is actually qusb2_phy irq
> 2. pwr_event irq is missing for many targets
> 3. Actual hs_phy_irq is also missing for most of the platforms
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: Fix hs_phy_irq for QUSB2 targets
      commit: 2c6597c72e9722ac020102d5af40126df0437b82
[2/4] arm64: dts: qcom: Fix hs_phy_irq for non-QUSB2 targets
      commit: 6bf150aef236fbb6d9fd299081fa8f1f0f6fde6f
[3/4] arm64: dts: qcom: Fix hs_phy_irq for SDM670/SDM845/SM6350
      commit: 7c9afa1fd84ba1fb5b80eed490bfcde2206ef5b0
[4/4] arm64: dts: qcom: Add missing interrupts for qcs404/ipq5332
      commit: 927173bf8a0e36d3ec47b808652822c594807fc2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

