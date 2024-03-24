Return-Path: <linux-kernel+bounces-115406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438048893D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E319E295514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B46202B85;
	Mon, 25 Mar 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6B+xpqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27098142E64;
	Sun, 24 Mar 2024 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320584; cv=none; b=tVbI9aMpTbr2oeS/aKUnv4Afca49IlX5xAAGC4nedlY9vaTif7frVESJn7jA/XSDwJ/vMnvPxrYiWGHnyKHOX7H9Xto6OqBsZEnvnmP/hlApIZ75Ia9tzOC5AeqDzHA3s1rRZT0uFZ+0F43+6/RS2UavScUh5DxbVuVfd150K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320584; c=relaxed/simple;
	bh=YpNz7k0bZJf6FZIogUl5rE4t51Gl1H2vSO5ig7uR1Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnnxTUoS33yaJ+PLd6Qx9+UO+oypk2cQPtkEYsNQK961FF/9sl9lvPVej0MstbAkkq2GhFfSzof5etTQygDlN05mcqmnLkMuThbsuSD5OLG/dK6x1RwL4Ma6IzHrU5vDbBZRluZl/3hnxC1PKD+w3ViDHoniy927J0f4US+Qeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6B+xpqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673D1C433F1;
	Sun, 24 Mar 2024 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320583;
	bh=YpNz7k0bZJf6FZIogUl5rE4t51Gl1H2vSO5ig7uR1Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6B+xpqj4siV5pLv2+z02Sm6XGFc9mpjL49xmuh1qnNne8ArFjQMGxk75V6BD9rgS
	 JINIORXYLiLtPHXI/ju/TVKDNQ4TIQk5HOvmfv1jaaLV6lUgv7P3YIBReTmZuP6FBB
	 LNGMo6JegUU+nPhxrJinipiOv2F1fLsna1RmJ9S/cdGxmXQPLIoyDlrYDESOVHPF33
	 88gtAUiQWUuW23pWMHGdcLG8LKZD5Bo+KykMsl5b5CBIkv4Mtr0vWnAbAaqDhT2wa3
	 EAoAurq959BTU9VYyNYldZvq1+gbkB2wxFxVLtsojSGlta0likAEhezPf02pXUD8jq
	 nn4W4RnDl6tlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 144/713] arm64: dts: qcom: sc8180x: Fix up big CPU idle state entry latency
Date: Sun, 24 Mar 2024 18:37:50 -0400
Message-ID: <20240324224720.1345309-145-sashal@kernel.org>
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

[ Upstream commit 266a3a92044b89c392b3e9cfcc328d4167c18294 ]

The entry latency was oddly low.. Turns out somebody forgot about a
second '1'! Fix it.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-3-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index b1d9853419415..f2eedbdc025c3 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -289,7 +289,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <241>;
+				entry-latency-us = <2411>;
 				exit-latency-us = <1461>;
 				min-residency-us = <4488>;
 				local-timer-stop;
-- 
2.43.0


