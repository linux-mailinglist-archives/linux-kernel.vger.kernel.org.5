Return-Path: <linux-kernel+bounces-131115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0A89833D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CEFB27306
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F73674BF0;
	Thu,  4 Apr 2024 08:35:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E674421
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219716; cv=none; b=tUuaWzTa9nOndpihvTZmCNi9QL7uad3OVsjeM/kuncbrsFkWsexPiJiVnfy2fmuxbIl+eC8e9rz3ZhstTQzcz5RNT+33IOx1PdLIM24V60Zrh+mO5KW6vG9d+68GhnQ+DQti/VCenGqWoQBejSP8P+3aubtqw8s5BvGtqhkjX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219716; c=relaxed/simple;
	bh=DjIod4vdrwlFQJE94FcN3Z4LXCtugW0BAzyBfoM+dpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NzeWbByi6mFLtLArOIcf64WSr2/EMIcC8jsoR+YA8UgmRbpif+j+kI+OwZwt6ZBdNAHGVxA7BoX+vMwAlC/1Cb4nKxnelKqD5axH9YhLTSsjMO/hXF9+0P2U+Fe6pGQJNvwgYn++P4SNNWcaAiZqEsaSFY/xDHvbJxE16fWrdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsIYZ-0004VI-L9; Thu, 04 Apr 2024 10:34:47 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsIYY-00AKm1-Qr; Thu, 04 Apr 2024 10:34:46 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1rsIYY-00Csm2-25;
	Thu, 04 Apr 2024 10:34:46 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 04 Apr 2024 10:34:39 +0200
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Protonic MECSBC board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-protonic-mecsbc-v1-1-ad5b42ade6c6@pengutronix.de>
References: <20240404-protonic-mecsbc-v1-0-ad5b42ade6c6@pengutronix.de>
In-Reply-To: <20240404-protonic-mecsbc-v1-0-ad5b42ade6c6@pengutronix.de>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Jander <david@protonic.nl>, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712219686; l=961;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=DjIod4vdrwlFQJE94FcN3Z4LXCtugW0BAzyBfoM+dpg=;
 b=kxLefLIxxx0tt5acraW8mOFfMZ5VI2os01W92AilqJqXn+kq6IQJv4/ddLV5wzrDiNAZ/WlrM
 dp83JKtoMRhDWkEcfAlxypNwIMC33jQmTGHav47ZtjETGc4eyoLkXyY
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

MECSBC is a single board computer for blood analysis machines from
RR-Mechatronics, designed and manufactured by Protonic Holland, based on
the Rockchip RK3568 SoC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index fcf7316ecd74c..4847fe072d550 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -700,6 +700,11 @@ properties:
               - powkiddy,x55
           - const: rockchip,rk3566
 
+      - description: Protonic MECSBC board
+        items:
+          - const: prt,mecsbc
+          - const: rockchip,rk3568
+
       - description: QNAP TS-433-4G 4-Bay NAS
         items:
           - const: qnap,ts433

-- 
2.39.2


