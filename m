Return-Path: <linux-kernel+bounces-114210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39B888925
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD291F2D4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA72208979;
	Sun, 24 Mar 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNZqu2n8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34A137909;
	Sun, 24 Mar 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321542; cv=none; b=cqhv0P/6gPEEmn7L6a8x6oNLr2Ujd9+xCZT9XTjault47suoMaG6SodPd2r1ZkUuec4IwYey16Hehqs3JQ9necKDxbPCu4i3+rDNLpAP5rP5IDs5uqVdGJTSnxAzRQjUpA0L7xRRl15jIkQIQZQcLBi/CoDi0xvQ7CqHdPdqaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321542; c=relaxed/simple;
	bh=tN614vzaUT52efr1bB/r45OV/PkKSNPmC9OVEROEBJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQOiQotdivSN/Na3ov+A7ygrFT8J2MyFH345dudxU0oxCBr2PxnDNF2oKDrUQxTeKdIE9CA1BptZgZKrrYQfqJUlx5my7tboGPh9F4GivlRcqXh/CNUg8IAv0Z9UgBX7Hioya5jBVwImCa61tQ+k4TSAUCox/coCXl7CyFPkCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNZqu2n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA77C43394;
	Sun, 24 Mar 2024 23:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321541;
	bh=tN614vzaUT52efr1bB/r45OV/PkKSNPmC9OVEROEBJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNZqu2n8+Hlb2Ntub5RNl1rbD7/Kj3P+TyawgE3wjm7OEq5J89VXqHjloQa4Ts1BT
	 c8V6e4hDXStEBmpe99etXQ+L0ImDB8nqcQCjEUDbi2j+HBXcmkaN/TpBE4t1fnKEBV
	 uhtUKM0M+LZoVfcgimGMshHitV+pdJs6KBIAg/hHgV5maL1p3/Lmdq5ixtdmkBUNKX
	 jVdp8oHvG6omGsXa0CIoi+8RoRWi/wtukuX+4JU04mgd/4SorN0hSMkkUPSLbZhqUL
	 xjC0Lme+VgbfoFirFfPi6fpJuNs3pmLJOtPi9tAmT0qrbZKV55XZY9g+Dd+jH16869
	 7OxXetFlR6qWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 269/638] arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M Plus eDM SBC
Date: Sun, 24 Mar 2024 18:55:06 -0400
Message-ID: <20240324230116.1348576-270-sashal@kernel.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 13ab6f174a6b577bd7d09124b47ec8ace2682e42 ]

The SPI NOR bus routing on this board cannot go above 50 MHz,
set the clock frequency to maximum of 40 MHz to be within a
safe margin. Remove the comment as well.

Fixes: 562d222f23f0 ("arm64: dts: imx8mp: Add support for Data Modul i.MX8M Plus eDM SBC")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 116bf9738a8a4..cd44bf83745ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -121,7 +121,7 @@ &ecspi1 {
 	flash@0 {	/* W25Q128JVEI */
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <100000000>;	/* Up to 133 MHz */
+		spi-max-frequency = <40000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
-- 
2.43.0


