Return-Path: <linux-kernel+bounces-115877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C7B8899A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5743FB2EA66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A291382CB2;
	Mon, 25 Mar 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmE77zYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917B146011;
	Sun, 24 Mar 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322072; cv=none; b=b7kO0d56Nhfi621HPaOzXevMdmID2BwkEpUdpWV/kg2Cm3QXeOG++Wr7Txn5okR2U4tcXhTe4e8iGX/AcB6ZTQNypOKUtv2h1eYUAV7Ei43iCXNONweoUIiQUXI+wRr3NYEZitv5eh3ZDXeXRXutQuD2KYtVSsJUMkVAiri9wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322072; c=relaxed/simple;
	bh=r1EZMsX43xu45DFLV9hd3hrr8GBFDu0WUSfe3R9m+NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjU38TR+jVEQZyGgN9x+87yX2XXqD7eaMSWEfJvhGbg0u678FYl9DH0rrQ+dmwTz5jqgGEsmcxxsfeetpEmSodSdpqT/ehkZdvBbmLRj67CjpDUG/QsbvPT2/AlRh1vMSqIoueGR8etWrDqPaCVyOtDXaNZ2IA36XLRB8Y35b1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmE77zYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCE4C433F1;
	Sun, 24 Mar 2024 23:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322072;
	bh=r1EZMsX43xu45DFLV9hd3hrr8GBFDu0WUSfe3R9m+NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmE77zYy+SiRgsiNjYGzA77jjQrpM+w98eCFP3kn9bqhOrmi3rPV7/lgk+Bd8J5q6
	 LCJbPX1P53hgCQ2ngZMXUeNR59OOg3g6XDcL7SuBnMA0n968PA2PM9115V86Wi6um7
	 NGyWBc9PZiZdySvTFbGTDW/T+jgkmsEw92rVWp0aUEOU8jy/OjuboIIJHAje9T8Yg9
	 QQyfVfM50lvIbJVgoPAxH83pN+KHxxQA4vrhuW8x4EDI7bDl+MC8CvA60Mo3fp56pT
	 0jIAnRct/XnxWtsob1MaPAH366vzQvgkp2Lp//onLFcKFHF5bd1WUAuO2qnILb0h7u
	 vBi3ZCSllHFPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 145/451] arm64: dts: mediatek: mt8192: fix vencoder clock name
Date: Sun, 24 Mar 2024 19:07:01 -0400
Message-ID: <20240324231207.1351418-146-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 2f40c6cc407c1..4ed8a0f187583 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1539,7 +1539,7 @@ vcodec_enc: vcodec@17020000 {
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


