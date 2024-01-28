Return-Path: <linux-kernel+bounces-41950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331183F9EA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB84A1F226D7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C483C498;
	Sun, 28 Jan 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="EJOMD3Ho"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9812EB1C;
	Sun, 28 Jan 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474928; cv=none; b=Vocekce3nilwPd4g0cROpcIBK4rE501ybCrroSe5oTFlB8kVIqLXDxQgHZ4hqMCGFPgJgBAmaqcQffbyfTVjfbViYOyQ4QO5VK0iiR6h32L65eXH8nHw52eIk6Dhbp80F82xs95i0lf3obu1+vV5R9m4HXyRt54btC3XCgVQ/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474928; c=relaxed/simple;
	bh=sC4x0F7ocxCOiTa61zP6CfELEuBIay9GFpbnCJDfh/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZCWfZzua3aHBrIEJxTGXQMg1h0R0S9jba7qbHwP19ClyGpchUmpDStJ5h8Hzw6EdcNro1j6+jnatjPPSUOWVYbMbzqG0K0Sp2qHP+6dOkXoFMbkrKaWO6iFVqny97iRveaOUjydpuXSdOdsvV2Ffa7xfUTXU/EWky7FGumzLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=EJOMD3Ho; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id C738C4649A;
	Sun, 28 Jan 2024 20:48:39 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Miles Alan <m@milesalan.com>,
	Ondrej Jirman <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 2/4] arm64: dts: sun50i-a64-pinephone: Retain leds state in suspend
Date: Sun, 28 Jan 2024 15:45:08 -0500
Message-ID: <20240128204740.2355092-2-aren@peacevolution.org>
In-Reply-To: <20240128204740.2355092-1-aren@peacevolution.org>
References: <20240128204740.2355092-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706474920;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=7f8Pqy4UhROYbk09gyqrlaBXv9qrJ3dn1Gj623LQxSg=;
	b=EJOMD3HotjeLQcDFlPSxcFnoN3nW4WypH8d+tyrewLLGqsU46t6K1yLdx3qDx2od6hNEj3
	BMaTuqsa8o9W0bD3JuUYBTNax2AflA0B+a69MUnW6kIL9uP8fgDXUz/lcW2PKB1ak5I6ie
	KujAkq7t9VoaDzzJ8fkALkziEg4/9Ss=

From: Miles Alan <m@milesalan.com>

Allows user to set a led before entering suspend to know that
the phone is still on (or could be used for notifications etc.)

Signed-off-by: Miles Alan <m@milesalan.com>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..ad2476ee01e4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -43,18 +43,21 @@ led-0 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+			retain-state-suspended;
 		};
 
 		led-1 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
+			retain-state-suspended;
 		};
 
 		led-2 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+			retain-state-suspended;
 		};
 	};
 
-- 
2.43.0


