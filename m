Return-Path: <linux-kernel+bounces-163943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8278B7662
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32101C22A90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837B172769;
	Tue, 30 Apr 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4d5hDGW"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63452171E4D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481750; cv=none; b=r1fvioOJdeVB38SEPCH2e/nwjY0DagFCO+VQdBIFzXTjWUOhhKAT3HVHd5zkfQThLtv1kV4qY30FtdnGysxNElvRwU52q6etF8v+qQgg+RaYgGRz/awSLF+xD1gW8vA1U6hhwkcHdomHhWKGedZHsrxo2hoKEbmApMQDLCAiyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481750; c=relaxed/simple;
	bh=fECPpxQCPx5VlV9ywdoFmxEqDVmv+UQlkwXRIu9kjcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4c1Qwu6nYrpi1vU2SsKgXo/SdO69DRPBpbGv11KheNddOE7dSfcsmWG+hTzP73IwqMnObQ1JzSOY8HRV5Jz6sNZ8Qh9nKeS+6rhZ8d80poI8LaVDouACrI9bFxziIZhKDPntzxXMZfMjkySmfiQis+ZC5TBvlxhElIxi4zwH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L4d5hDGW; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f056f928eso431096285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714481748; x=1715086548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vGWU+yuHMlxGeQ2v0UxRXrwFtugXz7htO5Olbld0OY=;
        b=L4d5hDGW//a5z9Kf2K6U9z3nrC2F3PyPIABO8Vzv74hD9mWGnL44Da4hx30Y6K5/mG
         U2257tYst1pSmvXL7DY7P7vBIwMimm9UDhr3Iy2P1q6WsyxvcwbXzfiYys0MxJiRMO0M
         aMB9A/iD3cH5WB25FYrNRqi0Kd+xmw3o+i9kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481748; x=1715086548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vGWU+yuHMlxGeQ2v0UxRXrwFtugXz7htO5Olbld0OY=;
        b=lL/h63G1x6A3v8UmN/8NAVoF1RI1MfpmOupSBwm5qxA0YT4AWCkKzb6cBe/xCav02j
         OSGC8jRdclbBXN8Il/Likek1mxOXxVa2bsu0C1s0vPFmc88L8Z0tIClxBjAPeCQKc41f
         IvkRywKdBdKNnlwW/SU55thUv9CKFnUBpcQZazPYbm+H8qlcJczyrXTkbnAZumFIeRHA
         R172E08tiUH5mIuzN9Ck6Tn7S0OJHDhQ3x69mNXkgQOKwcZ5lW+h+RanSKd/elTeij0/
         jZ+v2w2ZaSunQ+y1zSdl+hQT3BI1Fk2MlNY49jE59uFvDtOwLcgoRS0zJZKCtonte57+
         TW2g==
X-Forwarded-Encrypted: i=1; AJvYcCWLUyWZqN78MJkg57nBqHzpN633PvgJOdILygRBGUsonVLYWftEZZt26Ej8PrmsIBKZtR7R596csxHID8BO6NQ2HtwIt74UvifVdhux
X-Gm-Message-State: AOJu0Yzwd+5K5plONLQzhE1fwMG+l9FqFwbJIZ2GxnJnDKM/0fP/6qJB
	TxrODHTi7x94c6kn1AcXkckFHOqcq3ZOiC6S1t5Bq7Dnbh8Tbdpp608Ssksgvg==
X-Google-Smtp-Source: AGHT+IHmc9EduiMj1OpTnvSkXwddOA0ZCHmY0W5Zlq6AnSEMhPm3qZQyuicCrl7kaS0cmeF1jbBCsg==
X-Received: by 2002:a05:620a:57d7:b0:78d:68fa:6e41 with SMTP id wl23-20020a05620a57d700b0078d68fa6e41mr15004216qkn.64.1714481748273;
        Tue, 30 Apr 2024 05:55:48 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a111000b00790f90ffc32sm1553667qkk.22.2024.04.30.05.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:55:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 12:55:34 +0000
Subject: [PATCH 2/4] media: intel/ipu6: Switch to RUNTIME_PM_OPS() and
 SYSTEM_SLEEP_PM_OPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240430-fix-ipu6-v1-2-9b31fbbce6e4@chromium.org>
References: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
In-Reply-To: <20240430-fix-ipu6-v1-0-9b31fbbce6e4@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Replace the old helpers with its modern alternative.
Now we do not need to set '__maybe_unused' annotations when we are not
enabling the PM configurations.

Fixes:
drivers/media/pci/intel/ipu6/ipu6.c:841:12: warning: ‘ipu6_runtime_resume’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu6/ipu6.c:806:12: warning: ‘ipu6_resume’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu6/ipu6.c:801:12: warning: ‘ipu6_suspend’ defined but not used [-Wunused-function]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu6/ipu6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 4b1f69d14d71..ff5ca0c52781 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -803,7 +803,7 @@ static int ipu6_suspend(struct device *dev)
 	return 0;
 }
 
-static int ipu6_resume(struct device *dev)
+static int __maybe_unused ipu6_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ipu6_device *isp = pci_get_drvdata(pdev);
@@ -860,8 +860,8 @@ static int ipu6_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops ipu6_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
-	SET_RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(&ipu6_suspend, &ipu6_resume)
+	RUNTIME_PM_OPS(&ipu6_suspend, &ipu6_runtime_resume, NULL)
 };
 
 MODULE_DEVICE_TABLE(pci, ipu6_pci_tbl);

-- 
2.44.0.769.g3c40516874-goog


