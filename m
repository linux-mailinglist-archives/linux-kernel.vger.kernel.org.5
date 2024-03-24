Return-Path: <linux-kernel+bounces-114168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C958888D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE9F289069
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72255247F99;
	Sun, 24 Mar 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNm2kJJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A42057E8;
	Sun, 24 Mar 2024 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321488; cv=none; b=EAqfLdwljpJiDzihCaipVY6RnQ+5VNWYuLAJCl7jFKXDs1LgtJe2+TK8wltkhLi3F09o0lkm7lk5HhI+QGzDqrEojEP3h0IkM7jBxAwWZGPL8AWTG7Wd+46EQq5/SPFEFvbzscP7mpjEH/WJlRrm3cI/Bt2p6wVckBfN9Ikp4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321488; c=relaxed/simple;
	bh=rrG1Xn02Ri/2nGX05CFu2/ro9ZQohjCcGnRg+Ua058Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkA5DtACj8BSf5aN4QopdUDW2VleB1JHZEzrEGp0k7xfkVHRpu3tphB+ei8Ds/0ai8E0FUeR45MhyO0+6uBBgJMSmgUxx9gO3MgngykpCtHo7kECN+XnsNZWta3rpOLQT4ntBMVM+H6zP5H/Ewah7giLxOsFptNB15bgtJDILto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNm2kJJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA211C43390;
	Sun, 24 Mar 2024 23:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321487;
	bh=rrG1Xn02Ri/2nGX05CFu2/ro9ZQohjCcGnRg+Ua058Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNm2kJJI24HTlayh+SNCfAIb6nHhFnsfAtwCgEL/+sP8fMrzMszgvaUop0MBF+dkU
	 IA42eXa0WFkg5XduJY6lkrHbLCF6OhWbXPLfsnPj1wB0JWka5A1kRXF0advtEUqYtr
	 GXxhA6XRLUSLYbFd1PMmOibL4jkSIxI7WSQCEyMzHHdnGmD12CmRckT6a1J2Sh89TE
	 +kUDXKqdpsrAxCE9s5BF1PyzkJxX4TXC8r/GLYgo2KMVfINeznKIK25cwsBMUygOH+
	 MtuDW/JN1PK6QqOxukYJMf4EgOK9qJnlNbzkuBmUY+H/wW4rwKJqsLDp56iw+nR8gF
	 TY+HZJYlQTMSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 212/638] arm64: dts: mediatek: mt8192: fix vencoder clock name
Date: Sun, 24 Mar 2024 18:54:09 -0400
Message-ID: <20240324230116.1348576-213-sashal@kernel.org>
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


