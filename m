Return-Path: <linux-kernel+bounces-135585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCD89C7FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9A286374
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA913F45A;
	Mon,  8 Apr 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIDyEQWV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306413F431;
	Mon,  8 Apr 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589435; cv=none; b=EhqWTmxmHI2vCCD+PHXpPhhOfALOeV93VKo9e0zeyUdQmBkEvS7pHsu6TWk3s/tq3oNOpX707iGVprIMwTKIs3OOWNLKjkokO8Cq/GEF/Nn3FGZgWzsD8vQv0jmSaVkyEW61qu+ztgY/EbCQJUESG39WChk7TUuBVPeCZYrhynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589435; c=relaxed/simple;
	bh=q9IM8e4kmx5pm3npvywSgEToxazinW+5NZxmKhNW/gA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rl4OQQc3kHSzdaNG5S97qFJOJX3tYgkABq4YHNFfVGQGMgWenZlZ3xd20BfmZ7rYK3XcqFfI8mIek6ZZwzhnbfecFZn3/Ywax8D8eSg0YaSqz13moL9WKblPS+X5ZMZuLBdE1+c/MfoClnRrZ3f9p1A2c29+h6KpYvJaV5e+RzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIDyEQWV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2be2361efso8171835ad.0;
        Mon, 08 Apr 2024 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712589433; x=1713194233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9xH90W1R99SqhnZ3QXZmpgoRmLM86GDmNKqMgrpRoU=;
        b=ZIDyEQWVjVoMO0XOMYX0oDXrhLGzfPkKXSH2F8LNnXO+aAb/FBcv2wCS3KA9czHkcM
         zDW06xnh1fRFXWvm6Hag6LQs1oA3wuxII/v0NIEi8XcT9YJVtKPClJNrtitoG8+/xzxv
         T+flPFi8dVEehdAOCyKkvssdsBmoJ/B9sXgHtZyDbOeq9IfhBiZvnZcoe6vhPba4q2Im
         ndNGOlb3pis4YxZuJlL0s95ZqcTIvJEb9xQKZpjttYNZ53OeomcR8J1lFUNMFLOMRjDg
         VyUTyodUa4H0ivSg8klvdsV/UlWGMW8BwydZlBu6GTPkTkrXkM/+NbJ09Asqo5n3hKFc
         ikSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589433; x=1713194233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9xH90W1R99SqhnZ3QXZmpgoRmLM86GDmNKqMgrpRoU=;
        b=kli5KlahEus0QxRZjX2ptwcXIZyfNd6R2scdkk6hfdz9i/gVLDHs+dgwxshcQiz5f9
         s+W1y22I+fGcSomi0WSxSWC3c4v2bZJpVMTrm8IXWxVjXQ8NUjOYrjaNFA/Enbb7vEFW
         g3rC7qdsonJbSJ833xKYjMqVR2lp5fAhUv8bOHiBCCAmkhezLPGDE3ds5ro6epxplbuW
         F1+h+siiorEFLljQsObyBS+qQN+S4IvikTO+4S4qwM1e3j7ejn6dr4c1KiHOf/FbZPjf
         rFHCuhZoaXc0M2jejLtBu9AK7ioubcE8bpR8HbZdpfRy2Gvtat5MqfzAFVD36VICZaI+
         xnMA==
X-Forwarded-Encrypted: i=1; AJvYcCWw6KOaugtm5ZULF2tGJjHx1vueDqCFc5uKUJXgoWb7xb32wl53AlYj/DzmrEvNB9di6htdEtfvsUvFmWrM+rBO0wcmE0XTtZAYVhOFeT4pt48HQ2L8oy81YQsg4lYXAo6MmK8QHrfG
X-Gm-Message-State: AOJu0Yxoch233Bti1bf930pNRSsbMIJHhSN29UnRzEjkHqKby903seLG
	F0RrkvxmzwB4Y6DGhXSuylYHYIH5jE9C9Zx+o/lClRgo6qQ2pygY
X-Google-Smtp-Source: AGHT+IHEuGFGCot+KiYuKSvFvlp7ddrKUfIGp7L7kNqhsH721/45ozPn9g2ce73YIdNB1UvO7yy9rQ==
X-Received: by 2002:a17:903:22cf:b0:1e4:5572:9d63 with SMTP id y15-20020a17090322cf00b001e455729d63mr1572678plg.1.1712589433257;
        Mon, 08 Apr 2024 08:17:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a8b:2133:6cbf:3d35])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e0bbd8d0b0sm7214527plb.189.2024.04.08.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:17:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: mka@chromium.org,
	frieder.schrempf@kontron.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on failure
Date: Mon,  8 Apr 2024 12:17:00 -0300
Message-Id: <20240408151700.1761009-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

In case regulator_bulk_enable() fails, the previously enabled USB hub
clock should be disabled.

Fix it accordingly.

Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock input")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/usb/misc/onboard_usb_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 648ea933bdad..f2bcc1a8b95f 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -93,7 +93,7 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 	if (err) {
 		dev_err(onboard_dev->dev, "failed to enable supplies: %pe\n",
 			ERR_PTR(err));
-		return err;
+		goto disable_clk;
 	}
 
 	fsleep(onboard_dev->pdata->reset_us);
@@ -102,6 +102,10 @@ static int onboard_dev_power_on(struct onboard_dev *onboard_dev)
 	onboard_dev->is_powered_on = true;
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(onboard_dev->clk);
+	return err;
 }
 
 static int onboard_dev_power_off(struct onboard_dev *onboard_dev)
-- 
2.34.1


