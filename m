Return-Path: <linux-kernel+bounces-97251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2687678F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECE5280F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FD1EF1E;
	Fri,  8 Mar 2024 15:46:35 +0000 (UTC)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDA2C869
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912794; cv=none; b=tz10oTeHS7HmwpL9vOQTtEamTOIoXsrEAS9Ue82+iluIdUHiKN0QI1flJlNsASnBG943u/hPX3klJBob1IKF5ZlnPIdR8Del5R/Q2fB+j2hutJvlG3rWwZbPSrxRiSiXnC3qbOCIuY8f9732h+smfKnUM3zs4LagLee0paGBHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912794; c=relaxed/simple;
	bh=3lrjrYKRC/VUEIt4asSA2wf7CvLTQLe9wT4xZRQgpdI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tLx1pjYUvuKlKZD6oYZEWp+3iVF/H9fYs+tFyQhXgIUj+n5ylwUVvg16cb+7OoqOxuMwXAbyE9u25sjGvHUfM9vw8P7ckvUNZluHoCqp0rFbrhum3MLwgJhXQMOp0EvqlcsEy+m4eDNC0FM0CCjLvg6wB78qHszCIUlhtpDMnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrrB83ylpzMpsfS;
	Fri,  8 Mar 2024 16:46:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrrB76PDrz3X;
	Fri,  8 Mar 2024 16:46:23 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2 0/3] rockchip: small DTS fixes for RK3399 Puma
Date: Fri, 08 Mar 2024 16:46:06 +0100
Message-Id: <20240308-puma-diode-pu-v2-0-309f83da110a@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4y62UC/3WMwQ6DIBBEf8XsuTSA0Jqe/I/Gg8Ba96AYlpoa4
 7+Xeu9t3mTm7cCYCBke1Q4JV2KKcwF9qcCP/fxCQaEwaKmNrGUjlvfUi0AxYIlCBT0Ya5XDW4D
 yWRIO9Dl9z67wSJxj2k79qn7tP9OqhBTa1Y2xd+eDl20eMboUy4g3zjjx1ccJuuM4vk+Qhk62A
 AAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Dragan Simic <dsimic@manjaro.org>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

There's a pull-up missing on a pin that is used as GPIO input for PCIe
which will make the diode/level-shifter not let voltage pass and thus
not allowing the state of the pin to change.

Also add the missing regulators for the PCIe PHY+connector though this
is purely cosmetic.

There's also a missing PU on the USB ID pin used as a GPIO input, so
let's add it for the same reasons as the one used for PCIe listed above.

Note there's a light dependency on
https://lore.kernel.org/linux-rockchip/43d84aa9-ce0f-406e-82ac-2a691264ee23@theobroma-systems.com/T/#ma0499cbc5e5c20f1a4c6b8452baa2d296abe2d0d
to prevent a git conflict for the maintainer(s).

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- added underscore in regulator names to match schematics,
- reworded commit log for PCIE_WAKE# pull-up as suggested off-list by
  Heiko,
- Link to v1: https://lore.kernel.org/r/20240308-puma-diode-pu-v1-0-2b38457bcdc0@theobroma-systems.com

---
Quentin Schulz (3):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma
      arm64: dts: rockchip: add regulators for PCIe on RK3399 Puma Haikou

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 ++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 33 +++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)
---
base-commit: 370e52abbf8306f09b0022995ad7ccdff3a834bb
change-id: 20240308-puma-diode-pu-1d2f4551be6d

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


