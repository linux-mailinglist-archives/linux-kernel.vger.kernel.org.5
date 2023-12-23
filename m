Return-Path: <linux-kernel+bounces-10203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E182481D129
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955FB1F2683F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0328DD4;
	Sat, 23 Dec 2023 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="ARZb8QlQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC142576C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4006b251aso20659985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296803; x=1703901603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2H+OHqcZ1Qbv0b8tU4ea3tj5qRZ9izHgVmq1IeQAcM=;
        b=ARZb8QlQkNa+iWYfzILv+EGBUm430fjq9cYmaEhl5kuhyP6Cu/TAzYOXbk8YJthN90
         H0nUcBHJNe2zHZ4V0+Xl0MNYDTbf8IXsSS1ZfLyDepQ4q5UQP71AjEM/+/a8rMuA47Rh
         UzLFji9j+e8VK3Tt4lV4mNczdUKBUW/J50yZfVpNUmWk+CKkP8jz8KSDXTpsBUkYrNo3
         Z3CMtWMYiFwVILlK27YqE5SW0aIki7+3ErUazaI9CWOq+77pXRrlk6tSqfnY2gDJN6W6
         bOdjvPv0doKazAjd0jF9fYjqzVNK66zOZbXJCMzDFpHq/EQNTe/7CvHZRmm2eWw/w8HC
         cd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296803; x=1703901603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2H+OHqcZ1Qbv0b8tU4ea3tj5qRZ9izHgVmq1IeQAcM=;
        b=PVqrw4XVWv0gHm7cbvHJPezWUfeyfF4Rg5Ke8llAF1asBwNkIxC2LsQVjWGxLWxDTd
         lDWOsEFk8M6/XwBcPGz8OC9jOEvO0fiTfZbpBlOorsPDZuW+G70yML3UdxiHnvJRpLLt
         8xGz57Ep8QfOCsHhP6pLxFKNYB0LkknUBw9pPCmDYgK1PaFtVysaJELqATfkvSy7PUtI
         eMICa9dIJNMiSdVISIoNjN0gSvbPQu/eLzlyZqid6q2f0uY8iTfrH/IrXojPA3AX7mXe
         p9nVmXbQwRyd8sFpDnkVYV9IlrhleUZg5xHj5tIwy3ES7JNn6juGjr+LIfxrq7Eyd8FT
         bG/g==
X-Gm-Message-State: AOJu0YyxCTfkrki1g/RWAipYiesHdBs4JA50vJrkxwm4v7KurCnb7uV/
	o/4cUDsf5BPsJ3as6WyEnMyqXpzYj9KJUw==
X-Google-Smtp-Source: AGHT+IFkqfe8NiWQa0TXGYHrThu8cR7iGPzH1UBbzR6d8nUNye/eDowNAjxRbYGH+MNDemw+4SNRyA==
X-Received: by 2002:a17:903:485:b0:1d3:ee1f:ce54 with SMTP id jj5-20020a170903048500b001d3ee1fce54mr2191383plb.89.1703296803429;
        Fri, 22 Dec 2023 18:00:03 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.18.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:00:02 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 20/20] Staging: rtl8192e: Rename function rtllib_DisableNetMonitorMode()
Date: Fri, 22 Dec 2023 17:59:42 -0800
Message-Id: <20231223015942.418263-21-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename function rtllib_DisableNetMonitorMode to rtllib_disable_net_monitor_mode
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0158b5595c3c..d6cd0e0785c4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1678,7 +1678,7 @@ void rtllib_start_protocol(struct rtllib_device *ieee);
 void rtllib_stop_protocol(struct rtllib_device *ieee);
 
 void rtllib_EnableNetMonitorMode(struct net_device *dev, bool init_state);
-void rtllib_DisableNetMonitorMode(struct net_device *dev, bool init_state);
+void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state);
 
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
 void rtllib_softmac_start_protocol(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ec7bf27820c6..e3d51355dab3 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -361,7 +361,7 @@ void rtllib_EnableNetMonitorMode(struct net_device *dev,
 /* Disables network monitor mode. Only packets destinated to
  * us will be received.
  */
-void rtllib_DisableNetMonitorMode(struct net_device *dev,
+void rtllib_disable_net_monitor_mode(struct net_device *dev,
 		bool init_state)
 {
 	struct rtllib_device *ieee = netdev_priv_rsl(dev);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 5d165d0b134d..eb331cbb9850 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -270,7 +270,7 @@ int rtllib_wx_set_mode(struct rtllib_device *ieee, struct iw_request_info *a,
 	} else {
 		ieee->dev->type = ARPHRD_ETHER;
 		if (ieee->iw_mode == IW_MODE_MONITOR)
-			rtllib_DisableNetMonitorMode(ieee->dev, false);
+			rtllib_disable_net_monitor_mode(ieee->dev, false);
 	}
 
 	if (!ieee->proto_started) {
-- 
2.39.2


