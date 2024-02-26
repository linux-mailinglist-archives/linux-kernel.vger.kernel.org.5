Return-Path: <linux-kernel+bounces-81332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1286745B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5391F2B076
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3195FDB5;
	Mon, 26 Feb 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo1CLWn7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A75B1F6;
	Mon, 26 Feb 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949258; cv=none; b=LC9ZLtR1pVZUMRUnDqbVo4Qbn7+ZoWOFV/G1vDRuFlmg53yMuSofTwuJbVHV1V9Mg34PQJI8cWgOuhD/M27HhSDecdQjFNuDbhh8VtNJpMHqgXJBHwwvCU/Y6Gar2RAJW6VYs5jF90S7qcds6TBx28yD9f+njyPBvy5PLmNqs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949258; c=relaxed/simple;
	bh=tst3N3Ogd0NLb+9yQntn2eZ6lXZNfRn8LL6bYGoKxOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bPAXqVTjRW8+LFQcR30kUDTwYcPqSE7qbajyYsKIzGKmOS1L+mzhrJf75N9cQLDz4xcaH1KFg/YYv+7J30ISaWxE/ma08Xf7Z/vWKuuy2ckUhtLDYXT1313D4SPvgyQ0HEOnHYuX/yT/lgr0SGhW88WiFF0gJBm9HgTelCUa7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo1CLWn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E2FC433C7;
	Mon, 26 Feb 2024 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949258;
	bh=tst3N3Ogd0NLb+9yQntn2eZ6lXZNfRn8LL6bYGoKxOc=;
	h=From:Subject:Date:To:Cc:From;
	b=Zo1CLWn7kBO3dqtZwYhjmHvz67hXbCsddgPuOPmU86fiMqg0ZsBgR48+8JOSOuf+u
	 580OS/zJkG5wR3YOOPnMlJkAGuqVivmU+zKwp0ntgCv/OgWDJhRWV5boR3dBkzVAdv
	 6nqXS5XAZj5u9+K51qRE2a9iQOucI8+LUouBdbSO34nWJIVYqsgrlvQFQ7sozX+0Nt
	 CzSYzEwUIHh7LEOzBPXross7QDzOC48AridRdNko68syRIxa8OGgPkU7QjnJjSt7UQ
	 zw2B/toZ/Cn+TXkZO9jEqbhmRSKx/TuP/jNwQRQDBV/TlaVjd5oq9/cK+2it4rub3/
	 a6OnXjJ+dtM7w==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 0/4] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Mon, 26 Feb 2024 14:03:06 +0200
Message-Id: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPp93GUC/43NQQ6CMBCF4auQWTsGaluQlfcwLKAdoFEpmWIjI
 dzdyglcfm/xvw0CsaMAdbYBU3TB+SlBnzIwYzsNhM4mg8iFzIW4YCex94xRo8L2pQW+Q4fLOpN
 Bu2Cpr0RGmsrIFlJjZurd5+jfm+TRhcXzetxF9Vv/LUeFOcpOVUraorRFdXsQT/Q8ex6g2ff9C
 /Y8QlnLAAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=tst3N3Ogd0NLb+9yQntn2eZ6lXZNfRn8LL6bYGoKxOc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3H8B5NRe0+ntzBZocwRCFpqIUzzMk6GiOSfm7
 LVKZRCdLFGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdx/AQAKCRDSWmvTvnYw
 k+rAEAC1Avjo5YCFn0nTskB3ig6WyENuCGfXxlC3gLifKf7LC/N/Gaepyrfg8JJbeiVYmQ4YP2h
 EpD+Nfny9z8tlV8OYOt9QNJlfnOBxo5EPTXpdQJcQomjVXO+DP1Iv5P13L8Vvx+SjrjQKKpHzk6
 dgFlQRt+nTso9/F3YhZMElSdraI+cVW84fy+FfkLhWA22uGOQTsiB4Qv8dm7by5ZKtkPQ11xZHN
 yAnLLfqNA2n7ZK71GXzcNyb74QXNNzmxJShuZ/Jr8g50H/yXrjaDIdQBle8ecNgyf3r+u2VkqnD
 xRuPZbra1vAwmtDPoeoCGrXde/GZvB2sC6kZe2dLqZ8XyTqOYLtrGxvxYZ/vnM3z+7NSeE5INSy
 snWIcsPGETNs7SH3YGvAGpdt9cTsSzJXbomZqjgi37oQvdIW0g1YmARh/ntQ4TTeULn6Q7Vx4r1
 jHLrpwbNtoBW87/nHXZ3AO3ctbp5zk17veP4OVk/4JW+KkBr5L6FFhK0VqQwTP6xF+sThSDR2P3
 aq4Q6VFlRIw75g8HjlpQhwd4ZXtlbS+mrukkZMVUeEyJD+EkBns4t/8ndD/uT3s5zovpggH1vHj
 DxJ9O9ckuC3mm2m2sQ/1QkzXjO+Q3srNh/ITMXWrofOmNTFrGarhWSKtSbMUkm9mXyQKPFn24iM
 FOsCYdagOETN0uA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
in the wkup_conf node and fixus up the USB nodes to use the newly
added nodes.

Then it adds USB support for AM62P SoC and AM62P5-SK board.

cheers,
-roger

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v6:
- Rebased on next-20240226
- Link to v5: https://lore.kernel.org/r/20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org

---
Roger Quadros (4):
      dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
      arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
      arm64: dts: ti: k3-am62p: add the USB sub-system
      arm64: dts: ti: k3-am62a: Disable USB LPM

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi          |  4 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi        | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi         |  8 ++-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi       | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi         | 50 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi       | 10 ++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts           | 67 +++++++++++++++++++++++
 8 files changed, 156 insertions(+), 4 deletions(-)
---
base-commit: 8552c902efe7ef670b6961fb8885b67961aeb629
change-id: 20240223-b4-for-v6-5-am62-usb-typec-dt-769eec4c8c4a

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


