Return-Path: <linux-kernel+bounces-121887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2535388EEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EEAB2411B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175D15251B;
	Wed, 27 Mar 2024 19:11:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466D1514F5;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566710; cv=none; b=odAWV/dYGunwRq1fOgsi3u255pGoHCtjCIgID12WBS0BDvX/+kQP44pbbpdsgEToj2X/gLqKupqJpK9GxbuHoWWd5nivr8pNnQCnurx+8kRepBF0Ngrve9jeKwVQjw8tp1jEpEeTQMzbbR2Cf4WvYFxS6/gGpz0a1rnO35fCFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566710; c=relaxed/simple;
	bh=4nUPryLtDGoo4If+YhVGo/DJxC63+p+eZWj9NhHwPaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V61JprHxEvL607aPd/aMRkqmmBY8gv52KE4zCqWDR+K2kKGSjhXxtzT9lDd5bb8VqyhuBTir+5DQquXxir0+rRXoxA6mMpStAZNs+JmGB9UQOQgmGNzXunAXRqubWQIfKzoXje+g4Iy5hx1zN8KAY7/Y3oh86ex7dRYpDntO2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9DC43394;
	Wed, 27 Mar 2024 19:11:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A8BC110608D9; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/7] Convert MIPI HSI DT bindings to YAML
Date: Wed, 27 Mar 2024 20:11:31 +0100
Message-Id: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNvBGYC/3XMQQ6CMBCF4auQWTumFMHqynsYFkM70kmwNS0hG
 sLdrexd/i953wqZk3CGa7VC4kWyxFBCHyqwnsLIKK40aKVPqtEt+izoZhwkOAkjUuu6TnPjOlV
 DOb0SP+S9g/e+tJc8x/TZ/aX+rX+ppUaFxrDhy9k2RHyzcZpoiImONj6h37btC1U4FzOwAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=4nUPryLtDGoo4If+YhVGo/DJxC63+p+eZWj9NhHwPaQ=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9x/b+YytQSsGm+JuuxhwO8DgpUfrQ5+hgsY
 YLrQD0Jmz6JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcQAKCRDY7tfzyDv6
 mvwHD/0WN4FXiK/xWrK6kBd9G7xlLEBLmjOKAehn/7+CsJcEUjMoTbRBw0FdkpSIuc2BaztkO6K
 IAULcZtV6tKJFDHqkLVDARnvsKAW3517tbN9CCgjtCMZwZKocYTk1uFAyX7H9ZOjktoKRKJ0nPY
 1TGy3iqYTHHE8c2la05Fec9FOiepQQ8tQ/8QfzD3aBYBh9F+37kafeNxnDedY5rMTyZUtO1Nh1H
 5zf4EsIysQoSh0dmo39Wx4EdYsIrA5p80L8pCCKHBQZmmlxBrkhwJ7Ok4Ihqi3rD3MBVId51dil
 Amd6DekW0TFXuqr4dqBhZMarAjgMMFTrate6dmohF6cRL1PG+PTWVIE47bcJ0oBAR0id/ktExpR
 iQK2MHAtqHzVQbCbBAHnJ5a/V9R5Yxx0lIUAa9iRSUaIs/GoWkw49ChO+pGWjR2oLp09Bz1c19L
 j8dqqgpKbSqKwt4wSvHqN+zzL3sbAidSAlK9txw/qF5ZhqM+XN17Lvm0uGaswWuC8eqizGXtbyY
 LqVTb2x5cBkbjZrepRhXCVI8QkPzmK7bD7OxBrv5zeIczeRM52Vx7CziGkhuQ4GakNQaC7SsHeV
 8NOL/O9SuF4oJXvCM3jtdoxLa9x+bRdfPB2m0C9uoEYmg8DLuwPVBlYjnAmM1otl+JQuoTvqJ43
 Lpjjyu0RzOMKh2g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Hi,

This converts all MIPI HSI subystem DT bindings to YAML.
I ran the following tests:

1. Check binding files
   make -j$(nproc) dt_binding_check DT_SCHEMA_FILES=/hsi/
2. Check OMAP3 and nokia-modem DT
   make -j$(nproc) CHECK_DTBS=y ti/omap/omap3-n900.dtb ti/omap/omap3-n950.dtb ti/omap/omap3-n9.dtb
3. Check OMAP4 DT (OMAP4 HSI is not used upstream, so one is enough)
   make -j$(nproc) CHECK_DTBS=y ti/omap/omap4-droid4-xt894.dtb

FWIW I noticed a lots of warnings for OMAP3 & OMAP4, but
none related to HSI/SSI.

Greetings,

-- Sebastian

---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com
- fixed, that "hsi-client" is not a generic node name
- hsi-client.yaml needs to use oneOf instead of anyOf for the hsi-mode requirement
- change nokia-modem.yaml to nokia,modem.yaml
- add hsi-channel-ids constraints to nokia modem binding; I had to also add
  $ref: /schemas/types.yaml#/definitions/uint32-array again, because otherwise
  the tooling complained about the example DT having not enough IDs for
  [[0], [1], [2], [3]]. It does properly inherit the hsi-client.yaml, though.
  If I drop the constraints from the modem binding and change the generic binding
  to require 5 IDs, the tooling does complain. So I think this is a bug in the DT
  checking tool. For now readding the ref again seems to be a good enough workaround.
- changed node name to "modem" for the nokia modem
- renamed ti,ssi-cawake-gpio to ti,ssi-cawake-gpios
- changed ssi-port@ & hsi-port@ to just port@
- dropped blank line in omap-ssi binding
- moved additionalProperties before the examples in omap-ssi binding
- fixed indentation for the omaps-ssi example in the binding
- added patches fixing up OMAP3 & OMAP4 DT files according to the latest changes

---
Sebastian Reichel (7):
      dt-bindings: hsi: hsi-client: convert to YAML
      dt-bindings: hsi: nokia-modem: convert to YAML
      dt-bindings: hsi: omap-ssi: convert to YAML
      ARM: dts: omap4: fix hsi-port node name
      ARM: dts: omap3: fix ssi-port node name
      ARM: dts: omap3: fix ti,ssi-cawake-gpio property name
      ARM: dts: omap3: use generic node name for hsi clients

 .../devicetree/bindings/hsi/client-devices.txt     |  44 -----
 .../devicetree/bindings/hsi/hsi-client.yaml        |  81 ++++++++++
 .../devicetree/bindings/hsi/nokia,modem.yaml       | 106 ++++++++++++
 .../devicetree/bindings/hsi/nokia-modem.txt        |  59 -------
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 ------------
 .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 177 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap3-n900.dts           |   4 +-
 arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi       |   4 +-
 arch/arm/boot/dts/ti/omap/omap3.dtsi               |   4 +-
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi            |   4 +-
 10 files changed, 372 insertions(+), 213 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-hsi-dt-binding-a5d662e3d601

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


