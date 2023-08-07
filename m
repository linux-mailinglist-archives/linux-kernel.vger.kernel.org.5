Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3450B772282
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHGLem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjHGLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:34:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8759E8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:31:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178fa77b27so3720090f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691407833; x=1692012633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKMevEL8SVXVO551DayO5iLnQ1p07kMXooCuC+Y40ns=;
        b=DAySMXWCtDPnzrybLPTV5IjLfZgWA7t+Z4a8jyj4FF+41BX6w1hAkQ7IlVRbqq0pqH
         l5m3N0xjuJ3qVQ7MoUGdV2DZo4YNxxo5UOA5y68WdjCb1NBpOeHZbVAAiGgWn6DkyVEf
         4WAib3f4UfZM2RvKVITC3vVb0P9bw15we1Av8z0+QJb/mn+O/wg3WzhKMyAZV/krgLtj
         421K24aeirr4o/M1unkK/D8oTM8WYEBDPCS31afSH6HoRxjy1NG7AVIg2SmTcYzNwnag
         nakDHggb00yQeOnSJs0vE4yXtOE/EIdHyywTwycGcN3zhlUgkqJiG2ODM6LDhiWqA4z7
         Ottw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407833; x=1692012633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKMevEL8SVXVO551DayO5iLnQ1p07kMXooCuC+Y40ns=;
        b=Cd40/WegA/caDDmEyMUOK1Nv2SLOUoag7ynZeliMmWRlgWaG6V+nN9hN9vuaLCu3CF
         7+A/9AFvJWGjPXN+uggFC7LupIgKq5Pb4Pytb+l9n05okOjX6r+xGBR80VdkfXB17qkd
         RVHJZ8wL9mkhoKExGwRFrDEghd9zHZvYKMwY3STAXO2wKsjhpgjHbeAfRcyiFvGfIonS
         yH/fUhr2bsXgH3y4clum4PMizRYqj7hORaxUJ8pmSdPfXFRXiTOuY0LCDW38DB6YmebR
         ava0TnZYShdfXy0+eZy1CWMJTXQaisbGRjbOKOAGq0WPKNMviN3E6m1Yw0wbdILN1qJ6
         ttaw==
X-Gm-Message-State: AOJu0YymKfUnYi1GMYyEyCfW0CNYxSW1uaRGilkS2SXRuMiSpu+vwCOh
        /TsgORmFjT9VBrnc2WdFSEVFHhYeNW2szg==
X-Google-Smtp-Source: AGHT+IEZ5fSQ/MxWYfyddvfZ3x9Ph/7oAX0FLUtT8gZm3cgIVBHGbf6KaAlLr9uVCNx8tG1eaIxUUA==
X-Received: by 2002:a2e:964e:0:b0:2b7:a72:103b with SMTP id z14-20020a2e964e000000b002b70a72103bmr5947243ljh.53.1691406957194;
        Mon, 07 Aug 2023 04:15:57 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id l17-20020a1ced11000000b003fbcf032c55sm14717290wmh.7.2023.08.07.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:15:56 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] reset: ti: syscon: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 14:15:34 +0300
Message-Id: <20230807111534.12392-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-ti-syscon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-syscon.c
index f0dd7ffc3b72..23f86ddb8668 100644
--- a/drivers/reset/reset-ti-syscon.c
+++ b/drivers/reset/reset-ti-syscon.c
@@ -204,8 +204,6 @@ static int ti_syscon_reset_probe(struct platform_device *pdev)
 	data->controls = controls;
 	data->nr_controls = nr_controls;
 
-	platform_set_drvdata(pdev, data);
-
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
 
-- 
2.34.1

