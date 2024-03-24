Return-Path: <linux-kernel+bounces-113698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8F888E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79D11F2FBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D82146D4F;
	Sun, 24 Mar 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTgAYiIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C571DA171;
	Sun, 24 Mar 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320677; cv=none; b=aah1juztXzNofFE/qmo5tCdmG+TXcZTnlw5pGw/N5pqqj9M4Ce0o7DlkA5BU3geR2Owg8HXynoVA/XkoNaK5p2GBOznP4h6XOAxqhOIPjn2epXfkt7ayTGSq3Wh47M5AV5lgU9ZQYRD3hfMd9JzuQ0IIrOsz7ggTlbjwkz/6oK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320677; c=relaxed/simple;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCf8SE6//8d509BylWjKZ6AV3egYuV7uUfLZReTSn+mZXCKCDwJOn9iBtuJqYMGsmkDEcbUMyk8wIq+Fgrar1Z1f3PVoOx6pOWH0sjcrA3BJswGIfISre85hhy6icLRYlmuuWFVJEQssHhMQA8DqRSxLHo8SXzV8G7QMTM/9IQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTgAYiIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A07C43394;
	Sun, 24 Mar 2024 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320676;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTgAYiIyeQF3NDDfQUSNifpXilATzYewvpEUxElx56HrfeehQAMk5sC8ASWa9MoLH
	 KtjC47h2gorwjmbnldRDBjYCilx1D1upnEfBBgtDcECC3sYLn6tNfGiOSqdji5PUq0
	 mIwWHSHA5KKSrWediGU/oO1VDYWY1g2NCrmw+U/k8DDL/fRVQJsnalxKwTMJwjqYek
	 edFVLmrfoMicDaWc2wITHs8u+S/RBYltOmUf+D/JMC5jyiZELND0tMj8ioiD4neSyk
	 GL+VuFfF9mZkScvbk85MfcG0wL7TH9Ao4Q/WzA+z+1gM2vcHRhu4V8XcmRgTyEKsug
	 HMuD4fucA50wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 238/713] arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock name
Date: Sun, 24 Mar 2024 18:39:24 -0400
Message-ID: <20240324224720.1345309-239-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


