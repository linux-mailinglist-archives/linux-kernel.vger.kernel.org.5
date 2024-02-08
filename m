Return-Path: <linux-kernel+bounces-58358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA384E524
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E4A1F2B781
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094D7EF05;
	Thu,  8 Feb 2024 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MVnXw8UC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFF7E769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410424; cv=none; b=obbri0tBT2CoKe2Omr079CDyGKS8LI9G4UjEi8bI49+IhpXc1RSJsRMOaXF3Th34JSucoYMBXuFVLBs3HcnRl9soBh36U3T42iAxf81X12d3HrdobiSn4VYX4l8Rwh2sh19DpLrL5qfTyivrDwLIHI/D5q8LXdt7WdK8rbGoZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410424; c=relaxed/simple;
	bh=OXpJXM5ENIxkUBCwl/xB7oMNxeBAlvJGW9C9NzXiVCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trz/3F09VXuF9WPZM7fmtf8lqm1JQl5xfa1ps5LNMFLTyUxQkf4OgH3SIu1f09Du3oBbAgmJmriOcPvnQlMhbpkFbnx7ScjvjbiUL4ZY4/rhJBHI4NXwGRbqVC1FBByfGiF1F7GjBopogEnO+Y/q/HG/lp0HnoBcESJRD31YerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MVnXw8UC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4103be6e938so533465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707410421; x=1708015221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxuJQNz83Rv9rSn0MovZy25uHrT4R1JS0Xrvo9xnhdQ=;
        b=MVnXw8UC814h62a+82y8G+LfNJ2jmkko+uK84bt57uT+kMZ4yUO3xSF2wzJYoHPj+3
         v5by3nHhSS+xaleFjI2K5E0vt06K7phVFBtJtK94cghFiUF7igCAmTYrd94yyPc+XYEr
         CBCE5LcbA3/72YYyMfAQ2Owj+dKvznjiyL9kipf/4jhUmJ3j8TrIxPbSKZWXnoRsqpGy
         AWGIMVfBtfdQP/EScehaHHtuQDetZ/fLnbUKcMJKqLFhzNP1DeE91iBaR9Zayq/zBVau
         ldmNAq/CkoXaWHpXSAOkzsDETK7itKLh1zEgr0U50RMLnOd2erYlC7/j8lP8MB4mjgv5
         yiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410421; x=1708015221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxuJQNz83Rv9rSn0MovZy25uHrT4R1JS0Xrvo9xnhdQ=;
        b=CZ1G4eHHVPs7KG5THMbhXUPaVHRcL/ks/ILi6XcWTztogWyNKukzt1pRklzdSccLho
         R4RtG6a/xYzF+CwH/1TqlRjZ4wePej0UUq3ILLlW7fEz/Ay+yisTMaKDVsqrVYmJIETO
         w7gEwghmP1uhWU8tYwZLHulTlpdXCfj7C0Je2eCVsD1gvbSj0ftKMIyOaPlI0FBsYO3c
         mZfBkjqfopRssgK9RixEu3ovtx7hg0/aT/HwedcSI6uPe4IDhqH15hUduwEvUZG03lPi
         6grOlJRLo3lxmTq5Unh6myDP6pO9QxozRRbeiOsjIKKZ4tUIMjzY8gXNp/rXUJwYwds0
         YSEA==
X-Forwarded-Encrypted: i=1; AJvYcCWglrLyHyFSVHpwJt8CIJ3ioBXzmnny2o+vQMhfoCUzEUPluuQgmoUS7BFy4cDMDN5bQfdEVfDGek9Um0mrvSqcGRB6fKR2I48hJbLY
X-Gm-Message-State: AOJu0YyGtNdv19A5KTdbCehMn1TWYd3QcpBJ/zvCQcX/CWJ1Q55t5kFZ
	zaOMz8Pj5QsgWu0QsRSD11xcA98JWPb5G4ieWmZtLDUg7r+/R6MjmnzQnhF2IFY=
X-Google-Smtp-Source: AGHT+IG67zzLkDBYUQH/Oh+GXm+5eQ5upBG622C9PYnPayDKwkt63GFHsbuL4gmr6qW8MpMN8bhZdw==
X-Received: by 2002:a5d:4089:0:b0:33a:e9b5:b14d with SMTP id o9-20020a5d4089000000b0033ae9b5b14dmr241wrp.65.1707410420747;
        Thu, 08 Feb 2024 08:40:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB2I3ETg91DGm+JML3ch4l6SiV4VksNtKz2Lhmqdg92oqKC2pFDz3odWZV6cD9nOYEAbmKUITi4dhUBv/RSid1+VbrkPCg05YBK0rw1kQSQ6T8pqSz2T8DytkGU/i8Brb72f721tWyZfZi2fwOKl62KvqVYTAhlfowCrBEk9gaAV0lfx35lKBv9YVamjPxdb4dmvaaPCA=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id s16-20020adfea90000000b0033b198efbedsm3915335wrm.15.2024.02.08.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:40:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Miaoqian Lin <linmq006@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
Date: Thu,  8 Feb 2024 17:40:17 +0100
Message-Id: <20240208164017.26699-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The optional variants for the gpiod_get() family of functions return NULL
if the GPIO in question is not associated with this device. They return
ERR_PTR() on any other error. NULL descriptors are graciously handled by
GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
as they will return 0 and act as if the function succeeded. If one is
using the optional variant, then there's no point in checking for NULL.

Fixes: 6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index edd2a81b4d5e..8a60ad7acd70 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2326,7 +2326,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
+		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2335,7 +2335,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
+		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2357,7 +2357,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.40.1


