Return-Path: <linux-kernel+bounces-115393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB4889B50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6091F39508
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B711FDB2F;
	Mon, 25 Mar 2024 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuSZ1+/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F63C144D07;
	Sun, 24 Mar 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320682; cv=none; b=Up9yA2zDgO2u5ezK3hCvw0UQw5ycP6vww1zuoabe+Mjb2wf6I3jsjluJ5VjsVOmQ0iR9AgOoYt4oRF9syEz+bi95/YVlRfEyVnTy0JviH4wfgXvzkEgLQhgwcwZesNsVDE6N+8qc2W97HwdaGJBKJ/HHFy4hubfA0YGJ68jZboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320682; c=relaxed/simple;
	bh=rrG1Xn02Ri/2nGX05CFu2/ro9ZQohjCcGnRg+Ua058Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soe/oxMk3x87pTRn6arCkgdPk4IDn/OTxfoPmUCPfCSxFiLmfv+5+nw6sKkp968X5m5rPBWYevEyy2E4bI3wqBW+0zevQHI2Y/swuULO6/jHhzTFjPFf74WXdNGGq84ihWB8aPVX/mKlxxfF8448BnlTtdf2jJouy79YGfdc8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuSZ1+/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBEAC43399;
	Sun, 24 Mar 2024 22:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320681;
	bh=rrG1Xn02Ri/2nGX05CFu2/ro9ZQohjCcGnRg+Ua058Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuSZ1+/dUv4h0tdnzF25Jjfb9THgO690SuAJhiasY3vgw2ZiXkDFsZXOsv2twHEFz
	 EWlzy57L/y0kiDHVJ15TBiN60yvWdYHz2YZeBXsidZbL3umN4xCtPGrEfaWAiFRvYJ
	 fGVGtCLp2SQZs3B9C2WFxyLTXDrbIXgRfpZ8gPVfI8nVKdxIW6cwlJNhX+Tytdi5kD
	 nIGsj5wtmYJfnhA4Z+1kAoE81k44qwNOWVLgZdP1xJis83GqxNLc8Vq/OctWLRKaGZ
	 Ov8Wg2uSy5uNingYS3XR5vi/MHj1zCsFAV3wGZrJdq/Q17uVitpeLGfr7ttSQqjIaB
	 iUYTiCfgZNGJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 244/713] arm64: dts: mediatek: mt8192: fix vencoder clock name
Date: Sun, 24 Mar 2024 18:39:30 -0400
Message-ID: <20240324224720.1345309-245-sashal@kernel.org>
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

From: Eugen Hristev <eugen.hristev@collabora.com>

[ Upstream commit 76aac0f2a46847ed4a7a4fdd848dd66023c19ad1 ]

Clock name should be `venc_sel` as per binding.
Fix the warning message :
arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb: vcodec@17020000: clock-names:0: 'venc_sel' was expected
        from schema $id: http://devicetree.org/schemas/media/mediatek,vcodec-encoder.yaml#

Fixes: aa8f3711fc87 ("arm64: dts: mt8192: Add H264 venc device node")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231228113245.174706-4-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69f4cded5dbbf..f1fc14e53f8c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1770,7 +1770,7 @@ vcodec_enc: vcodec@17020000 {
 			mediatek,scp = <&scp>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
 			clocks = <&vencsys CLK_VENC_SET1_VENC>;
-			clock-names = "venc-set1";
+			clock-names = "venc_sel";
 			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
 			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
 		};
-- 
2.43.0


