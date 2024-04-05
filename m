Return-Path: <linux-kernel+bounces-133397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F85A89A33F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39629285EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EF16F8EF;
	Fri,  5 Apr 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3rozz+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084E16C858;
	Fri,  5 Apr 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336947; cv=none; b=UbYjtP5L1SZSb82OOrJAEbZYPwC2KiLnOlmgQz8CuZmaw40NNrNMCSBP61RoOE/HlJk/a0DBkCGLdwQLOSUIerx71UcxfR9yOXi77anN3TWBsqHuO7a6edSwoWHK1CSacZwjb0XaVRwStDSNKKTEuH/hXbS9bR+/f2ac5R0vFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336947; c=relaxed/simple;
	bh=H9vEkwAxYj5wWq9yqiD29L3VLUbFY7RZslsH1Qj/VMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EutXQ8VRhWVOYCsXCHpE8eRqbQPps0ep+C4jXoynV4ZhIkj9a5MAocTuxOTKRkGv7mK3BFnSdrh5fNTvqUH8z+LOpaD43bsI9GB46WdP6HWwge3kUWxDpNON0xELPCwRJt1mlR4ZjyGq0m4BC4THs9jtlB0mmIdNJrIy6lQLg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3rozz+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF43AC433F1;
	Fri,  5 Apr 2024 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712336946;
	bh=H9vEkwAxYj5wWq9yqiD29L3VLUbFY7RZslsH1Qj/VMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R3rozz+a0B1YpNvB4vfXKtdF7QEdy3dG1YafDVgmfBpbuzYPfTa91bgsIRwc8EgVI
	 v4s7/oL7+AgdOqVl2KmgB1zqG6Qr+cBq2/dqbA/V6hHI+726GOASKO3CkQ5+GXXfZ6
	 IA99s/DigM7iZXoftJjwNCrh7cvtblteI6hfk3MEEp4WH8D6dPReWf+iVd1SLGfVj+
	 IAU2aywjYNc4Pn0xVhLpYu3upppPYYn/p97e2WlazkOtg6FOx7MckzIUXoUFCDZD1k
	 GAXAnqvauMbResQ63Fk51YV7SswZJVLVoWxxRsa12bsn4478igh8zIb+ba9DSNV3gy
	 3Rw/zKiu4l43A==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240226-topic-sm8650-upstream-combo-phy-swing-update-v1-1-08707ebca92a@linaro.org>
References: <20240226-topic-sm8650-upstream-combo-phy-swing-update-v1-1-08707ebca92a@linaro.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix sm8650 voltage swing table
Message-Id: <171233694335.304553.13639721114299894293.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 22:39:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 26 Feb 2024 16:22:36 +0100, Neil Armstrong wrote:
> The QMP USB3/DP PHY found in the SM8650 SoC requires a slighly
> different Voltage Swing table for HBR/RBR link speeds.
> 
> Add a new hbr/rbr voltage switch table named "v6" used in a new
> sm8650 qmp_phy_cfg struct replacing the sm8550 fallback used for
> the sm8650 compatible.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-combo: fix sm8650 voltage swing table
      commit: f320268fcebcbab02631d2070fa19ad4856a5a5e

Best regards,
-- 
~Vinod



