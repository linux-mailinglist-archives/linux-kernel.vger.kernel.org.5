Return-Path: <linux-kernel+bounces-115617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E041A889CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034281C34B26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E134A309;
	Mon, 25 Mar 2024 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3OPrSvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E748201250;
	Sun, 24 Mar 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321402; cv=none; b=QjRI5MoJVcLbSsaOIrSpNbavBvKJ0/venCq7xWa2SKXgUD/jGbhH3Sl1qSMOyEmnVdrAPPJmQ9K/0wxbQLGABvV9kO/z/cX+KA+8gntEPURb8p3htF04qPE0TPKbaa6v9N3PdYWYPcksDRALHJtah06cCaM9IbmbhTH/d7DAbdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321402; c=relaxed/simple;
	bh=EUnoUEiDef9Ju6ymK0Atfqd4Cd2DW4CQpMJr/UKQeOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYg5E8x0Qaxh/8FNS7MyYkBBGRvckwUCUnbve3/kybv3gTwulgT+yUZBFdbV/vjiE3iHKQEvjMvLy4v4Gw5RxSyxyhfjqAwIxiwFdWKUOAwPPzb8CqX/UCnDh0jiGcEOjriSyAK0KgZw0KPwjg6k+sInyNatS70CL/Urdv0TmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3OPrSvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0719C43390;
	Sun, 24 Mar 2024 23:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321401;
	bh=EUnoUEiDef9Ju6ymK0Atfqd4Cd2DW4CQpMJr/UKQeOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3OPrSvxpIi1XRnZlj33+v/jpEEAqxU6/Lj+0sTDN2gO9Nt3Mo6OmQKjSVDEU80fd
	 v1TchPueKI+TY/dvGnpZjFTkgL6KLvJLDSdBQYt/HGlZz1DURXkZtnIruxJ+OBdHWp
	 +MknRxyYVl5gpc5WHEQJYJ1xu6IRpYk1bFvyfzv0jQyOc818JO6LR4EhLjGQfs6Pb2
	 qNAWxPwvu3tvzyDHWV0SeAe42bwHrmgx0xLIh/FLP9v5/Jmm5Q4yvy/jjVq2T8ebqv
	 6NHGuksEecg8EPpheFK03JoxYSy0pOePfW955KHDQ0eWgdKrRdNewomcCLM2Amsm4D
	 JGfouTEM5OLEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 125/638] arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
Date: Sun, 24 Mar 2024 18:52:42 -0400
Message-ID: <20240324230116.1348576-126-sashal@kernel.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 3c58b96df110a80e78fa36ef928f1e6c375008e3 ]

Most of GCC is powered by the CX rail. Describe that relationship to
let the performance state requests trickle up the chain.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-2-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index f9e929bfa5508..97a75678a5169 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -781,6 +781,7 @@ gcc: clock-controller@100000 {
 			clock-names = "bi_tcxo",
 				      "bi_tcxo_ao",
 				      "sleep_clk";
+			power-domains = <&rpmhpd SC8180X_CX>;
 		};
 
 		qupv3_id_0: geniqup@8c0000 {
-- 
2.43.0


