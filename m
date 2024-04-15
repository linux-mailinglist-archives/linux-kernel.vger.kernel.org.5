Return-Path: <linux-kernel+bounces-145415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6538A55E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFCB1F22AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F71762EF;
	Mon, 15 Apr 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="hIkunzUG"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B871B3B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193464; cv=none; b=r/GCMrrIwmOVMo88j0SaLkZHvMUoS3Tlw1Uc72Y7P2HTlw7fYUUkKaY4UXtxPp4ULKJ1RSQph+UvHiP2zcNBRtguzctyjSMLubH+Y4jUbpI6odsfgk6kxIm1kq2MtoC2hu+sS/pbtH3b4jixKyd0ub9x1it+1XpJjyXjSyDbaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193464; c=relaxed/simple;
	bh=xL0bSWmCWcrob4fUl0+9Fkfu2XebS5GWoaDeTiURZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8NdA3RY/MfWswMe3GZj24xvJFACWSM3x/UDJJhRWZID2NT2pMD6hIPzUchsAy/EEX/mqn6FEA7x/Q9yAJW5O+pYmqVduWiOp91PYXCLx6hmxxAe24NXf0VvQM8vPmuLNhGgB8lxn5U0IAlhxce1Gtlei8JIIeykBK6j4aJ8vZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=hIkunzUG; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1713193451;
 bh=VbsrmMWWph4CJG8LvhOpQoTebYqI7sNolAnzLmor6HY=;
 b=hIkunzUGN2IKS7q7dCvTN/Pz4Rk3YG6fq/7VFrvOLnsnvP7rSuyz2tj4pIli9nMVk6spHYmhY
 98e8tl+ODh4iSjdPvwL7gozI3x1472I1zFgQvUA7F2hL5NvnBDcRiAD+owqe/71O5Jm3WhbNAHN
 3uUzgTTVV4zUX3y3geLaJVwWRomJOBRqZuXPwlP2zW125xT5/x5gKy06OCq+32JS9xC92pPV3+I
 cmf/+zIet0SzL8n44O/Po+Yf21FfVhqTO/ojAUI6MApzwGZhX4XaIrH3+6czVlnQofja0PEDeuu
 UxCrqv3zwAs1k/EXFJNmO17BqfKmJsxzshquI81nsv+A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Date: Mon, 15 Apr 2024 15:03:42 +0000
Message-ID: <20240415150349.2207075-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661d41eafc656ac01cb46457

This series adds initial support for the Radxa ZERO 3W/3E boards.

The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
computer based on the Rockchip RK3566, with a compact form factor and
rich interfaces.

Schematic for ZERO 3W and ZERO 3E can be found at:
https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_v1110_schematic.pdf
https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_v1200_schematic.pdf

Changes in v2:
- Collect acked-by tag
- Add to Makefile
- Add patch to fix #sound-dai-cells warning

Changes in v3:
- Fix devicetree spelling
- Sort hdmi-con, leds, pmic@20 and regulator@40 nodes
- Change to regulator-off-in-suspend for vdd_logic
- Drop patch to fix #sound-dai-cells warning, similar patch [1] already
  exists

[1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
  arm64: dts: rockchip: Add Radxa ZERO 3W/3E

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
 .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
 .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
 5 files changed, 519 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi

-- 
2.43.2


