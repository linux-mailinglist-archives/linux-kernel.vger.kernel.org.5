Return-Path: <linux-kernel+bounces-115397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8739889B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15ADB1C33D17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D51FF5B7;
	Mon, 25 Mar 2024 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkVqgrpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB21DB41B;
	Sun, 24 Mar 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320693; cv=none; b=j3fDNFiqtOEcXXROlm7JGbxCwhRyFxTrVAtLGi8iofBmhxZhPKCvjoiP/mXcqZqRE77apI+shRgtwtJl6qp04uxo/2zhNe+MizAchWDKBDbf5ITgEc2vw+c1d/l4m006iJNK5cI7Qfnn4kOKY9qVu0H+y6s+bdypHjpfYLfaqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320693; c=relaxed/simple;
	bh=0BWxCl2nFw/sJ7Q83TuBcBmbqeMeajlBN2JcRS5sjwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7soQANKdAsMb8aC81nKrh4Xaf7BJ7kLVyLoF9e4snCVVUUsi+jVAs/rbea05ZCYrc8TX7eXNAjrqYjF6dvwMdLKShY/lRgEXZga6hsJvUuuChrMtvVRBPRCjG0xKs2Q6mk8vYo23EWOUME96CvocLODgSItf+OqpNBe1+cqvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkVqgrpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABF8C43394;
	Sun, 24 Mar 2024 22:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320691;
	bh=0BWxCl2nFw/sJ7Q83TuBcBmbqeMeajlBN2JcRS5sjwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkVqgrpP3nQlejnpDVN+ZEr7xa3kxBtpP2XiPFaAq3i/CyvSZLCJXFONsYfuhdCXi
	 r27vMRb7bPlX/gJJT7UkEatAt/yf2XGpssDnd2t4z0/5mCpS24JMvujOTiTsVE2kJH
	 4qMRhdR3hdRthxQ1it0zasvNyzMq1xjUmyNAF1Eak1pNDs/DtndfYrkoEfjcLexXZT
	 tDbeAyMqBpk2D+nbbNCUJMPy80FCZVjHQmngPwxFii0obRBieYAAV43sAOaII3wS5m
	 pl9Z8uPxg5L9FER+xpFHYYFI45NBdsENkmRCghMiG09QhRS3mJwZZlxZRUGPput/yJ
	 iCZBbANIeOW0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 254/713] arm64: dts: mediatek: mt8186: Add missing clocks to ssusb power domains
Date: Sun, 24 Mar 2024 18:39:40 -0400
Message-ID: <20240324224720.1345309-255-sashal@kernel.org>
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit a00d4a98af44e025891e97c490b2545368a25e08 ]

The ssusb power domains currently don't list any clocks, despite
depending on some, and thus rely on the bootloader leaving the required
clocks on in order to work.

When booting with the upstream arm64 defconfig, the power domain
controller will defer probe until modules have loaded since it has an
indirect dependency on CONFIG_MTK_CMDQ, which is configured as a module.
However at the point where modules are loaded, unused clocks are also
disabled, causing the ssusb domains to fail to be enabled and
consequently the controller to fail probe:

mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@4: failed to power on domain: -110
mtk-power-controller: probe of 10006000.syscon:power-controller failed with error -110

Add the missing clocks for the ssusb power domains so that they can
successfully probe without relying on the bootloader state.

Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20240213-mt8186-ssusb-domain-clk-fix-v2-1-1f981d35f3fd@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index ee0feadbf9619..4fd25f0f313d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -931,11 +931,17 @@ power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
 
 				power-domain@MT8186_POWER_DOMAIN_SSUSB {
 					reg = <MT8186_POWER_DOMAIN_SSUSB>;
+					clocks = <&topckgen CLK_TOP_USB_TOP>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>;
+					clock-names = "sys_ck", "ref_ck";
 					#power-domain-cells = <0>;
 				};
 
 				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
 					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
+					clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_SYS>,
+						 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_P1_REF>;
+					clock-names = "sys_ck", "ref_ck";
 					#power-domain-cells = <0>;
 				};
 
-- 
2.43.0


