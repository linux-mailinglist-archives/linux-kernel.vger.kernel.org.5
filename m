Return-Path: <linux-kernel+bounces-112986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3292888048
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CCD1C2124B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550212D21C;
	Sun, 24 Mar 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucC8I+KN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160712D206;
	Sun, 24 Mar 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319798; cv=none; b=ZnTXItHPMJOBTi79HNPVQkqiCNhFXaCCN9X/3PtJcNaQlHuGF1AcqpTjFmXsDM2mJbNbOfjxikF92n/z5c+r+jZsH8Fplcr9Myy0YIW3OqbinVAEcWtIzPU52OtxFt2W0MmlJHB3B+FyMiVZ8ACC2LYbZYGfTWUgqCfErAuqHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319798; c=relaxed/simple;
	bh=oL72wGx3zwjeeKYeLuybUd//Og1bGXKWdISX0373VC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFejAIBujd0cj+OzcNlVtOe5MJis6+j20clrZMQM5WD+tmY6w8fgXw8yAQcwFKvPzHVoXoQrLWP/WE6eLvMLDJAfrKv6iQORufQ+0lJujMgMNMReLlFrVYrTutD8UKi6gPQp5BkCUpJM7+fCwWXTFycIYoQMRuxC+lNyfo9mj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucC8I+KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FDC433A6;
	Sun, 24 Mar 2024 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319798;
	bh=oL72wGx3zwjeeKYeLuybUd//Og1bGXKWdISX0373VC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucC8I+KNsobTMe3csaQFnp1Oyxfg6nisAhujGSFxbk0ByHcZH286XDDPvP3qQGSod
	 nUWnN75WYdKpU3IWV+n5d2VvYQshwXwU63GupkCi6eQuP+0bHJo13m6O1vqoXobPKb
	 UIYckhyCmGngrBb+DF/YlXnzLZCezy/pWx2jyGp5Qykd0HTiERtPdTk2iOl3e7rQ4V
	 y3PYLvAR6jUtHADWc/RLUHQ0WM08WR0kowpDeG7yEbVOkQ9RI2q6BbXvyDB1hK6l6Z
	 PqLANNAbtXsnAqSOJUzZCaY+0yfrex7AXvGLwTj4DMT3TWtQONZ/abl4xUV92RdZJM
	 i+eicMUHZNydw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 099/715] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
Date: Sun, 24 Mar 2024 18:24:38 -0400
Message-ID: <20240324223455.1342824-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

[ Upstream commit afe9867a0c0e10ba618c15d4ef6f8699872f6cc3 ]

Make it easier to understand what the reg in those nodes is by using the
constants provided by qcom,q6dsp-lpass-ports.h.

Name nodes according to dt-binding expectations.

Fix for
```
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: service@4: dais: Unevaluated properties are not allowed ('qi2s@22', 'qi2s@23' were unexpected)
```

Fixes: b7b734286856 ("arm64: dts: qcom: sdm845-oneplus-*: add audio devices")
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20231229200245.259689-1-david@ixit.cz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index e821103d49c0a..46e25c53829ad 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -508,13 +508,13 @@ led-1 {
 };
 
 &q6afedai {
-	qi2s@22 {
-		reg = <22>;
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <1>;
 	};
 
-	qi2s@23 {
-		reg = <23>;
+	dai@23 {
+		reg = <QUATERNARY_MI2S_TX>;
 		qcom,sd-lines = <0>;
 	};
 };
-- 
2.43.0


