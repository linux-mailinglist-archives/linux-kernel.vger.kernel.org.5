Return-Path: <linux-kernel+bounces-86059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAF86BF14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FFF1C216AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BD38DF8;
	Thu, 29 Feb 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="QX9UehVi"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE236B16
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174619; cv=none; b=LVbjr8I4l1kEMrnG3qfKGtCtsWyh20n3VSJycXTos3uHkRcUh1O2FKhww+8Lrc2kH54zBLgBh7IY/3i/ATEaSh0RB4686WcvrVg0ZcAG0UFfk2PbadjWNXTF1jV4EHEwliVpYtusv2UiuNF395ZuJmB2ZS7g0bTf7V9W2FropSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174619; c=relaxed/simple;
	bh=TtPGBk36XpX3CmVxUVDkkA32ftSJsHAWNhFPZRbIGyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBT63IUpuXWWYgrbc2xI40eh+N7Y104kb14wLERxD7/0fJJxhnNcEbtd/GqUeTidLkWf0dsnCspCS9IES3MwfTwlsr+hKPU8+oTc92FdWvqG84JFhEUGQv+acZKZSCurM5WTN+qhzT7D+aJvNuXYsOcJG0YJT8S3nc0CJ18AAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=QX9UehVi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3651c1e1022so2492795ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174617; x=1709779417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhfHq+TB9JfA9EoJNMTx1D1THIHV8qXBJRS7zjeQSzA=;
        b=QX9UehVivYX4JKsYd+FHiIwYqCU/EK0AZnEFakzbC1einYD/a1+8DoQNH1eTTXEBpU
         dBLF9AUxygVVhTl4yxslWWqqN2ZkAsCIpydtnqPy3HGWf0VqDmFiuYBqF8l52CkPeK2N
         bFwRy0/T49yT571HthEu0BYykyS6Vke85Tar8zH25WHNTTSmOEJk3JaDtr50k7anp6VL
         KvBEgz/uPrk/QQIDWiOa2K9+mZZdNoIo5Sgt0QGOI9tAvYAoQHMVlZCZ0WtfD3Troep8
         PpAWWzOvF9Exzy1krGMcd+y0AFPmHUu5AfWxUyVMlUQM9b3WOgxYGbhZtlhnFWNLWpmw
         8qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174617; x=1709779417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhfHq+TB9JfA9EoJNMTx1D1THIHV8qXBJRS7zjeQSzA=;
        b=O/OGRFkjFPVKR8xPox+mChgmlIZuaqDIrKx5GdCFPpl5Zkq81pyz6tFBfEcGywzPQm
         tnz3uedA3FQnNJvxGJ5mhlRx9ZMu1ojvVca5KvKDt13+UjVjIACHoTXj5sA+tG3afy3z
         MnwUsTf7NFSKmrhPjSp9lPPxnyE7YYvd8oYXKg8+lIgwWouo2x/o/2OTKJ5NpNONsxS7
         /kgqzTDQcMuZdkqQEPsP/4Mad585zq0KcDgvI3q5gtjplimaMPf4L1P027VZpt9/ZyKJ
         gPfHLWPDQ5yKMduTG9yv6qroNgXn3ezqyggxPCLFqzgTZAZa/WX337VJWvjUJp9u/2y2
         t2ew==
X-Forwarded-Encrypted: i=1; AJvYcCXXfNNSgJ7t9c3sNAR7ceSf69/7HfGPt1T3gplYZXMmyX1kP6U5B4XQ0phdP+R3tuiIctyJo2wpDLR4HUd2LZ323WMR0m0ROGYTOXBc
X-Gm-Message-State: AOJu0YxbQehpi0yQh8MJQJpRmhvC1/DYtC6yoUyJCJt2SzypKCINf0hL
	LNgE53+ENqDj3CnTHjjEVa1PjPDhUSNZxVKsomY74NCJef0g71IVGE+8DV08q78=
X-Google-Smtp-Source: AGHT+IGQbkvRl6OZuvq4uMmwaSFBD56Nt80clHOrFAY3/gMfyXFQ//BdYzsq4OM/TELdk50TDDwuxw==
X-Received: by 2002:a92:d988:0:b0:365:8513:b6b with SMTP id r8-20020a92d988000000b0036585130b6bmr1130962iln.29.1709174617086;
        Wed, 28 Feb 2024 18:43:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:36 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 5/8] Staging: rtl8192e: Rename goto OnADDBAReq_Fail
Date: Wed, 28 Feb 2024 18:43:22 -0800
Message-Id: <20240229024325.453374-6-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229024325.453374-1-tdavies@darkphysics.net>
References: <20240229024325.453374-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename goto OnADDBAReq_Fail -> on_add_ba_req_fail
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c0006daa75ec..a3a2fe72d644 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -251,13 +251,13 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
 			    ieee->current_network.qos_data.active,
 			    ieee->ht_info->current_ht_support);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 	if (!rtllib_get_ts(ieee, (struct ts_common_info **)&ts, dst,
 			   (u8)(ba_param_set->field.tid), RX_DIR, true)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev, "%s(): can't get TS\n", __func__);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 	ba = &ts->rx_admitted_ba_record;
 
@@ -265,7 +265,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 		rc = ADDBA_STATUS_INVALID_PARAM;
 		netdev_warn(ieee->dev, "%s(): BA Policy is not correct\n",
 			    __func__);
-		goto OnADDBAReq_Fail;
+		goto on_add_ba_req_fail;
 	}
 
 	rtllib_FlushRxTsPendingPkts(ieee, ts);
@@ -287,7 +287,7 @@ int rtllib_rx_add_ba_req(struct rtllib_device *ieee, struct sk_buff *skb)
 
 	return 0;
 
-OnADDBAReq_Fail:
+on_add_ba_req_fail:
 	{
 		struct ba_record BA;
 
-- 
2.39.2


