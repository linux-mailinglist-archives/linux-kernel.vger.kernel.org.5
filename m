Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127B7776D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjHJLXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjHJLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:23:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E2268A;
        Thu, 10 Aug 2023 04:23:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso7220865e9.0;
        Thu, 10 Aug 2023 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691666631; x=1692271431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irgk4RzKZAvfCdOq6XrrzpJCPg5TtdhPqPpbTivRruI=;
        b=UkzpFFbG9fKssgZvp71rpCagoOljGoCOIkPBeupx0RWti0S3UbsIHzWFNq802TOjtB
         /QWFl3YB1FdHOU9/hoLkAAaY/LRP8ckE0EivwzrD5UQvTOLDU5xiPNtFtjCKUvVpKAxs
         rHPf+UrzXMw3IwxOViiv/zh5irZqGlrLpTyPtvq7fpfdl/lRSsNbbQdf4/9rV5Hwz5QQ
         Ja9vz9wDmoXLPG+XqT/RG/ATfl6SbIRCql8eiLN5mY4nPqC5G2uCwxHZmNlMsk+HJa+E
         2D0Nhkn3+cTdWDl5dl9C5WlMq/R21dRqEyN6Vijei4Bfx9BG4jUX3JWXLb/GsSIwcI4N
         8TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666631; x=1692271431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irgk4RzKZAvfCdOq6XrrzpJCPg5TtdhPqPpbTivRruI=;
        b=cq/Zqmo2pQTR13ErNNgMccoBdF5BIwkK/i1yu8tfSbR8oRgbQo9OT7FgcPCH0gBYrD
         2QTU4LSGhemK8l0aJZ05Y+txnj9G8c/YpMzATm6lHlbjvGOtGEOz0LxFkWL7RIH4u897
         8npAldAs3yYQRRhu5eFDQa/zJiczRO+Ii4yhvAnfvqUGpRwsFx006YRfhjSNueJYGiiT
         3rL+K9CVbd6xrstW3+tIk/f7dnpuzVpX0DKHb7LXC8UHwN0qefUIB4GiBOgQbXbHrD3t
         H/CHCElU8ssxTtllf9vekQp5odpbP4iZiY0lYCYpzaNs0DrrfgqDnx+lfmCEQC9JyJzw
         EFOA==
X-Gm-Message-State: AOJu0Yzwfi6hxoubzptgsCQ3MNZyhVRj4lGpw34tSo1zgPYjwJNebdwX
        mLebQCqalyDkWTqoaxRhRiXcVJCxgN/aRg==
X-Google-Smtp-Source: AGHT+IHovna6J2qq7oZ88JcNTiLopqPIl0UXUlUT7KfA4hmav0+U+fDmPv6ystcz37x5TRePfLvTNw==
X-Received: by 2002:a7b:c4d5:0:b0:3fc:1bd:95a6 with SMTP id g21-20020a7bc4d5000000b003fc01bd95a6mr1798464wmk.31.1691666631494;
        Thu, 10 Aug 2023 04:23:51 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b003fe24df4182sm3540921wmo.1.2023.08.10.04.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:23:51 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: k3_bandgap: remove unneeded call to platform_set_drvdata()
Date:   Thu, 10 Aug 2023 14:23:44 +0300
Message-Id: <20230810112344.3806-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/thermal/k3_bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 1c3e590157ec..f985f36f2123 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -225,7 +225,6 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 		devm_thermal_add_hwmon_sysfs(dev, data[id].tzd);
 	}
 
-	platform_set_drvdata(pdev, bgp);
 
 	return 0;
 
-- 
2.34.1

