Return-Path: <linux-kernel+bounces-115364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D684488A0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC34B23540
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC41EF7F3;
	Mon, 25 Mar 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCf28Ahi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5DB1D791C;
	Sun, 24 Mar 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320605; cv=none; b=RIoqTeDojwHvaXx8tE5Ou6lOu0OpkMDjV7CT+fI0CT0f7m/41T9gt1WeH119SCD5CXNVSzb5zKt8b5g8FhVr7CJz5fwcoOj7YOXTw4rf2KSSIDQvujVywiN3Yn4hetyh8QBQm+Jqh/xKE7jGkMt+QY/BIThzMSSuPewItLzEyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320605; c=relaxed/simple;
	bh=HZWqqmqbHkrcbXrUTxMgEXv6AXhAmJ7jFq9Fwj3RpIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tY0JLZhwFcheKZ+9m8cyF8FxQIrq35gCt6pobMf16QfdI8JyBe6KthvkT4zLRIj0MEAaQr/IYr/5RJzalJvqUjqQlEFuHRd56afQlrr80yc89bsIn8VPKOaGm2M3YOomynqLJ3xbmHSkz0vpJh2YQksIy63WEqScQJEQbGtsmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCf28Ahi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91693C43399;
	Sun, 24 Mar 2024 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320605;
	bh=HZWqqmqbHkrcbXrUTxMgEXv6AXhAmJ7jFq9Fwj3RpIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCf28Ahiru/aF2g2iv7aKw/ckneMpMyGKcNbHg/vO3HKY8M8qZernVvONyqp1bTNH
	 LLzOWoGVZAYFDysUwqrUTfci+eXTICktHoyepF7OGhtC1evLUV+PiWKfr+8uxGzJKV
	 zfQG8PlhlW2fXlJszTb7TNqCv4eHyIdvI/d4MK++Hfm0ecYU6r9PTO8sGMIunexhn+
	 1qaSWnCROzLQQbs/gD0B9w7AJQnu7JPlOQLtxnF/s1p/fCrWIcI0cjJerytZq9Tvgy
	 HknVlQ750w6J1zEBD5Ye/tcCN3Ae3tUYnzatU/aaVPUo8Ndv25IT/4kDmTrPbM6TYn
	 mxg9myp7X8WDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 166/713] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
Date: Sun, 24 Mar 2024 18:38:12 -0400
Message-ID: <20240324224720.1345309-167-sashal@kernel.org>
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
index b523b5fff7022..13d7e088aa2e1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -485,13 +485,13 @@ &pmi8998_charger {
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


