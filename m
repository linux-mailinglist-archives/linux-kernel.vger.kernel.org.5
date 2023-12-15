Return-Path: <linux-kernel+bounces-781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E268145F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332022858A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370A2D056;
	Fri, 15 Dec 2023 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LzfpBTQB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B025101;
	Fri, 15 Dec 2023 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702637169;
	bh=7++2TugOuHBscBWsZZMksH52fjmuIFEskx09aH3Ys30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzfpBTQBc6jdcVCXkrYHf/DB73UDXAgYxMpB4zdubXqQk6gqm7xufDuIzDI9Eb4Gh
	 X9dQNsWyvFfzw/M606wMrQS974OEISUk9cWmbVzXZe2sMcp+OW3NH+SlJdCmZf1744
	 jr1yafbqlvIpCZxFp/S10MthewqPfztEU2kc93XKMgmJlUkxxkEhrQa9vRcniteDLw
	 vTA7yM6D09SwmYUI7UFoKr09tVbH5yMy+kziVSBn2pWrVGsA7y47i8xEqtPcNwYmH8
	 9tutou3gHpRbCBjO4iKR+7FQPNWit3PfjtZaXnBHOM6UrMRjvTgHgzbCpZbyQj9OnP
	 RMW7KRghQGegA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1B0F3781FDA;
	Fri, 15 Dec 2023 10:46:08 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	linux-media@vger.kernel.org,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v2 6/7] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
Date: Fri, 15 Dec 2023 12:45:50 +0200
Message-Id: <20231215104551.233679-6-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215104551.233679-1-eugen.hristev@collabora.com>
References: <20231215104551.233679-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The larb clock is in fact a subsys clock, so it must be prefixed by
'subsys-' to be correctly identified in the driver.

Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v2:
- none.

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index df0c04f2ba1d..66ead3f23336 100644
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
2.34.1


