Return-Path: <linux-kernel+bounces-142257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9DC8A2990
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2923F281F30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481415467B;
	Fri, 12 Apr 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWl/lkBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AE53E1E;
	Fri, 12 Apr 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911354; cv=none; b=AzP1lGVCQxQPDlO79FAz4+jHlDQwfPZ8KLEM25ruJcCc9zVaPRlQiaLeB1p5Je/kyHg60NkYh8VHqb1x2VIzawmeR6uC7ojcpJc9OQz2HIrASQiAT6Ig/9wD+gb8NSTzdZIEOjufpm3Nqe9iQhAjuSgJiApUwMhK4+bnj2Nbw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911354; c=relaxed/simple;
	bh=A+G6ElGrbdxKFc19F1WFdjKXJ4NPRwN4ZSGf2BITplc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=en/sBPAts5iTGbVDk/mixJBCqyalVE8l32RLYalk8jiwqTRFCgoLMv1IFuyuBOGfh3oVYVSv7jgJlEJWrcr6d6si3wlbFMj9RQmMeDqm/mm/gFhv+AefV1JE4oYnIOGOcaEPqc0YqPLkk5dyL0Q8SzeiC5hLpnIibpQH5k+cU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWl/lkBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0D75C32786;
	Fri, 12 Apr 2024 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712911354;
	bh=A+G6ElGrbdxKFc19F1WFdjKXJ4NPRwN4ZSGf2BITplc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eWl/lkBW00ATexLk5CJ4hGJJhnDZK12QlOi9JNpuuLncH0QM6T/lRbazUc4x5HGjZ
	 MDNqkrXt3e43Yz5moOpe3hzw8Nm253TQpJa2GuU5PPw89QQqLBJmBViaYg5O/KRQBe
	 5n+LVd540vk7a5zljRj0nPK3TYLDniAUUrLgPtFt/c+tC50UbJ4RMjDskneVv0d39W
	 EVnUmzlLNVds26f6d6bKnxFQlpvXm8eB5LUW5DV683PxUv/FpC4Wk8xuTjl2X4oI+5
	 4VylVWq401sPKwAbdFhEkGmrIslN8oMANk1e2Fc239pIdftOKodGlAeikWgi380Lgw
	 FE5D3N9dSTYvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47EFC4345F;
	Fri, 12 Apr 2024 08:42:33 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Apr 2024 16:42:30 +0800
Subject: [PATCH v2] arm64: dts: meson: fix S4 power-controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-fix-secpwr-s4-v2-1-3802fd936d77@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAPXzGGYC/3WMQQ6CMBBFr0Jm7Zi2qSKuvIdh0ZQpTCKUdEzVk
 N7dyt7l+/nvbSCUmASuzQaJMgvHpYI5NOAnt4yEPFQGo4xVVl0w8BuF/PpKKBZd14XQndWgHEF
 11kT1sPfufeWJ5RnTZ89n/Vv/lbJGjUo71xK1xp/Mzc2POLI/+jhDX0r5AkNlCI+sAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712911352; l=1368;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=oKEf8J5zEQ5VRP4drtkFgH9o2pd0Lw+wi/tMBGddobo=;
 b=g58n8V9t/QOY/0zH12yHIGuXoV1zedqzQpBb4TpKujUbaYz9w6Iv3V+0IJTaDWu4CybnE7KPy
 U0mZWlwsjwxBksQosAldqYNI8h4o8x1+ufJ+NDJhg+Mhz7pmacs70Z5
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The power-controller module works well by adding its parent
node secure-monitor.

Fixes: 085f7a298a14 ("arm64: dts: add support for S4 power domain controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Add fixes tags in commit message.
- Add firmware node to adapt documentation.
- Link to v1: https://lore.kernel.org/r/20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index ce90b35686a2..10896f9df682 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -65,10 +65,15 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
-	pwrc: power-controller {
-		compatible = "amlogic,meson-s4-pwrc";
-		#power-domain-cells = <1>;
-		status = "okay";
+	firmware {
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+
+			pwrc: power-controller {
+				compatible = "amlogic,meson-s4-pwrc";
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	soc {

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240408-fix-secpwr-s4-a99ff960d0ae

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



