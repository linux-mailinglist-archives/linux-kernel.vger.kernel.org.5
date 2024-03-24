Return-Path: <linux-kernel+bounces-113071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1688813C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BE12827F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63814A0AA;
	Sun, 24 Mar 2024 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV3TyEzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A414A091;
	Sun, 24 Mar 2024 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319880; cv=none; b=C65oHnTmf3j0Y8iyEoMWFeojl6+BBdvw4O3DDLn4YS/GE4xXeHNqDyZUTaZJePOj/3h+ds77+ZoPQGuTD+uWEYiHZDw3Bg2q7biXJB4yTyOSCgtrNcF3IAlxWGetR+YCCsbHEx0RshFdps2Y83+aBZUMszr3MVC3Unke4/3xQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319880; c=relaxed/simple;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1LzNjFlkLhKgfiG7wZ4BQoEmrRZ4D9v5tasAwjz1ehhbkPI2Lvrlkf/5pdJYT0O4+UsBUlvMXLshIegmea8SvAymEbwMskYK3O3BpFbhoic7Sosd1stTrKoVsY4G1DVZDqhyAeiMICi5mWMsjx3e0Vit3BF9leCKuq727aWenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV3TyEzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0711C433C7;
	Sun, 24 Mar 2024 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319879;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DV3TyEzE0ERD0V4hXLLMGdkNBH6qw/xLbOeSfAA78AEgdsSSVTqUcxRTter3Kxgnh
	 MqFyGG88MSLyPcOnPvjeVhaV4tencVpOWejrisq2DefAeW+Gz5hNynbL+F2uhN6fmD
	 3jm9p1MhLmChDsO+7J0gaa/V2yP1c5qqZSXWSYwOgTlQXW21kSWAe4PblU3xRiLEFg
	 28ggvYKlDZo+5KSUVIX5YeG64MAo9Nr/z6+RSsz9M8qGJyNthgYR9NQYUFvtvG6D8Q
	 m0xG+bLwLIO7cnmbE0r/ZGK3jnzyMNqIRZ7dT8Glas2nPc8dcW+RfwER+ijVCFzwHv
	 FdW6sYEQZfFFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 184/715] arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock name
Date: Sun, 24 Mar 2024 18:26:03 -0400
Message-ID: <20240324223455.1342824-185-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit bb69d19c649669f700149df309245cd925612f7c ]

According to the "inside-secure,safexcel-eip97" binding "clock-names" is
required only if there are two clocks specified. If present the first
name must by "core".

Name "infra_eip97_ck" is invalid and was probably just a typo. Drop it.

Fixes: ecc5287cfe53 ("arm64: dts: mt7986: add crypto related device nodes")
Cc: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231116132411.7665-1-zajec5@gmail.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index fc751e049953c..a7d9c3246a875 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -234,7 +234,6 @@ crypto: crypto@10320000 {
 				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ring0", "ring1", "ring2", "ring3";
 			clocks = <&infracfg CLK_INFRA_EIP97_CK>;
-			clock-names = "infra_eip97_ck";
 			assigned-clocks = <&topckgen CLK_TOP_EIP_B_SEL>;
 			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>;
 			status = "disabled";
-- 
2.43.0


