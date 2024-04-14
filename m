Return-Path: <linux-kernel+bounces-144295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5F8A4446
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC67B22203
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5513664B;
	Sun, 14 Apr 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmXeuRo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCE135406;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114092; cv=none; b=sgGRTZ0R+oDKDICQC91Lgq3t5BHzYGLDpnJgQCLy9pdK7/6siE0zfcwn61cs9AlCeMasjJLbgEt2Oq80GbImGJQ6Op5fPpjaGpcu/MN+kovpYiZsxdbrM1QKCzsI20WihtjHBtbzlgZ6dwxyzEdodfK6t4e2/ADxkxpYOVz3Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114092; c=relaxed/simple;
	bh=UDW1oNJk9sNSh+j3ebklBPggtO7h3BowNjPx6lX3k+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVQPXtz/HuS6SHa4pGJ5a0PsnH5VZF0k3LO8EmiH2NGtg79U0AgpnFflB9w1t9QcV4LoA/Mr1wZBvTARXvb3tPd6lKsNw/kOK4CkEA1mZO+f8ZcilyZiPUqiiIokqxC+If/rnfVCqK4u+YQLVPjd2OnX985FagNfyuATU4XNvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmXeuRo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3AE1C32786;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114091;
	bh=UDW1oNJk9sNSh+j3ebklBPggtO7h3BowNjPx6lX3k+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tmXeuRo2x1owbyvPCJxywUUlWTgs2DRrAb5X8Jf4No4P1bIsNJgHYo1rYa4Y99GAX
	 PssphRjHa3cxQ+iZVlvx3Sxl3u+wxRdxt9vZ/RFTfjErn6sHhmBmx/ZwDazrGwLVcN
	 oF45crWC6dzB+IfgeOwrssPIQht8rdzO5UGuYu3uVI6geiluPLUnkV0tAXc/psn5iA
	 BCGRVU/GqMkPF3LqN56O81h4Nrn7rZYVV7hrtsMuL0l541PyCZv6v9afTrDoMrJMpT
	 UmscnINikPu01h8dpFExHeRXncbcqLZu19IcLrHzMQ6scqikjvK9FvFXUTedgN494F
	 TOObpk09ucSog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E3AC04FFE;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 20:01:24 +0300
Subject: [PATCH 4/4] ARM: dts: BCM5301X: remove earlycon on ASUS RT-AC3100
 and ASUS RT-AC88U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3100-improvements-v1-4-0e40caf1a70a@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713114081; l=782;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=bi+4TJMCgd5mWbrKWAfCvlVW6KiexBBfcJK3dSc81ko=;
 b=GTKiQLdAfsoaTgGBusvq1BOGZYVRgaLQz3N7CUuH4ORpJJK5s1CxVllSQTlQP2ITzw95wiZwT
 ZdXZ+FP8nnWD6wEUK4XPgCU+AWnIJ2h5k8fdFrMHIqX7InHLHKniYpX
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Remove the earlycon boot argument. As Krzysztof pointed out, earlycon is
for debugging, not regular mainline usage.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
index 84d583168d81..9c7efb1c44f1 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
@@ -9,10 +9,6 @@
 #include <dt-bindings/leds/common.h>
 
 / {
-	chosen {
-		bootargs = "earlycon";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>,

-- 
2.40.1



