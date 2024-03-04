Return-Path: <linux-kernel+bounces-90894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E287067F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848471F2874D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B24AECA;
	Mon,  4 Mar 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJGwyF4v"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4D481DE;
	Mon,  4 Mar 2024 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568303; cv=none; b=p+C9xqp/HsR/YwwmbfR8Squ8zogiPWqHH4LdPBnD0B29ZAKtShLIJH5JDNJZTSuFvbQMDhXD+kGB3wgrUjGzwwt61nXZSTZMiOSusIGFZ5HP0FyHstCVBtCeBwJhz+M/Z1cw79+7hWWw6+0nHY2cfpFeq2GCM879vSiEX1SkU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568303; c=relaxed/simple;
	bh=vwklhpn4E3t0t2sYXhfOMvzOREBAH79QTShrZLc8eV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0REUeN1OEiFLGFYFoeSFgzw7aUiPzycC6ooCALZydjHbhWJxN3SC+E2rrCAlh2rnpq5Xj5G6bcLyfsPU73WMU+woJQHtszeUQs1wmhtZ9jOVqygqCty7OktaJTamec7uFmFptcxuBwNjf2qkWYpdko69FZKWrY4LPy8P4tJf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJGwyF4v; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92D922000C;
	Mon,  4 Mar 2024 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709568299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RrmFDhb/hI64FahWrZ6hwr/R5wFK7u5uPfr7IWELcA=;
	b=RJGwyF4vbjrYp/s2XsLFxiHONc2Rj5CyxpcxKhuyfvU2i6YfssDcAvn2HV9azH1PZox/BB
	YH1lGBD5H0I0GCgVZG49KRj32QrqW0xQyFUKInfmon2Gf7xMaW7VDyr2DkZWy8xyNjJWq/
	68+CZakrrfdY8ltlIHUepS2WV4KK4ck3v7RG9thfnDtdXKJjlm3ULjcYQiebyakcL/qyHS
	EVm0uUC2Ri7XNwOFYHtQLt1oPbvy6UcChqb6IEidpvDnvtMiBUWPSA9dbOy3cAwpIPB3c4
	eAhI+/vMooa3/+zZSeOY8twndc+vA3dMVMBR65pSlAL9vYlzjdQeqpl3plAvWQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 1/3] dt-bindings: Add Crystal Clear Technology vendor prefix
Date: Mon,  4 Mar 2024 17:04:52 +0100
Message-Id: <20240304160454.96977-2-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
include "cct" as a vendor prefix for "Crystal Clear Technology". CCT is
the vendor of the CMT430B19N00 TFT-LCD panel.

Link: http://www.cct.com.my/
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fef2e12b504e..96e47742e250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -248,6 +248,8 @@ patternProperties:
     description: Catalyst Semiconductor, Inc.
   "^cavium,.*":
     description: Cavium, Inc.
+  "^cct,.*":
+    description: Crystal Clear Technology Sdn. Bhd.
   "^cdns,.*":
     description: Cadence Design Systems Inc.
   "^cdtech,.*":
-- 
2.34.1


