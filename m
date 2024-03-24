Return-Path: <linux-kernel+bounces-112648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F66887C84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED651C20B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163751773A;
	Sun, 24 Mar 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N71CAqrt"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299D7F9;
	Sun, 24 Mar 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279841; cv=none; b=lvQVd+wsRefAtEsl2yvJFVMJE01x+qCWoQO5xE4zujmGIHl95l20R/TvP1fUniaL8eDfQMRGSr+nAdu7ABhjofFrc6VfZjUSuoBad4YLLwnoZkKvQGdgX8Nysh16Nlt6rBvVZsC9YMYmT38yFPuhmb/n3EvurXXoStGTeVpW5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279841; c=relaxed/simple;
	bh=GoV7N9H3Rf1wTkZrAricLZg1WI/IKToKGh5Ep0OHxng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6TkIBU+JiwoBSh1vgNEReWviuWGvhciGrnE0EBTUbg3jLfxB2UGJdc28Rt0caK7BRwWyA2uxzFS2sSvXial5fYl6BYHBDLWB7yNqymh/awidbScE4DeucMhocn2rEgzMoTOf9F7oBur/dOb/ZhhFUO1yUSgZkkUvrocGtm3FS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N71CAqrt; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JT3mh
	3pBXUE1j0Z7V6vKd0YcvAz/Tmr/5mTxbrnRMLI=; b=N71CAqrtACJ/fESGQSwmd
	0scqgszXr2/ABusiso1N2CE3W8RFaIuxRWQ0fz9r44rDC+jU6x99sCe9UVEY3mdD
	Psite649DIgfNm90mR4Ei52bDRgEGjOb/ulKDYTlSe3iqMS9ipBXo4QQp80jAwP/
	R700ke9v8fRpbnxcBWPRcs=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3f6xjDgBmCswnBw--.40872S2;
	Sun, 24 Mar 2024 19:28:42 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5
Date: Sun, 24 Mar 2024 19:28:33 +0800
Message-Id: <20240324112833.2181961-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f6xjDgBmCswnBw--.40872S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4kCF48Zr43ZrWDurWfKrg_yoW8GFW8pa
	13ua9xGr18ur4FqayqqanxWFsrCrnIqFs5Cr17GFyxtr45XryktrnrWryfCryjgF13Za18
	uF45Zr1DKa1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi89NxUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAarXmVOC9d6HgABsx

According to the hardware design, the i2c address of audio codec es8316
on Cool Pi CM5 is 0x10.

This fix the read/write error like bellow:
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6

Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index cce1c8e83587..ea8de76b9214 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -218,7 +218,7 @@ &i2c7 {
 
 	es8316: audio-codec@11 {
 		compatible = "everest,es8316";
-		reg = <0x11>;
+		reg = <0x10>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-- 
2.34.1


