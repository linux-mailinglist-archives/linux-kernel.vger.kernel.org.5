Return-Path: <linux-kernel+bounces-18503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF2825E67
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34590B21931
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD07FBFB;
	Sat,  6 Jan 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R7WVcETC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED5E570
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso189900a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 21:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1704520579; x=1705125379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVzWH1kTIs3O+aFZdU9/JNQTpKc+IEiawn+wHaJsvIU=;
        b=R7WVcETCkWBK2qXub5gsdCY/qI/9fFWEf+QiZVIXJFfd49t+g4UpHeYNQwmej+Hq2K
         TjQ8bz2FnM4i66dP+8InMEEwBNN1zw/ApSFGitbPqLrst1J2HzGFSDV+sEOzWK6Ywl2U
         htnlChNoXgmpLRDCFhpX0Z6Mo7VFCdEewV172aSMbes+mWWy0RWLVHdraRM4yVLnprHi
         c9PacPu9iYhqI8UVoHbvGdpJYL5hVQUdCWBkf9mXB3/uYSt9YQrEEuTy1IaPfmO3vEff
         AlqZN6fciJcaz79KqPYPcWoXeHsxnc1swR8+4CdXsv7TueqSVMTUQHt0wBhHdgY3Ueai
         kzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704520579; x=1705125379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVzWH1kTIs3O+aFZdU9/JNQTpKc+IEiawn+wHaJsvIU=;
        b=no++dVIgh7T/EDN73H8DUXo+8Vr2IE2oZK8TytPpZjpQl67tspjOyS2LFYF0KnbmGN
         9wKK3UHPSEhYslSqXSbTb79qIc0Ft3FsVS3S8ID1hhNtS7xpdfCU6M7I+o6tGC+3PD6q
         iXOOzYyvnF+gwOFrxzYKCCXPjp+7IEnUmYJWMPvAizhzrQoKisgMdnJjPY5YK8sFQO0p
         K6FBy0MgcJe5sFMjP5gdXfIPpXli/Crq4qgCTQYzMIKPsBnNsyFk838jWOq+ML+p6/+7
         GkxBzD6mWAQimG180hQeiDThfhF+bkgIWRStSsUSNENaP53VlBX8urp4h50S+02zQd0g
         4e9Q==
X-Gm-Message-State: AOJu0YxnotkJAfGICyzkMkQFpt/XI5QnrOmd2ylRJF1WoAWwIBK8C7dk
	Sf7tyX4AJckcJmaVIIzL2q9XTJJixnxCCA==
X-Google-Smtp-Source: AGHT+IGCyk5AExPvdo1CxuYOSK/ddtSEBK7+OX4zn6mMDV0yv9ueqB/tE95aHpZ2veaorXuUdGP0qg==
X-Received: by 2002:a05:6a20:811a:b0:196:5861:6242 with SMTP id g26-20020a056a20811a00b0019658616242mr443386pza.125.1704520579291;
        Fri, 05 Jan 2024 21:56:19 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id y29-20020a056a00181d00b006d99d986624sm2280873pfa.151.2024.01.05.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:56:18 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 13/21] Staging: rtl8192e: Rename variable SlotNum
Date: Fri,  5 Jan 2024 21:55:48 -0800
Message-Id: <20240106055556.430948-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240106055556.430948-1-tdavies@darkphysics.net>
References: <20240106055556.430948-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable SlotNum to slot_num to fix checkpatch warning Avoid
CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 34e30b03c545..f4e48b4a122d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -922,12 +922,12 @@ static void _rtl92e_update_rxcounts(struct r8192_priv *priv, u32 *TotalRxBcnNum,
 	*TotalRxDataNum = 0;
 
 	slot_index = (priv->rtllib->link_detect_info.slot_index++) %
-			(priv->rtllib->link_detect_info.SlotNum);
+			(priv->rtllib->link_detect_info.slot_num);
 	priv->rtllib->link_detect_info.RxBcnNum[slot_index] =
 			priv->rtllib->link_detect_info.NumRecvBcnInPeriod;
 	priv->rtllib->link_detect_info.RxDataNum[slot_index] =
 			priv->rtllib->link_detect_info.NumRecvDataInPeriod;
-	for (i = 0; i < priv->rtllib->link_detect_info.SlotNum; i++) {
+	for (i = 0; i < priv->rtllib->link_detect_info.slot_num; i++) {
 		*TotalRxBcnNum += priv->rtllib->link_detect_info.RxBcnNum[i];
 		*TotalRxDataNum += priv->rtllib->link_detect_info.RxDataNum[i];
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5cab1aa6455a..26ceb579afeb 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1115,7 +1115,7 @@ struct rt_link_detect {
 
 	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];
 	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];
-	u16				SlotNum;
+	u16				slot_num;
 	u16				slot_index;
 
 	u32				num_tx_ok_in_period;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9a9b8f63218b..d7edfa1dca65 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1072,7 +1072,7 @@ static void rtllib_associate_complete_wq(void *data)
 			    ieee->ht_info->enable_ht);
 		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
-	ieee->link_detect_info.SlotNum = 2 * (1 +
+	ieee->link_detect_info.slot_num = 2 * (1 +
 				       ieee->current_network.beacon_interval /
 				       500);
 	if (ieee->link_detect_info.NumRecvBcnInPeriod == 0 ||
@@ -2073,7 +2073,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 		ieee->seq_ctrl[i] = 0;
 
 	ieee->link_detect_info.slot_index = 0;
-	ieee->link_detect_info.SlotNum = 2;
+	ieee->link_detect_info.slot_num = 2;
 	ieee->link_detect_info.NumRecvBcnInPeriod = 0;
 	ieee->link_detect_info.NumRecvDataInPeriod = 0;
 	ieee->link_detect_info.num_tx_ok_in_period = 0;
-- 
2.39.2


