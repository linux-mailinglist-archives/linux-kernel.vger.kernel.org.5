Return-Path: <linux-kernel+bounces-35442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53592839131
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866811C275F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DDA5FDA1;
	Tue, 23 Jan 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZndW9YLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2B5FBB3;
	Tue, 23 Jan 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019652; cv=none; b=HYU4/w+ftFdP2dOnlZK6UZLTKFxw0cWqJDKRi7LQ7CE0o85iQHNcrR+awBefzh52vrtwsTY105Va81BPwTKOkcvccCJQo8Kv8/FJu5Qg7vQ7BWCu78MRRrAaQP5NFsfNuXHdx3tUJv4tB5OrvBFdD8ueCEcgQUM+AXs9pceaGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019652; c=relaxed/simple;
	bh=BSqpNwWvvj06ZNWgnkxVT5ti2mYYSuS4FzKVFq6L3Q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5z32d8xtrBdC4m88XvHR+pqHdogFFh/r2v26cnST0MyQXyJb9XG3H+TMmpXKpZVF8lfOUCUJ5eqvpXD9HYQgqobVVm/N4Rpvryc0i9VvZ8WWm/k/meOXxyHWgEra7pUvowXPPccWuNlDL6YWTEgemYMmjFs5MxxcXfvgt6o2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZndW9YLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE6C433C7;
	Tue, 23 Jan 2024 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019652;
	bh=BSqpNwWvvj06ZNWgnkxVT5ti2mYYSuS4FzKVFq6L3Q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZndW9YLr0E9gHuSZrXWZVLpxpOChQ+pzpMFveSt+0RdKJ4fHC4KcBYbA/bfv2pDoR
	 LJqO6ofO1EeTMU8WVCDmpvtw5hSwLJWR4uY/9HdfGBysczZq+wDfIwjkmMDF1W6izE
	 yKU0s/++Go+Aam+XRea8A/9djoFQdlfAGaj5MjtSnzFZFTTCpAhz4O5fq2XHeLGSh/
	 wBjwojPAuQqM9EwuXZBwHOl/3Kk1REoop8E/AqJiqla3rSX3l5hSB/bWz9FlEeX//j
	 L8hmUjrNPEcfnVdNEGCsKc30BfpzzWv2G+qHXbcdLpwF8n83zP5qFI+9NYMUYFFzT0
	 PINdGtXOzUYYA==
From: Vinod Koul <vkoul@kernel.org>
To: bvanassche@acm.org, mani@kernel.org, abel.vesa@linaro.org, 
 dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org, 
 Can Guo <quic_cang@quicinc.com>
Cc: linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
In-Reply-To: <1703557892-1822-1-git-send-email-quic_cang@quicinc.com>
References: <1703557892-1822-1-git-send-email-quic_cang@quicinc.com>
Subject: Re: [PATCH v10] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-Id: <170601964819.371263.15091699444243668502.b4-ty@kernel.org>
Date: Tue, 23 Jan 2024 19:50:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 25 Dec 2023 18:31:30 -0800, Can Guo wrote:
> On SM8550, two sets of UFS PHY settings are provided, one set is to support
> HS-G5, another set is to support HS-G4 and lower gears. The two sets of PHY
> settings are programming different values to different registers, mixing
> the two sets and/or overwriting one set with another set is definitely not
> blessed by UFS PHY designers.
> 
> To add HS-G5 support for SM8550, split the two sets of PHY settings into
> their dedicated overlay tables, only the common parts of the two sets of
> PHY settings are left in the .tbls.
> 
> [...]

Applied, thanks!

[1/1] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for SM8550
      commit: b34ae8598c9c3a95e7f8eaeaa1fcf6fdba0aef68

Best regards,
-- 
~Vinod



