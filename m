Return-Path: <linux-kernel+bounces-144299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C68A444A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2A71C20C36
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EC135A63;
	Sun, 14 Apr 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Uly6kSE1"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F51353FB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114213; cv=none; b=m7yimA4GW+/b3a3PJ2ukpVgGJ+9g9aJktGVe8ePMw6mD/aY6KRT2pZjJu6LdNmwQK+EMRmYH+BnabaWy2DXYOo2a0RL7pwnnsLEZFNwk4dCIfo6+hPiwiNM1M3ITXS9aFmooeRbuDerTmyP+9AM3lqMJqK6jN1mtdboE/v4/lDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114213; c=relaxed/simple;
	bh=oAu0xcmhHlCV1+noU6f7q37wld1qEcXlQdUla+DYoZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9aHWHAtQhmmXHtpCCiFwpH7PIMPH0x4a7kLv8l318a3UjNbxSXz9KTcTsqraBUfAqOG1Ayv7V1M2xEtR1fjlklzMdGT9RtVobHj6Nn+fGanC0sxoUjy0tDrulvINkzZPbi8Idvc+2pjJNh3hiqKUxQHkgN+RGRjW/eL9xSd4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Uly6kSE1; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1713114200;
 bh=gMlj6yQsVpAUf4c5FKz3DvGcpLcTW6AorW4VMtzn7yQ=;
 b=Uly6kSE1BmGTuLLpIt3bEvgpCF8SNR9uC2XTTTlLew8fGARPpcCyHbefIRGiZPejxZx/kZtqp
 TXFvL9gaBHt9tVziQXm10IhF50dSZmARERsoVzzLevJRWhpdmYiJrrrGaDwvYYE65dDKXjdUKpb
 zjmPBSBJ/sh+moXqCcZV9DlBtGjNHPcq6LHyffN65c9prbtSfbQizQIvhqTG8okSGWHx1hoXEZw
 6376ym+LrnQ+AjC1eItZGsiWXiuNBqvHVSHKLfRp8y2mxz5Iv4UItyEDHBnqIIrIF6ypvuziyMS
 fDOSuJKtySxF/8o93mAshYb+QCDdnCuf98j35URwDq3g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Date: Sun, 14 Apr 2024 15:11:26 +0000
Message-ID: <20240414151135.1774981-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 661bf22e99ce03c87699d717

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

Jonas Karlman (3):
  dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
  arm64: dts: rockchip: Add Radxa ZERO 3W/3E
  dt-bindings: display: rockchip,dw-hdmi: Fix #sound-dai-cells warning

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 .../display/rockchip/rockchip,dw-hdmi.yaml    |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
 .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  26 +
 .../boot/dts/rockchip/rk3566-radxa-zero3.dtsi | 443 ++++++++++++++++++
 6 files changed, 523 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero3.dtsi

-- 
2.43.2


