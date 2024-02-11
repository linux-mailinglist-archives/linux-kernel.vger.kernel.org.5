Return-Path: <linux-kernel+bounces-60957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BAB850B90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6BEB224BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F965F876;
	Sun, 11 Feb 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="dmzPbnUS"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1595DF09;
	Sun, 11 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684744; cv=none; b=OTuOJy04TFg3bxQKufFUUbgINPYaOBjv4Uwg9kvplyqyxUsxCndHn14UE1aJhKr0hFHS6/JTUY7nEZIbsn696mgWkCPU2LE8Ke/PzLgU1z5KZxxZA0oU/ZnbMo5+cLGnWrSX40O60AN8Flreth9l+HOC+OFEpwZTmRzYqaE5C4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684744; c=relaxed/simple;
	bh=w4dFeJN6ekT4fZLMgY0MSjyE6BSqXIkBWnDC/steBeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igJjiftaCU3tywFDJpzV99C1OXbVupXm/A2NrvomezLINg0Ok71yBpKA9K/sA7j0HX+9aVxp0wbBZDu1CsXE+wu9OKLXRTQD+LJkvp8lm/ExSopw/26U3oDr922TRl1aIS+ePkwUQilRF12pVqdOI+EHuI7TfZy3ApHb12kjHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=dmzPbnUS; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707684739; bh=w4dFeJN6ekT4fZLMgY0MSjyE6BSqXIkBWnDC/steBeE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=dmzPbnUSBN3rAZwsOXvc/kuP3DbzWzuU8f2O5UamPg5Fc1RazlMXoyFd7M1trUqUi
	 75UG+FaleqqPP0yOWPlNQ/llBfxEU3g60GCK+q7CDDVSInLXwae9sEfZtYa9ENSW3t
	 UQHHXT/OMUIr73IFC1CCh1y4Optr4iI5l3BXQIsI=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Icenowy Zheng <icenowy@aosc.io>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MAINTAINERS: Add an entry for AF8133J driver
Date: Sun, 11 Feb 2024 21:51:59 +0100
Message-ID: <20240211205211.2890931-4-megi@xff.cz>
In-Reply-To: <20240211205211.2890931-1-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

As I am submitting the driver and have the device to test. I'll maintain
the driver.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc5ca7a042b5..cc691f61a77e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -579,6 +579,12 @@ F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_i2c.c
 F:	drivers/iio/accel/adxl372_spi.c
 
+AF8133J THREE-AXIS MAGNETOMETER DRIVER
+M:	Ondřej Jirman <megi@xff.cz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
+F:	drivers/iio/magnetometer/af8133j.c
+
 AF9013 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.43.0


