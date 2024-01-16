Return-Path: <linux-kernel+bounces-28033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0C82F95C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C62CB26419
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BE5F85D;
	Tue, 16 Jan 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Q92RNJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4855F848;
	Tue, 16 Jan 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434950; cv=none; b=iYD8N2m5BpfSIgNmsxHrxrX0wpO8MNudgMxv/VMG4XpDxuSIzHaeOfx4xeK/KzIsqTxYLbV7CmrozDhWYNPFEVTp/ZrVi+2CmjDKW6XMiedFc6C58uuWr04GybwlaIZAl9GESXms9cUbDXf7bMK3KEJXQuMIbzwicuXJUDh/D3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434950; c=relaxed/simple;
	bh=EPQKoTu75PSJDG/n35vxRxVccKd7hKiSSXu8KL20AIU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ukX8VMZeSwRClXIF7IHWh+q/Zi4fSy2R+asB4QZAgVS5eTAuqQISA6M7w2HAue4T2latK7gfAC+ogY9y9S47YJZ9YxiXAoJeaiIrBLS6yzISI0xT0dzmom+GgSjmWV4CkZ/l2GUxvsY/VP8dyqzXr7rNnTAKMiBWnmP3YpwyJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Q92RNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC9AC43399;
	Tue, 16 Jan 2024 19:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434950;
	bh=EPQKoTu75PSJDG/n35vxRxVccKd7hKiSSXu8KL20AIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7Q92RNJBPSyB57/Bzof1frNTDNtYx7N/f+Z6CSTxidsTWvsBsIdZoPTlEefUG6uc
	 LxA2iYDfhLL33YaFxb5lsx/wqIQxGnV+g01p+4zWE86iqSyoN1rhFBe2kbovn/WHyJ
	 6C2foCVLkUmOvsajrhSkAJpGt50qCF07Y9hqKBHicmqHX4tXLM6RKfKPqJ5JhKvi6j
	 KqD8+9vZO2Ax/jUCy0izr8uTlk3ELWR3GBJV666LTGu/2nJ28eOvZdoQDqKcgXMgtK
	 h4OofBAROMWs3AyefsE3WbNeScnfCAiq4zQ8kLmCftq2RUMfGN9rNUCaQvBQesmSXT
	 sxX4zC+8NJZLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 16/68] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 14:53:15 -0500
Message-ID: <20240116195511.255854-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 5f55da4cc37051cda600ea870ce8cf29f1297715 ]

imx7d-lcdif is compatible to imx6sx-lcdif. MXSFB_V6 supports overlay
by using LCDC_AS_CTRL register. This registers used by overlay plane:
* LCDC_AS_CTRL
* LCDC_AS_BUF
* LCDC_AS_NEXT_BUF
are listed in i.MX7D RM as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 7c153c3e8238..44085ef27977 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -818,7 +818,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


