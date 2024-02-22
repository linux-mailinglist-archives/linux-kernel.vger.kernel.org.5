Return-Path: <linux-kernel+bounces-75755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE685EE81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9590DB23355
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77E12B97;
	Thu, 22 Feb 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="uXQ3VUqm"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC79111A1;
	Thu, 22 Feb 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564435; cv=none; b=t0Orq6H6WbihIUN1j66VPCOg4uNAgUdY/NWnubwrl098fMMe0Du7V1ou3sbegPlL56Hjzq407a5rhNaKDvF4UwPWaOMkEcfT2WYoPtX47HS+F6WR2gJkf8hHy8GZGcnNRUnOgbRYXGmN/wt6luEJU2KANjpmn1pSRQoym9JUaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564435; c=relaxed/simple;
	bh=fv14EL8qluYJNiBOfMCSkBfAz61U2MfMPqNzk1TJ8ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1eo5W93zpA42oy5Rim/P7PUwDhApSuK6bUnv6rnDbMehFoGaHtWivBp8/jV2kdNbjvFyy6kNI9iZaGtcO9wsmRPr7jdc3rpExMufEJY+iWqbJLQTazwZadTLlXcPq53DjikdgH0Vhc0d314FfsavXFRq/6AQnYPTGD3f6JV+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=uXQ3VUqm; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708564425; bh=fv14EL8qluYJNiBOfMCSkBfAz61U2MfMPqNzk1TJ8ss=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uXQ3VUqmF0IrgPFp4YqH2rt7vLp7zHYe3S/XqSkq1AFNybgFOTLueINq01PNAvfdA
	 rUURN3N9nolnIvHC2RQ1y1dXOoQZSle5xCGV5rq5rUQhe9J+SVoo1qIqMqEhvcwcUT
	 vtNdx7pxKo5XBA3eSc2IpwuDwfABkkbMlgWk4Na8=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] MAINTAINERS: Add an entry for AF8133J driver
Date: Thu, 22 Feb 2024 02:13:38 +0100
Message-ID: <20240222011341.3232645-5-megi@xff.cz>
In-Reply-To: <20240222011341.3232645-1-megi@xff.cz>
References: <20240222011341.3232645-1-megi@xff.cz>
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
index 9ed4d3868539..e027d3ec3f8c 100644
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


