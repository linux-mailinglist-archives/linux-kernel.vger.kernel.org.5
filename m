Return-Path: <linux-kernel+bounces-44857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2235842833
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1068E1C25416
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31382D8A;
	Tue, 30 Jan 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkoEr/yW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DC5C8B;
	Tue, 30 Jan 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629252; cv=none; b=NYmee026owSg+ENL5pv/9YbRo7rVr8MvV0IlCFKJEFSvsEOs3EJgPsIfZVwDaD7KIaid4zmyT2jIddj2JXbaYJwuAL4hiH5TZG50LmFAHTPj5LUWRZue59hus7chu9PDaDSo0ekp+K//XE8jnhpQ0Cf6UOvLkSohzPZXd4Ji3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629252; c=relaxed/simple;
	bh=5JVBol+N3NA6sA7/pQ17TMWbmAv0reGA2jeSFwK1yIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=blero38O9K9Xwsvt1F70iAd7EoSoL5UgzLfVIfc1vuGYIunvSLlUMOkqlRKWuWaha4+FpIP99/QZU8chstz6wqgWef18G+ax2P1wvCj029NNOzUK3AMc/6HdXkzGNFnBO0W4VUZn1ml2ZrfEcwTQCZ1CBZImKPH9SbQe0E2I0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkoEr/yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1359AC433C7;
	Tue, 30 Jan 2024 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629252;
	bh=5JVBol+N3NA6sA7/pQ17TMWbmAv0reGA2jeSFwK1yIY=;
	h=From:To:Cc:Subject:Date:From;
	b=tkoEr/yWwpBi4HsrLgjmgn8efhg6XLzfVeOj+e+i+5SvXEZm6Cw/dVznnybEULP/r
	 Eyd0UJpwioeU9I6HRd2o+s1GNeqpWqtWgTQDKyLI983X+J2TOo9pohdqM+uloaNxbX
	 csmm2ouvpnn4EVy+qgrHbEWrmOHui3XL5S0Y0PshGq4daHobl7HtF0GLkB6SkocuDX
	 N/xK2dv8YEq+vXz829xIdQIlzmt5Nn0v1LZP6AhTEhVB5GY8Bzr/gruN18brDO1eFs
	 Ts/M0UonH0KVAuNayqUcZ+7pbcAnrhs7CjNzseMYELIG4dmd4oUFlZ8CVPOddfxz7x
	 wFnAt87ZTwcVg==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com,
	lee@kernel.org
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Tue, 30 Jan 2024 17:40:32 +0200
Message-Id: <20240130154035.6901-1-rogerq@kernel.org>
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


