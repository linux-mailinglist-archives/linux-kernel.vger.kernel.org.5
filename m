Return-Path: <linux-kernel+bounces-84605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D486A8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DAD1C23C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB6324A19;
	Wed, 28 Feb 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGQ6sFfj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147924A06
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105178; cv=none; b=cfccY+FB1zdJ49vYJg/D4MuzksUbaJMX5e3MyNaJf+qArXFx5vkvrCdlB9BZy5WjCJUvvT+pqO+YK+RdUouVorzze25b81bFapk2a2LF1jFsRr77HPZrFbl3VpF/ZrogCvv0HGXeKRZvxP//1Ilj9OElHyjIDtFwjRcFX2P69rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105178; c=relaxed/simple;
	bh=asjFfwYuPjymOdYYLQoZSQr0W4mVkOPufOpRClHRK74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BZp6l5ZhVXVJRdbUayR+yZU21c73OWELgjbRz9/mYc9Tia0G0iGmNd0JeqkJBPNS5iRXGIp40mV+3Yo6gDAjSx+xZjVV46BKGq4D+O+0RbhsCXqrsKc8j4N7ojn+I7cX4fX2laoywRbe1i+NTyFex04LiKxOaVz3KnRA+kOCAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGQ6sFfj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412b4a12bbaso1637505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709105175; x=1709709975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4qmpRXQDJZ+dKyhU210IX58ZV5gg5CCPG3QCEGwT80=;
        b=PGQ6sFfjp0kmrDeupv4LRFPomPOkh3WlVhgDkWpKRYOlrkols0Bf9B6URMCrQmM8fm
         Ha8D/AzTVPIc93bxMUjNsmjtpRAmcYwdplAyxjxvv1+60fbWYgkEvstiTw3WoX/fkHtr
         +gZBVhacVcnaYprevLBVTCmV/ZVChdOnLX/2uk8lU3/yqHPH9NFKyXHX8sZKGvzUzEGh
         eLZfBt6u3US1fjxbzUoc2dcZAcRFx+hVS0YUPNUZO7ElphTW91YY8jCYnHikA4pHMKUH
         0vCeiTBGb60CkfZwRsIFMHWbRb9vQaTdbPmBePG2nIKR2e0q+FLB6Ot/iiGKXzbpWt9p
         Krvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105175; x=1709709975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4qmpRXQDJZ+dKyhU210IX58ZV5gg5CCPG3QCEGwT80=;
        b=sTGZnwQ4bWkROxSsG2SK3/cKNSKs+mTlD6O0/afFx0T9Bh6JVN3soM0tFF3KvJywdv
         uTAiFwQ56CBqIMJtIGLNqR/WmAss4Bxlf2jIRpQpQVXmJi0TBL9APGlAATFG9dF27l9U
         1m8mDh73PJ3UTbt7/Lv7op8nPzZqpuLildF5m4322AYUDiE2ArFSQKPaB188Mnx1nvqH
         Hw1a5uxEvPz3eZLCve/nLyLCYnFGSDZjV8+dsjsm37XIZ2/I9fZKJxV/vG+gaAdCv/Z9
         6hv5kVUFftmxak+uFi14JpLirC4j9fW8ytBCcJRshkhyRoi4H4bx950GxOaJstteFXXm
         fRfA==
X-Forwarded-Encrypted: i=1; AJvYcCVBV4s1XDcI4V92QJFwlKEXNLw1eDAnGj6O/cdtRNYrgDUOXogPJ0jaEavhgnzSMDNmJRMMHYGmUtKxiWHXO1TPttSW6lQW1mUgsYoN
X-Gm-Message-State: AOJu0YwjZQr7MukGsPCwBsPNlEAvj+6J9Husbq24wNqjNEd04R+fiaWm
	UgZREcKgnb1cIbZZNnMnNmvh5hyil67QiAcXb23teC5YtDb/KZKM
X-Google-Smtp-Source: AGHT+IGqgAcMdec3GgCn6K3wUoxK78jFOqYzkRWw+67awvXsZwIBcMadsUraraDWAGDT9sIxLJKbrQ==
X-Received: by 2002:a05:600c:a0b:b0:412:892c:7eea with SMTP id z11-20020a05600c0a0b00b00412892c7eeamr8674264wmp.37.1709105175155;
        Tue, 27 Feb 2024 23:26:15 -0800 (PST)
Received: from ubuntu2004.cynet.local (vpn1382.cynet.com. [84.110.53.106])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b00412b56aa46bsm663566wmq.13.2024.02.27.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:26:14 -0800 (PST)
From: Ariel Silver <arielsilver77@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	yogi.kernel@gmail.com,
	dan.carpenter@linaro.org,
	straube.linux@gmail.com,
	garyrookard@fastmail.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ariel Silver <arielsilver77@gmail.com>
Subject: [PATCH] Staging: rtl8192e: Sparse warning regarding variable declaration
Date: Wed, 28 Feb 2024 09:25:53 +0200
Message-Id: <20240228072553.11740-1-arielsilver77@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed sparse warning: "'dm_rx_path_sel_table' was not declared. Should it be static?"
As dm_rx_path_sel_table is used only in rtl_dm.c it should be static.

Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 92143c50c149..850ee6ae1f02 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
-struct drx_path_sel dm_rx_path_sel_table;
+static struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
 
-- 
2.25.1


