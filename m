Return-Path: <linux-kernel+bounces-152338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C948ABC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E31C20AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5463D3B3;
	Sat, 20 Apr 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJe03Sk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB13BB21;
	Sat, 20 Apr 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713635517; cv=none; b=UvC3XQCZVL/xmsDNG3BHkymQTjPvJI4URnL4rgQoU1eG4bC0pjwWB5Ci5G4b0Q39TH1qy4nXTXnFhRUsWI5czruqDboSmvtLotwsph2C+bIAzuGpf42g4vKMvAlOonO5P+BVybkORQV7qFOsmIvTmQi/nwRJJG+Hce1ZVVha4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713635517; c=relaxed/simple;
	bh=ROExDQsEH+OHB8y7wgpPcV5MjxcqRC2Bc6cOct/bMh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSEdskPIuvsnVfIG1KCu7S+pA8NiyOPlI2jERdMjBCA73YY7hSQNRl7g2NusCZxOV7XzUmR4yMAMR036BVFthgoj+OgQTWEkCcpgnnCRzTQmXc82gq7SpdlVNnuRZkcP1FLn10nyFle1c1wWEk7ZJGXdSlO+i8K1j2rkwU1LADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJe03Sk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70123C116B1;
	Sat, 20 Apr 2024 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713635517;
	bh=ROExDQsEH+OHB8y7wgpPcV5MjxcqRC2Bc6cOct/bMh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJe03Sk6HAYpaBgcD9jHvif4/cEblSghqrcbpiePkVHFiEITyOaGHS7rh36fu57G3
	 dJ8RxNouW6x+/wM0KBo7uV+RxaeizJ2askKhguwowzhKnh873P3r8HRWeDh+7Izsmc
	 CG8xM+ZzURiioNNDHfxfVOTVL5o/HhW+VlTb4gXvTymM9074OqaC7+MkuPgdxY/dC7
	 bxK/tSfykppgCYW2LozlZJgl22BDOLR65E68Nz+vrZ0SX4wepuZ29KR+UsbgaHn0ie
	 yyavFw5zP28vTl3mW/ELPQTIao0z+ZGUKtecDi4zN4aZp93oNDnzxVZg6OENAKUG9y
	 9sVf27rZXS4Ug==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: x1e80100: Fix the data-lanes and link-frequencies
Date: Sat, 20 Apr 2024 12:51:54 -0500
Message-ID: <171363551100.1138274.16090356735717665466.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org>
References: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Apr 2024 19:13:55 +0300, Abel Vesa wrote:
> Both the CRD and the QCP have the data-lanes and the link-frequencies
> for the DP3 in the wrong place. Both are properties of the out remote
> endpoint. So move them to the mdss_dp3_out for each board.
> 
> Without these fixes, the eDP is broken on both boards.
> 
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: x1e80100: Drop the link-frequencies from mdss_dp3_in
      commit: 8a2a43a978e51bcddfe8a89bb2acebcf24f1d767
[2/3] arm64: dts: qcom: x1e80100-crd: Add data-lanes and link-frequencies to DP3
      commit: 2351d205081cf4e7d960c0dbc5891e5fbda0b1f0
[3/3] arm64: dts: qcom: x1e80100-qcp: Add data-lanes and link-frequencies to DP3
      commit: 78a4407ca834cc448cb015e714ca230ec6bb4503

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

