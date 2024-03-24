Return-Path: <linux-kernel+bounces-114795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51B889140
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03F31F2C484
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40013D508;
	Mon, 25 Mar 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxvqdB3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70D276C63;
	Sun, 24 Mar 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323400; cv=none; b=E07HFcgWnapgm2kfhN50j8LnekFja0FusEY+EMGeuOQlE4cfkazRrTNEZP+Ps5yvK2GXbgVvG+JVwQn0CT93c5E/7n/wBfbjfQtoLN+NCWV454KqOPqfn5UyYCLqO1mACdYZlQfBMjeKFIvPbuTGSqeSUa/rQRkq1Wrk5zubtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323400; c=relaxed/simple;
	bh=kqFJ8GGFE1QaFK5hp69g3hvjiTT4Uo8QimzB2zV/zPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI1gZVEq4kpDOuoBLH8X50b+4/7mt+nYrBGa8EXwkxX0q7sFro0tLieKsTQ0/J1HNueHyta4GEhLlO0bI16l12TZhvTsbFDo0JBfUeTdC8IzVdjA2b7L4JrXs+EwDr9j+5B5pUNcYf7VVF5Fl8qf1R5ruvrj8IM3b+/jqDYhnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxvqdB3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AD3C433F1;
	Sun, 24 Mar 2024 23:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323399;
	bh=kqFJ8GGFE1QaFK5hp69g3hvjiTT4Uo8QimzB2zV/zPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxvqdB3b+BNDM5KsvqY7+1RqLPimOxbRPAq6hgATkq2YSb0Ju9W5l40CvBmRmWA6D
	 UH0xfzwVs3q4jePzTOqWwZ7haDS53nxmY2sadTDQ0Q8GSqhA+Y5HXTyYUO/cCmlQac
	 iO/SmYmXGG5yzDulfYN7p/GDL99v3jC9QEzytD1vdEk3JhLSwdivB7QhHxweXqqbf4
	 ktepzE+LpBeHq4bKLVuU1h5bGY5JzP9TESLbeK1jc1AnY0F0SOFv+9Xx34EKPPBrtv
	 NUGHF9lKiFp9emSuMSOV9OIeSOOpTRKbXxK49mhnsv8Aq6etwChP6f33bAv/xSlnQl
	 f5HPyctoqk02g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 100/317] arm64: dts: mediatek: mt7622: add missing "device_type" to memory nodes
Date: Sun, 24 Mar 2024 19:31:20 -0400
Message-ID: <20240324233458.1352854-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index cdbd70bf5dd9b..483f7ab4f31c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -71,6 +71,7 @@ red {
 
 	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_1p8v: regulator-1p8v {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index ee454a26b4597..28e17a7e2a5a6 100644
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


