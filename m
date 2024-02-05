Return-Path: <linux-kernel+bounces-52766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB37849C74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D202863F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CF21373;
	Mon,  5 Feb 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9BZvc0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B522EED;
	Mon,  5 Feb 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141556; cv=none; b=Pk3RfsrP6BNjtrynoKvxABVBh78NJS+V131x3au9MWOhtNFs351ViWT3sFSk4suR3deZLV4u/v8BCMXzHUqYRwXibRKZ5dowbyQSm2cjBbxCsU+r4cRUYU2geJDKBiKqYlA/t++6cgUBTroLpKMuUYlWZntvSFjuOZYsbl5VyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141556; c=relaxed/simple;
	bh=AnikdZnOTsGXdEyQTau0kuvwl7rNCalpyiI9Ffz36X4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nh747U+z7p23cybZXvhjjrw28rdl9UfKhOyx7DJqEPQ/qNfRI+zeVDp3hysCyVjdQBdjgnRQ/XsnJDveKBazQB3OgS9jpVMloRC+s17sACaXgKSBLCtyGSs04wE9uFxifRD8PDRVja4U6VL0A6nPiDAAU4Vq1w5xMtXRa9Ibyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9BZvc0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D63C43390;
	Mon,  5 Feb 2024 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707141555;
	bh=AnikdZnOTsGXdEyQTau0kuvwl7rNCalpyiI9Ffz36X4=;
	h=From:To:Cc:Subject:Date:From;
	b=X9BZvc0T0ph4fdgkO5Y7fC7Gr0jtyyTqOQMMKa3se/IvfVMnMq4DKMs91qQBgPUPD
	 D0QMby3rNvw+nSaCK4oaUiqZzO1QfMuQUWjsdpljbVcl/m5xAIgAq7uW1cRHwwQB/V
	 js6iJN5U3Ud3C6ZR9wtAG6pNP3sr551jNqJRauGovan+iRE9oQOZ841VvTC6rH4PdE
	 A6cyJh+mQQUe31o5/uB/B5OGq5pwWRwTm06hHymdkSZ3Y3uR2COu1sOhS91XCpe8ls
	 n15nd2vFcIq3BlE+S+SpYjNszD4w/frOZmindqnUpGpqgL7KJ0GIHsYe3JTLEnP6ST
	 xe6UjlhKkyOug==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/3] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Mon,  5 Feb 2024 15:59:05 +0200
Message-Id: <20240205135908.54656-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
in the wkup_conf node and fixus up the USB nodes to use the newly
added nodes.

Then it adds USB support for AM62P SoC and AM62P5-SK board.

In v4, we drop the 2 new patches that were added in v3 to add the
missing PHY2 register space to the USB controller wrapper node.

Changelog in each patch.

cheers,
-roger

Roger Quadros (3):
  dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
  arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
  arm64: dts: ti: k3-am62p: add the USB sub-system

 .../devicetree/bindings/mfd/syscon.yaml       |  1 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  4 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    | 10 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  4 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 46 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 67 +++++++++++++++++++
 8 files changed, 148 insertions(+), 4 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


