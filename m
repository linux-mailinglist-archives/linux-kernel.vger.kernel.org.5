Return-Path: <linux-kernel+bounces-55948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9984C3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA67C1C259CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1220315;
	Wed,  7 Feb 2024 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coKNV8EU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0347200BA;
	Wed,  7 Feb 2024 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281221; cv=none; b=mx8t0exMFwRW35KVmr3a7PB6CW3VnPKWYUdhDfXxbz5Oz3BlGr+FpRfmF2gC007Fd8ZE8Z3RPNKex9ZG3922n7Kl7OljZys5upt3jn+9VkJ+SmWHwYBPDkMNmiFymtjX4vMLQTnN//iJ7xNfdHNrpm2BcSx6cxo+lQSvAK4sW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281221; c=relaxed/simple;
	bh=ah4fNiXUN0qnsNYg/9tNzHgmJyGt7n2KX+H460RlCU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK2km2nc9e1bDz+qhwMwMtFeXcPCi85zU8STKz2qSyUlzZOkaaJfh0+NiHwF7BIC4AbHtrJpZ4Gai91GKqpepX0aAFUFIjXtiA+m86Mkru7xmpg0aNI4P0W0AblHvLNgFFQDveMyOjbsBvNNPOEhcadZ7bSQ6h6vUuHc+372GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coKNV8EU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E5CC43330;
	Wed,  7 Feb 2024 04:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281220;
	bh=ah4fNiXUN0qnsNYg/9tNzHgmJyGt7n2KX+H460RlCU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coKNV8EUc45DRfwbOKlFoYDTj8tc+bS+s9BV1RSuYGBuADgGuq4jfeVhNqsWsQRDS
	 fYHF5DComsjqvKuKF5+Jki7RXpexTcDNayhBjGr7rDHpFtetvuBW634Zgtjgc6fNt3
	 QENMCTgHajWr8Yh9DUjnvJcoaZRhiCX55ASltvyXHwfjHbFPSn40PEsk5/qc1WVQ4c
	 zh5rqKy8FfBdL/pfBEOyYNlhFuVke7ckwxtQ6j4vkCYAeSDYpG0AHoT4bALWNAzwfL
	 8robiJz3VqATgXpyqg+Y6F29fP2BPJTnT3vasvZw38dvErpFerCULD1vN6tNRLsioI
	 irzDkR8QdN2WQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
Subject: Re: (subset) [PATCH 1/4] arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping
Date: Tue,  6 Feb 2024 22:46:23 -0600
Message-ID: <170728117680.479358.16920334289720602189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
References: <20240124164505.293202-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Jan 2024 17:45:02 +0100, Krzysztof Kozlowski wrote:
> WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
> it is offset by one.  Correct it to fix recording via analogue
> microphones.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping
      commit: 8ca7fbd92c1b28edb5d5df7aeb8bb4886ddb9829
[2/4] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping
      commit: b66966b1bbc0aa58f7af83cbd56d5a206892857c
[3/4] arm64: dts: qcom: sm8550-qrd: add correct analogue microphones
      commit: e2f1a18747b1bcb48900290d8f4de13e2ee55cbb
[4/4] arm64: dts: qcom: sm8550-mtp: add correct analogue microphones
      commit: 503c0129b3aaf2aaf481ffd7f0a422af8a18f0b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

