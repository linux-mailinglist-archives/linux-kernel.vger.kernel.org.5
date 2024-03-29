Return-Path: <linux-kernel+bounces-124316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A989159D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94421B22846
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7423FB2A;
	Fri, 29 Mar 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZpEFsqy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA854EAD7;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703855; cv=none; b=u/rJTdb0usTrFV+/AxTYhMOBElPevJaHJoTRCJNPDwQzeUoUILsoX5QArO0Z0BuyJSIOEupsNAufK0+YOgdgBT4hxp5nM5oEU47VRIcQO3+I8bq2GO4c7wT7EeD4Tpw2ehQA3/9llFEPtQQK+CeFN5X7fb33xEUQ60lce3+od+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703855; c=relaxed/simple;
	bh=stRn40k3Wznn/gwcVteftCGGh9Q8iyBgC3XO/vR9ah4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQNFGENlGp11cW7OSKutofGPsfrVwViTW7Xbe/lENwMamhM6gOKY5IIiwXmk3cc2dafhWzoPplp0b5dkK7FxzIj8SM+sTdxgwoiwZKv3aa2esZjlbkn5cX0F1hNuFpuBlfbjG6VyJ0gEpgrxIL+cxfKaB4pBGIfwTtUh6tv7+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZpEFsqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64F85C433B1;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703855;
	bh=stRn40k3Wznn/gwcVteftCGGh9Q8iyBgC3XO/vR9ah4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AZpEFsqyYwMBCtFoX62cC5ri85w8HDkTs8aNFFzgLxCRTyYZip4k9Psofp2kT1e9r
	 XR5azjAXVmHcBXg5HW16Y27uSEHC/xTAdq1+ufUPQwnj9P26o73e03WvD1VWHv5O7u
	 /BKch4lSUmsawiqXvVYS8nAOaV86bLtOGUt2GS9CZHMileOrw6Ijl9bfP406mPx/8p
	 cUR0zcfHDKkMUXJaxhNAc9M2vSq3J4Qyxh1lkVNcZ+GyZME/a6CgzKDosvqQTeY6S0
	 SsSvmQ/lWgv2gZSMDK+NX/EZbR7mrbs4D5trnUo/zSlAA7QpcT5AdH+zTRBDR3PG2P
	 HgA7WRGfWnF0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59311CD128E;
	Fri, 29 Mar 2024 09:17:35 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Fri, 29 Mar 2024 17:17:15 +0800
Subject: [PATCH 3/3] arm64: dts: amlogic: add reset controller for Amlogic
 T7 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-t7-reset-v1-3-4c6e2e68359e@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
In-Reply-To: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zelong Dong <zelong.dong@amlogic.com>, 
 Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711703853; l=1108;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=nQ6i4onLrotYFoJPFCF0uK2+BCj3hGBC1C42Lz/v9h4=;
 b=Jaw99hNZQkkHxQBjC35M3u7xduE2mi1d6p+mbAr75eUopJQwluSwKkTVhFrdm2MgKnxJglndn
 fc86fr2K0poCv4GnbrE3ablxTtxcKSl1DfbTwZmXw38Wpr62LNNX5tb
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Zelong Dong <zelong.dong@amlogic.com>

Add the reset controller device of Amlogic T7 SoC family

Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 5248bdf824ea..e94bb85b5292 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/amlogic,t7-pwrc.h>
+#include <dt-bindings/reset/amlogic,t7-reset.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -149,6 +150,12 @@ apb4: bus@fe000000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
 
+			reset: reset-controller@2000 {
+				compatible = "amlogic,t7-reset";
+				reg = <0x0 0x2000 0x0 0x98>;
+				#reset-cells = <1>;
+			};
+
 			watchdog@2100 {
 				compatible = "amlogic,t7-wdt";
 				reg = <0x0 0x2100 0x0 0x10>;

-- 
2.37.1



