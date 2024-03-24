Return-Path: <linux-kernel+bounces-115405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0E8896D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21897298BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88748154C1E;
	Mon, 25 Mar 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBb2dEUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC941D1D65;
	Sun, 24 Mar 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320583; cv=none; b=cX3Rscp7oLceiuQQUTQqjPLpCsoTaq7KOe+7bXugNnkKGX7ptGYm/EXuQ0j9mFDaC7HfTyQ9QoTuoy5jEobFiOtSCY66obMJRYDBjjTOzAO+vgZe0JktO6d4bZtCApm2ImLKJ1U2ysujXrlus0RFvSWPvH3UhcYG5SKHQGT3/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320583; c=relaxed/simple;
	bh=l6C4Gt3BuSiTVpDszGUvAntoV6yA9mHB2XxgMdcptEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVQ1EWCxpsuqtECj6C1NC1Z17s1usPKf/R5YokPg4eTNcFFs1MRDE1U2dvO70/j+vQGHo8dVqOJr3H7WLzteH927iBGy9BYqR45bAFsQRDlFD/iEuX4gA/ya2ixlNKFwNjvkpuUvJEIIHpQOVcxv7RKD6V8CovSWkf0ugH7vk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBb2dEUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83211C43399;
	Sun, 24 Mar 2024 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320582;
	bh=l6C4Gt3BuSiTVpDszGUvAntoV6yA9mHB2XxgMdcptEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBb2dEUxRumjl4XWVDNyeDgzFbvOpDkK/7HDWcekMJl4bCtdn2qGXaraP4Vy2B11d
	 uJZk4nU8pqTWgW9ATMLLWZ6xZAL4ZOwcuXpsnuJ4RcVUljKd90nrSKOoDVvNLQynfr
	 3Q0PFK4unGzZR6s5Yg8oGr6o0s1QuxidS1IdHKm2T5MtY8kvn8dZuXLG+l33ynefWU
	 oK+6h6FFwBo3NDvrMAWPDxRb3R8pbk6CrhgzFpONZ8LXeRDCub6iLcd5zUBDk59V6p
	 Q0QSlIKqvblCyd3hovjcHnyTT+LOJ3gjS/TX+K2wDVEZD0xu0SVc6wKk9nlj0sk1sU
	 +8DyfnT3MBxOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 143/713] arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
Date: Sun, 24 Mar 2024 18:37:49 -0400
Message-ID: <20240324224720.1345309-144-sashal@kernel.org>
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
index b389d49d3ec8c..b1d9853419415 100644
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


