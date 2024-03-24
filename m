Return-Path: <linux-kernel+bounces-113089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2F888161
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40872B242CA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77708152E18;
	Sun, 24 Mar 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUcat1nT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6A152DFC;
	Sun, 24 Mar 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319897; cv=none; b=g7G3FyUExhAbFGWLd77YvEJ5DtXZogezo3J0KShUutR1s5xxxFCUl9qbbLUaBut3l5MVNa4a2xLUTUYZFNRB4xiPg5MljltHhu6bB+9kk2obR/q70hNWc+IZXcdc0lK2Ydow8RKwpMJCreNtROryjPFY8t8+Tv8AJWuLpTE15Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319897; c=relaxed/simple;
	bh=a6Ou2TGAoOsIm6LFpewaaxQoBqH4uC1WhR41znB/YTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJg9hDUskSaP0OQRCqYP9DU5Kzb2mNIHIfNPdeVIpBGCH/hbjyOCY2n7S6AfSnAYysnF5M0XxtN5oazDk8F6u6ah4YQdbV4NLWlqWVUAAcqB9KXX9ayRvlg6N6+YP/slN9IJ2Ow/QQ1IGL8RJs6MtL3xOACsKMpNQHobnHO+ZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUcat1nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98293C43601;
	Sun, 24 Mar 2024 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319897;
	bh=a6Ou2TGAoOsIm6LFpewaaxQoBqH4uC1WhR41znB/YTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUcat1nTEmcyLDilsI1Xl+P9ksoIcvwKig99eEmpzLy8DCqRTVmfS4AFaotowAp76
	 Ukvk5o8Cx4eEP7dXf7uUZ3MNF4eTdHoqDFg23z38SFUlf/x7K4TERp6WKJwj2s/Et9
	 DlbNGiTEFfRG9yucVaalusefHDzb/eA5PFG6EHW+gJp+JeLQyXzcfFaxtx6PbwuoGg
	 ndy421iYCMZ/Bfnky4c4FjfMn/mRlLLL+fh5BND7D+H8xXF8HcV4rgO1K8LXSAa8Ip
	 n0aTKh+/ATu/i5YQdyCPLR9m6fctUNewWJ//Jfc1P68K0YPNbJhPylL+CAsSp7GPrB
	 Bl0ML899tCQ7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 202/715] arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
Date: Sun, 24 Mar 2024 18:26:21 -0400
Message-ID: <20240324223455.1342824-203-sashal@kernel.org>
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

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 8ada14cafc5e185c668198617cd1ab4f1d8d325a ]

Add the overlay dtbo file to a Makefile target so it can be
picked by the dtbs_install command.

Fixes: b8690ed3d1d1 ("arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20240208-for-v6-9-am65-overlays-2-0-v2-1-70bae3e91597@kernel.org
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc9103087..08ce34d21d5d0 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
-- 
2.43.0


