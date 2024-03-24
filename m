Return-Path: <linux-kernel+bounces-113681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F980888E41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F381C2AF65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3E127B4A;
	Sun, 24 Mar 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeLinGK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A1D8BC0;
	Sun, 24 Mar 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320644; cv=none; b=UzqDi3T1yqXIDkFRg5CxZNzJCB5xk3GtVr7OwGz/6VCz8xxJACduShsxFWkWWYEE3SCDzEfuSR+ws2ysRqidZlBGLcS9t2rkaGcSXsOFa/36yW7iMHYNtzPSdkXJv7n2YMri4D8+W0sWKH7bqVsdpNYDE/DsmK0tXDJEvXgZYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320644; c=relaxed/simple;
	bh=4f1erUva8FFOMSrg8Cy7B/IPul9QQ0jPoIHd+IvGvak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AurF4XFnqsQHTA7q3M0/XHp0X0CyaSpskURwPf2/D/ySni3N8zLV5zcRosUSrxsoi1baZdwvGKylhgz5JCcBjEDBV0mTbEAzazbAT0kzyDNep0hJmhoXnFsqEI11aLcgmss6uYH+6zbDCrJPaSedA+SIFb5DNCbr80+J1z9MT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeLinGK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E70C43390;
	Sun, 24 Mar 2024 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320642;
	bh=4f1erUva8FFOMSrg8Cy7B/IPul9QQ0jPoIHd+IvGvak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeLinGK2WElkcGqglxYidGKWe0AjYdaFAMN+RQ0zWSGxurDawA/8DmNyWFqaT6H1r
	 CE125I2Ibh0m6rCwsTRxJ75RmcpWGyuyTgl+PgnQ1Szb7wVbzmRcmuqtHe3hYSIBAm
	 f3G4O782GJJkjthqjL6P0d4+1sZGZ+E7ndt1sN54pJ2GcYmwYUqAYPrzh3O/BzVSiW
	 nvqBhcJxH8SVkONq1tdGHMzo5xurTuTvV7siBtdJLAB0+LojXaG4FaTupIMyuiQAj3
	 j/4Ba5hxnQJKWGsOi2vZDA7aNKOeG1pu/DwquEaUSorVDNNdCnAtiE7BoKuyIl6bW5
	 mu4hehqyIlFbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
	Andrew Davis <afd@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 204/713] arm64: dts: ti: k3-j784s4: Fix power domain for VTM node
Date: Sun, 24 Mar 2024 18:38:50 -0400
Message-ID: <20240324224720.1345309-205-sashal@kernel.org>
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

[ Upstream commit e4d252e6d29208aea56d4c04270523e306b1e3c2 ]

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/devices.html
Fixes: 64821fbf6738 ("arm64: dts: ti: j784s4: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-2-85fd568b77e3@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index adb5ea6b97321..37fc48aae6945 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -616,7 +616,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x00 0x350>,
 		      <0x00 0x42050000 0x00 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 
-- 
2.43.0


