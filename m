Return-Path: <linux-kernel+bounces-114949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5A8892B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5475D1C2E386
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07E1BF203;
	Mon, 25 Mar 2024 00:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbIK+w/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61817A90A;
	Sun, 24 Mar 2024 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323691; cv=none; b=rzNWSEfOX1HUlUtOfUl3zZTakB9BfWE2kbZCNIpP8Gp2m6D2q/lp921UjvkxMzsi2Pu6lqZnGarqPfZAb5RVxqK8+k4NKUoINHtkUxqOkPwLFKhmcEde/FYT6/4dHp/8bkIAtVxhTVnZ4y0b7YmAVUqIn5U9ur8A1mSFeqrOKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323691; c=relaxed/simple;
	bh=21kd0MNS3pEpDqW586UDWv2efJv8oqkhwV370kyKQdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk7mwDSXmVmapEFFxFrCg9QafFVsSntTCnSjgxCYA2d4UCQKOK2pJnwH3dVu5dJ6+VRzphprmqM7m6ZfaFN1uskjwFnzKaCtTHxonRWYEJBX35bQmD7w0YGp+vXrc4HuGewlI+V8Bh4qewVt0YiiT3hC9oK8FX2jiKZRv7NmorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbIK+w/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229E5C43390;
	Sun, 24 Mar 2024 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323689;
	bh=21kd0MNS3pEpDqW586UDWv2efJv8oqkhwV370kyKQdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbIK+w/G54Iq57eXBzzygICPdwZcEalFLT9tvWL3/Gw1sLSkp/f8yksXw/3GenKaH
	 u5gBAlMAZqY44BB+0ZZCZ8QQY3OgSJBFXfyKRoVPLnUFQbqhhwMyMaTsb0RvaNDCc6
	 cr0/+KV7VFxV6IioVB1IGOlxWrEmF4VMGcNwC/83GnQEBlWxcFQvCPw67eVIzaJhDf
	 ONdasOnrBqdRx1OlNN71TUSCRIuFoemUPBi+htYeJE3c10pK3y/3HDyMn8rJohTVCz
	 uyDAB+JpoyalNHnKBtPvO7wZe7P0svr8fX5xIPGgOFNVFJ/nHQiFCAXDS87EVNNWt6
	 i9TIR8/mdktxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 062/238] arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
Date: Sun, 24 Mar 2024 19:37:30 -0400
Message-ID: <20240324234027.1354210-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit 99d100e00144bc01b49a697f4bc4398f2f7e7ce4 ]

This fixes:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: /: memory@40000000: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/memory.yaml#
arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dtb: /: memory@40000000: 'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/memory.yaml#

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240122132357.31264-1-zajec5@gmail.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 7e6cffdc5a551..778174a7d649b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -71,6 +71,7 @@ red {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 993f033d0bf04..810575de66702 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -57,6 +57,7 @@ wps {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
-- 
2.43.0


