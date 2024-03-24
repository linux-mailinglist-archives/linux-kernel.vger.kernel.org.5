Return-Path: <linux-kernel+bounces-113078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A188814A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3181C215E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB014C5B8;
	Sun, 24 Mar 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNS3meRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B114C59A;
	Sun, 24 Mar 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319886; cv=none; b=sewkVHEXrnBmc27RQd99LPubRJVIviIwYiOIB4G06Syny4YLUcCbaygVeCzuWRUetQdHY85lLNgh60fU0YQRRioZZ9FAlVSYzAk3Xu36tYj3y5BTW0QuGUph1tpW4v6cDdshjU1IitysAag2eIEPTDFGjSDKHKU2FYreuCC4360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319886; c=relaxed/simple;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7CfJILf65XEHXh5VO1R8ubasIfwncZJ8MkJWFgrYKbFlsXL/hShrXHTnH7XmszTe94nZ6SCHSDwB8lf6hT3OQ6oB8SqPTAHu+NReiEemyBTmtb3vh9Hqkx4aqWQR3QKFGXK08z3UUjoq/gYuQImZO/uG0nZQ1A2C/cxYFP6Oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNS3meRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE124C433F1;
	Sun, 24 Mar 2024 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319886;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNS3meRhkdE1ZMhn2lECxJJ4NGVB/dc+obcpBwd7+vidRChPsZSn+uYFmqIwcmbQk
	 qkAUYNnM6QogGD5UNlO43YGiKVQEhh9k0dXiYPPeTTy2yO5KQycMxnUDETvsGBWK2t
	 OWIph4ZwaSBx0+vmyBAiXCfdn+3ryH9xpFaVq4yI/RlAvMTPvRvB4qRUUHVDoCj0Lq
	 fXZvCT/qDzAXBmTdCCieE9wBugMFrj3VBj1R6hwB1g31MiGSMEvWkSKLTsdjScIjpF
	 s/0vkw0/ycuNCw60h/XwwFImoHPqcpR6LhG+3miWMiCQAMp5wbDaVt5a9PftoAwuLw
	 bGQWVuaS4SgdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 191/715] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
Date: Sun, 24 Mar 2024 18:26:10 -0400
Message-ID: <20240324223455.1342824-192-sashal@kernel.org>
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


