Return-Path: <linux-kernel+bounces-151096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDB98AA913
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E131F21AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F384AEDB;
	Fri, 19 Apr 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/IsYB29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D33F8E6;
	Fri, 19 Apr 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511370; cv=none; b=gJjqHdSFArKX+rw+AfjF31Z2X+neL+CsI2+OMKOrWOGVCgPWx37xuSxDWTf6jaWqH7HqXbgxoSg41dGRmPGT3o8y/cqSJBe/OrY14gfPSIiaie36VJwjFt35QxoZoqtL9MmzqkX6lX+NHWOZ8JILSXxIqCHuqWj2ynRO5awloVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511370; c=relaxed/simple;
	bh=fTx2/kEZ6vQTQyJpDG0BPTHimKj4QlyE9Zlf2maFXRA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gm04UVJRBRLW6AIbIpMDuOAagkA3r0K7flQo1aGLTqou5loefVuQWn7nLahU3CPCU4anw7X48/Knv0PrURFYhjB0/aOWOoD2At8cWoU5UhUwvDLCnDzloPd6OQ5sAuHP5eFU5BrVw8nlIXbcm7umIuhlDKPiA8xY7djgVXY07jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/IsYB29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF2DDC072AA;
	Fri, 19 Apr 2024 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713511370;
	bh=fTx2/kEZ6vQTQyJpDG0BPTHimKj4QlyE9Zlf2maFXRA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=r/IsYB296KlE2TEK22/NBYLocDw0yZgNXgRH7FUbA5Z1R/7vdcvmcQ2nAdpKi/5gJ
	 SrC/JtC3iNv/z4UqsrII1Nlo7Jpjks2vAKcfgUryJ1Xe5u0ESVdZtVYw2N3aQfPVCs
	 8yIpTarrkSgyOdd5d27WUMPm4Nkp8p/qgcbJRerfRuRX36CY7gpnoXDO0YAdAe2YEs
	 7eqoFx+CB7sPO0992gc2hTomcurecZNEFPhyPH/stPdh5E8ZrBdPuXyiI8QkNfYMdy
	 xpV3Gfq8Suo3yaTsp84dokKys4rVsLeGtU7nIfJ2/gT71zPfRkerCZksZUCcXxWpFi
	 VZnW9elV9z2GQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49FDC4345F;
	Fri, 19 Apr 2024 07:22:49 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH v2 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees
Date: Fri, 19 Apr 2024 10:22:47 +0300
Message-Id: <20240419-for-soc-asus-rt-ac3200-ac5300-v2-0-f95ff50c2a4d@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMcbImYC/4WNQQ6CMBBFr0K6dkxbCoIr72FYlGGQWUjNFImG9
 O5W4t7Vy/uL9zcVSZiiOhebElo5cpiz2EOhcPLzjYCH7Mpq67TTDYxBIAYEH58RZAGPpdU6oyo
 zqqGmES269tSr3HgIjfza+9cu+8RxCfLe71bzXX9l4/6UVwMajGmw1b2nmqqLF56xPWK4qy6l9
 AHn3XUsywAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713511367; l=1620;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=fTx2/kEZ6vQTQyJpDG0BPTHimKj4QlyE9Zlf2maFXRA=;
 b=C40LCsSt9mET0CXsjILLPq6IXlS0AybUsb2BeYFICsFynLdE0SO7mdqsOlMvr3tcFf/4cJsOY
 GgZ4YnNYIbTCPQ0bKX25EA+BoYK22mAnlotZ3VmQjyzf6Kb031zpCXW
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

This patch series documents the compatible strings for ASUS RT-AC3200 and
ASUS RT-AC5300, and adds the device trees for them.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
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
Arınç ÜNAL (4):
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300

 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
 arch/arm/boot/dts/broadcom/Makefile                |   2 +
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 150 ++++++++++++++++++++
 .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 156 +++++++++++++++++++++
 4 files changed, 310 insertions(+)
---
base-commit: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
change-id: 20240408-for-soc-asus-rt-ac3200-ac5300-5d6efc2c497b

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



