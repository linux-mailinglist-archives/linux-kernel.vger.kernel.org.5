Return-Path: <linux-kernel+bounces-144125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F08A4220
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86288281E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45AD446AF;
	Sun, 14 Apr 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7UrGGbM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8E36B0D;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095180; cv=none; b=r44wp6mcrN+Keh9PCwagHCDJ0R8wWvq62hVICAcPcGhD53Oz2we5/POWIWn6HrHGouceB2qzaTl7hcqDzYwP/JGiTVNfUf5iQntgsliJZG4KohQua9qrS/wAl1ajAcIkMQADUU/1YCbNKCeCgrCy/5eV4rat5RmaYUBV3w0ckhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095180; c=relaxed/simple;
	bh=bs/HBuzrWPto5XJNDcrs4aU2SIKT5lLppGTW+5D2DGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkXCukMIs6/5hc8Jx5QAcYHloLRngV7dtYs7Uu9sXMtsYUCQWp2tzey2HMCOwhpeJNNO4J+qx5gMrJbx2E+uC7Asu6vfxPYGXcW35ZHl3aF3Srv951pD01fd54vbaoBy0zPvfVWDb0bDldOJX8DB9tPaMUB4u29UPqvWmtZk0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7UrGGbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7526EC32781;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713095180;
	bh=bs/HBuzrWPto5XJNDcrs4aU2SIKT5lLppGTW+5D2DGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i7UrGGbMaJmtTjTJqW/rXnLGe0O8M2KxWgUqp4a1PE8CiCn/kgZdYpCzSIqAboPTO
	 qb/4Gjm0qpy/G3qkzk2vM35vfk9+9im6qgVWuuNLzB4HNR04we11QaOG8qUU017De1
	 lSp7pgzQD+uFCSlrM+C32gXMwuaWfqjo7VlfKvbwn+rotaq+kGJlM5xyQuNHbhUj1i
	 4W3YRfwXzsjeMMuoJ4TYt27Wjjn1j99Yeg4ZTPkZbHJ81hCmSK4Vf/a36a8UH0UQ6A
	 sCTmHYrZs3IXqt96dou1ELsGqZsCEPM6qha6KP8Kzz7NSDnjZIcJU3hGIT/C5YGopC
	 6jdBTWPK0HPog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEEDC04FF9;
	Sun, 14 Apr 2024 11:46:20 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 14:46:00 +0300
Subject: [PATCH 1/4] dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-1-118c90bae6e5@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3200-ac5300-v1-0-118c90bae6e5@arinc9.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713095170; l=786;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=J/PDI/R4cOnHbY6bRpKkCzRdD8CWg4daS8qpi5rDqrw=;
 b=l8rafI7epTQ7ehjEwBD9pTr0LJw/Xp+XYxzNkgVMlyAXyl8CV2wOdRRWiVO1poThyExoqabig
 sp6JJOl4RHjBGT7QGxiAYu0I40n4E/Pmmn+FIEPurmPGkzkBO+XUtqA
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add ASUS RT-AC3200 under BCM4709 based boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 4cc4e6754681..215bef740aca 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -53,6 +53,7 @@ properties:
       - description: BCM4709 based boards
         items:
           - enum:
+              - asus,rt-ac3200
               - asus,rt-ac87u
               - buffalo,wxr-1900dhp
               - linksys,ea9200

-- 
2.40.1



