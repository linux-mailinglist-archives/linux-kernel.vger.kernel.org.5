Return-Path: <linux-kernel+bounces-133353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6989A2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F3F1C2256D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34816FF2A;
	Fri,  5 Apr 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrwapMbU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13408171671;
	Fri,  5 Apr 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335295; cv=none; b=fbhr2qCLS3qYhKVthSDrw50UwfXDo7veol49lAIeGl2BR793n+EhhmEzrcfh4jPsr5IJvYmuiZqsvW6ItLviAmWUacRsJl3K7RlMvLvf4n/WfpCvz8jEYwOR1SZHktsis0ESoYLTkWzo4V0RL4+Xu20DFIH/ZMO4lAGJnGwVXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335295; c=relaxed/simple;
	bh=CNyZv7F7MM6DJREsMjJWxzU9kMvkiJmWI7Qjwel8lhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXNS4iVEJpoAxWPIasJaU3f+54qirbx6VcRi1BcS35UWCHtgobnIL6tyubA4R3Wr2KDUSAhLXWVg+EEY67dGho4Hgbe9T5n9sZWf/NUB1Au/QoyGqOmgdObndFcu/Vd/8LTury2gizJ78q5ORTCYBZANUsjbOZNSYVnbVDdPKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrwapMbU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d6898bebso692769e87.3;
        Fri, 05 Apr 2024 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712335292; x=1712940092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oushmNgLEoSiFSU+fvxV91NyvXwpQw1n1UeXr157a84=;
        b=NrwapMbUSGXQ22+GoLEGdr9hsHdi9ndXKdpazLzll5CA3PWfDsa51ngJ1PqT8d1bcK
         xHoJfTYQgBvbn2eYHiZTi5LRyMQAQ8qhcxLqyx0dG8o2P1gFG/0YGNP7DY1VAlfBMoG6
         GlBaL3lwKfrDQ+k27I3El6zwVeP9IfINgtOJmyi4qzoGS5b3N87KdavGff2XQyAaueIH
         qGEJGDkobQLtj5G6Bf7vo1m/euXeULvaSUOzTX+JSCQ8WMm7ubOuozEmMbR6dKYYOM6G
         hrhYVox6TsbwzbEyYEp/npk7pLuoMBg1A9xbtz227/WAZKPm2GqNPx8d753n2I9QtuSH
         mkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712335292; x=1712940092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oushmNgLEoSiFSU+fvxV91NyvXwpQw1n1UeXr157a84=;
        b=ksF6ELvTa/rVcJjKvpTgJfuulwEb0hyzzDi5f2pLnO9SW9q2Tk/Yt9YVlKAeX/O+3K
         mEqmRI1nQNKi7h0UFEuP/xshk3+z9ZG0tQB1ueWK2RVbnEunqKyKbmdEq+DsKMrBUENM
         j2ctA2LzXbasYHqjwTfb92W2eZEuIKSZ5hK+ennY0Mi7Fd5pYaqHD9TN2X+qn8e1x2JN
         /Klh4jXAQSZrrEq0s87sqbk0uFSMX/7P8FtneI8ZRPMPOjsYvTM7kZyfS3Q91T5r4JoD
         mO7WzadxmsHqODS3bAg111Gp5nMlX+x4Eht0y2DSxlN1wA1O/f9zgW8mv1+PSJDfWiBK
         u13g==
X-Forwarded-Encrypted: i=1; AJvYcCVTbemXBiYXhlwbFkYVpQl6DnfxMe3psBJTlvr1UjhC7cYcUbp6NfHyBNqsr4G9lj77Kse5FBhE5wSpoH+odDGjPkOgr13LbiLbJDDAohO72WrGe4Lspd5c2YQaPqTI5QbVUE0S/XgYrQU=
X-Gm-Message-State: AOJu0YwdiKOxW90/ZTWY6BjfVzMqSLBzN0uZc/sMPrB6W6q8V/jEXnDA
	7sar2pxpwhHqv0fnRhNXDDJmDnNjGEx1OaspIGU3HM2wXD+p0T/GfvDxIodNneA=
X-Google-Smtp-Source: AGHT+IHKx/AFFoYlz2wsU7Ow4QEd1FTQYHkZhM2bjswqqJyLYJTgiqOPI9cpnPVCIAiE7UMQ7DlscA==
X-Received: by 2002:a2e:8911:0:b0:2d8:713c:8313 with SMTP id d17-20020a2e8911000000b002d8713c8313mr663883lji.45.1712335291918;
        Fri, 05 Apr 2024 09:41:31 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651c124d00b002d6c93793f1sm218372ljh.77.2024.04.05.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:41:31 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] media: chips-media: wave5: support reset lines
Date: Fri,  5 Apr 2024 19:41:06 +0300
Message-ID: <20240405164112.24571-3-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405164112.24571-1-brnkv.i1@gmail.com>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for optional reset lines. For now, simply deassert
resets on driver probe and assert them back on driver remove.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu.c | 16 +++++++++++++++-
 .../platform/chips-media/wave5/wave5-vpuapi.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 1b3df5b04249..1e631da58e15 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/reset.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -151,6 +152,16 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, dev);
 	dev->dev = &pdev->dev;
 
+	dev->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(dev->resets)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
+				     "Failed to get reset control\n");
+	}
+
+	ret = reset_control_deassert(dev->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+
 	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
 
 	/* continue without clock, assume externally managed */
@@ -163,7 +174,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
 	if (ret) {
 		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
-		return ret;
+		goto err_reset_assert;
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
@@ -246,6 +257,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	wave5_vdi_release(&pdev->dev);
 err_clk_dis:
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+err_reset_assert:
+	reset_control_assert(dev->resets);
 
 	return ret;
 }
@@ -256,6 +269,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
+	reset_control_assert(dev->resets);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 	wave5_vpu_enc_unregister_device(dev);
 	wave5_vpu_dec_unregister_device(dev);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 465ff9dfe8b1..da530fd98964 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -758,6 +758,7 @@ struct vpu_device {
 	struct ida inst_ida;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct reset_control *resets;
 };
 
 struct vpu_instance;
-- 
2.44.0


