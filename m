Return-Path: <linux-kernel+bounces-48064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE758456CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B45428D209
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A3915F31D;
	Thu,  1 Feb 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN1OuUHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345C6160863;
	Thu,  1 Feb 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789020; cv=none; b=cm8yN5RW31N1QGzOqR4GUTJCPFNB1iUSIx6qAiNmDrpBcDIPV3b1hY/wg2JXGiRIceW8fwKZBPOA5AbpJeScTSs9P3PEOHxigWcYC3+WnI8Hpc1PI6xjcsbC/f/f743YegmucuTsNOBV29xd9cDo7SL4OQpM9hu8j68FXnYbVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789020; c=relaxed/simple;
	bh=qE//04Xk8CrxNHy3MjWgpVPBFmewfZRMSVNUv6yX4qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spn2gNZG8wgfFp86joRF1lg/2NOlh5T7ailQJkKMpcyQyi0N5GpakdxW0SaNMWgXqLHaP6qHtiDPPCJ5Rwcl5KMbKA21ctej0WjHWmEAw+qwUyxootE8TrA3p7h6PQ+vpjFSTlKo2iVgIXcM3ec3jtJspYbEm5qlpEwO+fs09h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN1OuUHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BFDC433F1;
	Thu,  1 Feb 2024 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789019;
	bh=qE//04Xk8CrxNHy3MjWgpVPBFmewfZRMSVNUv6yX4qs=;
	h=From:To:Cc:Subject:Date:From;
	b=bN1OuUHwgsz2QUUCjtfLFtXJWjG4+aL4x01VSkH7AjHPBHx0PmtNw5ymlkm0b3feX
	 TwzgHZR0eyRrpHH9/nBB4knh0v72OAZvv78R6Z+OJ3AzuSNf7Chb3k8/3FnuTirqEb
	 RvBGmVFmh90V7QCAfiwfuVNZlm9OYJWskUAcAinyAF2VE6Z7vSg9U1af791avLr1IY
	 me+KyN7Ga0lAmhSr4hl/qKiT9QnVn3rG6+sNK2AmYgDsDbqJtGqik93KCIJlWGwXMT
	 019IFUMZhkjPOhfuO/vlQsG6KCqMmcR/+W8G03M9w6GcWgPHQJDIEpsAmvqQP/fPxk
	 GH33xY431xkxw==
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
Subject: [PATCH v3 0/5] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Thu,  1 Feb 2024 14:03:27 +0200
Message-Id: <20240201120332.4811-1-rogerq@kernel.org>
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

In v3, 2 new patches were added to add the missing PHY2 register
space to the USB controller wrapper node.

Changelog in each patch.

cheers,
-roger

Roger Quadros (5):
  dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
  arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
  arm64: dts: ti: k3-am62p: add the USB sub-system
  dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
  arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper node

 .../devicetree/bindings/mfd/syscon.yaml       |  1 +
 .../devicetree/bindings/usb/ti,am62-usb.yaml  |  7 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 10 +--
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    | 10 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 10 +--
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 48 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi   | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 67 +++++++++++++++++++
 9 files changed, 163 insertions(+), 10 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


