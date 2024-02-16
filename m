Return-Path: <linux-kernel+bounces-69205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A48585BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9C11C21544
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD263135A6C;
	Fri, 16 Feb 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="vAWv73XJ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91501353F0;
	Fri, 16 Feb 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109421; cv=none; b=G1aJVX7wMLnX+b1CtfI/NYMMm9wPHjUmB6aRcxr8ORDMoSc1wFU8AuIuAal04BYH/bckNKp1yR+/GZWIR+t7PELRz42/kVBPC5tdUqhnX0O8O2e2Y43FQz5D09yhMuEkJuNqEieEmnK58bjoneOcMjn7ZbsvGYHg6clu69beY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109421; c=relaxed/simple;
	bh=ggOOHXc5HreBSJwVQw7MwB2dcdf4Tv7xliEtFE73NVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvQGi+7jwXMWPZP1lxRiCi2fJcvmowtWOHkD34GSb41SZ33dshpCdgIgp/ZKwIZX0+A4SyA6/QFK+FAgecjg2JiJ8meuFpgnU1DyTEFQ3k3YIW3VU+I05OJ0Q3fByuo3A3cnhq03vQu7NC0x/v4g1PLHSi8D+wtJKUeTE2BouP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=vAWv73XJ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708109416; bh=ggOOHXc5HreBSJwVQw7MwB2dcdf4Tv7xliEtFE73NVk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vAWv73XJ3heeLQdQH8c+ATkeeCIBM1v4II1JHlPiquE3eJtbpVdSD6YUunhoxubXu
	 WjJNSc2aUu0IL2TajFNut6wWCRP20Dqm89Xio5rC5dVxgkliYtytNX+0Rx3hsc7XOu
	 Ua7g8gDdWM6xo07h9ONowM9ixxxCjixRTNadlmc8=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: Add an entry for AF8133J driver
Date: Fri, 16 Feb 2024 19:50:02 +0100
Message-ID: <20240216185008.1370618-5-megi@xff.cz>
In-Reply-To: <20240216185008.1370618-1-megi@xff.cz>
References: <20240216185008.1370618-1-megi@xff.cz>
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
index 73d898383e51..67f4974ac803 100644
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


