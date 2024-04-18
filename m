Return-Path: <linux-kernel+bounces-149338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A85B8A8FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DFBB21C16
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCE64B;
	Thu, 18 Apr 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cksNc7Nd"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBC4A02;
	Thu, 18 Apr 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398725; cv=none; b=tySAmW7sEG9daDGIZfUR26BBbBJglWlhmU1Rz3PA0hEnmDiiOz9OX6a/5dQ0IPJXL0XmVpdQmD2euX8QG2d7AFElzy0jXEfgKn8yapJv6SmGXpMkgdt8XGuoDcwlGcUR3AgoCnjA8fKz1I5SXKdCPkzrFl+M68muQRCu4pEHb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398725; c=relaxed/simple;
	bh=yj/sYzJ2Jxp+y+6KcxbcY/KqBOzuG1tsZ4AJilTQtew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btJDndRvu+kdOVsKUY8Fm5OPdSUYVbHPl+xFSdw9BHwaNPx4e0Cfq8o3kLvXUw+rulfSceCWmWNXLpFLQ2OnUmsPpI8EuBI98M42v0A66B9WmGxASQF+bQqiXWX6es+cWk0Qsb0fjybfxgvPgIynwz7OpfL1CQXr1uMHkHZ8GzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cksNc7Nd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36b08fc1913so1150435ab.0;
        Wed, 17 Apr 2024 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713398723; x=1714003523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lw/eo8vYS/jr51eHoroeN5VlW5AAoYkDX60WZMmgGs=;
        b=cksNc7NdjJeEBrXt8Mizfa2duojUBbFDY+3C0OEHG9/umObsFfggxaQPE2iVWoOdRK
         YG5jVgzIp9E85DbSplnWXdZVRR5cDiTsE/+B50gUAZm19DfnlEYgHeYdE1Ua2s7u6pYs
         G5pz0PPatXJKS5fas44mDgs++rJSpkV7nnY5k2QIGx3tiNCrsMtiX25CgdPlyB6y4cC6
         oNk0X7mPrmBpyIau3O8OC5mjOVuuFHOBXMOEsZmc45yglmFT67Z0RBDRxPkbUROwN862
         sga0N/cnMMbi/EUYsqv3ta6VCW58HQl+qyln3cdxES4yY6HRQCvnts9nvULxTWkflRcd
         Hxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398723; x=1714003523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lw/eo8vYS/jr51eHoroeN5VlW5AAoYkDX60WZMmgGs=;
        b=PIMJxbvayox5rnvfQt/ghPWheRKbCqlbQ7RdO39mMhcLkMwgezX7vsxnhsfSKWM+Pl
         VXx6DFEwzCUM2/HwHNZiAzWTrKA+ZBA/k5OEu/D9+Ud1/zVFsQ9jJtIRnBjH9KRmegnM
         gAKw7Z4yXiIuGpFZaE6kaK8jMt3mvgC4CK2PRp4kpxo5MfPxlCo/A0AoKRtPwZDrOtE9
         qXm+kPY+4fDjtdSRZz3xhiPqEqCAF/TYbzJvF45ueq81GynDclyhloyzceti9cMh5T1F
         HhZeXS52fxHnDRi5D1HWatLAvJzN8dxXQvj8/4+lnPqmK9/OpfHQjZQs5xknX0gcR/FY
         AY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCViUDHuG+LRimVed9TyNwDZuYHuxx+sI4H++heCgq7qNGjnA5JBaHJEmcQNP7GkrxA4BbcAeJxVzlK8b/CXomqyNB0H8RtkceSeXY5ZlQCSwQGGiNUP4tO91SPxZFon1woqCQt4E0gE93OTs9DgeMc=
X-Gm-Message-State: AOJu0YzGd52sdx7y6bQgM7ysepPhxbZdBsigwyzjoFK0UJOxXAUt2otJ
	EwM5Yf0hdvNFSbS4SYyw176uklZJmCXbyFxVBGQ1zrRdopVMs/ES
X-Google-Smtp-Source: AGHT+IGOWuVeNK5n1yJtOE4vhdXiU4Ah+hHLYIlOUB/p61hc5VYbJesLZUvdNIwAU0mwyRjpJLuSVg==
X-Received: by 2002:a05:6e02:1d05:b0:36b:3024:a4da with SMTP id i5-20020a056e021d0500b0036b3024a4damr917731ila.3.1713398722906;
        Wed, 17 Apr 2024 17:05:22 -0700 (PDT)
Received: from shiv-machina.. (c-73-169-52-138.hsd1.co.comcast.net. [73.169.52.138])
        by smtp.gmail.com with ESMTPSA id ix10-20020a056638878a00b004830f829b86sm90127jab.133.2024.04.17.17.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 17:05:22 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com
Cc: linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shivani Gupta <shivani07g@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] spi: spi-s3c64xx.c: Remove of_node_put for auto cleanup
Date: Thu, 18 Apr 2024 00:05:05 +0000
Message-Id: <20240418000505.731724-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the scope based of_node_put() cleanup in s3c64xx_spi_csinfo to
automatically release the device node with the __free() cleanup handler
Initialize data_np at the point of declaration for clarity of scope.

This change reduces the risk of memory leaks and simplifies the code by
removing manual node put call.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f726d8670428..833c58c88e40 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -950,7 +950,7 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_target_ctrldata(
 				struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs;
-	struct device_node *target_np, *data_np = NULL;
+	struct device_node *target_np;
 	u32 fb_delay = 0;

 	target_np = spi->dev.of_node;
@@ -963,7 +963,8 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_target_ctrldata(
 	if (!cs)
 		return ERR_PTR(-ENOMEM);

-	data_np = of_get_child_by_name(target_np, "controller-data");
+	struct device_node *data_np __free(device_node) =
+			of_get_child_by_name(target_np, "controller-data");
 	if (!data_np) {
 		dev_info(&spi->dev, "feedback delay set to default (0)\n");
 		return cs;
@@ -971,7 +972,6 @@ static struct s3c64xx_spi_csinfo *s3c64xx_get_target_ctrldata(

 	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
 	cs->fb_delay = fb_delay;
-	of_node_put(data_np);
 	return cs;
 }

--
2.34.1


