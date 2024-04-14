Return-Path: <linux-kernel+bounces-144294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA98A4443
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2BF1C21DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5403136647;
	Sun, 14 Apr 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYnFnNw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA11353F8;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114092; cv=none; b=tBOigIMeOk5zLI3mQGO3uS65DsP1YAao+IgzaeLMI44Ymr5JAUALkMBUJj0ixU7RF5Oh4P9rhPAb4Qn6/JxUtyHmJsh+VUNk5DA5w1gJ4ktnaguHBGOMwW0qhtVumgcgg9FUvRW+v8Y9bN52QKqRm/4bz7J6okF6Jz7UR6+tMII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114092; c=relaxed/simple;
	bh=ted2EB6/3rRPIS/bCEaZLR50/zdj+pHcSxe+25yLhvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rUvrqf898OR7kvJl6tfVWmD9m7ILXxVr1CsVy6MVDSE2IZMq22vPXEk7BEZgOke8yuMsAgvL70UCLUzyXDiIcMJ8gA8Y887vlJQ6vSB83AUAcqoaakwTrZLaWEHqfTlwJiko5FWrat/ElNpDT9BTR6NckOa+p7XjTw3aGOp9EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYnFnNw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F01CC072AA;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114091;
	bh=ted2EB6/3rRPIS/bCEaZLR50/zdj+pHcSxe+25yLhvg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rYnFnNw44M5VBOH4i3wTHmFGjpERNyFyCmOIUFwyDmxq6DgnpNK+N5oJBFt2l7zzF
	 4YaRDuaIMqjvx8u4cGOfJ7V2MSt/JnPIcXWJFKBb9A82z2VVmf4zee9TjcCN/u0WYY
	 XcORPwp0Ul0bq2oiXjLuRzlGbLVgXRWpU4wIddHaI1xIRs+5HQ8O+O5BC5z3bYA46e
	 k2/mPEfYnpvBuj+xY9L9fV2j9ae5HK+aPHaVNr4b8sPTUsoTwa0nyl2dOCKuBt/LpQ
	 tvhjj6lgyBYTlRlXm35K5TE+zWDw+JRGrC1gRiz9Tl41moA71eR4EY84p3v0lCFP/8
	 m2cwemWj6dU5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8877EC4345F;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/4] ASUS RT-AC3100 and ASUS RT-AC88U device tree
 improvements
Date: Sun, 14 Apr 2024 20:01:20 +0300
Message-Id: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOALHGYC/x3NMQ6DMAxA0asgz7XkkLRDr1J1CK6hHkiQTRES4
 u6NGN/y/wEupuLw7A4w2dS1loZw64C/uUyC+mmGnvpEKUQcq6FXxuw/R1sxcwxEqPNidZNZyur
 INOSUHvc4cIRWWkxG3a/L632efx6rFFR1AAAA
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713114081; l=974;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=ted2EB6/3rRPIS/bCEaZLR50/zdj+pHcSxe+25yLhvg=;
 b=xmIWfBZS6gMIuWyH9ZufjaesZaWHkmSMkBS50irEp196eawGCZbnHq6O2mvwKIJCHQgjkD1O/
 jp4QXiYPBQlCBldgqjh4o1DhT/+Hlu90jOHeY2SvkzpQ2ACxmfiyEKJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

This patch series introduces small improvements to the device trees of ASUS
RT-AC3100 and ASUS RT-AC88U.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (4):
      ARM: dts: BCM5301X: use color and function on ASUS RT-AC3100 and RT-AC88U
      ARM: dts: BCM5301X: provide address for SoC MACs on ASUS RT-AC3100 & AC88U
      ARM: dts: BCM5301X: remove duplicate compatible on ASUS RT-AC3100 & AC88U
      ARM: dts: BCM5301X: remove earlycon on ASUS RT-AC3100 and ASUS RT-AC88U

 .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts  | 13 ++++-
 .../boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 59 ++++++++++++----------
 .../boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts   |  8 ++-
 3 files changed, 51 insertions(+), 29 deletions(-)
---
base-commit: 011d79ef1cfad701c2d8e7e80d8c77523af9c771
change-id: 20240413-for-soc-asus-rt-ac3100-improvements-c0ba44653bc3

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



