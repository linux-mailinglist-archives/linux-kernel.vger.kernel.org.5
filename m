Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E58110CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjLMMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjLMMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:13:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F00CD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:13:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so466858f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702469613; x=1703074413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itOaiy93IE/Oi6dMo6HICWXrGEv+UyQ/qj9qyPZPCTI=;
        b=TzxUdnVcAGZyDE7aYTDCJG6I8+hoohg1CWfT+OuwxYD+lLWez8DqiQWBWq8Fm8Cga8
         BF+fPu9Ayu9HbMn6ESP3ptoFaGytSlZBXiyqAWBKbwT51IR+EEKuzPrwg/OSYY+oaZ77
         pJ2poqy/X+86bC74YxVada1+EzRNe9A5P9JunjWmmFos+V6IHTiPoCVGVePRxFJqDLCh
         pVCKRjxP0viH4yhWz6w7IlYDSeTdbdNLG+bvKcivxoMJqTtBe2asFK/HbWBPRtJ1eAa3
         PBS1CXF7aO38vQuXBh8ZVbLGO4x8uQqFJJSCGB+ApYmqraeqxSro4hT+IKhrcf3giyju
         JsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469613; x=1703074413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itOaiy93IE/Oi6dMo6HICWXrGEv+UyQ/qj9qyPZPCTI=;
        b=KzWust29pnfvKbVgQz/sMi5cKGTZPnC9V/3i7ETptcQOXCb0BbAvx5waQnoozSjN49
         wvRRTjZAfkhDAMuUWSUAHqyCLkJnAftU6dT2dUHBd1n1YAtvoD7il6rVnlJi5EtYBYNv
         acAeUXRht7dZWjKwEpcpH08+XoBiprG20OmSYd141J/IYDGsK/pB/chpYcpQqoU3fYhu
         nLEsVLl+S0/BOnR8VhmrawmCEr+xnV8kLdtCI+PiYHZvygpPBPqHIkIulL+9vf229FUV
         93p8pfv7TBAsfOsvJ0OZV5G1Ck1wdnk3LJu5mzRtprVz8ROTGW67douV7di6b76I6Gu6
         fYzw==
X-Gm-Message-State: AOJu0YwZ1zaMnCo6fK6WbaNcwy/607d+ZJvsuxafLdmReMfZ0gmls6FI
        RTnsnE9KiwZ1tu0eOVES3WJ1vg==
X-Google-Smtp-Source: AGHT+IHBVhZ856MZTBC5mOJutrT1OZrSe6h1yPpkPxqc4M4ZwxuWH5d46WF0/Hk0NPQHpI9BVcoRzQ==
X-Received: by 2002:adf:fc0b:0:b0:336:3843:ab7a with SMTP id i11-20020adffc0b000000b003363843ab7amr395500wrr.115.1702469612760;
        Wed, 13 Dec 2023 04:13:32 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id g3-20020adff403000000b003335ddce799sm13224614wro.103.2023.12.13.04.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:13:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Check get_temp ops is present when registering a tz
Date:   Wed, 13 Dec 2023 13:13:22 +0100
Message-Id: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially the check against the get_temp ops in the
thermal_zone_device_update() was put in there in order to catch
drivers not providing this method.

Instead of checking again and again the function if the ops exists in
the update function, let's do the check at registration time, so it is
checked one time and for all.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..964f26e517f4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -437,11 +437,6 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (atomic_read(&in_suspend))
 		return;
 
-	if (WARN_ONCE(!tz->ops->get_temp,
-		      "'%s' must not be called without 'get_temp' ops set\n",
-		      __func__))
-		return;
-
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
@@ -1289,7 +1284,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops) {
+	if (!ops || !ops->get_temp) {
 		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.34.1

