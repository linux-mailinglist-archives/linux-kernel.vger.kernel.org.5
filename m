Return-Path: <linux-kernel+bounces-78666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5688616E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D6E1C257C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5795784FC4;
	Fri, 23 Feb 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kF1uRtGJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9682C94;
	Fri, 23 Feb 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704336; cv=none; b=ONGMgD+XTp3ADHtO7yXT/88yI9nO9QxefiBxjs9N81DrL8Y0QfuXjIe9RM+v7S+UlCxRdbN57M2up3mlzO+xf/Vr9egRRoR0r+hP1pd7K/gXqhHOfVwNP5thW81477M4HOdY4nit3jezNQ9lIRze6ZWZssJ7WeVn3+q3dsyzuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704336; c=relaxed/simple;
	bh=vE5VgPP6Zm7bCL/kEb3+VHnXXFs1xbBqGLEwnPNNXLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twqZhVvHbjnJio6zCxIcRVL5ipbR7nUv4sNZrXllJsauPCTWrnHjKcsQgJFZeLVgO6UfcupcIUt9OynLSmAXUtbXHNvLI8/E/0RBC+JmHVz/A4OBmLc0Dr/GrdntS/4ZGIaa1O1h8uEafr5aoxaIepNBhk/sq2QWBvU8A1yH3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kF1uRtGJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EBC81C0004;
	Fri, 23 Feb 2024 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbIZMwtxQIO+hXns/iDo1uxK2FfPOqD7m7muGpA+4qM=;
	b=kF1uRtGJZjdQLHjQC+iq+zv9FIHFE8XcIXdKRpKFrlQAVWPUH6P4uS9KFI/gC9OtnqNoZO
	JW58FYyVdiQ3FGxNCvMHqukattXpUCx16iLkt6Hdbo1dFFPhNrt5AR8FbFpXHVMj9QKIZc
	V6FQCLsXDLjnhRX57QT5xGbP2hxZ6eyI5F/V4winePg/yPVYA/gBrc17r1VOUxgUZyljiz
	bRVU0mdHdioz/UcIVyYY3NLgtTN+GvOOB/g05X7fH5i4qC3GvD82ECOWJw3jql0pBRGSBv
	ryS6xX+gKGAMTz92bT3JjqOxUGsiBK60PIV5+F2wO1PrN1oAJF1qPmm9nb4zWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:26 +0100
Subject: [PATCH v3 2/8] dt-bindings: usb: ti,j721e-usb: add ti,j7200-usb
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-2-b41c9893a130@bootlin.com>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
In-Reply-To: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

On J7200, the controller & its wrapper are reset on resume. This makes
it have a different behavior from other platforms.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 949f45eb45c2..d52d5b2965aa 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - ti,j721e-usb
       - ti,am64-usb
+      - ti,j7200-usb
 
   reg:
     maxItems: 1

-- 
2.43.2


