Return-Path: <linux-kernel+bounces-88149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E886DDE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E1289A89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2B6A33E;
	Fri,  1 Mar 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CroOZLCy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fSxtikbA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5E6A322;
	Fri,  1 Mar 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284468; cv=none; b=CoEPXf9uleTWuJ1RFo2CRPuATnWhDIXOcOZQ2evio1xgEoJZEjmEuP100MMVTahODq3jOTpU8lKY0G2HhqGe4c4bin3TyyWmV48BP/69Tx7DrVIk0wo12lxQ6KkFx8rA3+qweCespjWM7aTOC31kSmZYkrXD8dMo9iy+/aghklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284468; c=relaxed/simple;
	bh=9iM2bu1u6XMX/Yg0FXpuZQl+3476RIQYzgQlICCm004=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F/tjvcOGTKAM7+CFSmmqCacYGZaGNaH5o7dYDTaiHjmfMunEe/TY6V10kFhCmBoHA0PQ7CdFSS/jme/s94BqrQoX7/fN1TEG2o6nhyPvXHJly4qFN7F74i6LA14qIHvh4fa+fZCPPW9/r5GHpAQ3adCeCF4iJMteWIvJM1X9dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CroOZLCy; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fSxtikbA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284465; x=1740820465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P8svfQZtYemDwzWHFSATYN5ZAeYKM9GfycB0sFipewA=;
  b=CroOZLCye3gPR85g0OTaIGKBjOMWMzW0ELBA59i0Y4zbC78IpGQaUSpm
   W7ukyqCCiI58eXJbBmWU4DsV/bd4epUNTLLT4IK31dQwWU08WKh/OaPgl
   J1i6i8tBfzylSLqeiKHSrhySDLYfgkoyPy4HvQClVdLS3pPNh/6hFJMRQ
   C9Wqz4AmnA7DY1lDCC14+HTJOhPnzVoNVkA68saMDFSz7HpqxtlkPRRRH
   /vVHNIeQHLnPyGpM+3rKJ29Pm/uQ/pKXDPS8+5GAfbsr6t20UwmBPq3EZ
   8ueW44roPTYj/dgaQW8B3k1s+Qqlc4cDsv6SS29MRBJetRpLKAMVHZBdB
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682423"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:22 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6993017343E;
	Fri,  1 Mar 2024 10:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284458; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=P8svfQZtYemDwzWHFSATYN5ZAeYKM9GfycB0sFipewA=;
	b=fSxtikbAqRRAXD1t65u7DIqtzTMOovELAHPFiRm9UN5Vo+naKkv7aXbSZds+n6PjIgj8Iq
	9kxlRfVE1DW9urdtHMSGOF3LqMA2vUlt0wLe74t6X3usLW4BCp2Ci8WGwYmJWy3rdv15S0
	WmiewnhOl1n614GRE/VlAkLMIL+51+4Sm4lJ0er3aPG6+uMd3uFK13FUOnYPm5upves96Z
	B0MTsHj2Oheqb7/M3GpIY6zQuuwe3hopbF1D9uYuHAYpMUCiaZBl93wKDbmAU8DduF5NYV
	XcPr3iBHXx7VfJlcYd6viA+UGFbgCixnkwxFrTNiE6vUYlTFqnP80ElhTKhdag==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 0/5] i.MX8M add DSI output endpoint
Date: Fri,  1 Mar 2024 10:14:08 +0100
Message-Id: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

this series was initially triggered by dtbs_check warnings. Despite [1]
rendering them invalid, this series still simplifies the DSI OF graphs on all
i.MX8M variants by adding an empty output endpoint.
Each board enabling DSI connection can simply reference the label.
Patch 5 uses applies this to MBa8Mx board.

Best regards,
Alexander

[1] https://lore.kernel.org/linux-samsung-soc/20231122-dtc-warnings-v2-1-bd4087325392@kernel.org/

Alexander Stein (5):
  arm64: dts: imx8mm: Add empty DSI output endpoint
  arm64: dts: imx8mn: Add empty DSI output endpoint
  arm64: dts: imx8mq: Add empty DSI output endpoint
  arm64: dts: imx8mp: Add empty DSI output endpoint
  arm64: dts: mba8mx: Simplify DSI connection

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |  7 +++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi |  7 +++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |  7 +++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |  7 +++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 14 ++++----------
 5 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.34.1


