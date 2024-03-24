Return-Path: <linux-kernel+bounces-113079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D6888814C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DCA1C21523
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A714D43C;
	Sun, 24 Mar 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfJnZIbK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184954735;
	Sun, 24 Mar 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319887; cv=none; b=pUU9Ng1J4+rTNcfRtMOJM4Z85XCrjmOnToUgUOc4IZ/prKhsExfh1ohR8mQe55nNDapAF/0s9qMD39zw9VjjgSZvk8Sky9A0HX69nFVjRlS2H3/MJZKW2lo+gs2e8rnWPYokeQ/n2dG7HwyHlaAbxKH7CnJWyEOBzmvVRYm/h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319887; c=relaxed/simple;
	bh=i6d8nId4acQL2nz8imcsUWI9nn4vWU6z66u0NR4onf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejTtN5hbKLfQFuZt9WTe6sv0yUQwFZNqI8SDUxWprLmejtU9LaiKlxOPkK5+xblr0FqfCnPXusfTjkwkEETgvhxIU2a6RsswbJngIx0Mo5g1B7TWgrXld/aZhxh9evp6g4Rh0ZsvR3Gk9hcCLgBxYvrPI853tD33BE7FV6pUUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfJnZIbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A58C43394;
	Sun, 24 Mar 2024 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319887;
	bh=i6d8nId4acQL2nz8imcsUWI9nn4vWU6z66u0NR4onf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfJnZIbKflQsSyE4R1TuwoVlHkVjFeFtx5W1ZvC9rAO5csHdIcHiM9MtbTKEXxVgR
	 u200KtPHYTfYCSY3CswVB17h54stOvpE8Pgf8EidsS1ur7SwXsTUYFH+Izuhu2s6ZP
	 ByI3aFuljt2BZQD5yLWX0PQp1NocryV4bGEnGsmCcHNfRHaBu8WKmZjzYGpbaeJNbH
	 ll8cczF0Af+7gIatibZ7Z/sx64J+0WtmeNyXrEoumldhi1V+KuWxQ6EW+iZ7QvMDKr
	 Igi8GMDOW4UW2cwfBvPduRCTvBdSmUrIJSLOgQBP4iiCmeVQK7z76tXoPlUMVTEWlA
	 +o36sRQ5jirXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 192/715] arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
Date: Sun, 24 Mar 2024 18:26:11 -0400
Message-ID: <20240324223455.1342824-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a1f42048dcc70..850b3e2773680 100644
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


