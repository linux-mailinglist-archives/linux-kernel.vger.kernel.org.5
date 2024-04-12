Return-Path: <linux-kernel+bounces-142618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D8C8A2DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D11F219C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1355E56;
	Fri, 12 Apr 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsbpPnc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640E254903;
	Fri, 12 Apr 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923326; cv=none; b=dUiB2ivUYr86Q/SxfTB7P1m4/BXCWlm8/28q9IAArUt7rCtqVecVdEuV0anXN6JKgHvfiArpFmWTKqZ49XodATqJy+SK9G34rLYSkxQ+jD7ZNlOAHDB7SvvJ+avQ7vjIVMIv0uGM0xgUaNlWxqsC5OyL2QSdgxiqAv7KwKs9ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923326; c=relaxed/simple;
	bh=rERn7yeXD/7hC5Mii1WXiEi1cpIHUuHBgX/pqno7EQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bhXds24FOXsMNmFQ9tS4h8cL/CS421WMYcb4FlcMBPacLlo2DPmmMdnXFao88GLbyjkHnCtmvwIqYiO5NM1xCuZTUDxAcE9LIBhLv0nmBnoKeiddamjrSXnqRrTShHrVyUzrb7VDY3a1F2UPSJXWkb3f4VoLv/pYMmbUyKRzQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsbpPnc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64F7C113CC;
	Fri, 12 Apr 2024 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712923325;
	bh=rERn7yeXD/7hC5Mii1WXiEi1cpIHUuHBgX/pqno7EQE=;
	h=From:Subject:Date:To:Cc:From;
	b=dsbpPnc3Y1lPe+jNAVVDtarUSzJwDd+U2t03crTqqHovWGGdGpfklz/tMpBkX0kgD
	 XyKAK1xHbQiHGLRPJ1vjQseCPrl5vnxzK9Jtq3K8JY22j8s3vgKAm79R9Q5PuxaA9i
	 /UTse9KTF0g3Nd/cGEnlk/Kof7HeEWic0K+bHTzAU/Sq+SNawxx6QIxbAo6Y8KzSca
	 OGOE9eInZu0YQe60GslR/CXLWvT9xO8uL9LedcS42Vb1x1Xutw1zzCOARpEV2J5FZX
	 DYMQ61Dnr4rQGUQIlg4GbYodBUKZ/h6EPuwleeuzeY2OlHEiQMh/gCzTrLDXE3MNMN
	 +oBHwx2LBIhKg==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v7 0/3] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Fri, 12 Apr 2024 15:01:57 +0300
Message-Id: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUiGWYC/x3MMQ6DMAwF0Ksgz3wpuCGoXAV1cMG0HgoooagV4
 u5EjG95OyWNponaYqeomyWbp4ymLKh/y/RS2JBN7Ni7G9cY54gtoHKQT2B80xPrf9Eew4o6eLk
 7FgmNpzwsUUf7XXv3OI4Tss+UFG0AAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=rERn7yeXD/7hC5Mii1WXiEi1cpIHUuHBgX/pqno7EQE=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmGSK6mGLNRJVC8ORfJs2XNhJMfrpZcxCgKSDsr
 a89UXYCwIOJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZhkiugAKCRDSWmvTvnYw
 k0CCD/0cz+uZZ7ZzQH9VglqLzrFoEDbRegbC/JvHUaqiQdrn/bE8hDipQS2u8FIdJpTjZizYwkb
 ui0wLhqUbV5iiGjtoowq9TDfG1L4LeRH6uHW/UjflaJtQMTqYKS2hbLQQeIwSfowAZcasstsWms
 dGLQ8+c0opOY69AuahQV11HFlS9TF/SD/nZuEnn6WQkxgxybC6guOMKanAMmDMPLTLZ+YFOd9ct
 3gcFbZntESZZk1LpwrNaJ8RKK2OZlogoMGts02NpIRO3JOEzufLCXcO3D7YogYdvXpQc1r/vlwe
 qziLsuobTaLLqKS5ViHBcNOp/2hMJ73klrOEgody0vnFjYR5IpWQH6Q/NYmspmUGx3phmKM+dEs
 ndZWvzgfMmulcQICMswXtmQ+OAK68BGbSRn5/lrKvXpjvDzLyI9gp//pFn+8Kyc4L5cT9IDfRhZ
 DYRR32DD37o3FE5ivLku24/qWe6E03vl2r0o3QeSqAsb+aLg4IXhOewPFZCAQUiAa14yBxpSqhi
 dvB5dUod6urWMFtm/0vCS+KyRi6S4U/SPXHHe37trAS7HEW8RC0yb4D4h+ONVeG0KHcps6En+tZ
 jKmgOkL/bAlymjRMMNDo995DfUjuYNqg00MgKTFiy+N/UCA26YkAQPuhoItHzuqK+Doz1tvfAO2
 gfjyQCNGKRCfSkg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
in the wkup_conf node and fixes up the USB nodes to use the newly
added nodes.

Then it adds USB support for AM62P SoC and AM62P5-SK board.

cheers,
-roger

---
Changes in v7:
- Rebased on v6.9-rc1 ti-next/ti-k3-dts-next
- Link to v6 https://lore.kernel.org/all/20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org/

To: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Tero Kristo <kristo@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>
Cc:  <b-liu@ti.com>
Cc:  <srk@ti.com>
Cc:  <r-gunasekaran@ti.com>
Cc:  <linux-arm-kernel@lists.infradead.org>
Cc:  <devicetree@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>

---
Roger Quadros (3):
      arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
      arm64: dts: ti: k3-am62p: add the USB sub-system
      arm64: dts: ti: k3-am62a: Disable USB LPM

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi    |  4 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 10 +++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  8 +++-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 +++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 52 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++++++++++
 7 files changed, 157 insertions(+), 4 deletions(-)
---
base-commit: 534ad093bb80f19c20b251a89f09ce1a0e3d4f2d
change-id: 20240325-for-v6-10-am62-usb-typec-dt-564a902aa674

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


