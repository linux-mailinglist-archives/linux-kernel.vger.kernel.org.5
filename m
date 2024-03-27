Return-Path: <linux-kernel+bounces-121891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFE88EF02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD011F354D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38B153568;
	Wed, 27 Mar 2024 19:11:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49A1534F2;
	Wed, 27 Mar 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566713; cv=none; b=TQ4SreliH3ZGZ2nb91J895sxb1/32pOi3moZTVansEEZEg4pL8Q9DtDbnzuhGZa0eYtzCulRU8HQvuO8RGSjSplHRxmIziPAWoxgOPdYUagnVN6PeKvML3Gyued/mCjcRyzW2hKEK2UPanwPH+FR9LL3Ub0jcxLud4gyWshRQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566713; c=relaxed/simple;
	bh=EFoBKQDAtN6cym3QOd8+YHdfS7fjMPqCc2hL9I5LNmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtGSrO36ju2Q299h2LTTC+sb7XvUg3qvATdFA5e1lFC8YSjgBse0e6So8bJ5AJhhM88abtiiiugTm3vtZK1UpPXa0ZrORhxrkDh4uB+IzOLNNTD7ED6ksycFKirmIKBhWJIsO19HgB5m+vXRxapHZYlAzoIKV5qVNTrJyodscGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0176C43394;
	Wed, 27 Mar 2024 19:11:52 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B2A3B1060DE3; Wed, 27 Mar 2024 20:11:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 27 Mar 2024 20:11:37 +0100
Subject: [PATCH v2 6/7] ARM: dts: omap3: fix ti,ssi-cawake-gpio property
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-hsi-dt-binding-v2-6-110fab4c32ae@collabora.com>
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
In-Reply-To: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=EFoBKQDAtN6cym3QOd8+YHdfS7fjMPqCc2hL9I5LNmM=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmBG9zRhmxn4KXjiTpdziUEKvi94T9/0ghUS9Rv
 N4TYjDvf9uJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgRvcwAKCRDY7tfzyDv6
 mkGED/9N4AzZxhU9U506p5D1XkyqSQwVn4ZdPuify6r8oB7tXt87t2xr5CT5ZlRN2gYJQ7+MErp
 9M1cQ4N9htf+aI+KbBap9UWBWk1S+W3hq65ffeDWK0+A7tOCFkR0Qq02npDon1gruDl/wMXBVAu
 ZIaDjlJJhq6xrsFlD1ycJqRJHqBRuWGzOCwWt/9rz4IAwy8M5UqYIjbpEcmysMBMMJUg/TKZzpY
 Zvn1kznr6YHpc2M/X/5+ACQNuHC1M5vkC5qsf+F8TY2LdhQ4b4GrLWLtXj9BOG2+d47lv5T8SH6
 BrF+NJSzdCAOrZ12pkmna8IpbWskSjzFIGc7fXBMbBuUvWbZo/rgm0gB2uyvwQfymE27SJu1Oq6
 Q0ZAx7u62iDebTf47rca+gShb8BT+fpkPK8a2KHtzKZJrhQgRYZvcZK1014/9xs7EgBoWVvfa+H
 rrPsyhNRDkx2guV/zx60kc2RZBepTHeBlCN+x+Er08/BKjjhDgaIR7izIvudYzkhDnVgsYYW2xr
 fvrrRHnLFMALlQ5LDx+lgfYkZDb+0jjZouaRNdJstKyGqzfE+BFL/gvm1Ssp8Sr69ZpFGMGT20b
 s1+uc+8UZ1REdNksQKH+6buBYUBjvJES9hIjeAmGsE7tXjIfnSIm42xEQfHaCW3pWj93ZaGnzwb
 oydafkCPPDZPSag==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The SSI DT binding requires, that the canonical form "ti,ssi-cawake-gpios"
is used instead of "ti,ssi-cawake-gpio".

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts     | 2 +-
 arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index d33485341251..b906b57371ce 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -1121,7 +1121,7 @@ &ssi_port1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ssi_pins>;
 
-	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+	ti,ssi-cawake-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
 
 	modem: hsi-client {
 		compatible = "nokia,n900-modem";
diff --git a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
index aa4fcdbedd8f..6e0db8275227 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
@@ -448,7 +448,7 @@ &ssi_port1 {
 	pinctrl-0 = <&ssi_pins>;
 	pinctrl-1 = <&ssi_pins_idle>;
 
-	ti,ssi-cawake-gpio = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
+	ti,ssi-cawake-gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
 
 	modem: hsi-client {
 		pinctrl-names = "default";

-- 
2.43.0


