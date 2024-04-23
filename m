Return-Path: <linux-kernel+bounces-154810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A348AE156
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A30A1F229BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179EC60267;
	Tue, 23 Apr 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpY1pR0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2858ABF;
	Tue, 23 Apr 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865860; cv=none; b=VRCRv0/FK9oDNuAwggxkyfny+0+Yl5RegoyB/QBhQX3ybHF3O3Tty/Lh1j6Hh1mSImiGdnq/lu4aalFaPSDwVOP4pE6vrhwfNB/Soo5yz01zOmt/Wapl3jwGXCAccbSPSnHvzHCr6cF/4dHbnK69Z5rfq2EmlcAaXbQgDhT1Om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865860; c=relaxed/simple;
	bh=FQLt1hmXPP3cDkvy4rTvlY0mMo/XhlZ354mwI3by6iM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hjT4Kf1LGSbo2a55xcttfHdyMZK7w6KuvQ+myKycJbLZp5iNGeTrJdfziIPLYgD6KUh3b1bv6EanJ8KgplABXpVquRJboW0oXiQX6Gqc8xKU5DBfHaq5g5BqNitOdrDCUS+gJqMxMt6oiBs7Rp4yyUGNj8ce/ICZefYog4MZnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpY1pR0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D96E2C116B1;
	Tue, 23 Apr 2024 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865859;
	bh=FQLt1hmXPP3cDkvy4rTvlY0mMo/XhlZ354mwI3by6iM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LpY1pR0KqRtOCUIUK07oiHmdmM3lbG4ve3myhPArvgGHZZNesmSNJ9IaxfpAKubYb
	 pZrbkLj/4cJUTYBkd+XyhQy5GeSne+O+Fz0SnqCDHk0K/hrbjtwoeoZXkAUzypbc0Q
	 znea+45G2wpg/yp6oOs7/4/WwccHMKaiWt/HtA0ajQ4V7AdLl0wWr133+7aulsFRXu
	 QrQh7PDJqUuhgTMyXZlaME/C/wXl3QfTP4PCkLOruVDJwTInSSfBahrkgy8DZNIBiI
	 M7EllTCAqk5K0GHVWbCt0mfgJwKlEYLgSZfiOV05a/OAU5ydBMYgfvky7M4DatNPvz
	 Wc1WMfQNWHgiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE177C4345F;
	Tue, 23 Apr 2024 09:50:59 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH v3 0/5] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees
Date: Tue, 23 Apr 2024 12:50:44 +0300
Message-Id: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHSEJ2YC/4XNsQ7CIBDG8VcxzJ45KNTi5HsYB3oFy2AxUImm6
 btLGwedOn353/C7iSUbvU3stJtYtNknH4YS1X7HqDfDzYLvSjOBQqLEBlyIkAKBSc8EcQRDlUA
 so6oyqqutI0FSH1tWjEe0zr9W/3It3fs0hvhe32W+XL8ylxty5oDAeUMaW2Nrq84m+oH0gcKdL
 XQWv5ze4kThnFbOKSRhZPfHzfP8AXFbRjwaAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713865858; l=2295;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=FQLt1hmXPP3cDkvy4rTvlY0mMo/XhlZ354mwI3by6iM=;
 b=qMdw1MUc3Tww2iXeIs464rNvG05CzXQzzZhWOaRk5Z6RaRjyuPZMdIWfOSsX9zQnfrtgh6GSp
 Pc6+aAB53vfA14d6V+9kO2Fps6t46d9OGKpOk3YewVhmrbw3EybzSTX
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

This patch series documents the compatible strings for ASUS RT-AC3200 and
ASUS RT-AC5300, and adds the device trees for them. The last patch makes
the device tree files for ASUS RT-AC3100 and ASUS RT-AC88U conform to the
Devicetree Sources (DTS) Coding Style.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v3:
- Add a new patch to the end.
- Patch 3
  - Reorder the nodes and properties to conform to the Devicetree Sources
    (DTS) Coding Style.
- Patch 4
  - Same as above.
- Link to v2: https://lore.kernel.org/r/20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com

Changes in v2:
- Patch 3
  - Remove the chosen node as earlycon is not for mainline use, and the
    stdout-path property which should be used instead of bootargs =
    "console=" is already described in bcm4708.dtsi with the same value.
  - Remove MAC address assignment to switch ports. To explain why shortly,
    on the switch with CPU port architecture, the LLC Entity associated
    with each port can be accessed without a distinct MAC address assigned
    to each port. Therefore, it is unnecessary.
- Patch 4
  - Same as above.
- Link to v1: https://lore.kernel.org/r/20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com

---
Arınç ÜNAL (5):
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
      ARM: dts: BCM5301X: Conform to DTS Coding Style on ASUS RT-AC3100 & AC88U

 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
 arch/arm/boot/dts/broadcom/Makefile                |   2 +
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 ++++++++++++++++++++
 .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi |  92 ++++++------
 .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 156 +++++++++++++++++++++
 .../boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts   |  69 +++++----
 6 files changed, 390 insertions(+), 81 deletions(-)
---
base-commit: dd5c56cd065e6f7ac5f87b939e8a3c499a62d463
change-id: 20240408-for-soc-asus-rt-ac3200-ac5300-5d6efc2c497b

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



