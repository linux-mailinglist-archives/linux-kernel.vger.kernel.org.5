Return-Path: <linux-kernel+bounces-115359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C097C889B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AE29C909
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA221EE695;
	Mon, 25 Mar 2024 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieYiv/KS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C2142E69;
	Sun, 24 Mar 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320587; cv=none; b=n5wAocOWGSeL7/TF6Kva9H9tiZompvcf7rE2QlR5Uobgbo6RUhoMvP9bcUb4Rz3RvHKChgegqlXr+uxZGGckQkQKsneucE/j3jUN3OEdVDLR8VEzq7BTt9lTnWjyMxaslNzVzsu/jtNBBo4uJjeCIT29GWA9V5RClLEdR31zqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320587; c=relaxed/simple;
	bh=v4tpY9TjgoZAruqQPzt21efiR6gEuxM8n2q2NqUeDqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6UTzisFeHmLk5+2/tLKhy6qIhemanq31CjONsDsvQFMOEdoCKy6NgAG1pQQiOfXSDGop/sU91UYk5nBBCRnWaaoLJ5AjLRxMMqGZlFbnYt30GhDgmmi2KuALqo76pMJ/jmMYba3KT8zAaD7dsvVF5PjI4CFKCYo49NwRMk5pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieYiv/KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A27C43394;
	Sun, 24 Mar 2024 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320587;
	bh=v4tpY9TjgoZAruqQPzt21efiR6gEuxM8n2q2NqUeDqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieYiv/KSeYHLwBlWEmvYMibdlEGoghjIlUSzXRBCgYO3UvsX0JmAOlE2CCDatutGw
	 akbYsa0B2U4iBOLUSURnw+02wLWauTYau7D8l8EwMmG6CHjLcF8FDzn1UhCBIyis8U
	 5WW4BbjQ9mjPeT2/7Z4jY9opYn6RQ/vyqFnkz7N/WQ1wRhFK+lm5P5Of2uj5C9gjof
	 hh7gX9vib11ZiRy4/s8Uysr/1+flsgy+7HDFFbA3R0lL0jJ7B84em8zAshgoEkYmds
	 hFt8TssiDzxhbMtEhx4QsEAn+UdhFb1hmKE4ApabCjpZ7ySKFzSW2sG0f8BW3MOm0t
	 TkuFwd0nvIzew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 149/713] arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
Date: Sun, 24 Mar 2024 18:37:55 -0400
Message-ID: <20240324224720.1345309-150-sashal@kernel.org>
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

[ Upstream commit dcad0590d1ea4278a55c30dd2903611a96111601 ]

The AOSS_QMP region is overallocated, bleeding into space that's supposed
to be used by other peripherals. Fix it.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-9-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 881b4e0d5b8b4..6760f6a340975 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3249,7 +3249,7 @@ tsens1: thermal-sensor@c265000 {
 
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sc8180x-aoss-qmp", "qcom,aoss-qmp";
-			reg = <0x0 0x0c300000 0x0 0x100000>;
+			reg = <0x0 0x0c300000 0x0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
 			mboxes = <&apss_shared 0>;
 
-- 
2.43.0


