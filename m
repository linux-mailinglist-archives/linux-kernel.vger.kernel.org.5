Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77280E75B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbjLLJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346351AbjLLJU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:20:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32711A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:20:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso7194390a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702372832; x=1702977632; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7/FCALzJMBC/rKEcJ3A2AOybQwAx21cZLAPfuxjI6U=;
        b=bcXT1ZyNsRHuSJ/Z5ybzzkK1GK1fqAjvw9qONP+OvUhUH2rWkmQ1vAHFHqgMj8B4N6
         Dfl3yeNt9QoqEgQggg5XVhGx0GiCk4rRY/3t8T9NnKuYsYZ84M0ex8YBt5DbFr2bzCbr
         udqXVy/Dw3YRz3qwL48ZddBBR5mAqx/cipZ0tFcqmyiSi8gD8dqwYw0SswBGKZfE9Mak
         KqOzj6zXOpwMz/UKt1Js9r72/NEf5C/MJU6E6G2UmLw9W/wQsJEoueDNU1VawueeYs8v
         S0ZGo02hwtOGpvR2VY71W0hwjEcD9nqHT6uAbdHc4s09NmlwYu1U8V424mDNSgm900JT
         n1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372832; x=1702977632;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7/FCALzJMBC/rKEcJ3A2AOybQwAx21cZLAPfuxjI6U=;
        b=nhtu3dRR1J3z5l4l7UaxuLfcPzOvVxTSCRrWs+h/4VakoZhlGfPq9XS0KNp7kFf7ei
         ufF8hZOAZrAyWd8AAxpJAMbmHzSxosUspQxOajaI5M6PTZykd/HOD8IhjH9Pb5QfzUO4
         asQmyNlq+zCMNCwXd3YBxjvyB/KfoH45kPxWHVGCxmt8xWaou/RP+XT4ig5RZNQhuKp0
         4Gn6hNl/kUCicvGQjzznVta53WDNwjdZdShjV4e6fK5ne6E5ZH0qS5ti+OfNGcXQ0iBc
         8sM8hDDMl9pI9GAJpAGbBmmRTpSGZQ//WXeL4i03TIdwg4yggQOi08y1ZcBzASYPkT4O
         1RQg==
X-Gm-Message-State: AOJu0YzHlsJv3Ckf5wbl/LCfqmx8uAOMkerNmuqzNUaNsAO3KyizuicF
        q+brWh92X5YzqiPEfmb3U/U0Hg==
X-Google-Smtp-Source: AGHT+IFviJpWOCS2ssWh7zDgND69LD8jG/YfNIrMpCFmrBkCDDGz77dPhXaS+p3xsgkjLM3lofoN/w==
X-Received: by 2002:a50:85ca:0:b0:551:14c0:7325 with SMTP id q10-20020a5085ca000000b0055114c07325mr1998415edh.40.1702372831751;
        Tue, 12 Dec 2023 01:20:31 -0800 (PST)
Received: from localhost (h3220.n1.ips.mtn.co.ug. [41.210.178.32])
        by smtp.gmail.com with ESMTPSA id h28-20020a056402095c00b0054c21d1fda7sm4525402edz.1.2023.12.12.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:20:31 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:20:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cdx: Unlock on error path in rescan_store()
Message-ID: <8c79956b-bf8c-4511-97cc-a16833a0630f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added locking to this function but these two error paths were
accidentally overlooked.

Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cdx/cdx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d84d153078d7..f4f9f0c88c09 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -572,12 +572,16 @@ static ssize_t rescan_store(const struct bus_type *bus,
 
 	/* Rescan all the devices */
 	for_each_compatible_node(np, NULL, compat_node_name) {
-		if (!np)
-			return -EINVAL;
+		if (!np) {
+			count = -EINVAL;
+			goto unlock;
+		}
 
 		pd = of_find_device_by_node(np);
-		if (!pd)
-			return -EINVAL;
+		if (!pd) {
+			count = -EINVAL;
+			goto unlock;
+		}
 
 		cdx = platform_get_drvdata(pd);
 		if (cdx && cdx->controller_registered && cdx->ops->scan)
@@ -585,7 +589,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
 
 		put_device(&pd->dev);
 	}
-
+unlock:
 	mutex_unlock(&cdx_controller_lock);
 
 	return count;
-- 
2.42.0

