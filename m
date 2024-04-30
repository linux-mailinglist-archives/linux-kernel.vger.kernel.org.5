Return-Path: <linux-kernel+bounces-163500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DC8B6C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256B71F21923
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC1946551;
	Tue, 30 Apr 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cz1p0bF0"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305F43F9E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463495; cv=none; b=V2Z9iGjYL6cxBe623fpTe2LJ/6QpCl1TKlGslH/BuC8uLGBH4j4t6wXh7lcG/PM+VKbMr/HwY88UDvmJGcj96OI65qyRykXa2OABuhWBRqTRrlyjxgOwtm6EAxdQvjh3r/w3/HTOw43aWaWfOyI7CF6Sw37wvqipt2iKSRHkhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463495; c=relaxed/simple;
	bh=0jzk6sPYQEC59SApxornkivyRflmoI1pFn43nf2gouQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSRfbqlKkYAFv9p1FjxzAaOLDQDgpFCckDC3cD80oLjAcdlJF+8w5yhSBCSMFYZOJzQoYPLHANwFLBhj/kI5wCBv7vl8x5Qvd/oYzysk7M8VHdSnSLKbp02CSORoxucKR2yUshig+ewF6NJc1ST1egYErkpDohiVnx8RhlYHrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cz1p0bF0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-436ee76c3b8so42463571cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714463492; x=1715068292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R57CjkbkLkl8A/VUwKtkzF9x/otNALa5HeVqDryNHrA=;
        b=Cz1p0bF0cZvCsMjrTIPFVt1HLmBH2HIu0+NPp5S5+5XMPA6hq/jvHGd2sbCx3WW4Cw
         WayJuW+VPXpMjYTkZ8IckXhTb11K5TmkYfrZWHGhGHVrJ751HsA//31qXDOXEoijddfz
         fti++wGjM8MPX4Ysf9zMhlXke1d+6Mr1Urp7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463492; x=1715068292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R57CjkbkLkl8A/VUwKtkzF9x/otNALa5HeVqDryNHrA=;
        b=E3anGzaXMNfhjivBMgJcNJxtj8382uD7+MOlSpmpjcMQgSDeyzYyX9q4RQyt8WHW/h
         blQ6BfuriKD55tbOd8c5Cr6DvrTd8ct/lLHJFZAd/kWbWOmXNLMxMt+jjcI/evGOeEAi
         dcRmc3R4YbyTVDz6Tu24PH0mEg6Nk0c+jZAZVSoB2/r67ix7i3327kjBoZASukRAgoSr
         xKcQj4qcmNRalhtiZxAsQ24Y8jWJ91m5CuV08PVUUAHlk0lN4vhePski1FCeD1AL1rFd
         W9EeGni0iVc/NYMzt4gSkoz7BocY8jfkflEUQ/OlnbbQoKyAnKSkgp+jBIH03Vf5RYYs
         6Qcw==
X-Forwarded-Encrypted: i=1; AJvYcCUYWlAi5G5qzxnbdE0a0XtznzexxoKRyci6Yv4CoWuihFITQHRcNU6L7FHxtx+LwcuFlH5SgLm//EiZAxgpEPhSpatwDM/w/7PnyCVA
X-Gm-Message-State: AOJu0YzbEliNXCoOnVRi4EQ/hinLRcS/ZYohhwPkO7xmh1urlnvGdOHX
	nLs873cWbCHG6LSDYYhhvsyoPIPgUFqLvUzpkXSUjnR2rxK0OsEP973QS+VONg==
X-Google-Smtp-Source: AGHT+IFox+JJPaIDfnbJPXdvKCOIVMCsX59wRzBpWnMawbJcnJD3u85NhlKUJm+Q/1EmXzvmqcrFDg==
X-Received: by 2002:a05:622a:1b86:b0:43b:dd6:82c0 with SMTP id bp6-20020a05622a1b8600b0043b0dd682c0mr3500422qtb.33.1714463492092;
        Tue, 30 Apr 2024 00:51:32 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id z11-20020a05622a124b00b00437b4048972sm10634547qtx.18.2024.04.30.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:51:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Apr 2024 07:51:26 +0000
Subject: [PATCH 1/3] media: bcm2835-unicam: Fix error handling for
 platform_get_irq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-fix-broad-v1-1-cf3b81bf97ff@chromium.org>
References: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
In-Reply-To: <20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

platform_get_irq() cannot return the value 0.

If it returns -EPROBE_DEFER, we need to populate the error code upwards
to retry probing once the irq handler is ready.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index bd2bbb53070e..2a3a27ac70ba 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2660,9 +2660,10 @@ static int unicam_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
-		ret = -EINVAL;
+		if (ret != -EPROBE_DEFER)
+			ret = -EINVAL;
 		goto err_unicam_put;
 	}
 

-- 
2.44.0.769.g3c40516874-goog


