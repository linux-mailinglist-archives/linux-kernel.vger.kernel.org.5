Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A63770B24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjHDVlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHDVk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:40:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD388E2;
        Fri,  4 Aug 2023 14:40:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686b643df5dso1973195b3a.1;
        Fri, 04 Aug 2023 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691185257; x=1691790057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omRwdoLI/pe73xmt4uOi5eZK6XRdWhCrwxfJwoygChk=;
        b=CfB4IQydwlw8qfkGeo3+kBLf6k/IfL5xcXe1txkcOjb0UYeHDRNNRUJMd3w6Yp2lzK
         SKz0sK2u/DuAe+baiudh3Eg5JQdtZlsc95J2JZAOvx6gqpYNWZDFz4xxVmgEc/aC5Fxt
         UcrjVXVtg6gXEf/ZW99y4hlOsYglCSxiLRRP0t/WFx4PyAospbSDZph1YXSTUJ/R65e8
         8BMMdU4P6tmUpn+Gsc3QP169BTpqzaKlbsiDIxbj9vD+4LaHykGrv867lNaJjSXb4xvM
         CI1PZLs+rq0I4vljklw9Agb5imMJn6XWN6W9BnnjEWS1QiO+OMLeLNa1/VrVxqPNSwQ/
         M35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185257; x=1691790057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omRwdoLI/pe73xmt4uOi5eZK6XRdWhCrwxfJwoygChk=;
        b=FlumkaPRxzE5sqTOZDWNz3JRfbHCoZk0sfCmbg38wGUvoVuyP1wmzHuPU1NijDD6zn
         LRtRvEou5noH7u7sLbHP695rkpmB3ZizwFrfGbztnzuIK2iDPoAdVpXf3W9Q5DbbP8Gz
         EIuHPRB+bRoLfL+BlIW0k76sSOPfZnMmCRPFPxf4RWTGUscrwGnSgY9o3cQNRXT52w3n
         EU/IOh/DWvQjN0XzZ69XeKARhydN1FJYf/0of7q0h8i5D8g+RMZZs0nW9g9u5riom5Oe
         ZBPnZlTLjS4o5HCqI4frVU+ZbMj66Jy4n/1RuGzWqZtpjYuzDEHgF337PokrmC4vtE+R
         w8Kw==
X-Gm-Message-State: AOJu0Yz76TYPeXU17OyfH/znWuG6NUyfubCy9ibaPJn/Z7qFGVEiuBmq
        Pz6jbNM6XPMuUohazSq0N/E=
X-Google-Smtp-Source: AGHT+IHIPywqproRva9PBjR/uyaZ0ol8pgyRadE6dVe697kIxczOrJd0UdrNH/ZS2a0OUbaJ5mhtPQ==
X-Received: by 2002:a05:6a20:3243:b0:13b:a016:465b with SMTP id hm3-20020a056a20324300b0013ba016465bmr2682720pzc.19.1691185257191;
        Fri, 04 Aug 2023 14:40:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b0063f1a1e3003sm1972928pfm.166.2023.08.04.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:40:56 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] PM / QoS: Decouple request alloc from dev_pm_qos_mtx (alternative solution)
Date:   Fri,  4 Aug 2023 14:40:51 -0700
Message-ID: <20230804214051.136268-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Similar to the previous patch, move the allocation out from under
dev_pm_qos_mtx, by speculatively doing the allocation and handle
any race after acquiring dev_pm_qos_mtx by freeing the redundant
allocation.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
This is an alternative to https://patchwork.freedesktop.org/patch/551417/?series=115028&rev=4

So, this does _slightly_ change error paths, for ex
dev_pm_qos_update_user_latency_tolerance() will now allocate
dev->power.qos in some error cases.  But this seems harmless?
A slightly more complicated version of this could conserve the
previous error path behavior, but I figured I'd try the simpler
thing first.

 drivers/base/power/qos.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 1b73a704aac1..c7ba85e89c42 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -920,8 +920,12 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
 	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate();
+	struct dev_pm_qos_request *req = NULL;
 	int ret = 0;
 
+	if (!dev->power.qos->latency_tolerance_req)
+		req = kzalloc(sizeof(*req), GFP_KERNEL);
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	dev_pm_qos_constraints_set(dev, qos);
@@ -935,8 +939,6 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 		goto out;
 
 	if (!dev->power.qos->latency_tolerance_req) {
-		struct dev_pm_qos_request *req;
-
 		if (val < 0) {
 			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
 				ret = 0;
@@ -944,17 +946,15 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 				ret = -EINVAL;
 			goto out;
 		}
-		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req) {
 			ret = -ENOMEM;
 			goto out;
 		}
 		ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
-		if (ret < 0) {
-			kfree(req);
+		if (ret < 0)
 			goto out;
-		}
 		dev->power.qos->latency_tolerance_req = req;
+		req = NULL;
 	} else {
 		if (val < 0) {
 			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
@@ -966,6 +966,7 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 
  out:
 	mutex_unlock(&dev_pm_qos_mtx);
+	kfree(req);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_update_user_latency_tolerance);
-- 
2.41.0

