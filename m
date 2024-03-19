Return-Path: <linux-kernel+bounces-106948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BF87F5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA6E1F221AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2116811F7;
	Tue, 19 Mar 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQW87LND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF07C08D;
	Tue, 19 Mar 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816557; cv=none; b=J57YSKZstKDY1sNyTrDus5x4khxmH5VzkgiX3jsMYlpvfkZy/OytkhpNWhjtf+JZ4irsDq9xhoV9z7BC96N8+JLM1hGIMw0Lo3snxXc9m9cCdGHj/Nn2h8a7cCBioceT/vC80xKBctPTSxwDs3hp8Vkxt6qNH0c2YHo5cYreF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816557; c=relaxed/simple;
	bh=pR0pUKXdk4OaEm1W7BRUVAIyxgZurA/jvCPrd47GJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hL5NlFG8zT1ZeWE3OWm1iSTZeNobyU6jvrtAc5ALNpHS8T0irdoEEkZWxR+DkmCtyXj2QH+I0cGHArnyCKQo+lMEkQDq8PWtoptaxjhwAxdAEdJqT9bqr/hFF6STVyP4SbmcBZlqXOYOxzJcXHGi8zGkK9NgEXz79ehNLtRVr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQW87LND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC41C433B2;
	Tue, 19 Mar 2024 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816557;
	bh=pR0pUKXdk4OaEm1W7BRUVAIyxgZurA/jvCPrd47GJxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQW87LND/XUrKXrVIs+MMXvtt6pDb1XRllxlWbJzRYIadX3jH70YKXf+furE8AQZw
	 TsdTjRS6cqMJ/qktiOlE95g+Nvr6Reo/WYTrTVAhWe0rQFeZ/f9TA9VCV58wePf2U1
	 uc4ZvcvPlALWBonoR7l67nueUoefslL4hwefP3UhPum1zOrGST7a2eqBnt3PFMF1yi
	 mAo7xShuI8J+QLfVgfIzhJi5y+krY+GMhbpDYUJr9G9R195hIfsAy7KUJgWrDbeP4x
	 6t2Plygvtkn4dAysmMR6WpyquDeBkv08QcnYbYpUZigOrp9PwhoT0Q2UPYkkXWG1xa
	 OjLCSgYDZo83g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qcom_stats: Add DSPs and apss subsystem stats
Date: Mon, 18 Mar 2024 21:48:47 -0500
Message-ID: <171081652649.198276.8802375986980090268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215-qcom_stats-v1-1-4a2cf83d0bdd@quicinc.com>
References: <20240215-qcom_stats-v1-1-4a2cf83d0bdd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 14:53:50 +0530, Maulik Shah wrote:
> Add SMEM items for compute, general purpose DSPs and application processor
> subsystem stats.
> 
> 

Applied, thanks!

[1/1] soc: qcom: qcom_stats: Add DSPs and apss subsystem stats
      commit: f8627c303fd34ab70ff6fd8a1048ac11035b7fd6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

