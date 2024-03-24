Return-Path: <linux-kernel+bounces-113705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A12888E51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F261C2B037
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752AB1292C7;
	Sun, 24 Mar 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqqfrSvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172E144D1F;
	Sun, 24 Mar 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320684; cv=none; b=AfdVGiXHxLKZB3I2B3rcQPISKBqprold2pV41MDnIx4uhCN2yOEtHD5R6nsG4AnLfjHJdKpzF17PKzFbmtTh8t34mPnj7gKNrKWhtpotNT4IKgf9CkebCZo9cHQ89Z8WwTyUaGrPPGKTLIyIAlGH0s48e3rN13DMPnLiiALr2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320684; c=relaxed/simple;
	bh=xxrcHK3u9+N9bxYZFwHB6zkQtYX/lIuKUvyAgZsqUQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtSPs0z8MDdPbXwIhCu3tezXJospLMQWByPUJ1FddyYZQexhjPhH7uK0mcqIehCA3ZqSJ1bA48D4d4SVqmqbdmvXs3NjioFEnGWTbAbduGMq65QQdrSRT1ev38H/WLZJs5aex26cWXlrb7+n9V5nOvVA7HFW2DDR5hRVVi4nQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqqfrSvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22540C43390;
	Sun, 24 Mar 2024 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320683;
	bh=xxrcHK3u9+N9bxYZFwHB6zkQtYX/lIuKUvyAgZsqUQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqqfrSvl48C5+kLT4lYUqmBwoKrG+6LY/VOULt/NLuENB8SHQsaUrlzLqrtUHjFGd
	 wR5RyCd/xfZaOLTfdMYAugB2r81v/1Dp3ndkvuZ7o0AcaXgIGR14+GuBZp4tHTvk29
	 ufTt4ZUymlarS7B4G3X+9I6+0rPbyEAHT9AAwdtIHjn7OZdoTJOvpj2FK5Zrf+vrmU
	 tzkA3wkShx+bfyO7mMXtcsy3E0A+JwKy8mb+il+ZIhBhvLzDiVr3+Kh8ICrQoNUDwH
	 bg5IxlRIJQOzPopPnu7g4m1uBKZt0DScHsDW6WczzEwWyRTjoKyQDZgDSloVa5z8N/
	 PmzVd1mAYIpZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 246/713] arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
Date: Sun, 24 Mar 2024 18:39:32 -0400
Message-ID: <20240324224720.1345309-247-sashal@kernel.org>
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
index c46682150e502..26cb3268ccbaa 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -75,6 +75,7 @@ led-1 {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 2dc1bdc74e212..5c26021fc4cf1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -57,6 +57,7 @@ key-wps {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
-- 
2.43.0


