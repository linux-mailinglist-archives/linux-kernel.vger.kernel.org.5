Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287C7618CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGYMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGYMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:49:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85C1AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:49:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977e0fbd742so874666766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690289397; x=1690894197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Puz3ztq+s5PMQIYSFqmtMplo+slwUgkmSW9O9rbzaQ=;
        b=hVigPGX//gTdtgmRuslLbiD1/zcY/J9BI9iISd0U4KzwumlLvSTCrKq4TVJCmKI5+Y
         gzNDIQRzCKFPphY9vbQsCB8Y0OcWy802EvA7wpSi8njOBNCZyNsNx/TovT71NWTTal0M
         6zJrn0OCpMUMog1LoXLLbfPPloeuSf5Cq8Uahs3w58Hu2gJWKIe3wuYNrb7kmA1Az+r8
         7FksdF0bC/1r8yXmfBqwolspgGX32xjGunx2VBJr1MCnDU3TgC0/DZjGxFrO0qaQHvOl
         5etfhfrRaDodt9q7a6NlRCuoNzeq16P4nKo/Z8ODRTBH31SSfxr53sAIi+ClzWSGRUMT
         jStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289397; x=1690894197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Puz3ztq+s5PMQIYSFqmtMplo+slwUgkmSW9O9rbzaQ=;
        b=hZqjNWzoMkL8KYHut0nNJQ7Dv5CBY+Me+EVLZussicORR8/ga0ofwZSHBPeH3HGs7u
         cyrBFLlM6M3fAQQ9ihj/1o+sarMmWfkf/32aB8YUHlJdfYn2UAf7GQ5iy8NUsZ1uElIT
         Z3xcjifUMuu2y1PbxlTrwcgEd+A/56Iz+Quyxxmd/neWYHUZzGAxvUmkqEO1ldf/0x6N
         zkZluMnXTL3joztj/r3RTM6uiG1A0wcXbLByAYEQxWPpFCoefNL2MXTor0Qf3QNwRxfD
         w+d/d4toBUTZiAXFnVnW1ySqLBgOU9DfDa6jQvPacdE3CG6D+4xpwHE4vfTvSImxoz8i
         iy2w==
X-Gm-Message-State: ABy/qLal9Goqk/8PdQwMAQpXvs9QvRvL6L2sH8JdixWUTw8YHdLNb+D5
        WMiSImhKMSVAPvizDUyTzf4VsQ==
X-Google-Smtp-Source: APBJJlGLU28v87Y58xqBP2PjJL/KhzkfhRXDaTYlF8sJo7esBdIHBy1dZgN9EPWiJakxco6GyTlwTA==
X-Received: by 2002:a17:906:2d9:b0:973:d076:67ab with SMTP id 25-20020a17090602d900b00973d07667abmr12076828ejk.42.1690289396804;
        Tue, 25 Jul 2023 05:49:56 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b00997e8b6eaa1sm8133283ejb.41.2023.07.25.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:49:56 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pmbus_core: Refactor pmbus_is_enabled function
Date:   Tue, 25 Jul 2023 14:49:50 +0200
Message-ID: <20230725124954.3824954-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Refactor the pmbus_is_enabled() function to return the raw status
without any additional processing as its already done in
_pmbus_is_enabled function.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index fa06325f5a7c..42fb7286805b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2768,7 +2768,7 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
 	ret = _pmbus_is_enabled(dev, page);
 	mutex_unlock(&data->update_lock);
 
-	return !!(ret & PB_OPERATION_CONTROL_ON);
+	return ret;
 }
 
 #define to_dev_attr(_dev_attr) \

base-commit: 55612007f16b5d7b1fb83a7b0f5bb686829db7c7
-- 
2.41.0

