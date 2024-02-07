Return-Path: <linux-kernel+bounces-55956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9351284C40B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505C4282D61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC825601;
	Wed,  7 Feb 2024 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFMCcwS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D752561D;
	Wed,  7 Feb 2024 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281233; cv=none; b=BG31F/9aXQqHN+4TPHsVqekHl1wS+XEdNc3kL5humelOzVjBs0AY09EfLbgHyG0aUQjZA95eabNsbcjJ07s59GCAvu2oEYFUpZUlVEqdbUs8oHLqgTP+shapldObuAEJ/V3HTyBZ46q5FtHDRnIrc+P4DHwmwIobqYOrrr56xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281233; c=relaxed/simple;
	bh=PEiKbepqN1tdzsrKwdIdcAcSszbVASQIy57fFJ6zAjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUthce1ahG0nusdT4zFKirc7FK/VCKfeBXX/tarTkl4wNFm8zpzzQAC6bjBplJLKVNorgqCuAmpK+boTukoZVj5PEE8DMgb55f9RJfYhAmXhKckECrHLdctgvM0TP+TQFksNkbyPitb/xYuaydgQPHXJBOnjKag70c6EAVLCXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFMCcwS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD45AC43390;
	Wed,  7 Feb 2024 04:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281233;
	bh=PEiKbepqN1tdzsrKwdIdcAcSszbVASQIy57fFJ6zAjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFMCcwS+mK9Ng1VfIQ/wUATOSvSezL/pd9K14mFK0L32ZY5GcY4swCVLYX0v98Q2a
	 6AM2XrnRLC3zPfq2qMalTcZpqoBoHZmWm7a+G+scgJOg3HKCpmnJv3oWxTEmEiYrkz
	 jOJf8fZCDWvzlEFgnHDKbiQrtMySwHVxx4obJjbybIwPWPb0ufZT9N4oL0t/8hU1Mz
	 tFdxeyZHJXgwMsWeUSGHdNXKN3D7MDNlTugR/erBcQb4ACCLCGHYBMRdm/EMt/Tw5q
	 duHr4E4BvUoPvBVPW9MaaYaLBrgxgEyAQACZ3PWJ8Rs5dINiF188+XH92HObRjDZ0U
	 fOF9ZoqwjOLJA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] arm64: qcom: sm8650: enable Audio on MTP and QRD
Date: Tue,  6 Feb 2024 22:46:31 -0600
Message-ID: <170728117685.479358.1744444074409243114.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
References: <20240125-topic-sm8650-upstream-audio-dt-v1-0-c24d23ae5763@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 17:42:40 +0100, Neil Armstrong wrote:
> Add the remaining Audio nodes on the SM8650-QRD & MTP boards including:
> - Qualcomm Aqstic WCD9395 audio codec on the RX & TX Soundwire interfaces
> - WSA8845 Left & Right Speakers
> - Link the WCD9395 Codec node to the WCD9395 USB SubSystem node to handle
>   the USB-C Audio Accessory Mode events & lane swapping
> - Sound card with routing for Speakers and Microphones
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8650-qrd: add Audio nodes
      commit: ce745475acacfe159a358897e122e38b045f8008
[2/3] arm64: dts: qcom: sm8650-mtp: add Audio sound card node
      commit: 6e9d86933cab198d6d86ee19f4b81fd1732787b3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

