Return-Path: <linux-kernel+bounces-113077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724B888148
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61FC283D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60914C598;
	Sun, 24 Mar 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew5FPKJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B714AD08;
	Sun, 24 Mar 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319885; cv=none; b=idFJpEJysAXGiNiMXxse0crnIv6p2rCAh88duNqJjpZTHJFoWtFMDyfZ2VUZlTrA8Z9ZKZlmbc6gvDHdhWBNws+AGzQOhE5AW8Ml9Voh0c4RqYwFs9mjwoHCkn3a2xKuGrWNxtbsAIkjcq7PfHiu1M6RqWyTftwOaoWHP/8fRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319885; c=relaxed/simple;
	bh=Bi6N9t4aRKgVA4P0PqsF7x1GHKprdkWEHWbgHbzfyhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X99kX01xZGyAo+P3j7Z40CqexVr0SIKqSLELOVIoPNxnwyW4xHHcHeXI+EBtx6AhnAZn7TFY++eiswhvPYCeiFYb1S55ucqMfjPDSIAg5U6patjLr/zp/x4rlhWF4YEhIll6MuspvnGi5TRTy/u1A5tXm7P2TjrnLFah3PpCjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew5FPKJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039ACC433B1;
	Sun, 24 Mar 2024 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319885;
	bh=Bi6N9t4aRKgVA4P0PqsF7x1GHKprdkWEHWbgHbzfyhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ew5FPKJJ77nbYifvHRbzoX5UDj7Vj3ubplEaZ1WT4jZ/NhPymg9DLhY3wWfZrWS2c
	 8E6ayl0JKP9wfbpMZRIYo7Oz95pOGs9FKHE7/GwEcf3nmfFArKJN/b4OM9fxVrXv7L
	 C9kH6z+cGe2szKtzVNQZeX0SnUZbUYDmEGrewk0Z68qzuAYI75OJmPF+sI34HJiUJb
	 7xCIs+vMpQj3gOtIphT3MjeER6A004oeGMm3gU+hjNmuBP6X4So9C4UCibHtn2TzXv
	 VYpGIJBkEQ+oHu2HlG3Xb43O7ZLIG9lQp1z8L+19MMT4T1y21Z9/Q1wzBvFpnDwLd3
	 xxN532+P3phqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 190/715] arm64: dts: mediatek: mt8192: fix vencoder clock name
Date: Sun, 24 Mar 2024 18:26:09 -0400
Message-ID: <20240324223455.1342824-191-sashal@kernel.org>
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
index 6dd32dbfb832e..0e432636b8c23 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1814,7 +1814,7 @@ vcodec_enc: vcodec@17020000 {
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


