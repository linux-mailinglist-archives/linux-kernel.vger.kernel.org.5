Return-Path: <linux-kernel+bounces-41424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA983F0C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A23E1F238E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA4D1E52B;
	Sat, 27 Jan 2024 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyizPbHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAF28F5;
	Sat, 27 Jan 2024 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394867; cv=none; b=X2JXW27HdnCA5RBt4MP0zvtNr5Wtz0QZVrvpab4SfwsumlVoYKldyIzk7UXfFD75msSRCBy7kQs5ry6CYTj/OzsLM28XCeUiQh2nAWYx+74hksxilwblnM9+Qz5LuKlNb7HcGGXpaaVRlCN5wJ882KKta9q9ie1ploHf4teVYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394867; c=relaxed/simple;
	bh=iNJCVwBYoi92TF68dI/xBHr9ANWwQklf9tMHA1ga848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEB0cxfH+JLSRieUZcKMu99apGxwWQQOn0GxkoUr8r+5WSgox6n42v5OplJzQNiMkHLUAMAr4Lb0zmJr6L9iBV3vFnBR8UJU1FFRIR9KklMDPGvZModEHtHuxWw5o9gs4BOMI2yljDYd+UDBbEUdKsW1v0ml+WU9wVi6VM639ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyizPbHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA0DC433C7;
	Sat, 27 Jan 2024 22:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394867;
	bh=iNJCVwBYoi92TF68dI/xBHr9ANWwQklf9tMHA1ga848=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyizPbHe6MwmeLMSlREOBLZYik7O7rn8awukKrZODEOGbEh4WVPGg6tfU2mB7uXMe
	 tQL+/6MrV+blK/MWomFLlFqCQQuWIW/Xby7tzca1+k6roV7I+GKNsSla/aiYMvMYvo
	 ofmYQ/CqIWJr57c5w7n23NAOVkRqXVLyJrRGFfM3j+a8xcGzLkz1Y9YhHPjTb4AtMN
	 33r1n6LWf5EoljMrap7fA/MJe02X/fpuZsqLP/iQ6mlwezQat02LGb/HnpF8WExSpC
	 /vEnYpV8hE0NlD+KOejjgLxvjvszfF7mPWA31akp8SfcBaR53FtVf6x+LJ8v6KXP5V
	 k+xjjprSqEsow==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] More 8180x dts fixes
Date: Sat, 27 Jan 2024 16:34:20 -0600
Message-ID: <170639483110.20773.5258274792331313647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
References: <20231230-topic-8180_more_fixes-v1-0-93b5c107ed43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 30 Dec 2023 01:05:01 +0100, Konrad Dybcio wrote:
> SC8180X has got various random power plumbing issues, this series tries
> to address that, and introduces RPMh sleep stats.
> 
> 

Applied, thanks!

[01/10] dt-bindings: clock: gcc-sc8180x: Add the missing CX power domain
        commit: af5b3a595954bdf5a7fb92bd6594fccd241f77b2
[02/10] arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
        commit: 3c58b96df110a80e78fa36ef928f1e6c375008e3
[03/10] arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
        commit: 266a3a92044b89c392b3e9cfcc328d4167c18294
[04/10] arm64: dts: qcom: sc8180x: Add missing CPU off state
        commit: 07b600dfdfea65d58dd80ea25becd8cff69bfafc
[05/10] arm64: dts: qcom: sc8180x: Fix eDP PHY power-domains
        commit: 24e98cb3d5e2c86565680e00008a794b4eac0040
[06/10] arm64: dts: qcom: sc8180x: Don't hold MDP core clock at FMAX
        commit: 309b5774f45aafd002efdb2656673542419abd6f
[07/10] arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is on
        commit: 6d9fb9e4c473cdfd2adca019b46d8e482105cae7
[08/10] arm64: dts: qcom: sc8180x: Add missing CPU<->MDP_CFG path
        commit: f0cd5a0ebd419bd151ed79baf5f044da797521ac
[09/10] arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
        commit: dcad0590d1ea4278a55c30dd2903611a96111601
[10/10] arm64: dts: qcom: sc8180x: Add RPMh sleep stats
        commit: 3168e86af8d1c346edf69b2114b3948ff03b2848

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

