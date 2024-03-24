Return-Path: <linux-kernel+bounces-113951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B0888F32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E527B308A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572313F442;
	Sun, 24 Mar 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAc/SK4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329114B085;
	Sun, 24 Mar 2024 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321063; cv=none; b=DaD11V+JXiwMTPw4iK8hHmfhd8CZESVmDsK0hTu/LT/3RQuu9GvltYoGuZ0OO+dxq1rAi/L/udI6ma3Kj9EExbjGvvGZeKzJcG79c5AxGggVROYhcZW0zXuguarGsnhEzd/+Wp+GvARBYx0B4uErQAcWA9yxCJC7lQyNGmG1iyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321063; c=relaxed/simple;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMSsY0tSi3eZ8Qo3cEhy6jXCymG2poDCJmoEyK9xww4NFdoDvfc6HStGY4Ukkn1LH4wK1G8m1MaB9MSKuCIV5xGDcxwo6z2noobi06mG+7l/SBZLCTUmfxSGeh6VMk1mGbUlhVeyAUKdNeAluMXk/jwKPjR0hITCnhBt4tt3agI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAc/SK4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA5C433C7;
	Sun, 24 Mar 2024 22:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321062;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAc/SK4VxRKcs4zHFPecOOdGAIkR2BAs0ABqUC/4gfNzvEJ6ETz/A87aKUf7I1cel
	 0LP39SrrnBpV2O1jl4UhcGU1l/aPo6Tt92JJfu9bRY7vpi+b4Yk0Mj0x8RsJLE/zIY
	 481LGV5YUolGCiFGvQD9SW0eVFMaKp8tKjz5z1mwUS4aN8UN10ljgj69uYtGaYppFy
	 g/7WUzDEg/CWpmEEXzV/LswAF36eBAboNG0aVwIWgZas7iX5c+NCQYy4qZRUdUb+KI
	 tDLK3bgSoCtU3kR6Vq9ImLRgvyYS1zQwhsLf2YrJzN+FF7WLxU0xHbxo48Gbacxb6N
	 FXiAhFCJXR5jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 626/713] arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
Date: Sun, 24 Mar 2024 18:45:52 -0400
Message-ID: <20240324224720.1345309-627-sashal@kernel.org>
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


