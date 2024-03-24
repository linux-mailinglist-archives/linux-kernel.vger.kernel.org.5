Return-Path: <linux-kernel+bounces-114122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA2888888
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988B8286154
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5223E43F;
	Sun, 24 Mar 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSuBjtzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7A202393;
	Sun, 24 Mar 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321427; cv=none; b=Oh5GKYDFd+1oDipxk5x4fZMvKt/qFquNYzE7FU7RP12UrTKZUZqfZnK+v9SsMBKglG4CodzWgcC6GIeAq/mTqXjYUpSyDW5WtvlIcVVGvZfuw2jDCymqIloq7W8kphiLCkRfzxM6hNLr0NCRgcE00EZBLETAVNYH0PeQj6jnQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321427; c=relaxed/simple;
	bh=ENmzeOXJwmG/br6zOUsAuqC66/r6+HqYQSJyjqqWua4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZhai3Y8fGTqW0C/gt8Z7Q0GuCHrZ7ZYUPUNVSef1kui/rzwX72UmOu9+cmDKDGFG4OzDnogAxIPo8AavsKtcN5szl+NYRnZKwdnHa5HByKaTiXo7Wv423uxefO/SBKLSRF1h+uiOIf+h0zchrV6wQmNMtCh6WrDID+NbkFTWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSuBjtzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FABC433A6;
	Sun, 24 Mar 2024 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321427;
	bh=ENmzeOXJwmG/br6zOUsAuqC66/r6+HqYQSJyjqqWua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSuBjtzzKmqRM5dEgru4BRVARaNI0Ag41KNpIw09gG/oyjKQ+HKiknLTO29fYHC9F
	 k/6WWVryaIObs2rp4nyXU8pn9a4L9L4IZV2Z7fUi3eORS0Rg93/KiColz5MqYBYVLJ
	 3HqeiHg/yvlUWTH7fsVwvlcoF2pxmiijFw4KbdETeiDPmUc2hUqA6q915ibSAUxtIv
	 kycIEWP/lc5KEU3go9JSMIXMAdHkXgZM2D3eZ9tPj8iUEtTTypB7jWus5qh4GJZ5Vz
	 fWtPFZw/pbeiSyI5Vki0pg8QrIZYbsGXw/uOcNf/wGOjgPA0m8txTgfL4R22AjTTKR
	 ktbgNyfaO3YSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 151/638] pmdomain: qcom: rpmhpd: Drop SA8540P gfx.lvl
Date: Sun, 24 Mar 2024 18:53:08 -0400
Message-ID: <20240324230116.1348576-152-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 2a811666bc9d0..efca30c185a15 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -207,7 +207,6 @@ static struct rpmhpd *sa8540p_rpmhpds[] = {
 	[SC8280XP_CX] = &cx,
 	[SC8280XP_CX_AO] = &cx_ao,
 	[SC8280XP_EBI] = &ebi,
-	[SC8280XP_GFX] = &gfx,
 	[SC8280XP_LCX] = &lcx,
 	[SC8280XP_LMX] = &lmx,
 	[SC8280XP_MMCX] = &mmcx,
-- 
2.43.0


