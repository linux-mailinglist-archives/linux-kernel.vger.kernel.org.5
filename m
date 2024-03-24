Return-Path: <linux-kernel+bounces-114173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642568888E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A18B1F28254
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A39156963;
	Sun, 24 Mar 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3IoukpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7A136678;
	Sun, 24 Mar 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321495; cv=none; b=ajxazDZSXpZRY1vWg1ptvXTdeHVYLGbbSj0OZwB+Kgi24ZsNj7+utZFsL110hxHqDaeCSdc4oIn3grY6BabFzBVL4c5EyU2cmx1PJzaLnokjUh9cw4atJF22ViKMrqHhzFJNWaYk2JVYKfKOvAksQbKLmuaBNn0Xo1a1KglE0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321495; c=relaxed/simple;
	bh=zDwrV9qQ/N4C7MwDZaNZ+GJUXT8auFLqKHkwnMxLKcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjatkSraATFsXw5fvMnJM549wMMsSHIYvLpg1GSWOCFIf3xuC0/BM22bnTV/AQZoSg9cT0PnHEelhhW+FMC9LJ/BDvjfCLoKK5Xgh1E17ZLkVW6+OvUY4AkOgcYJ1B8IP8O6oz5SU2u/MShJZxBkr5xsvgbwuYXkcU3rHOiI3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3IoukpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8122DC43394;
	Sun, 24 Mar 2024 23:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321494;
	bh=zDwrV9qQ/N4C7MwDZaNZ+GJUXT8auFLqKHkwnMxLKcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3IoukpMGZxZWYSMYu9ObdvH66sKOOngj8Fdk5+mBtOFvHC5gb7n9qCG5qVccy1WN
	 0onc+uU0iAdHuoUqugZ+tVg7YyvwUGNC+0ISi6fSzLYwKgWOXirdyP4Rhn7ejz0Q0p
	 vvpzhu+mPt3OocmGWuIYn1MusWLidKWGiByiSdldZFyfCD0D+WmnupuMOqFGjSAaAV
	 CIETuyQfeye/D+14IzZKEYJGQhLAw6l6hIfiKVkNA0pRcKKydXwkHzmZwXWJFbFZ4T
	 IV62iowguPQ1pdu1Okeml3YhMpGdvIXl614aWX7Ek+WjCFr2kv6aWBCqNGLghyxI2A
	 hKrKwEUkHLVtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 219/638] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
Date: Sun, 24 Mar 2024 18:54:16 -0400
Message-ID: <20240324230116.1348576-220-sashal@kernel.org>
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

[ Upstream commit 5dd227ccfb9568935bdaf82bc1893b36457dd4d3 ]

The SLPI is powered by the Low Power Island power rails. Fix the incorrect
assignment.

Fixes: 74588aada59a ("arm64: dts: qcom: sdm845: add SLPI remoteproc")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231220-topic-sdm845_slpi_lcxmx-v1-1-db7c72ef99ae@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 234d7875cd8e1..5bf0d5af452af 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3363,8 +3363,8 @@ slpi_pas: remoteproc@5c00000 {
 
 			qcom,qmp = <&aoss_qmp>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>;
+			power-domains = <&rpmhpd SDM845_LCX>,
+					<&rpmhpd SDM845_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
-- 
2.43.0


