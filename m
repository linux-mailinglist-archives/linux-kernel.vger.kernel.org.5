Return-Path: <linux-kernel+bounces-41134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21783EC57
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498E428309D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11D1EA7A;
	Sat, 27 Jan 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C32EE0x9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33941EB20;
	Sat, 27 Jan 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348190; cv=none; b=TpEWUN4uUm/YCAqkKHOCyZhNVUax2cJ+alVtbqff3GeYUo4FGbNetGD8vktjD1hkmOfXGklTeLv2eGGHmaRZS7BKef96KUXWD3ALHGB4ZJ+T6SAeytzleYzghkcLZ6HXy0yrMQMjV6GLhGqd6okhNJEoUK/Ef9GEzhAlVdcmaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348190; c=relaxed/simple;
	bh=VQD/NidxocXfg3lbUSR9Mn1auVgxyDDPdrTS//OCFiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xp0jmr7WsmKotQ4aCIX0JcE3goKFbL/UDgiqxFudPDnA4GZrTd98qBszDCjiO9Q+gqgPWFVhMSmTXZ9T9iY/8Z8vet1s/EXkUvQk17K7GQkMimBlG1cutlLMjpNW+/U2xq04vwuUxDPc4AIfZJG8caiYRaMNEBRDPWxEsTxFEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C32EE0x9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hRdLF
	PkToQCEg+EFjZ96iBxTD5I3RysLL03nVwpagOk=; b=C32EE0x9vy7+8if1qdJ6I
	wP/yZT0FljOx5/VpQaiLdGaTDSTQWjeaui2QA58KrINKiGf3JWunC0uPAFLcAGwC
	5+rQtsg6HqayBfa3Dt1qFHiWyVSaPftv5XpLfrMT3m2UFQhwXbf2/ZOVoVeT5uYu
	zUbOJv2cpph+X6FJ1ED9T0=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3rzHkyrRl5GopBA--.2976S2;
	Sat, 27 Jan 2024 17:20:39 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
Date: Sat, 27 Jan 2024 17:20:31 +0800
Message-Id: <20240127092034.887085-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3rzHkyrRl5GopBA--.2976S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDuFyDJw1kuFyDZFyxZrb_yoW3uFg_ta
	47Wr1kJa93Jry3X3s8ta45Ga47G34q9w4fGa4YyaykJF13Xan7Jay5Ja9F93WUAF4jkr4x
	JrW3ZF1UJw1YkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRpHq2PUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0glyXmWXvvkQYgAAsw

Follow others rk3588 based boards, and u-boot only use mmc0/1
as mmc boot targets, so aliase sdmmc as mmc1.

Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 3fae40b9ae1b..3b9d21a6f8bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -20,8 +20,8 @@ / {
 
 	aliases {
 		mmc0 = &sdhci;
-		mmc1 = &sdio;
-		mmc2 = &sdmmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
 	};
 
 	analog-sound {
-- 
2.34.1


