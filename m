Return-Path: <linux-kernel+bounces-88094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BD86DD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329CB1F2719C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D169E0D;
	Fri,  1 Mar 2024 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UZS52V5G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VF4EUw2d"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E26A32A;
	Fri,  1 Mar 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282449; cv=none; b=bA4k1Fa9kolQ+F/8rfpnFNa2uLcenyL7lrgow3MqmGCqpnfM31pDSXjZ/c7J+htmu2hmsKYMrJ2xuMo2dYdnvxQsWDKghkP4yW6SX3lgQzIqInUINohfmCLiEqisiCKSy4r6BQvsP7O20C0EvlALbl2u0MTeEmI3XB6e68qyLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282449; c=relaxed/simple;
	bh=5krobUKFPQVFM6DCDoevYZXMR+ogvs911v6NfUuohVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouDxkK349EinYevjDza1jHiA/zNiJBgVsdkRXQ4171GxTHdhZt+z17xIm5O6+glrBuwcgpp3+5d96f7jlE8ZstlzhrG3RHkIHvIppLvii+jIcZzqpvwd9o+Zndf7x7VJ3gaOSF2tMEV/4skqgEyIerCaahHS0d6qA045WBMAbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UZS52V5G; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VF4EUw2d reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709282446; x=1740818446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=roDEc9/Haw8V4ko75VQ2V+i9NSA1sqHboyikroeqvpU=;
  b=UZS52V5Ga+2XK8KXSrOXZ8LTHGYX9t0/gM0JqrE27IKrjzMghuXD8Dnm
   Ocp6pLtOA4SLIrpDuomu7pwT05P7kC4KQK13joceA7E0mDiyxjroLsdPv
   NEyrY6GDDpvy7e9iApyE10pAuWVlgTc8PhwqYRGUzMI9gZzlsffdxC+vi
   QkptpGGORoGIauTP3imtEexKDKgYGbybVgeU9Ci0LBakW1258SoWXjDg5
   hZA9QXY8eNrqOPmn1+/fBnvBuzmSTbafhFE+919SVvKT1KgkDteh6SWrY
   pQtrmQgJ8XErFR3IKzsT24kCc7+b3NtTqu0oi//UzDaAajqRKEoOss9wz
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35680482"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 09:40:42 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AB55172297;
	Fri,  1 Mar 2024 09:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709282437; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=roDEc9/Haw8V4ko75VQ2V+i9NSA1sqHboyikroeqvpU=;
	b=VF4EUw2dWOvr9Az8Mz6MvLM1QNZJPS4oX42yBYbsCY+DuNqooHtriFos2IqGagQkAb9es8
	Y5Daiq4Qrz7y4znauxYqGWeZ+oqHKPXx4h3CIVPI0FQ2j8LCQdoxQcJWIKyoQAZZ7cHmge
	DZnFYBxnjv1YsJAwzxRZNgTJBhD0O96GzUSHtVerUQnI5bMMIM7MF5gluzToL8yYK1IfJM
	AAYcf/QWDysRtdy9hbfZfvx7012YR7H2S/X3X1T+5hc19pVGp3jhH0kVLz7HYsqBq+SnFW
	SXxAMGje8zBpKAqGGJ1YUtOUQp2slkWaccKUV9kcI7HmeXMK7YjSJepxAV8f4w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Sebastian Reichel <sre@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] media: dt-bindings: i2c: use absolute path to other schema
Date: Fri,  1 Mar 2024 09:40:08 +0100
Message-Id: <20240301084009.3030753-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301084009.3030753-1-alexander.stein@ew.tq-group.com>
References: <20240301084009.3030753-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Squashed patches 2-5 from v2 into a single one

 .../devicetree/bindings/media/i2c/galaxycore,gc0308.yaml        | 2 +-
 .../devicetree/bindings/media/i2c/galaxycore,gc2145.yaml        | 2 +-
 Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml    | 2 +-
 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
index f81e7daed67b6..2bf1a81feaf47 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
@@ -15,7 +15,7 @@ description: |
   They include an ISP capable of auto exposure and auto white balance.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
index 1726ecca4c77e..9eac588de0bc2 100644
--- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
@@ -19,7 +19,7 @@ description:
   either through a parallel interface or through MIPI CSI-2.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
index 60903da84e1f3..0162eec8ca993 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml
@@ -16,7 +16,7 @@ description: |
   maximum throughput of 1.2Gbps/lane.
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
index 9a00dab2e8a3f..34962c5c70065 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -18,7 +18,7 @@ description: |-
   available via CSI-2 serial data output (two or four lanes).
 
 allOf:
-  - $ref: ../video-interface-devices.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-- 
2.34.1


