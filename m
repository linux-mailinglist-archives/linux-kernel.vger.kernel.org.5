Return-Path: <linux-kernel+bounces-87279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C686D21D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109F81C2356E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD87E76F;
	Thu, 29 Feb 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3fyxzix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7E70AFF;
	Thu, 29 Feb 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231073; cv=none; b=SAccH1x7yMLbnduq4LS3ADsRuK85aN2JB3oqB3lQOp+BeyoIfOxc4JMlE0S5PUABkWKEPFZRuuEvhG671vt0hA8rBCy6RX+1RZL2jEoMCohywxiG6c53MiHldeEC1nIYD0hIwVxx5/n7jmQPnkQO/TpDNAUH6wgkbfh1b28bJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231073; c=relaxed/simple;
	bh=owRtMB60N4nLYRY30ar53Jnf0Bh73JU1ENEVrBOTZpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDFMvrQVMPEftAijzwaJZQAa52mz97p5NBI/gMLfpgHXT9+lRFjnKv6ulAO/8tx2CvXyAotvh5kKOhvfkdL5FH4bjZa+JK8oKX2jI6aj9onbxUJ5HOOwBCWLyTzccFVWpxxnR4qOBUzsmz1EeRLlsNm03SnJS8uGLjUjar+n9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3fyxzix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9641AC433C7;
	Thu, 29 Feb 2024 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709231071;
	bh=owRtMB60N4nLYRY30ar53Jnf0Bh73JU1ENEVrBOTZpY=;
	h=From:To:Cc:Subject:Date:From;
	b=m3fyxzixMWLLWuDU1VI02wsNPIrgu18PKMB3nYauh2ddFscVlK06zRyLI2hLhtGwF
	 fEXYMn/xaMPrNBhfjsV9UxXeGFEXIWB55TZ0MEMVQXC3nwm1GPL0tBSuH/u0peEx6b
	 qZoH9yC5iG7xOKxnNF1gVRhmvoh7sW1ol4OHPIUKmKJLUEYASYINI+mmmbz0plUApv
	 56VWDh55xvYzVQ2e5MXkIaENwYzz1wR93hry6QZjBI20j5UKV3D2NMTSKD65EfCZKA
	 Kvg9seACZWv0qUFscY8022irABrkHnH56rIJeMO4Mv7i8gsAqKcHIxhCzihhaIaPa2
	 dDm3+JSAyjF2g==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RESEND] dt-bindings: leds: pwm-multicolour: re-allow active-low
Date: Thu, 29 Feb 2024 18:24:00 +0000
Message-ID: <20240229-excluding-bonelike-d8f01dcc0623@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VcurFTzb2TP3//4Y7vcwerf6iF/VbPf6TOYoBbN+VFE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkPTh/Ilpjc9kk51iF/q5HsTv0vC/UlRasdj5h0cjNNf 2WisGt7RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaydwUjwxHp95JubPmGVfJd qlvMWB/uXxa1QP3Gs5mRlnxbt234zsnIcNdXOym05d7/aZH2hY4bGDU9XONjD3FMDN27XsZ31ZQ ZXAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

active-low was lifted to the common schema for leds, but it went
unnoticed that the leds-multicolour binding had "additionalProperties:
false" where the other users had "unevaluatedProperties: false", thereby
disallowing active-low for multicolour leds. Explicitly permit it again.

Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low property common")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

This needs to go via netdev as the commit it fixes (and is based on)
is there

CC: Pavel Machek <pavel@ucw.cz>
CC: Lee Jones <lee@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
CC: Christian Marangi <ansuelsmth@gmail.com>
CC: linux-leds@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org
---
 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index 5edfbe347341..a31a202afe5c 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -41,6 +41,8 @@ properties:
 
           pwm-names: true
 
+          active-low: true
+
           color: true
 
         required:
-- 
2.43.0


