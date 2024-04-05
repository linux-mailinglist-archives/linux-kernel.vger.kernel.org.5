Return-Path: <linux-kernel+bounces-132563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E568996AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69BB1C2129B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84612D772;
	Fri,  5 Apr 2024 07:38:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AF12BF18
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302728; cv=none; b=RIwbzIaAeScg8zT7K243AO2VQCqhM7U6baUG6hHF63k2mdNwfBUP8sHS2uTkpOLnruk720XiksIYEg/bZ7DjoRNIgIi/ps6ES45V/2/Ctgn6N7vp+Rtj0fa4njt0JkBAQ3/qy1IPQnHjmFHlDAG2byn0f/pG1xilQTrfFI2vEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302728; c=relaxed/simple;
	bh=vEZlMmCNoexJ8LmDeMg+hM/HB8jrt7K5VSF3PSzQy9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxJ1+twBSGzG5FNLvcft0FByGm5rnBSpwjLo4c8/YVb9sMvyyq7FFEWRzspFIebU9JBchb2OQVjYfyvSW+VGdJjRqVjApn2fg3ZDzRDsdX1r9QWt0zAQlM9tF358NTLCxjO4gcL9EWff/wh4EruQxZ2+y1w0aeKMP1ss2snvpYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rse9n-0005mg-MJ; Fri, 05 Apr 2024 09:38:39 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rse9m-00AWpx-TW; Fri, 05 Apr 2024 09:38:38 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rse9m-008vil-2h;
	Fri, 05 Apr 2024 09:38:38 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 05 Apr 2024 09:38:36 +0200
Subject: [PATCH 1/2] dt-bindings: clock: rockchip: add USB480M_PHY mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-clk-rk3568-usb480m-phy-mux-v1-1-6c89de20a6ff@pengutronix.de>
References: <20240405-clk-rk3568-usb480m-phy-mux-v1-0-6c89de20a6ff@pengutronix.de>
In-Reply-To: <20240405-clk-rk3568-usb480m-phy-mux-v1-0-6c89de20a6ff@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712302718; l=792;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=vEZlMmCNoexJ8LmDeMg+hM/HB8jrt7K5VSF3PSzQy9g=;
 b=hWJoHWEjX0205sJwn/JZR3TVmydlMr04W59qD8pDTWYfgbNLH0qWcL+hTEyNmZ8zXNNeZ1L/m
 /CArViKcKXHA0YceyGPH94ORtv5vMS5lCJw2zNFRN0sgJ+e81/2WM18
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The USB480M clock can source from a MUX that selects the clock to come
from either of the USB-phy internal 480MHz PLLs. These clocks are
provided by the USB phy driver. This adds the define for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 include/dt-bindings/clock/rk3568-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3568-cru.h b/include/dt-bindings/clock/rk3568-cru.h
index d29890865150d..5263085c5b238 100644
--- a/include/dt-bindings/clock/rk3568-cru.h
+++ b/include/dt-bindings/clock/rk3568-cru.h
@@ -78,6 +78,7 @@
 #define CPLL_333M		9
 #define ARMCLK			10
 #define USB480M			11
+#define USB480M_PHY		12
 #define ACLK_CORE_NIU2BUS	18
 #define CLK_CORE_PVTM		19
 #define CLK_CORE_PVTM_CORE	20

-- 
2.39.2


