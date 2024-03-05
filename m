Return-Path: <linux-kernel+bounces-92442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C503872038
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA061C22B17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD88662E;
	Tue,  5 Mar 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVgF4Zbw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47285953;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645536; cv=none; b=qAuLKqWcnBFQD/pzdiPxX8bQplQdBGwjkGokmSgY5o6Cp1DWzNPnYNEI39yLNIeelh6MjeHDz0DIHv89yI9MccZnqEsqi+psfLI4DryNmeK0z1UIx/bNw6zbRczfamBDKLOrmV77WYrFunMJJjY1xW/8BzIwYT8bW6gSfH+QW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645536; c=relaxed/simple;
	bh=FihEUwCX50+sOpSeSlKTyAI5nKu3cdR1twC0ge0m/T4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sLRy/Yyi8At6qEPhh466eViQxdCXatxMgk53Dbt1MQamboRmFpj9oPwVgwJdfpMldHG99sshGU+9LXRT3yEn+dn++az8DAEK/IgEVTcDNvDVOn6gv2f5Cn1+bb4ObiAbuq2H+2Y/uAm2RtXqsx1ETT1atTp/zzwDuiIAiYFCfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVgF4Zbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E657C433F1;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709645535;
	bh=FihEUwCX50+sOpSeSlKTyAI5nKu3cdR1twC0ge0m/T4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RVgF4Zbw/9zjAw+nC5J2lWdYwfmD/InF3Dil3B3FQYMWyWLlgizzJke+63D9uLqvY
	 tmECtsqVJa7H9Vt/xVG2Iw/AkppuDnrba80pe7i3zoHX56OkK9AHOz8Stgn9gG+SSw
	 +5c/1jNhJig3LHDnDNubicBeB/gNMnu7Q1OgcD2DiJMWTb7QwAXQin9Lufhk2HmExh
	 1uiSBewp1NMzYil19s6Mji+iI5E9K+49uo55M1943qGqT9iRWB5anC8wICaRSOOFE4
	 7+CbJ11MnTJ1gegySw2Bezg/+Uy9lM5+4carVmRx2Z1aDjepDnHiLy8uepeR+IPQEo
	 i0266NFg2od/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7CC54798;
	Tue,  5 Mar 2024 13:32:15 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v5 0/5] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Date: Tue, 05 Mar 2024 21:32:11 +0800
Message-Id: <20240305-inno-phy-v5-0-dc1cb130ea08@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANse52UC/23MQQ6CMBCF4auQrq2ZzhQKrryHcUFLK41KCSDRG
 O5udWMNLt9kvv/JRjt4O7Jd9mSDnf3oQxdHvsmYaevuZLlv4mYIKAFFwX3XBd63D15jUyp0hVZ
 Ss/jeD9b5+yd1OMbd+nEKw+NTnsX7+icyCw5c1LoS6CAncvtwmy4hnLcmXNk7M2NKVUIxUtJO2
 VJpsJVdU0ooQkIp0rIi07iyINJyTeWXEuQJlZHWQAjSVMYJ80uXZXkBnvnpFlMBAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, 
 Shawn Guo <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, 
 David Yang <mmyangfl@gmail.com>, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709645533; l=2619;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=FihEUwCX50+sOpSeSlKTyAI5nKu3cdR1twC0ge0m/T4=;
 b=3ymo1/B20cCGRvoJeNsGWfYtGDcaFn42LOyz14PG9giPuRZQvqjiTXG++HxRuNK5BNmHVJ1zK
 1ci3BoVGn51AGTtNGey7HifuI4fQ3PfHW3J4obCzKlvy75IKWtm4hZW
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This should be considered a hack. The proper solution would be
extracting write_reg logic to a separate regmap driver. Leaving only
"write BIT(2) to address 0x6" to the PHY driver.

A proper fix should be implemented later.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v5:
- commit msg: bulk->array. (Philipp)
- use devm_reset_control_array_exclusive() instead. (Philipp)
- Link to v4: https://lore.kernel.org/r/20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com

Changes in v4:
- remove reference to histb-clock.h
- remove fallback compatible as it has no use.
- remove phy_type (belongs to host controller)
- fix bot error (Rob Herring)
- split YAML convertion into two commits, the other add mv100 compatible (Krzysztof Kozlowski)
- Link to v3: https://lore.kernel.org/r/20240220-inno-phy-v3-0-893cdf8633b4@outlook.com

Changes in v3:
- address a few binding issue mistakenly missing in v2 (Krzysztof Kozlowski)
  - add msg about hi3798mv100 being added to compatible list
  - remove minItems for compatible
  - remove | for reg:
- fix existing dts (hi3798cv200.dtsi) due to binding change.
- Link to v2: https://lore.kernel.org/r/20240217-inno-phy-v2-0-3bf7e87b0e9e@outlook.com

Changes in v2:
- rewrite commit msg to show why hisilicon,hi3798mv100-usb2-phy is added during YAML convertion.
- split required: to multiple line
- add allOf to wrap if:
- remove perictrl wrapper and the second phy in the example
- tested the binding both for mv200 and cv200 dts. fix some silly errors.
- remove Pengcheng Li from To:
Above all are suggested by Krzysztof
- use reset_control_array_* APIs to ensure all resets are controlled
- Link to v1: https://lore.kernel.org/r/20240216-inno-phy-v1-0-1ab912f0533f@outlook.com

---
Yang Xiwen (5):
      phy: hisilicon: hisi-inno-phy: enable clocks for every ports
      dt-bindings: phy: hisi-inno-usb2: convert to YAML
      dt-bindings: phy: hisilicon,inno-usb2-phy: add support for Hi3798MV100 INNO PHY
      dt-bindings: phy: hisi-inno-usb2: add compatible of hisilicon,hi3798mv200-usb2-phy
      phy: hisilicon: hisi-inno-phy: add support for Hi3798MV200 INNO PHY

 .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 119 +++++++++++++++++++++
 .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt |  71 ------------
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c         |  70 +++++++-----
 3 files changed, 162 insertions(+), 98 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-inno-phy-a2d872f6b74b

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


