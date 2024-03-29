Return-Path: <linux-kernel+bounces-124168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD96891354
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487F91C224AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA213CF4F;
	Fri, 29 Mar 2024 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp9LJB6O"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3233E489;
	Fri, 29 Mar 2024 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691097; cv=none; b=ExDOkeJqmbjk9Hmd+WURU7F6zti3U2ygGL0IY8fXj8LdqARWyqf/nVrZNpu8bvg+4wVAuGKlX2IMXemT+2r9QQGHvIh/NoSjcIx0zHlczdjiGBr5tAMIPAVQQ5FK6bHOLDlsuGLrpadbI3IgrlXAn6uKx6o4IMY+j2Q4Q+4Z5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691097; c=relaxed/simple;
	bh=Chsh0Y6imvACPZqM0aZBL2mZYFk82NHt7OzDTWuPeoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ht9jvZQbb4+FF0eM28WvXv8AISRnvCR8KeamndUllONURgDW67bYm0dq5wh1KhId956D9+tcwZVAK1+W631dl6yswr+u0tigGwV+/iuKgpHsxjpwU1OJOuKmxl45vxTOuuD3rpL2FYWd0KCSF4W47b2sceKvSY1hTbNNxoSJXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp9LJB6O; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c3ca3c3bbaso1006470b6e.0;
        Thu, 28 Mar 2024 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711691095; x=1712295895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwjYyV1xedFSqTP36VO0uSIhJUQea6nzzcBnO8oLakQ=;
        b=Kp9LJB6ONOeza7po2PGAel2RM+8n6GOuKYvMUnXl5VvRFRd1GE1Nkb0EJtQ+MYsHwo
         Kgkh3arvkUmpVPyHyolattScXqqDGbske2QK3/7T95KvDBXEVgb5F+17+SonfYR1iNLa
         wYca7ukIp4xZcYoTRYC+Y5wRCA0JfXq/W3c04XF/Xo0AqkupQr3B58HlY+k0LHm8HoMC
         rOoHvIbgvr0VtDe6ajDhcrXNpMMxY73KpJOIQgCQCqL8MNtzbsBT4KGSvgeNTf93XCNV
         x7bdt6orHqVlZ+YyU8Xtu4f/zkxVdo41BmPpCTRexiC9QQIqHFge8ilh/m7dERLvTukf
         dSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711691095; x=1712295895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwjYyV1xedFSqTP36VO0uSIhJUQea6nzzcBnO8oLakQ=;
        b=YYUiPEosnR+pL1CsfVYNbfEIP4Zxnl3G5QPzilanJhsqGAyebomryiZR4wL+qgPrHm
         XKam8NcMswFL6x+7xOpW59bKLBDIBtqUO5uVm8Ad5K5AySn/lLfSYh77Un+q4eFrZRlD
         y4VoI5wV/Y79EnINGW1Fuw3S/zYt2luRQhURM4DtHOQIRN5Haqgx77GqCGGYbeW94JAF
         6we2/8AaGAujcJMUjXbJXCQLWYyTNS26JpMOlXQ7gxt4HddVDt0v2l+u5fNunh59Yqxt
         CDjaQC1SyRbpLDiFmRGD7qwIzlrE1JSrYZmB1h+LxZDjpjkzoE0xAkkSQdwWi5Lwdw8a
         kCLg==
X-Forwarded-Encrypted: i=1; AJvYcCUwxh0Rwy21EmJc7qC6Cs8ug/71QTOyaEQUTrlY4c64YODmcfgSi9XVgHqevUVTB5vquDyWVy3STsF+IL3a2iLpdDmP/WvIXcqp4ydKVQ/Wzb13oM7IVym7INmEipz+mJ7ldB1Am/Wrl1E=
X-Gm-Message-State: AOJu0YwHelT+vhUQEJ+pKjGQutwriwB3sf4ohjWkexM6h3KpI9XNQr07
	tzZMr1ts3YrhvTNBabyuqVXYYMXGyRXMQHmN+sy7UJTPxwG0lyH2
X-Google-Smtp-Source: AGHT+IFDwMv1sfBpVAUxu6Mc2Bi3QSJQkBrer5BK2llVjxSCi4SL/46S6aRYY65dN4uWzKxG3Vi07A==
X-Received: by 2002:a05:6808:211f:b0:3c1:c7a8:5ede with SMTP id r31-20020a056808211f00b003c1c7a85edemr1577604oiw.46.1711691095092;
        Thu, 28 Mar 2024 22:44:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100f:826c:582e:d62c:addc:15b1])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b006e47e57d976sm2315495pfn.166.2024.03.28.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 22:44:54 -0700 (PDT)
From: coolrrsh@gmail.com
To: slongerbeam@gmail.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v4] staging: media: imx: Remove duplicate Kconfig dependency
Date: Fri, 29 Mar 2024 11:14:46 +0530
Message-Id: <20240329054446.33523-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The kernel configuration VIDEO_DEV is defined twice in Kconfig.
Thus, the duplicate Kconfig dependency is removed.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit message
v2->v3
changed the subject
v3->v4
changed the commit message and subject 

---
 drivers/staging/media/imx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 21fd79515042..772f49b1fe52 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_DMA
 	depends on VIDEO_DEV
-	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
 	select V4L2_MEM2MEM_DEV
-- 
2.25.1


