Return-Path: <linux-kernel+bounces-135209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7F89BCBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654A01C2232A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11352F82;
	Mon,  8 Apr 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T6BofPOC"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134B524C3;
	Mon,  8 Apr 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571222; cv=none; b=QTJvah1Cj3pVocAHuFOY+hDw1ffFCG8Tt798BwBc2s3kiPFc3hEk01pYHG9Oi9m7aTa06sQshpi8u5Sl8HV+kPm2YpnwSjXwJ1fZhDgYI4nmI+suQc6rEWtMtnhK6YPhj2jtNuACnsv7JDdRShKzyKniIS1n+M8hhzOYayKDIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571222; c=relaxed/simple;
	bh=f01pXbgO2GE8Kb9yOfxrCA7cA980dnsTdUB62TMsnb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GwIoMXEYPz+VgcmUtft/Ai5fPo6cP9CDXm+cLaMKE8TIYowxiMAbV4h/JjCZSdQLV4KfUbPzcaXelFt25xQv8Wh6KTPE9BTwnOvD1hqSAwuhQqxYBTDW8iqc4oi/tqjtDG7Ll+KwTaZCj6XmyFx2/LM2dtjAIWT8982TKSqYhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T6BofPOC; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69A441BF20B;
	Mon,  8 Apr 2024 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712571218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQDs+Tl3x58+cNAH6xzvpVIo+0vY457yGgBc+Uw2j8E=;
	b=T6BofPOCSt4jnPMcX9odySe2+Da4oobDxbKryWwQljBhaMUuqGDHcp03ZjYBVYz1JR0oIH
	xTBZVoPsN/6Q2VRer1QN219npjmyCzZVEEgrwJK4NlWPUswsQIg5m94AxwKK3URO3/FrdZ
	cXCw7fEccGAx9K1mJ8NB6gIUXkITO8EW9tZSnfW94c/Mv5GN/TOuG7qdA5HTYouIUXsWAR
	fNgLsacNpTBIyhMxxh/XGJN49/K9VLYQ2ge1blI+lrACrAkPQ41MmRICOYuVen4ckNqGum
	lY4siKjgO6kNvck79O9PMrGOw5uzntnyPpUY8SfVlVO81lcoRBEpO/z88YZtyA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] MAINTAINERS: mailmap: update Richard Genoud's email address
Date: Mon,  8 Apr 2024 12:13:29 +0200
Message-Id: <20240408101329.9448-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

I'm working now at bootlin, so I'll use my bootlin address for kernel
development from now on.

Update also the yaml file for atmel-serial accordingly.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 .mailmap                                                       | 1 +
 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 +-
 MAINTAINERS                                                    | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8284692f9610..71e28f4e0d4a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -524,6 +524,7 @@ Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
+Richard Genoud <richard.genoud@bootlin.com> <richard.genoud@gmail.com>
 Richard Leitner <richard.leitner@linux.dev> <dev@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 65cb2e5c5eee..eb2992a447d7 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 maintainers:
-  - Richard Genoud <richard.genoud@gmail.com>
+  - Richard Genoud <richard.genoud@bootlin.com>
 
 properties:
   compatible:
diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..0dbdc81e46c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14363,7 +14363,7 @@ F:	drivers/dma/at_xdmac.c
 F:	include/dt-bindings/dma/at91.h
 
 MICROCHIP AT91 SERIAL DRIVER
-M:	Richard Genoud <richard.genoud@gmail.com>
+M:	Richard Genoud <richard.genoud@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/tty/serial/atmel_serial.c

