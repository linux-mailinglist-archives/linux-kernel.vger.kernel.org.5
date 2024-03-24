Return-Path: <linux-kernel+bounces-114169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A0A8888DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E7F1F27BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF1D20606D;
	Sun, 24 Mar 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osfYU/sj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839122057EB;
	Sun, 24 Mar 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321489; cv=none; b=iXWQivddIPCfcfZT5eF6bkteo1DsjZKgI9p9w/wvoJxS5GOO9lg0MMtuZgFA6sl4PONZQF79+J88IIUlT+08IWqNrbQArRhEQHuzDe6qpr/3bmuyBY24W6s3i0jcPBfmCuFQfmWEJ8C8ZR1wOSh3xIXH90S4MPXhfI8BURLHXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321489; c=relaxed/simple;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nou1Vnwcy5OWVOXVQh/Si0O8vEEpeyO3Zk+6Xb2cy7KRMX2zwsDI/Pn8wOs2uuNGo5bOs5HyJyOHsxzFPBioSg6EDMBkdqQhBN73a6FOofzLREQZV32zG+ebLWlL1zNq/NdJCQFJfd1T/DhGVMU+Z/H1IScxauY5OVjHDM4Uh08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osfYU/sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB2C433A6;
	Sun, 24 Mar 2024 23:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321488;
	bh=O9eze3/Xwc/ji+cKXEagCMTc8AL45Jdq9HEYPVII6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osfYU/sjL2pUl24Fc/ujvKVXiobfBsaA5+l9zrTILQ2YXAEK3t9rnfLbEw3KoLWnf
	 sX8/u8nAAQP8SgiVWqppRVhMgCIkA/6RrJKhNDFsJg2lRlxpfILCuTp1WNpfiqdg/O
	 93fU3Mq7H3upbS7emA4BIGmqYfVNtppj6yShg4gdzZynYpDgRTTsNxSlRH50PwddEr
	 kBAXXlVwmyM8vasP1fysTg4nG24X1CbR3Pl6EUPamiaZvj8CNqJKKq1g9LGgsYEb7r
	 Mfkc0hucJYLii1E6aktOn6jNImmo7MASj+8+UdtmvGKcywEI3nMkskFC4D3ruR52o2
	 hAfrs9MUesNhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 213/638] arm64: dts: mediatek: mt8186: fix VENC power domain clocks
Date: Sun, 24 Mar 2024 18:54:10 -0400
Message-ID: <20240324230116.1348576-214-sashal@kernel.org>
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


