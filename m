Return-Path: <linux-kernel+bounces-115414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23715889B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A51F3590D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718212057C2;
	Mon, 25 Mar 2024 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBtCzUPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288C1D7931;
	Sun, 24 Mar 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320610; cv=none; b=F9eVcVimAfEMwPKR93fhaQhRCYpfip9+whDNZzp50X9JcZF9MDxwSpFmyebHM9XZZYa3B1CxFve+ZtqiyYAigXr3aBv9utZqTHo55I+/7dBmMVOMW7scJZSww+zIpJ14g5QCoWCZAqhjaiIhby9WZjhNj59+yH6IAF6sOFEGcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320610; c=relaxed/simple;
	bh=iD2tP2w5qBXFxh/WQCe5efjp671Yj3yfU9cw0LsYFyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuoZV5pVicYi1O8QFqRurUSjx47DdqgstYdsdtQoV9utuHLJw3FIG++7neS+ad5RNTx8fUCC6wBHVikHz1Ee0jfWJ6N7QTi5gpVa/LsSqOT7pLCZvIo2BEOxptvbpciwv8McbzBUyrlyjwHR8S+ZFzj6nAtzPkXC9mrHIrbBzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBtCzUPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D01C433C7;
	Sun, 24 Mar 2024 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320608;
	bh=iD2tP2w5qBXFxh/WQCe5efjp671Yj3yfU9cw0LsYFyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBtCzUPNYdneLOpN6ziQXnS3ocR7T6+g2PaVOgSEJUhvFgpWD80Qx8C4f3PiULLnQ
	 zxThtLpDqcXuwt3PoyPyiziGcBF0wXxcQ5SF7TyURUPqiJ7MGjuRMz2j7fOiP0YBD+
	 HyZ4teVbTqWl+PP39kFyiJthMjYd7FSCSdCd1oMyvx0JsaRVFJPxDrsUNYjyPKetFZ
	 IYBmC6heuQjELNNUed3ndr3K/nxLSlXdgmM0TIcVIyImsZBGnLfAbHo/T8uawooHH4
	 JSjtHGu2S239ogHEqOd82+/YswBaCgCtM28/S6qR410UnGtCTLHXjSym0JSyiv6pWe
	 GYJ1xP/nrfpZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 169/713] pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
Date: Sun, 24 Mar 2024 18:38:15 -0400
Message-ID: <20240324224720.1345309-170-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 883957bee580b723fd87d49ac73e0c84fc03a446 ]

On SA8295P and SA8540P gfx.lvl is not provdied by rpmh, but rather is
handled by an external regulator (max20411). Drop gfx.lvl from the list
of power-domains exposed on this platform.

Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240125-sa8295p-gpu-v4-4-7011c2a63037@quicinc.com
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/qcom/rpmhpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 0f0943e3efe50..e4d5afab7b3b2 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -217,7 +217,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
 	[SC8280XP_CX_AO] = &cx_ao,
 	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
 	[SC8280XP_LCX] = &lcx,
 	[SC8280XP_LMX] = &lmx,
 	[SC8280XP_MMCX] = &mmcx,
-- 
2.43.0


