Return-Path: <linux-kernel+bounces-161423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120988B4BC4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8FA1F219F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09706A35A;
	Sun, 28 Apr 2024 12:42:45 +0000 (UTC)
Received: from mail-m92102.xmail.ntesmail.com (mail-m92102.xmail.ntesmail.com [103.126.92.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81844C85;
	Sun, 28 Apr 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714308165; cv=none; b=McMz07KYKejXr2h3S/u7CWASewC9sPVzgQ0uMxLoDrObl043l8zleXE1Sq9RlbKFmFyKnzPCOf6GkICH+AjdChm8+LlENkHqJGJ2Sxnj18YEGHwB7JdrHrdM7xq+WJtcKu+G5Uj7Qj0M5eiiK/aWnfzi+htVbUdHeIllO1aM4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714308165; c=relaxed/simple;
	bh=o+eduCBbZngVakIZ81GQ0U04aim/PqJJMkZQduX2gXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dpp5olJDiQRb7X/F7XmTajsrtJ79rQ9DjnCwdczMpqIBaNXHy7LSZGd4VtDrIDiMtZGjev2P5dNLB1JbprKNupLhl1NOCvYvtvzco171wxQ0sV7Z06hvqtBveNFq4/5WlXs1nXUjxFJ8Kf+62BtfeIU68HuMh+ZIa5jIFzcHJFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.126.92.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:6c50:87d:6be4:19e8:d47])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1F7EA7E0129;
	Sun, 28 Apr 2024 20:36:43 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3C
Date: Sun, 28 Apr 2024 20:36:16 +0800
Message-Id: <20240428123618.72170-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSh8fVh0YGExMSE4fTRkZH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTRhOS0FDTB9BTRkeT0FKQh5DQR9PTFlXWRYaDxIVHRRZQV
	lPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8f24b528c603a2kunm1f7ea7e0129
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6Tio5SzMDOi4rPDMdOEhC
	KzwKCU9VSlVKTEpPSEtMQ0tITU9DVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTRhOS0FDTB9BTRkeT0FKQh5DQR9PTFlXWQgBWUFKTE9NNwY+

Changes in v2:
  Collected Acked-by.
  Drop cd-gpios for sdhci.
  Add mmc-hs200-1_8v to eMMC.
  Correct the spi max frequency.
  Update model name and compatible.
  Update regulator according to the schematic.

Chukun Pan (2):
  dt-bindings: arm: rockchip: add Radxa ROCK 3C
  arm64: dts: rockchip: Add Radxa ROCK 3C

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3566-rock-3c.dts      | 750 ++++++++++++++++++
 3 files changed, 756 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts

-- 
2.25.1


