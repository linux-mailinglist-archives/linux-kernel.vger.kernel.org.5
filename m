Return-Path: <linux-kernel+bounces-121892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C088EF03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E7C28E3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2915356B;
	Wed, 27 Mar 2024 19:11:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6E13E043;
	Wed, 27 Mar 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566713; cv=none; b=aogD1n7sMgCSidcv9/qgB+Bkkz42oY9kKUGIW3ZAn45I6+whqlaFIs0JeSlgal2ke9VR+dAEGz4YlgRtSChX2En2C9qChOfNegGTaX1hY2iwXEuqUGo3XhYELUnQr3+M8LlmlW4WzcY7Ty1EN8F6IJD4kIrlDtq42PDzNpW1X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566713; c=relaxed/simple;
	bh=8K4YFhR8C6V7MEOUhnFeNGpLwrwArXVCXtTG2QEyaYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jufobp79wdoTNoWPIySAnVkG6zj4G4byUDjkmH8EjseL8bwdzJSw62VFEd3z0zFW51+f4Rerty8JOimJqZM4w35d3KBhuUfcL7ho5HMHOMQX8AYPK0SqGrKZ5W1Mx0scGVF3qz6VHbgzBn/gWGJ8sTz74wctSZw0nxry9OadXns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68A5C433F1;
	Wed, 27 Mar 2024 19:11:52 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B46581060DE9; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:38 +0100
Subject: [PATCH v2 7/7] ARM: dts: omap3: use generic node name for hsi
 clients
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-7-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=8K4YFhR8C6V7MEOUhnFeNGpLwrwArXVCXtTG2QEyaYY=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9zVErjO87lwBsjYyxEn8oqZ6l2a7ExGGuss
 YmilPZQAjiJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcwAKCRDY7tfzyDv6
 ms5OD/94Zzs90HS6zooUcE0CmRNm9ia+akkjPf1uyyeQWV0CRM04NY+FwZihySdgkSCt3sErhQa
 CSkZQ19HbPK4tham9eFvpjHNNXustDfv2Yfglpr+6lW6aJ4FNlEy1YqlZqTeLA51Q2VIu3r/lqE
 eZEyJCVd7fWxxUPg7wCBqJ384frCXyhWRbDmrYZ5/whuygglaTzAondIvzTu2ryfsWOEiM2Z5bX
 kJyMkWjSxWR8SxUvZbICMB065KAuhar999eSFqVNEOZGkWAKmVikX/wGIVL7av36HAVcISFK4G/
 WvVkZ8jYA8CYk1Pm8Fy/IJueaeamUt8IP+/Gnq3uCvZt5rQnD7zOeoCwJsGeI7Sr+PcNHhpgKXT
 gftpwzcWc8hTSNo95Hg9R5gC2j7c33yGJASf0Gk/QXeGiNzD1tO/R66zx9bIAZZDKH+/aoj6Cj9
 a2Up8jsFRH0r1w0adeT7PRuGWf+vWaIbZueOBAKsySFlR5IEKmDTzMayLcwvA/bDzwUitijXK+Y
 f6vX31oW5/L5ld2O6vjUB5ELebok1o6KKpl2HKuXPZuXPxFGuqn0eI74jePNagiSoMUdLJcBeAg
 wNvx7Z4A+wTO/9cYlNEV2aqckVcQ5lBlX+hoRqQuxAO4AMVYXyyMxNoANUvD8+Syzd0roG2kChW
 IVCbu6zhzeXxuwA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The HSI peripheral node name should reflect the generic type of
device for the node.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts     | 2 +-
 arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index b906b57371ce..bec31faf86db 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -1123,7 +1123,7 @@ &ssi_port1 {
 
 	ti,ssi-cawake-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
 
-	modem: hsi-client {
+	modem: modem {
 		compatible = "nokia,n900-modem";
 
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
index 6e0db8275227..7e6dbc1968aa 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
@@ -450,7 +450,7 @@ &ssi_port1 {
 
 	ti,ssi-cawake-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
 
-	modem: hsi-client {
+	modem: modem {
 		pinctrl-names = "default";
 		pinctrl-0 = <&modem_pins1 &modem_pins2>;
 

-- 
2.43.0


