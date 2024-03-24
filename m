Return-Path: <linux-kernel+bounces-114104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676E888871
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C82B1F22CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7823B470;
	Sun, 24 Mar 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM1Q7Ut7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA320127A;
	Sun, 24 Mar 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321408; cv=none; b=G04PcXSeOiQc9vlS1SSXp2WFKb5POh4i+q0boYNfeQmKdqMmPVnkDaiaMg2nhcnZFoGYOkLuX8SyidvF9CJRpotISG7fX5ZHDl4ICNsGj6VFYmI55PBm1Z2CGrmx1HOFkMUluVq1PCeos0HUv/HCQCuN79BAaIPmrymgRp+os7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321408; c=relaxed/simple;
	bh=n71pM3LvilKHX9PjjzODL+40J/Vl8g0bAl3/erD3ULg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuTq54UtS6KsxrF+9dxUecsXfQXnS0Qvo1Qi4DZp5aRyP4/XDs/J5hiFLXIBDvIJbfqd7mxXnknncfBZKNE8ypHWEnRMfUDWUcD7x+dqAZNDysadqsRqXnEQMUT0yQbV4GbmREiag1NTF4bzqATfOPVnz31foLBg35zTXebbZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM1Q7Ut7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E04C43394;
	Sun, 24 Mar 2024 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321406;
	bh=n71pM3LvilKHX9PjjzODL+40J/Vl8g0bAl3/erD3ULg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM1Q7Ut7fT+MjDFkhpHm0LHZDUy8IesKplPWSpRW0SWcZurDhiCyEn8B3FuVsLw3c
	 bu45mBPfwCjozMkv25Nd+wAowVr4SRrgmjLjtcxALGEoJhamar6PvXezT1jRI0BDtL
	 vkYkuYjwExCzDAwdJvVSZEVdNYQ1WDVj+6rIjPxH/3+9/hKHhGEiXeiffeYkvqbCfH
	 +qujhubHj0MyjhNcgPm6biEItyzISQ79HhTALlR+Qinyh+Tea/AiIqcu4JY0lpcLIT
	 kPIf2LPNLmS2srYjhZPAnJ3j0JmxIhB02azWUxNabB+KAbJC7bIES5ljhprrrQTaIt
	 A4BmaiyFg07gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 131/638] arm64: dts: qcom: sc8180x: Shrink aoss_qmp register space size
Date: Sun, 24 Mar 2024 18:52:48 -0400
Message-ID: <20240324230116.1348576-132-sashal@kernel.org>
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
index de53541858420..6eb4c5eb6bb8c 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3257,7 +3257,7 @@ tsens1: thermal-sensor@c265000 {
 
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sc8180x-aoss-qmp", "qcom,aoss-qmp";
-			reg = <0x0 0x0c300000 0x0 0x100000>;
+			reg = <0x0 0x0c300000 0x0 0x400>;
 			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
 			mboxes = <&apss_shared 0>;
 
-- 
2.43.0


