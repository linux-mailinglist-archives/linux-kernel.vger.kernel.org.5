Return-Path: <linux-kernel+bounces-114165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A58888D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B021B28667F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC4247F73;
	Sun, 24 Mar 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hApdMVMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582014CB36;
	Sun, 24 Mar 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321482; cv=none; b=aakg9CgJQE5IGX0qizmiZGeiDHebfVk66kFmV3rKwTupx1LsxpGzV+SlZsAgNESScmeNO0tnVoSpgI+NpNP4Rg8TcNvf7+D2dTEd42IMSYnNYCVErPST8UY6bDNwLKzPdDw3PHpCzut1OsVdyA99tfR7/8iWpsj1xDMzpk5wmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321482; c=relaxed/simple;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AizfpSBMv41uI7ziiKcXkDqCdyLJ91q84iaDhmnbaLkZY0KyAyP3DBKOyCG0VV/lIQ6VwCs20839LvqEMbm279/jp1t69eucOcI5tD9EKAUJTxMpTT8tHH4q/OmyjqdEG5Rhb9xeXjqV8sbqkQmoueFcKV+9DOd1iliCM+Lk8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hApdMVMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C333C433F1;
	Sun, 24 Mar 2024 23:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321481;
	bh=/Cgj1l+Rb/KLXPOO1028JhYLxPr473Y7ZEhHjRqRylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hApdMVMIB9bcKRcYee1WQbmt3HG5HGmDAh/TLf2H0kouhgZ5vXcQn3YLG/Jef/Gzy
	 DQuaJX6bZVWnrYiwlmlQRfl6yvkarkzee197u4PWaUHyKk3Eq9OQca6KvQ9vJ8sr3w
	 P7+qcSO7d8wbBguJmCqDOsl5dGQGM9gz0bHdWC1FQzj/4ekuwW0iAVc/l8bLQHHYMF
	 4CUXCpDEMDiYz8zdZf6JNX+qpA0wTbNLAEg9TRTSxb3BPdEmp7L7Xmbt1soDHSP/8V
	 D3ROUqLRO1Pp0qqZFBc6BgPjHYO6CJrGVwuuX86oF5S3WLy6k8kL9amlnnDOQlDigh
	 BgQrCbfdLSVDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Sam Shih <sam.shih@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 206/638] arm64: dts: mediatek: mt7986: drop crypto's unneeded/invalid clock name
Date: Sun, 24 Mar 2024 18:54:03 -0400
Message-ID: <20240324230116.1348576-207-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


