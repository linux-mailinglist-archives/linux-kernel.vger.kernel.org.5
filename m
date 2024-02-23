Return-Path: <linux-kernel+bounces-78664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E68616DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5365C1C25451
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64B84A43;
	Fri, 23 Feb 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nn7zMY6H"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB383CC4;
	Fri, 23 Feb 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704335; cv=none; b=DIEqvT/4R2Aegv1wemiIL578vKlAHo4/NwvJ4wrEIK4Tp/zWq0VU+zqYp4rd/DwyXbQ1VIGjeC4d18a2qBpm16FbIvFK78zxznCOmzuWlZKCPddO+wfmQxfRA4C3/WLpehgIesK4KaD/cp9nrg63IZH0pBPL+Mo7H7YrkB7na0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704335; c=relaxed/simple;
	bh=ceuENLTMAkBaDWsdWKmub/JNtRRYyaA6Cy/uv9r7MNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRQuyUWKw57w/fHtKm4vsfw2Mm7smkw8/f8OF5rtlFgoHUK3gQENa2LaLQzPAVw4rVs9h0Wgsjnkz1CgOLL+f+4IC9umFw/GkNXDWVRVkd7pWyUC2oFMbbn6yQfzSxO6jONW67sA8EfpSeNEoTj4df5vhsTqbk0ToszDuxdDQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nn7zMY6H; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BC811C0003;
	Fri, 23 Feb 2024 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtY8B6yYjBR+Rfp7/Ypf4+btFZdyTE+hN6hS7cZZSmw=;
	b=Nn7zMY6HzfNBbGDyTqI/ZEqzRvwjboOPEXmoAo9vCHxj/v+INYHF3WUXiAR6ycghf5kQdm
	2CMgMRfM5iCBR6jlPc6/eev5Nj45vlyMMh/EyeQJwxLeLAtv9T70F560iI3lpoS561C1tU
	Z6SUDkbLU2EYYQ4KNHViU+ofzUxv5YBjdtpLgn6mZHbDgnHbPc/8D/RGsm/Q661bVc+ecn
	O1/QGmn+PtpoDJRY/NXOvgVE05013sskrUA32AnQriQcDnrcKd8oXgd8Bosc9+4qy7sHMy
	+bjgWlnGoW9lXp0/Uv8MJcr2zg1ua0g79GRZh1OCaqiQ4IdCJgvoJ/PAxRaGCQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:25 +0100
Subject: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
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

Compatible can be A or B, not A or B or A+B. Remove last option.
A=ti,j721e-usb and B=ti,am64-usb.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 95ff9791baea..949f45eb45c2 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -11,12 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: ti,j721e-usb
-      - const: ti,am64-usb
-      - items:
-          - const: ti,j721e-usb
-          - const: ti,am64-usb
+    enum:
+      - ti,j721e-usb
+      - ti,am64-usb
 
   reg:
     maxItems: 1

-- 
2.43.2


