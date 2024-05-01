Return-Path: <linux-kernel+bounces-165306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B568B8AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8921F2339C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688012DDBA;
	Wed,  1 May 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZxQ5bmkP"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AA12DD98;
	Wed,  1 May 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569279; cv=none; b=DpWSLpj4INUhYKdQZrMmzoVQtEd13p68CF/ytlD9Ahrs/H05j1q5BRTGI5x8OTO5sJ/hz6uCyujSDjmGJu8hlIehrPSaI2Pjyaul9vOcksD2jv7ctb+trIpHn1g06KHT9D5vlLBZFpOHOoZPyWHbNA3HsBMdLoX8c263eLoItis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569279; c=relaxed/simple;
	bh=ycWgagX7JlsSyjXHTTuJ3nNubRp/rJ7hV7R56K1vNw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd8GJ8R2F01BFQxjXZ1yPZNlK21lSrl3DFZ8tO/GgFioZ0HcLnifp52LF1nu4/sfkEEg29g0OwoATcTwYhaKbGxZ//SVKToRtWa1JRX0lwU2MQUqWOSYdj3EkI+zZzVMzlh6YEtC4nG+HjpH+wM1KkHDCeHc5ZyRHDn0UCSVxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZxQ5bmkP; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=wc8mUdFGzbenhBr+NaQWmBJjKISZgrzN8QM8DxpgOdA=; b=ZxQ5bmkP4PR0YfJ02t6/M6bYj9
	sEyPuBqAR2mX1FurDGX/mwlt5sPBa1/8vJ7COqlPyX2I7hMp5f20ziiMGExtZYCVN1q2y5o0m2Fru
	vUgq6MKFkP5aV3JTs0eZqkcBUz5LW0SwD9Xo4r0/98NHWAxGnkpQU61yG/r+6D18UAmCV44I918v6
	cIbNB+nASlu+8Nw5Bswf3G4JcYHOeOqm1a/349kLlGuhwOLcDZfKVUAg3kkSGoHSntRmYVB57N+uM
	rpidesDXRhgLiVXPaYvUzjhTvO0UXXDPF0OID1+uoWu95/a/0VXm6cEeN3e0vTVQKbZHajxcSXMcS
	IU355lEw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1s29n8-0004lJ-2R; Wed, 01 May 2024 15:14:34 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1s29n7-000Dtu-1X;
	Wed, 01 May 2024 15:14:33 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: stm32: osd32mp1-red: ensure deterministic probe order for mmc
Date: Wed,  1 May 2024 15:14:01 +0200
Message-ID: <20240501131402.3579400-1-sean@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27262/Wed May  1 10:22:56 2024)

Add MMC aliases to ensure that the /dev/mmcblk IDs won't change
depending on the probe order of the MMC drivers.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
index 527c33be66cc..fd795084a6aa 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
@@ -20,6 +20,8 @@ / {
 
 	aliases {
 		serial0 = &uart4;
+		mmc0 = &sdmmc1;
+		mmc1 = &sdmmc2;
 	};
 
 	chosen {
-- 
2.44.0


