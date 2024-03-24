Return-Path: <linux-kernel+bounces-115380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55EA889D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD59B3F1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483E1F7398;
	Mon, 25 Mar 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvDMbvD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90231D8BB4;
	Sun, 24 Mar 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320642; cv=none; b=kO1Ulbpp+qZZ1mVpdorkHHJq14mm95Y98uKaTjQT2szQIcMiDzX2CUt1Xs0QZ3AHVAJEDDUDnQSaRK/K1cqdwuhOGmOP6rCcOiy7HGGYtmxYll/ksTlhFqUe8Ak/ZLs7y9oS5kFChG4x/u8WmMbWTxkxC7d8/Jem62V94Mjc4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320642; c=relaxed/simple;
	bh=uRQPRQbfvlKBilQqRImAjQMGdfGSTQ5pK9uohbD4dss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWav/T4O2/rCx95Uq5fN3Vze+J5ftjowl3O0Hw/ncpdBHvJCwgmkPDZdIvTp4WPLl1v6Vw6rzusyeYzpRX4vRboIyYU9VOgVoK7HnlwRlgUeiIOmtWctJ5HnIAyNWwvOeX86NpZZ9EGZ8HcRV75PBCz4ud6ZTsueHKzcRCQT9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvDMbvD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B62CC43394;
	Sun, 24 Mar 2024 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320641;
	bh=uRQPRQbfvlKBilQqRImAjQMGdfGSTQ5pK9uohbD4dss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvDMbvD5D262khLZ8MufYr/WyEMS9QclciJM2dyMs+KgJ4d7X+KvgSr1TymH8v/Fd
	 uohk4rppdvQPEOiSDV7HakwxJDUQgZFKnV5MPZ9FERUw+w6LEPO1ZT+bLl1XlV9sQ4
	 l4YYQgrMkyY3IUTsXLWI7PjSZj+8VY2qT1tYwR6FjeAM0oTBPeYCtJSk1xgOREsH/w
	 UT3HJ7VcQiZhZCCCDKtPneROd7HBy7IWIPPDjg/f0/TFZ6huVCqwRlbEtAVh01jher
	 StSVdpqOws9lL6t5bv/zRs1fsvzuCKYJcZ2ndMa/qDDdtFiW89LYnYWzcEbzq/WRHt
	 wGKTJg2f5rACw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
	Andrew Davis <afd@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 203/713] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
Date: Sun, 24 Mar 2024 18:38:49 -0400
Message-ID: <20240324224720.1345309-204-sashal@kernel.org>
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

From: Manorit Chawdhry <m-chawdhry@ti.com>

[ Upstream commit 5ef196ed912e80a1e64936119ced8d7eb5635f0f ]

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-1-85fd568b77e3@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 7254f3bd3634d..c9cf1dc04f7d9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -652,7 +652,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x0 0x350>,
 		      <0x00 0x42050000 0x0 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.43.0


