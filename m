Return-Path: <linux-kernel+bounces-115736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75838889759
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D9F1F382A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1163659F1;
	Mon, 25 Mar 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy89rkbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BB15574C;
	Sun, 24 Mar 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321833; cv=none; b=eGXxX4VdFMvHS/dmhRb+BLG9RsF1gIUMdYzG+dE/d7dbDAYgdtM0CFlMfaiAOkC35l9MBq+N3143NEhg5vLxZvm538CbKFsgwYIMvNegp2tQ8paxs8bdZBRdLKEuRNHdmFV0CQHtElQE8S5jPfHAO4dyQifOUUQJY9PfiAu0JVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321833; c=relaxed/simple;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaNGdgn9tYRABgjC2ux0yxvoIQUDkYvDmPkGJJKH2kN4DbUJiNyulJMaaICGoyD37uhI6OBdHKAv5N/RA6fPlEt9QRll2pZCvy7tqMEwYt5bC/mfcfVav+0FqsrbPZRQbSvbqPLqLmg/veeTfXzNiGfMzyixqyG7DA50YGuSr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy89rkbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFCEC43394;
	Sun, 24 Mar 2024 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321833;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xy89rkbDxI+IX/d2bTSC2pWKDDwK5EfNWSSpJmgMtOd/55aZcU2JVfflhNGEM+c2K
	 zG8DefW85mTVt3C2q3fR+6KtgLF7cooMfmEs5Ir2Tjp1OrNy95w4mi6W5BBInNXKn4
	 SnZ0Pk5eaJiavaAUA/PUh5Rmy9Pysj9aBUZziIMEL8368G/pvMCXQrQ467Iu7g7ZcK
	 dIkBGBEnyL4Ilp9Y0Clvcv8/wZHM1hA+yiqNaEnK8HNJJD9hovDBZJwPB7zFzIBLnF
	 kQsY1ZNdwbjYB/VK6vUFrOxgCE/MAxVCHs2fy/Z2sS+EO2EfNua/aSCUED0U8edjHD
	 WsJKFkKHE6jYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 562/638] arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
Date: Sun, 24 Mar 2024 18:59:59 -0400
Message-ID: <20240324230116.1348576-563-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 27058b95fbb784406ea4c40b20caa3f04937140c ]

Ethernet switch does not have addressable subnodes.

This fixes:
arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dtb: ethernet-switch@0: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/dsa/brcm,sf2.yaml#

Fixes: 527a3ac9bdf8 ("arm64: dts: broadcom: bcm4908: describe internal switch")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20240111115636.12095-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 2f124b027bbf0..aadfa0ae05252 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -227,9 +227,6 @@ ethernet-switch@0 {
 				brcm,num-gphy = <5>;
 				brcm,num-rgmii-ports = <2>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports: ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.43.0


