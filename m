Return-Path: <linux-kernel+bounces-128579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C6895CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1877F28403B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9C115CD4B;
	Tue,  2 Apr 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYd1wR8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38B15B966;
	Tue,  2 Apr 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086338; cv=none; b=ttyaKEHc9jR4xbkOFO/xE6Ma/+8FzZSqxP/IWl+pRcW1wWz4OS8ymard9RayzujKj54mH5x0Zq7PJtHrSDg4HvFSx3cvYF7tzFp0AgNHt7xslWsc8XqonN2lW6Nvm3aCe4dL8d5jzUWMJmErsrpP/ov5i+Ow5VbYX/NhhXkNyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086338; c=relaxed/simple;
	bh=eBlE96tIOWBCJILzF+odJbWB2jOmGErusUnoe0WS9tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuHOWG8ck6NYAB+MbQDoISiykQlOVpEBR5rcs4YOOMwr+Gnu3UTR2BGtr0LXG5NZWDjaJP1E4XPD7ak/qC7RsJ0FAdJgPVyUryGdb5RtgmBz4lEa0WvlHmorioHd3J5Cd+jAaiTAkXKjnsloYwv0dguYSqRm6P0yxMcG5VzydmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYd1wR8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA066C43399;
	Tue,  2 Apr 2024 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086338;
	bh=eBlE96tIOWBCJILzF+odJbWB2jOmGErusUnoe0WS9tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYd1wR8bHjnqh8fuKeN2S9Cf4sKMUWnBdsuoAPr2C0ZtJZVr7sYhaaRzOB2wUgYGo
	 IZNMJWbHdYfgFQ3ty73N1ZBYumPOEh0Fozi4BH/prHTZAZWZBhswNIpd4I0h9pyurL
	 u1mIiNQscpdmKgDC+OOWrtio9w213VipF8K20sMq6h7WXWzZLH+a0Pc4c7NWlsdA9P
	 s4+CQpb0g2jJ3K9c2Ra0ZqGlW+h/7p3FYtrmZdkiUax/MnJEy3n3efD5303uhJO3aD
	 8lJXNiuYVry8/m5W7MbcUthGSrzVyxDjSn8f9vNLfrJ1frcQbSXaXjCHfWjtlV6iBt
	 auIfC5Ddi5X0w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 8/9] arm64: dts: hisilicon: hi6220-hikey: drop unit addresses from fixed regulators
Date: Tue,  2 Apr 2024 21:31:47 +0200
Message-Id: <20240402193148.62323-8-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed regulators are not part of any MMIO bus, so they should not have
unit addresses.  This fixes dtc W=1 warnings:

  hi6220-hikey.dts:85.26-92.4: Warning (unit_address_vs_reg): /regulator@0: node has a unit name, but no reg or ranges property
  hi6220-hikey.dts:94.27-102.4: Warning (unit_address_vs_reg): /regulator@1: node has a unit name, but no reg or ranges property
  hi6220-hikey.dts:104.26-113.4: Warning (unit_address_vs_reg): /regulator@2: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index a2aa17e4dfdf..2d304efe081d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -82,7 +82,7 @@ reboot-mode {
 		};
 	};
 
-	reg_sys_5v: regulator@0 {
+	reg_sys_5v: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-name = "SYS_5V";
 		regulator-min-microvolt = <5000000>;
@@ -91,7 +91,7 @@ reg_sys_5v: regulator@0 {
 		regulator-always-on;
 	};
 
-	reg_vdd_3v3: regulator@1 {
+	reg_vdd_3v3: regulator-1 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_3V3";
 		regulator-min-microvolt = <3300000>;
@@ -101,7 +101,7 @@ reg_vdd_3v3: regulator@1 {
 		vin-supply = <&reg_sys_5v>;
 	};
 
-	reg_5v_hub: regulator@2 {
+	reg_5v_hub: regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "5V_HUB";
 		regulator-min-microvolt = <5000000>;
-- 
2.34.1


