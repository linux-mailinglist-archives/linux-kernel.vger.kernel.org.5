Return-Path: <linux-kernel+bounces-53806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D928984A6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B301C26709
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA883CF58;
	Mon,  5 Feb 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/DAjPvG"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B14D5B5;
	Mon,  5 Feb 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160703; cv=none; b=LRso+KfPSdce8rob86tJPBWHtk86h1SiMQHoV79Vpf5rCD4Nw3/+153QLTHOg2bzAxaEglUgksgiFJ9vl5srNTRIdeG9X4YOb8OtDF4JsbGvHEEBt/XH1pt6LR7guO0ofKpSMYpufXSWPjMZTJ7UKiiO29Zu9sbUhbKS7YmjgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160703; c=relaxed/simple;
	bh=CDNTWucJRN0r0wgKqo5XyZ/qBIWc6fFcrCzdkqZeMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byWMkl+pJrsVtfG9vXKsuFRYMlcWdMSmGpPfdg2/k4YynRJMwZdyUkowuR99T0/1TV4m7d3e8nHTPLX9kANptrsktGLnc9msFkk1uOHmptpux0esaPL2FRi0RFZGUvsTgMA+T7WKjTc9ySG+xjVzhyHeOOeLORBSCK/pcRlJuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/DAjPvG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51149561a39so2014136e87.0;
        Mon, 05 Feb 2024 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707160700; x=1707765500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuNWF46JFf3MlfJFwAYp5tNA2d7ETGv42lwNVneuKvA=;
        b=H/DAjPvGhpEbJblI4pUylSYXMKxHFIQ3hQBj89HCGhN9DHPjiLRxcf434wLYGJ2DN3
         Uif0JQqcwTONNknikRj2JIp3iffGFRg7LhMBb8Iwh44z28B+usMHHsJtC6wcst0ayq5z
         ZONWE0lxpnFrrUwlJaJMDXnwl8hPF8YtlthalrwXzmICX389qew26nmv0gM3D/l8Yx+U
         OLxcFLEcdX6DPDzWIkQzBP6196Ykuq7E3+ehRYDpMpADVkhRj/noHY56OCPsY52XSdeo
         AVhqjb/xjIeNOVEfgxh/m7jTZDsdMNz6hvsNnhDgMAc/6Pdcv28QQ61TF/UuSMwCpu5V
         S7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160700; x=1707765500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuNWF46JFf3MlfJFwAYp5tNA2d7ETGv42lwNVneuKvA=;
        b=biCEY2PEnDr8v3u7IsGW2IbHbbuUa1nz0wuUpRBPJPyCXMadLfMaIzj7qylOp+1DjN
         ozIQZor2t1XnmYq9r4foyl5Iog41SuxebYmqLq2L6roCsvFvr1H6Pp4b17ShoflBMI2D
         +cwaJguhOttEyhBAGsc+6v5t2IqKFpDSnXxCUZkkHIrEZCzpXB0We9r39402/d2kT1te
         9u2egyIlt8NlK0lsaGIjAbyTwlvT/c3p7LY2Wr2ldjLl/PTuCM2Lcj0yqqPwmcLkDqeC
         sxlgTHaOxYvBIz8UexQUHc0d8zHYoNfIV3bwwLyx/fLHte+dyJ+bMxJmiW9i1q2C9uH1
         zPRA==
X-Gm-Message-State: AOJu0Yw2me+o2HaRv3GtlGpRek/LixVYsenWg3mgsWSTzIH73mKRrHSg
	Ounli1FUZ1gjuwhoyia4l9+JXYW/tK1cSwseHDp6rg/2QvrkCtc=
X-Google-Smtp-Source: AGHT+IGT2PJNjUilmVD1j7lhhQcNN8A7J1cOjksKTPcQ6cCm0LNK4v06cdNUyonWVHxHvuiUG2OrBg==
X-Received: by 2002:a19:7502:0:b0:511:4a03:6b5c with SMTP id y2-20020a197502000000b005114a036b5cmr405434lfe.14.1707160699537;
        Mon, 05 Feb 2024 11:18:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWETNXcfCkJkwVTvc7GfNxv6tSBKxz5xuYUHWGgnD3c4Xqd5AyndbskdIocEuo79oqS5bHJf9moKWphdta5hZNPJJRRpbM+eW1lasGkL8Q6AhUw8ybNKyMYmenqcVKwZ/GlfV7cZM2OkYrayjFKWC1eyFEDLG04KxuxAg==
Received: from frutis-latitude7490.lan (public-gprs393011.centertel.pl. [37.47.166.116])
        by smtp.googlemail.com with ESMTPSA id e23-20020a17090681d700b00a3717f96e6esm159096ejx.171.2024.02.05.11.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:18:19 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Date: Mon,  5 Feb 2024 20:18:05 +0100
Message-ID: <20240205191808.998754-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add compatible string for Qualcomm spidev device (used for QCA4024).

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 655f2c959cd4..00bcb77ee597 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -710,6 +710,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "spi-authenta" },
 	{ .name = "em3581" },
 	{ .name = "si3210" },
+	{ .name = "spidev" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -734,6 +735,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "qca,spidev", .data = &spidev_of_check },
 	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
-- 
2.43.0


