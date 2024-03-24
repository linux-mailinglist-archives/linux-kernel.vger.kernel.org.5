Return-Path: <linux-kernel+bounces-113084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E7888156
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14021F20E38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB714F9DF;
	Sun, 24 Mar 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNfNWj4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8414F9C9;
	Sun, 24 Mar 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319892; cv=none; b=J9X1iGcveLtn2lTPUVJucLyRNrhKp/ILcxJWk3kQ1Kyvh+CW3EuThbJ/HzW/wndV9Rt0eiyvKdgzIUI4Rg+tAvi06HN8OL3tTMerxmEiuWuBQH6dn1BzkH0qvJ+HKtAyMXquEGn8xM4YCM6yXsYewcqZIyYTjiW/GAiRwJBtisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319892; c=relaxed/simple;
	bh=W/eocuTimWRq8wjEAwfXhQK4vhU5I4Kc5f4DFkIO8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIA3zk/xqRGBcRXAhKK6MwIdj403AFS0z9l0sFpcW1aaTfjG0FAvuLHrsQvrZBVrUsVti1WJaJXAQY3Fj4nnQ+oztcm4u9GQuLkSs0THNAa93RLobyjgH8wgpE7CIbk6zXtoDmWVb+2KeI+Ff5iR6NRtAi3QSqpBuWaMeM0JY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNfNWj4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4F9C43390;
	Sun, 24 Mar 2024 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319892;
	bh=W/eocuTimWRq8wjEAwfXhQK4vhU5I4Kc5f4DFkIO8S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNfNWj4KcdIMmiMbE7HhULFil/Mrvs6Gv3QK612vDLYcaOYgMHYPf62+k+pDbfUxW
	 gJ+9EvBMnqoeTmC2Tz6HFIAfi43b7v6otoWPRL4SBt4ktZD3pUR6tEht24KJpNqhdM
	 0vkNY+3z+BtkOAcZ/VWgMDpoMqS0R8OZyabGKs+86JxgRjHFCmeyNaJs0tsLN9wBVC
	 l1oztDKDmE0kLc9CpoloVETN9rpcT6YM9y+VYTrYqtTVsoEleALIO96K0QXE76dh1q
	 cyezY+yx208YQwUfe9IOABT8VG3LE9IhEetChsO6WmEYeXeNiX6pfDuu+Px0j7ZAOa
	 u4fQGT1KQ7f0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 197/715] arm64: dts: qcom: sdm845: Use the Low Power Island CX/MX for SLPI
Date: Sun, 24 Mar 2024 18:26:16 -0400
Message-ID: <20240324223455.1342824-198-sashal@kernel.org>
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
index c2244824355a2..237d404861424 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3366,8 +3366,8 @@ slpi_pas: remoteproc@5c00000 {
 
 			qcom,qmp = <&aoss_qmp>;
 
-			power-domains = <&rpmhpd SDM845_CX>,
-					<&rpmhpd SDM845_MX>;
+			power-domains = <&rpmhpd SDM845_LCX>,
+					<&rpmhpd SDM845_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
-- 
2.43.0


