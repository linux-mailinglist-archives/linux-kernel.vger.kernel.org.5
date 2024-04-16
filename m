Return-Path: <linux-kernel+bounces-147709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A58A7804
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC601F2137A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87D13C699;
	Tue, 16 Apr 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbQVd3vN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710413C3D8;
	Tue, 16 Apr 2024 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307543; cv=none; b=qDorFraeFahny9gC5Emtq9wDs6RJQ99EziLBhDon8hmZCO2sv8u07CLlgNOqb83n+K7Ty3uSUPzW9otmU+YpMhPgIYpDPWVL/2OJpqcOrmrtyl2oh+Vpmb9/OhrGHDWyPwmudhManTnbpbFWpxdOcPOnc2kuBGIgi1L4PHywBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307543; c=relaxed/simple;
	bh=z+qmmXpzq6nTSNsqOsbvOlSNaLFSzRdLB33VDRY6Skc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epBgSAv9flyfrdcDz8XK/6u0bnGyxiWmsTr+CNI7R9LqxsiL6AI8Le2VOiCIEbUUx6FWleJYQKbzc9tnLsoOl83YTfm0Uy99/s6Hmd570Btsn7py14nfuLs0ljdgg2lJVyLGHFXnLl3MwXFmXJAkn7czWEYLbhKulp4EQ3Zf9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbQVd3vN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518931f8d23so4009748e87.3;
        Tue, 16 Apr 2024 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307540; x=1713912340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2oCVnQurf2j1hwUUqHHtzxHqRucm9czT99yOLVFDWg=;
        b=GbQVd3vNIg1GIRr+GokkBsiP2Pr2mjuE7nMfrGtl/WFvDa//o+KDqMtz6EE0KTtVQ3
         Dz4+DLcNABEtIps7YPWVXdsmKsH2Fgdx6YZX9L1EyIRRwhLEg8w0KTlj7fnqXar6HigC
         94uumbDTETnXbttGbWXo5yR6Nk8GfiY2OldK8zldN5LUDhdx7FeBBUx5a8Yq6SSfFGIK
         dtuQAkLpPleuczhfAv6g9P22KqFvdiPg8oGmhs85GdwoUHkrYfa13Jxry0XV+FwC/8D7
         OnNeJGZKyiX1AsFgTKJfV1W/xFKg5Y4KOWALNx7trekd/6pHs1WgKDmiODCg2Lt90Qge
         f2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307540; x=1713912340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2oCVnQurf2j1hwUUqHHtzxHqRucm9czT99yOLVFDWg=;
        b=VRnNucS9aa7dYXY7p+k9guixYlrNXy8m00uex+6ClZUaAgggtclLg/iIqaih4DhYbf
         orcbd7dsuMmtbzk4szoLu3reOE3mCQ6jg7MM8fXyKQ6zSDs3/3P2b3uireczflKpAcpd
         /k8GSAcTA0PQpok1U4vrN+8mdks0kZlQxOT4Dfuk2OE/dXSm52ZXhId1e/QF0m1wl8+u
         DttS275P1fAHIh179YFBvhLGBA2LIgHZv/CttPKO/+kzL02EAm+XSRVUPE91ndN9lGCJ
         O3X0nx9MFhwcRSyKm5lsuwy4wdv9P7HUqmc1VGgDw/KHYqpUhXf3j5dBpGMI9ybXlncT
         ujUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDrF8vnMrZnXNmFBs4cxb83bH6aceAKiweYt+aDw+MdsiB+JElpBPxeu1r9NkwvjkvhzY9t7NI1wWRPoYL+Kk4XyqC/md3SCgaVAUP
X-Gm-Message-State: AOJu0Yx9uz3ZGqxb6NfpHTzPgZ/WEX8AatYgaJLgPWaFZ0GH2hTkl2my
	MZnH0zSJGIbxWPoO77Fg2vJhx6qhlnGhSG7OHXyctdeG4mBJtawRmjTzx79NH3U=
X-Google-Smtp-Source: AGHT+IH9kwj7ikjWf34pW3xaEE45/rQHUi17Cm6yPDrloMLFRuIgWvRzdixVmwKSOnEcbu0ZV5LD0w==
X-Received: by 2002:ac2:4e15:0:b0:519:27c3:1b67 with SMTP id e21-20020ac24e15000000b0051927c31b67mr1951572lfr.37.1713307539718;
        Tue, 16 Apr 2024 15:45:39 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id r7-20020ac25f87000000b00516d0029383sm1751908lfe.28.2024.04.16.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:39 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 08/16] media: i2c: ov4689: Enable runtime PM before registering sub-device
Date: Wed, 17 Apr 2024 01:45:16 +0300
Message-ID: <20240416224524.1511357-9-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the sensor may be accessible right after its async sub-device is
registered, enable runtime PM before doing so.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index f0505942000a..ab30d7de5a52 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -875,19 +875,21 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_entity;
 	}
 
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
-		goto err_clean_subdev;
+		goto err_clean_subdev_pm;
 	}
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
-
 	return 0;
 
-err_clean_subdev:
+err_clean_subdev_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
-- 
2.44.0


