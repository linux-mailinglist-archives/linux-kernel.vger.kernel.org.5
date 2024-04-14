Return-Path: <linux-kernel+bounces-144124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DE8A421F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0331C2103B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A0446AC;
	Sun, 14 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgLcLWWB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEB31A8F;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095180; cv=none; b=Cb+55cy4+pdRmLhvd8WNaVKi7ElmgPKNQIMvxmwU8bjIHJsDBExZo5gv4EGlXGBK6j4JkurhJvuMxkYsNQ5ReRZUy0pM9E4P62/WDnP4fkFK+kwAV6TsU5NorLsau0SwSLETLLCIKP08bp6y6bt3WK4+KxE7ArzDfRyKcC0SLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095180; c=relaxed/simple;
	bh=33wdznBHcrNrNHH/FVF4hi5/RJGXD7RBWwqYcSqj5MY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fbmX3jdL7dnAV9vkmCtheCqseBo+6MGPPl+Urew5wf7ZhcgufbvYhXePS2pPqhfC8nWRxjgnnCa/aSNaiD4kZc7332cqKMtgFo/qJZiXYtbwfiC8ipqvoJhO6u7m5o/s7CuxKjSYq/UNYjPU8kDp6VQ/uVYKNSC+wnHqachoH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgLcLWWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61BD4C072AA;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713095180;
	bh=33wdznBHcrNrNHH/FVF4hi5/RJGXD7RBWwqYcSqj5MY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FgLcLWWBZ1CRpXx5aji/rmvcv9VzDLQAZUFr5J8VRKbJm4IoU9UJYMnjtUNEhEtQQ
	 f+/XAfxH+15S2Hp0ZTadXWPKTbttrLe3tyABTcuX44Dbn7dKNrnJVrN92Hkqbrbhg0
	 brgm4LDK43znlMrEL0coYdu35VL5afhDeHuHv+AWXSdZOmYE236bBVaQTpIZ4GheZC
	 aeBfwTa0JoD4CIzVU649yDqeVKriKvr8kS8dgPn41sEq8JAFcFTQQnZfls7QgJyUZp
	 QerX/kRVvq4l1UofwEHt0TgI88X8bepfX8DszxVddmOjdOxk2ZJjjA6opQyhuEISwk
	 QzO4/l0aOohpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22FC4345F;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/4] Document ASUS RT-AC3200 and ASUS RT-AC5300 and add
 device trees
Date: Sun, 14 Apr 2024 14:45:59 +0300
Message-Id: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPfBG2YC/x3MTQrCQAxA4auUrA3E6dS/q4iLaZrRbDqSVBFK7
 27o6vFt3goupuJw61Yw+aprmwPHQwf8KvNTUKcwJEqZMl2wNkNvjMU/jrZg4T4RRYY+MkwnqZw
 4X88jxONtUvW3/++PbfsD8bV2/m8AAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713095170; l=956;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=33wdznBHcrNrNHH/FVF4hi5/RJGXD7RBWwqYcSqj5MY=;
 b=sIZCGgog3BeSnH4dfJhskcNWfY+9MZ+GaltlVyK4WmiTPZgTD5KZzwskCoUa3Axu/fzj0yKoh
 bxQtN2AQbQeCd/1QX8/jRVtc0VExaoehdw6zmaPjZC4Ou2pKWpfVjaA
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

This patch series documents the compatible strings for ASUS RT-AC3200 and
ASUS RT-AC5300, and adds the device trees for them.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (4):
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
      dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC3200
      ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300

 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +
 arch/arm/boot/dts/broadcom/Makefile                |   2 +
 .../boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts   | 164 ++++++++++++++++++++
 .../boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts  | 170 +++++++++++++++++++++
 4 files changed, 338 insertions(+)
---
base-commit: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
change-id: 20240408-for-soc-asus-rt-ac3200-ac5300-5d6efc2c497b

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



