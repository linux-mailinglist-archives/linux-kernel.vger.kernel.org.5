Return-Path: <linux-kernel+bounces-144297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37758A4445
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692EE281036
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A9613664E;
	Sun, 14 Apr 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du5Zv+wc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4A13540C;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114092; cv=none; b=NS3pZKqBMiqMqcIJee/ugUwDW8cVZds1vSoP5s+/Ve5ye+1jZ1/GyRvKKBiMKtY2wS3xnDpdmJmKLTz8AvxvDvSH26QfrUcBbFmdTWWK1v1usA0j1A73p0ifjWexYZZ4qYErVQWBpGPsoBOf45Y+byrY3lCWlZEl87N+m3uAj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114092; c=relaxed/simple;
	bh=o9uYlQNqrCGtMHvs3KUOdRGq5nijbxvHM9PkDuBzNSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqM3QtjZrrM1NkWQz0OFzv6bmGmNyEhh4C+cEdTjP8RefFn5yIpcaZgqK2GXtnOm1A6r2UIr3y4dEEXoJotaeiKTgaf0r/VW5jdg69/VDajibz3Vo/cVf2QzvJ8hytApcx39Ym4sJLdphTSCBIXFl8HIDQhD5vfYo537YqIENSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du5Zv+wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF7BBC32783;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114091;
	bh=o9uYlQNqrCGtMHvs3KUOdRGq5nijbxvHM9PkDuBzNSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=du5Zv+wcz5r977/H/e0aLkBHjbQKPT0ca8+kulDvJw7436f+gYcfPX4ovN47VlQng
	 q6ZMs0KXHfxKj5p7qrd8B2vUL9iGxg7wIMnXcEgvTtx/x4K278E4q2Tl1LhJq9feD2
	 ja7fCDdP2YJED6XcnsUhhBtrIVtS1MoYcMasCpddAPgnZK40eeUtL14E4kTkFGNlBR
	 Zqg20XPRQwGmFOnVYoYvnfFP2LVaTOtBRGPuNODZI7JjWLlY6ppLRNNwd7QOzB2Hvx
	 tESzN6QhSd+aJmBNKEYwSJ98oo0QcWbM6tuRjDIY8mqvSMK09w6XuqD7GsW1bcYybn
	 zmx2JjOjgw1QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC4BC04FFF;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 20:01:22 +0300
Subject: [PATCH 2/4] ARM: dts: BCM5301X: provide address for SoC MACs on
 ASUS RT-AC3100 & AC88U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3100-improvements-v1-2-0e40caf1a70a@arinc9.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713114081; l=1804;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=XNg5zKIjWsrnhPZDAMtpMUnqzsLMxQHh+/+ZQ+585t0=;
 b=t/VSblLuxfZr5QPDbh12w/4Vklfc40j5/zpD3kJ1fsn+1Jgy484Hj8fpm8pBiKsbzlIBypdCw
 BDYle8UdVEBCdtN8aG+xdGv8ANr9uAecAZMsl9vGAeIG1oJGDx4VrAJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Do not leave the providing of a MAC address for an SoC MAC to a driver.
Describe it on the bindings. Provide a distinct MAC address for each SoC
MAC.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts | 13 ++++++++++++-
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts  |  8 +++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
index 5f089307cd8c..1655ac95769c 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dts
@@ -13,11 +13,22 @@ / {
 
 	nvram@1c080000 {
 		et0macaddr: et0macaddr {
+			#nvmem-cell-cells = <1>;
 		};
 	};
 };
 
 &gmac0 {
-	nvmem-cells = <&et0macaddr>;
+	nvmem-cells = <&et0macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac1 {
+	nvmem-cells = <&et0macaddr 1>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac2 {
+	nvmem-cells = <&et0macaddr 2>;
 	nvmem-cell-names = "mac-address";
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
index fd344b55087e..c78f0c7b137d 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac88u.dts
@@ -13,6 +13,7 @@ / {
 
 	nvram@1c080000 {
 		et1macaddr: et1macaddr {
+			#nvmem-cell-cells = <1>;
 		};
 	};
 
@@ -117,6 +118,11 @@ &gmac0 {
 };
 
 &gmac1 {
-	nvmem-cells = <&et1macaddr>;
+	nvmem-cells = <&et1macaddr 0>;
+	nvmem-cell-names = "mac-address";
+};
+
+&gmac2 {
+	nvmem-cells = <&et1macaddr 1>;
 	nvmem-cell-names = "mac-address";
 };

-- 
2.40.1



