Return-Path: <linux-kernel+bounces-115070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4588941C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E09B29D22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C651289D96;
	Mon, 25 Mar 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+I/iqoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0A1802C9;
	Sun, 24 Mar 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324045; cv=none; b=SwHFZjpXpLP6O6kyJSIjNt4tO8fK2RjRDlweGFG6hiE9fZS3LWIYOwQx4FOSjZFTOZHuTZW/c5xwg3H+PDQRT7tv+7+zsgsbXaAkTX8x/3jmAnGv9fXJr4cDavVKv71gxYWWhIFkXKyvbX8iqCF/Adpcc5HGw2g3VWx8nK+JVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324045; c=relaxed/simple;
	bh=cUgul7GVawXXTCkismqgAbljYZKw1pITj12s5zgPlv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFlkwUuxnBKnyjtlEv8uC7iE606UTGGFR4Q00NJplxPUE4QCRHqda+Ad+AK6Nv0qwVmZgRtoJNfBQDRB8oTm4lDjXmJRr2GAqppOdcw91AvYKV55/0xf/rFAAMmi1aZF6AFs6ZtHfSgqRcMKYLdYefpKAfrsA+aZnk/HWtdYQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+I/iqoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FBC43390;
	Sun, 24 Mar 2024 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324044;
	bh=cUgul7GVawXXTCkismqgAbljYZKw1pITj12s5zgPlv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+I/iqoCMJczfqw7aANqe0jAFQp8/0JC2x9+Qitdn/ZHefhKd+KL2ZJsNkHuN/b0C
	 5Kw0T01uYhgDhxe0gv8cz0XA/kJAzWwpTXjAa6BgdW5KUzGKkMPT77AnHrK5nYN3QH
	 T63xl4L2k6RFg1OnHH9vINya+DHDqaIN2zmlp4eVTvgiwDAAyNrd+d+JVm+s+KXhP8
	 jW8+c9+ZCt8xFziWyXurdsb//Hd+h+Cc8a83kUvEQuc/AlOTJDPyh9mKpnZG0H87pc
	 1vnzgSopHs73fyzsG3ZKDR+bEaLoYIR3bSqFej9vKOme8yhZQZgwwVqcJ/pSNEH0mc
	 hvn+qQ69vHBlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 045/183] arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
Date: Sun, 24 Mar 2024 19:44:18 -0400
Message-ID: <20240324234638.1355609-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 7b095378c96cd..eec9ec1db682a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -71,6 +71,7 @@ red {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index f586c1ee4a59e..ee57fccd489a3 100644
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


