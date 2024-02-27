Return-Path: <linux-kernel+bounces-83605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF85869C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B0B33AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8E210E4;
	Tue, 27 Feb 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Faq9Y1gF"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB01F947;
	Tue, 27 Feb 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051450; cv=none; b=fh7WmszSHWCjw6qnPkOPFklVePfMMM5JhYqiuTXrT/KjCqjNzVwRkC93eiNUNXqNg1pHGUYppy4GESX+qGv81jwexhtKzwYV7QNNOnNJ3+0IPRRSdTJF10u94JvQUOWdhgxBtkF0tnTjGCbCPe0WP4kDaqVegtoiAEIBk6Mb4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051450; c=relaxed/simple;
	bh=7UWytEjpvnuf7HyU7fycSpNmZ+Pkvdxbg2+CIsFkOyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uy3905XSANCKDQh2eJNVJ7n5RB2gzdObnPb9EFyfBy/ezFHL9j+mLtOsaZxASSXPkFXtvQkZormahr+6h3o2YM3vjpVkYWvqvB4lSM6+YqTymDGAfXcYva7bSleYNpX3L4GgBUH/vcM4XBTd7V9Iaq48XU73m4GXC9zINP6eUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Faq9Y1gF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso70362111fa.2;
        Tue, 27 Feb 2024 08:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051447; x=1709656247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DNzd2Y9Nsj2d3D65u6Z6DGyaZKDh+IjqLbOArWV8kY=;
        b=Faq9Y1gFbR/wYpyoLPW5qvPHjrgaMObNHhSgcgt6WaPaPmulylZL9q+KKp2cmCelRo
         RzFYdXKOb4WhFNmw4su4/l7SOg+1BF9gJCcFp4N3N/XJf4vAna8Q7WuXjFfdN4RjfWKO
         BxYwqepOtzxL0XdAxS4i81/ycuaE/ss7ofCaMK7EonJjAgsFUixib6rYmArm2cNUmV1l
         f7uDr7op4kz9yiRb8p7ItfNgs5NdsK2p/x/zcYQStDtH0Eff5cRCGq9+DdrmhI4Ju2QE
         7AnOh4lebDOlQoVGxETKr3dkFPSNyeY9pu4egqhnH9HVA8vAz85fKxIL4Cx1/MpeFRZ1
         CSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051447; x=1709656247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DNzd2Y9Nsj2d3D65u6Z6DGyaZKDh+IjqLbOArWV8kY=;
        b=FusT7Yrq2y/igUHX2zTBZAliD7vURfPp3/bo2onO3BbaeTooslOVMZ7ApvMgYaO4Qc
         SZS3W3yZpNc/9ghe0ewGu0dVjnILXxtu6z35ddG0RUKspEnGnQfN+yLrgLFfnu+eDHvM
         7VgHiIDaypY10xwSkWOJQ4HhFf8MX6+HF1hsGcpJv3C5e1raWvs3P8DufaUjXC+Ce3gC
         4DsdKsnxP6X2YvSAh5QRnBgZT3W0K7Rz7fnCRZVW0w7t6suD7bT/hEf7RH15iILtleFN
         HnukE9i5WYLOOX2eAmgnOtMM3yK+3a5a5fl0hGOxfTLB6NrFemxrw9zza65trcuScH4o
         2QaA==
X-Forwarded-Encrypted: i=1; AJvYcCXzB0Vo7rKP4EAejiRx9PGmi6v5H4DwkBUCNQGgH4ZuPuxG2pyBfKPQ5ERsCejqx/W9K765LaXkl1LQQ8Lc4qAFy8u2XJJuumn/hG5wi4i4Qd5mlNWrAKPuHeam/GMqmpIBkle/x97beZs=
X-Gm-Message-State: AOJu0YxiMrO8ioKReC8zIAdFpgwysU6DnpoSky7JZ+n0pyxTjx1fUSPl
	CcemUM7zgEd08oqXpOGPY74FM4JGVP74C5IcR+h8sPpSkU86zBdl
X-Google-Smtp-Source: AGHT+IFZISPRXql7yR19T4+1+qCYS8CjAfn3WPW92vxe0d6OZiu78rXX0C72mM0dLUkT/wBEGqAs6A==
X-Received: by 2002:a05:651c:333:b0:2d2:3f13:52e7 with SMTP id b19-20020a05651c033300b002d23f1352e7mr5940035ljp.12.1709051446802;
        Tue, 27 Feb 2024 08:30:46 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id n11-20020a2e904b000000b002d0b6eafa8csm1300712ljg.39.2024.02.27.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:30:46 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/3] staging: media: atomisp: Fix various multiline block comment formatting instances
Date: Tue, 27 Feb 2024 17:30:41 +0100
Message-Id: <20240227163043.112162-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following fixes:
 * Reformats a number of multiline block comments to ensure * and */ align
   correctly

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 .../staging/media/atomisp/pci/atomisp_v4l2.c  | 34 ++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index 547e1444ad97..77809e88da83 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -78,13 +78,15 @@ static char firmware_name[256];
 module_param_string(firmware_name, firmware_name, sizeof(firmware_name), 0);
 MODULE_PARM_DESC(firmware_name, "Firmware file name. Allows overriding the default firmware name.");
 
-/*set to 16x16 since this is the amount of lines and pixels the sensor
-exports extra. If these are kept at the 10x8 that they were on, in yuv
-downscaling modes incorrect resolutions where requested to the sensor
-driver with strange outcomes as a result. The proper way tot do this
-would be to have a list of tables the specify the sensor res, mipi rec,
-output res, and isp output res. however since we do not have this yet,
-the chosen solution is the next best thing. */
+/*
+ * Set to 16x16 since this is the amount of lines and pixels the sensor
+ * exports extra. If these are kept at the 10x8 that they were on, in yuv
+ * downscaling modes incorrect resolutions where requested to the sensor
+ * driver with strange outcomes as a result. The proper way tot do this
+ * would be to have a list of tables the specify the sensor res, mipi rec,
+ * output res, and isp output res. however since we do not have this yet,
+ * the chosen solution is the next best thing.
+ */
 int pad_w = 16;
 module_param(pad_w, int, 0644);
 MODULE_PARM_DESC(pad_w, "extra data for ISP processing");
@@ -507,12 +509,12 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 	}
 done:
 	/*
-	* MRFLD WORKAROUND:
-	* before powering off IUNIT, clear the pending interrupts
-	* and disable the interrupt. driver should avoid writing 0
-	* to IIR. It could block subsequent interrupt messages.
-	* HW sighting:4568410.
-	*/
+	 * MRFLD WORKAROUND:
+	 * before powering off IUNIT, clear the pending interrupts
+	 * and disable the interrupt. driver should avoid writing 0
+	 * to IIR. It could block subsequent interrupt messages.
+	 * HW sighting:4568410.
+	 */
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
 	irq &= ~BIT(INTR_IER);
 	pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
@@ -525,9 +527,9 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 }
 
 /*
-* WA for DDR DVFS enable/disable
-* By default, ISP will force DDR DVFS 1600MHz before disable DVFS
-*/
+ * WA for DDR DVFS enable/disable
+ * By default, ISP will force DDR DVFS 1600MHz before disable DVFS
+ */
 static void punit_ddr_dvfs_enable(bool enable)
 {
 	int reg;
-- 
2.40.1


