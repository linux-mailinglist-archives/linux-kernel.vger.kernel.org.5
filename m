Return-Path: <linux-kernel+bounces-95264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD4874B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39D2B22BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B60129A93;
	Thu,  7 Mar 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZZywsdz/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DB84FD2;
	Thu,  7 Mar 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805320; cv=none; b=gcPWTH4cfEtnfRO11iuRaxM6MrsCjlHtWKMAYyojNihLT9XlcP0FobdfcqetWQg3Cd2Y0rhB1St2s3iob63HTxM7yix7AfOAfaURWNRqMgbWYSxy3mtJN8Qt2Ps1OizPLO4851fz/snv0DMmBnTk+ZjVRC/ylYlPYkN5PrJV4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805320; c=relaxed/simple;
	bh=3vDQZq4bBTHIKrUEtadqb5Tze2IMHI6WZ9emMoHzC5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzqXgrXmdmDaJglOAUelJjYsZqg02nygbcudEd1rJZcPNRmQ/0ukyFFpOcoJ70Q9kEtP/YNIPS915hJhvWjjIgo5oDTHoUWiM2gyqMlkzcZTuyA/qHCk2hcuzF/2J3nG12Luf6yp+idFI+O5spsJ6OSjj/DWLBHrqCPdP0rVVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZZywsdz/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23F351C0009;
	Thu,  7 Mar 2024 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRn8ycTUfkJDoPr5o1S7rMU5q43x9RS8jtz5zW234a8=;
	b=ZZywsdz/p1+lSsuNoJE7ZwP0r54L3buzp7ZaBwS6Ztgd3phy7M5FV/wNtfU7sd7arxFS40
	TA4gbgo/PmlsOUYXYY7BK21ywt74DO3VY+3ZNnCsnCT3UN2zeir74cNiGQlVA7pXNvc8aT
	r1bwfV2Zk8/+IKzPTXueqDnlbZOhFN2yiU//X65Wzw32wBsA/NRuZ4fAuqzW0cJK0vDq3b
	dPnqb1g2+FkUrfWZ0dETU/yVnQkqfSVdQnMpmV2zhOZDGs+p13Dq4yhSZy4iQJd2LBBjkR
	XAwqsCKZVFAf7/ufAoz81NI12tWvFELNMWC7wV3y3lu8H7a7rEsltB/DA3cAgQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:02 +0100
Subject: [PATCH v4 1/9] dt-bindings: usb: ti,j721e-usb: fix compatible list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-1-5ec7615431f3@bootlin.com>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
In-Reply-To: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
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

Compatible can be A or B+A, not A or B or A+B. B got added afterwards,
we want B+A not A+B. A=ti,j721e-usb and B=ti,am64-usb.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 95ff9791baea..653a89586f4e 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -13,10 +13,9 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-usb
-      - const: ti,am64-usb
       - items:
-          - const: ti,j721e-usb
           - const: ti,am64-usb
+          - const: ti,j721e-usb
 
   reg:
     maxItems: 1

-- 
2.44.0


