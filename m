Return-Path: <linux-kernel+bounces-78357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6731861259
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B5B251F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F17EF0C;
	Fri, 23 Feb 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbZbHu4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3857E787;
	Fri, 23 Feb 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693976; cv=none; b=Ha4+JTfeNhq9UaucyRCDwmfVnVprgt0c7IhiuwB1r2arBuNm4C0wM4yKlHeeWGsTgrZDIBeo59Oc5M/TID3Qbl0cOhVBiz57aSWEWQk0uc2yOb3r+2IkqC7z13dgSU2DZTjwIw0k3lB75RY8AlQqkx8gBoZuhtt+jlRkw4VtXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693976; c=relaxed/simple;
	bh=3f1saNFjDV9lQ3ymMMHFoFlIVWzDM7u63mKq3O12V7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aniF6hsilqcl657ovp0Z7QX0eRxCVM0WNix7zvhe5A4sKsy7E8Cc2MQUf4Yljmw3x1DlBxs9W/vHzm/RDYlxnOnkk8HLgdRf5ESEzPQKU+O9eX8a58m0lPyGsvqDYKAfgBAYo/lk7aMkCzia6fkTPObbcX39cqKctdR2xGoSJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbZbHu4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742E0C43399;
	Fri, 23 Feb 2024 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693975;
	bh=3f1saNFjDV9lQ3ymMMHFoFlIVWzDM7u63mKq3O12V7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fbZbHu4ElA3MhmADUy1GBfRaGcSPu/m2bFBd0t/SK+39nTPbqJIugNOdgL51cn4TD
	 +lTuIxeZXWPkyvj3wkLw2QkpT0TiQRYz2/9VWz6AE6UVV2wzB79xGGaWgYf9F4Jly3
	 fVvB8VBymFLgOHF5nL973gKoFVq6opBm/z0W0wwItGwQtqK5NCFiGc9yaXVoLaibkP
	 BuIYYTzQJKYMwKtmmRl6uX06BH5FEZMt5eNfd6t8AY6gMn/xzoJqfy65wK1Hx7nG3i
	 hGaPROGhu4KCvtGgqo9cruczGfLGWwWad6/UYxe1n/va4QfzfsP4Mj8F4D+delantY
	 1S6+e3PwFU6AQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 23 Feb 2024 15:12:38 +0200
Subject: [PATCH v5 1/4] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-1-4b5854d17d18@kernel.org>
References: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
In-Reply-To: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=3f1saNFjDV9lQ3ymMMHFoFlIVWzDM7u63mKq3O12V7U=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl2JnPku8a3cYMUjIUwnqIaokWxMKNBx3z9XuZO
 vLQj5Vl/g2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdiZzwAKCRDSWmvTvnYw
 k9lqEACr6m1xDqxQ1wAd7kJ25jhK/NdyIpsUTYjjRrW0jE8neukTLJX4hoyrAiWDc9zhqtpH/tG
 7UYDYW3lvFTiPtGlLQmxTXXX1QGcAPwsAPsT2cxd5FI8ijXv8ZXSAlFwN6Yct8uQN+RwGwtHeI+
 8nvg0IHXbkuMEbPI5ipIYfXnxnUXhHn6t90vzHHVPzi2ND/JSOWsAf0aL+LMTdeL9qVVhogAEp4
 4AQjz28E146Rk0TDpr9TbhT2yvGcF0geuswEq/6uTot+Ty5qwutd5U5VusROqyDMUU/+Tb7pppE
 F+c9qBoyCPc1sTyTyzBBx8MoWef9W//3wo4u9I0elAgbVK/XJqrOBkkR5dq4IJGvvGbheAWYpWy
 b3wcJ1ZKrBdie8OMhCtYHr84QqvN/3rlpg+ghz4wZcYcBwSHD+dxV26YlsN0Ve5m8MIvHCjoFOF
 8vi+4Hmbu6QYm7rW7foc5c1pb5nn0vU/iJvlSWzdLTcotIjz2eHEvTrwLS9FNHOQuqo/zEsY40A
 s38WImwT8557p1Oqg9qaNKsTQiqqvVZEKnl6/qOczBAqTC2vDiQwWMKoi6iNdRhg/3uYORRM4HO
 oKS4h2lzxHvXS21v+sjdPfaBUHUEAo7b/p3IUg1Mc+4+55hbWZfT0JUAh4lj8yyBPi1wb7zSw4y
 TqMqOZllKYp6MlA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add the compatible for TI AM62 USB PHY Control register. This
register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
is used to indicate the USB PHY PLL reference clock rate and
core voltage level to the USB controller.

[1] - https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changelog:
v5 - no change. Added Lee Jones in To list
v4 - no change. Added Rob's Acked-by
     https://lore.kernel.org/all/20240205135908.54656-2-rogerq@kernel.org/
v3 - add compatibles in alphabetical order
     https://lore.kernel.org/all/20240201120332.4811-2-rogerq@kernel.org/
v2 - New patch
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..9437705af92f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
+              - ti,am62-usb-phy-ctrl
               - ti,am654-dss-oldi-io-ctrl
 
           - const: syscon

-- 
2.34.1


