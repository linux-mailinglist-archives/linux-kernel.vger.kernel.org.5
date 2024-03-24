Return-Path: <linux-kernel+bounces-115394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0903889B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A692C1EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BD1FDB49;
	Mon, 25 Mar 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4iFyx/Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A3144D1D;
	Sun, 24 Mar 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320684; cv=none; b=h0tpbLAYtW7s/Q7HrQjc6SuoP2cALHx07iRyTCn6pfE1N4ZDRbjFQDUN5Q/lAQ/4Q/BzaZWsK6W6cJqV/sv//eaGIKxdVfwSCUSxl3N7L38KsxNJANcyPOMJnxRyvTWvWvbRIEW1dutjXqtCctQetOhn1qbDBVrVhddL1dxb6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320684; c=relaxed/simple;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7GfDn4dPzkzI2X5ZSJ1NmmPSIRzpXenqhn7vV761FIuuKEzV/zBBbq3W96jbxnZIEjes9VmoHkMG47bIFehgdTtz8/jBLFdinlGayQjiDI38QDAO7EWQIy0M8GUDAtmP9OnmeHvCSzEqyiptkGtVhH0LpWCp+BFp8EWFUANQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4iFyx/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32910C433F1;
	Sun, 24 Mar 2024 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320682;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4iFyx/Zlr1mVldDPKiKryPXK6jUAWlltE+b/mlB2qFRO+tWytp2Y5D4d/8kIrkjc
	 YN9DxDmEvkWPmpzpG82FwrQonLxfEOL22apWaxkvnZX/1dis4HDmTkfH2VxZGWNgma
	 TsP/sv/Cmr5Ck/ToHhZkVTvXNYI+zOF1TUQsHbqKOWaqsA6dyJSbEG9hH1uh8TB70T
	 9ZdJNfjRxGLpxLvdYRoRd9Y4JHvR76HaDapaiSMzWO4iWJWAK5kKPyJQ+lCHLT5Ysk
	 pASKKAOQPEMboHg07yGi4eiF1/MCh6MB1//SkvjtIuwWQ55PDTX5XoFqAHl09H9bS/
	 d13ha+naHfiTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 245/713] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
Date: Sun, 24 Mar 2024 18:39:31 -0400
Message-ID: <20240324224720.1345309-246-sashal@kernel.org>
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

[ Upstream commit 09860910c589a3bb3b5268ff6f704cf6b18ada73 ]

The larb clock is in fact a subsys clock, so it must be prefixed by
'subsys-' to be correctly identified in the driver.

Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20231228113245.174706-6-eugen.hristev@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 2fec6fd1c1a71..ee0feadbf9619 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1061,7 +1061,7 @@ power-domain@MT8186_POWER_DOMAIN_VENC {
 						reg = <MT8186_POWER_DOMAIN_VENC>;
 						clocks = <&topckgen CLK_TOP_VENC>,
 							 <&vencsys CLK_VENC_CKE1_VENC>;
-						clock-names = "venc0", "larb";
+						clock-names = "venc0", "subsys-larb";
 						mediatek,infracfg = <&infracfg_ao>;
 						#power-domain-cells = <0>;
 					};
-- 
2.43.0


