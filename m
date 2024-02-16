Return-Path: <linux-kernel+bounces-69468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF938589F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBBD1C20A86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9514C587;
	Fri, 16 Feb 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+fThbTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3E1487DD;
	Fri, 16 Feb 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125060; cv=none; b=O2csC9YwQq7IVzw6uwki4ibBL+VCa55gQo/i9z6ncEnBW1Oy8bM6z8FYnCdJ/MF4mCXgIHZb0R2y5BcVBn9CPhJsj4uLSjmTUNnTkyhwax78dfLBINshm6puSParl20M2Yod+7DPfxwpSAo93getHbyCIqiWQPY1An/fM+L126M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125060; c=relaxed/simple;
	bh=ILJzT/zI9kmMsCcHLRunTYarSIlvU3Pi2unB4Fx1DPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWH1+FZf7rD2H3f+hXKWGw3tTyCqU000ZtCdlB4768YaualAZcDP5MPagUWklCuwLS56MhviJ6KkLZZz3lRo69B9spqwCSPYWVCp7luAkFR5aWpArU2vBuXfpLCZpWB41fq74sKKfYCgF941JLKrX01N3oThxrhE7sxPmuDoNAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+fThbTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B9FC433C7;
	Fri, 16 Feb 2024 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125059;
	bh=ILJzT/zI9kmMsCcHLRunTYarSIlvU3Pi2unB4Fx1DPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+fThbTfxzCAJlU7cGmZ+C7Z04w5Qopwia5hIYQi5GNwFPWS+0lbs0q6FVqSPC9SV
	 ZJSsgDpFrhLwA7YKBFbTUNIySSCYmbPcmISqmangQpf4WQm9k2m/4q5lmiAJkAeLZc
	 cY66av2ywlm07+O3YEeIoIiE39J5Vd5MfCtnTYbgAV/rQyd9UjZCJcYHlaStBIajWU
	 YqPj4HWVZGADn6Ch5SEsEFCIA4PB5ZvavJIWH7Tfxbl6sGVyJrP3DZERDs9TwXL10e
	 cu/6nnhynwPstQ8gvNaEm4q4LZrf6kxY1W5V7MgRxOFU4jPjwiho3kZiVYCaxWBzgK
	 hi8GtL3fHPItQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1
Date: Fri, 16 Feb 2024 17:10:42 -0600
Message-ID: <170812504025.18043.14918411234580482517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-topic-sm8550-upstream-pcie-its-v2-1-b3398d86d1f1@linaro.org>
References: <20240122-topic-sm8550-upstream-pcie-its-v2-1-b3398d86d1f1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 22 Jan 2024 16:38:17 +0100, Neil Armstrong wrote:
> Both PCIe0 and PCIe1 controllers are capable of signalling the MSIs
> received from endpoint devices to the CPU using GIC-ITS MSI controller.
> Add support for it.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: Use GIC-ITS for PCIe0 and PCIe1
      commit: 114990ce3edfd059648889f978cbdc83447b305b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

