Return-Path: <linux-kernel+bounces-72001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E385ADAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06BB1F228BD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7003054F8E;
	Mon, 19 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY+2cyF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4F53E1B;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378079; cv=none; b=qos12fHgmgMGgi/RMH8iscIf/SWZthKd8mbMmTKqhuAnk3QQCcpDNGV5QGWxq0hgvljneoWfWC/i2IdsJXoWU6nftOP2bJmwgadyxM1ndFiu4wLpy6ski+dkZH0HnnJ/KcSorRaVvEOfpY4nunnAmAB0iyZraJWjNPmRg5siaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378079; c=relaxed/simple;
	bh=QALXNb0onLycYsgMBD77sidxYNcSFWXNGDA/ZI2hTFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHTl290DGb+Oq1cUmg9eyvyG+G3vaf0kk2PTv+oSIp252rTrqLYYpxJioMdpqB6HV+jt6sojuz2N9/X2vKSCD0srlB4ZsyXb92BI8Ts107wINRYlfKT3Z7/8MqTC+81ZrvJ54i6UVgdnZoXk2oOVGKvzg8PA357l3I4lojN53Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY+2cyF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49721C43394;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708378079;
	bh=QALXNb0onLycYsgMBD77sidxYNcSFWXNGDA/ZI2hTFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WY+2cyF8KbO2esqkK//upSklFy9fdKQNieae1c1W9+bw4JoGjAS1Xg2K4nBdNCzkz
	 Obnv5wb0aayVQmSqJmSB2atMUJPeojRc34aMUResDLnoQztvs0YgqdPfg3acqz5YRH
	 FbbBxzdBmL9KA7wTzIoZOslS67VSwuIsvNJQEIQqpFp+anBkNDAVDbgawEALIbAKpQ
	 54qGzvgo7mDwJ2WNOxHSwFdQnPiKCYLQaXiVbC4zbQDKUd1JElBKhxNnOs1quZiT07
	 ss03Z2oEsFVkeNHAqcAaO9pU/pssbGv+omExgR+7IVq97B/fZzPjWlwRf2Mb8DcW5E
	 stRXe4YextrJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28650C54787;
	Mon, 19 Feb 2024 21:27:59 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 05:27:59 +0800
Subject: [PATCH RFC v3 2/5] arm64: dts: hi3798cv200: add
 hisilicon,inno-usb2-phy to compatible list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-inno-phy-v3-2-893cdf8633b4@outlook.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
In-Reply-To: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708378078; l=1213;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=9vJGt8Ea6nDd4110Luo3uNaofm3Nie+YLh4/3aqzgKY=;
 b=G6dwipOzO7tIAyQn4WvhzD9c9rqV9ps0/6dGeA76lSMJBMrT0dJH/JkirMdy8SIQDVSc+ggtB
 y70Sgiw1jlyAAwqIqcwJKTAco24oWGn7DDyAwaasUOTGA/spqPteT2+
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This is required due to recent binding changes.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index ed1b5a7a6067..268d57eabce7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -114,7 +114,8 @@ perictrl: peripheral-controller@8a20000 {
 			ranges = <0x0 0x8a20000 0x1000>;
 
 			usb2_phy1: usb2_phy@120 {
-				compatible = "hisilicon,hi3798cv200-usb2-phy";
+				compatible = "hisilicon,hi3798cv200-usb2-phy",
+					     "hisilicon,inno-usb2-phy";
 				reg = <0x120 0x4>;
 				clocks = <&crg HISTB_USB2_PHY1_REF_CLK>;
 				resets = <&crg 0xbc 4>;
@@ -135,7 +136,8 @@ usb2_phy1_port1: phy@1 {
 			};
 
 			usb2_phy2: usb2_phy@124 {
-				compatible = "hisilicon,hi3798cv200-usb2-phy";
+				compatible = "hisilicon,hi3798cv200-usb2-phy",
+					     "hisilicon,inno-usb2-phy";
 				reg = <0x124 0x4>;
 				clocks = <&crg HISTB_USB2_PHY2_REF_CLK>;
 				resets = <&crg 0xbc 6>;

-- 
2.43.0


