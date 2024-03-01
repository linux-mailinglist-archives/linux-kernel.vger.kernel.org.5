Return-Path: <linux-kernel+bounces-88093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A588586DD46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE122899FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B0F6A029;
	Fri,  1 Mar 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="I1gbJAfo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MJxkvT+a"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BB6BB36;
	Fri,  1 Mar 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282444; cv=none; b=EX1lCqYrkPKLGrAVK2n3ZsRl2uL1+MJ6TD2M8MH7m+mpMAO1nUZ/Y55t3Dxff8bdV6aBDpoMzABK/L8rwC7uc5lSz70b47+4mG1gHTypjCcQTVK9ADnsM3yx/ThUpjFMWJIFDFluO+JLK+hlXLmPgBkywrVe7BOHd+cEiaquPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282444; c=relaxed/simple;
	bh=K63pbKLdAUYOWop/HtJ/eFv3uzmNlEmQ+U68PXHrgco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VetclD9bgwrVY6yH+FaPRaPuBYvg75wBbk2DSAp6mvzuQbjJ0OwoWRO1II3bishfkTGR+EolssxzfKuW7hi+rFsZB/4cqXyBodNX2JQcNcvKXzl7gPEzoTsjpUNiw19r32ZYyM21PlJwwmqPI+rMMICjNlwyC22Bh7IXhAKxL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=I1gbJAfo; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MJxkvT+a reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709282439; x=1740818439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lx7L1yeDQfLG89Mz94ToNu0CzTt1dUUrZHxQtg+EH88=;
  b=I1gbJAfoUJdotmtBeK4sT6GIa3DgGK2MMBeZD4dSMagGGXyjBmpW1Toa
   gVwABgKxQRHDBEN+zuH06A4nis3HcYYVglWGEYY2AwM1dS+heEk6B2dZ2
   ZNb6ExnOKi/IIbpwZQzqIBN4Ncpwi6RlcBoz7omHxXZHT5lDsfasem+Vo
   alm7dEw8xNlgIMkIgIYewwj6lB7jnHZPOEJf0mByTfxnPFJ2aAHnhjYus
   DmZli74wVf9SOVvy7tz3zD4ImkU4cKAh7iSXQVCHvi2rWMrC5c5VIPqtN
   M74hZLcCwhms0ViYV7iSoQPRnWg1f/+iavZoV2ClpWW8IsrsLnI/jwWT7
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35680479"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 09:40:36 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61003173639;
	Fri,  1 Mar 2024 09:40:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709282432; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Lx7L1yeDQfLG89Mz94ToNu0CzTt1dUUrZHxQtg+EH88=;
	b=MJxkvT+au9F5IKIzgwBJN2leQ1QuowHlrAJwinv9p/8a9Is+HEhBQT95ACJD+lowO6PEFd
	zqta59lnUKdt7xgbzLTqEgBK9laV+tzEPgIPLVlmU8BHHSaXGZ9m1jEnHSIQL0BwAEWCYr
	jStUATwWSghi+gZrqU5oKKohkuAwQkbem1plX19W9UH52k+FW7UnnQ2Cev6tmcRHsqMGDL
	A1TQZkhGJ1No5nDrjTqGp43ZsBcbPNAxYeKdXeVgJfPCOCHh0nwL6oRmc9D5VMucYlQc2v
	jflPoDtDMODF+RVicD5ce520XAdn6xEzPKOqodULfu74Xmk/jlV39UvTHV+UQA==
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
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] media: dt-bindings: sony,imx290: Allow props from video-interface-devices
Date: Fri,  1 Mar 2024 09:40:07 +0100
Message-Id: <20240301084009.3030753-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow properties from video-interface-devices. This aligns the bindings
to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
dt-bindings: sony,imx415: Allow props from video-interface-devices")

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* Collected R-b & A-b

 Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
index a531badc16c98..bf05ca48601ab 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
@@ -23,6 +23,9 @@ description: |-
   is treated the same as this as it was the original compatible string.
   imx290llr is the mono version of the sensor.
 
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -101,7 +104,7 @@ required:
   - vdddo-supply
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


