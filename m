Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F606764F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjG0JYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjG0JXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:23:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392476B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:14:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99b78fda9a8so97772766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690449241; x=1691054041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSbeOsHfiUld6B49i7Ndaigaf8fAMe9my2pbTspOITI=;
        b=CrcpKTAK+dFo2oeWmUWocOhIgUFNAdbmBLE/wBkHZB2u0i7gnyKuUCcatBT3KWz0bp
         ssWzmJvgFiZYNCqAmECC+OPzX70xG88ikKECxmShfli1HBAWjAt9F5FMIyRP6BGvysYG
         5Do1PE6iJMo/6zfldZGJfwWc03YxiHlOpZwKTDrPRcmNHSHQ62cpBPWxiqGvPiaLbWeX
         HtPk5CzTEeSeHZjtQz+8IB2djX/hcXFEiARUSOnVFiH9UrAVuknEbX3rOVhII3Z7KJqu
         HX+5TFpubLcUxFzU1rV6Q2E06DfQ5adf30rZRkV7mFnq1zuoF6HAVda+xFI87S3vZpi5
         H+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449241; x=1691054041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSbeOsHfiUld6B49i7Ndaigaf8fAMe9my2pbTspOITI=;
        b=UFTG4uc6XY/cFELBGI0xaNN9psEbJnZht+wqFc6ELEVxRY+rRGEmuzOoxQXEdr6aeQ
         mz+tgDK+ZPIX3HINaMUHa7o0dufmh8Y4Wl6fHPANtlurS24Vr7doJ+jglxcxxjRJ5gQH
         hwBI807KoAu3DQ8aIqAO7zVERnXIbGjh4KGephzlGVpb87JVjrsdzR9EkAaX3CdyToo9
         M5z7vfFyRIDsO5tBs4rB5dPUzsnzThQDQXv0larENqsHjcBO3AIQ6jYgoHmh+qLc2kRE
         J/1Y9Zr1uQRI4z507hnii9TXXjtXmQu/YqF+/gJ0fM8R0xqw9VLxhnTu6NNkVH+/oy2q
         yMzg==
X-Gm-Message-State: ABy/qLbQAr82NSAa7Z1SxpTiYtK79NVPdRtFCR0YjB5mGosZMLJXuFAg
        G87F2ghnTX/Wjdf48g5kh3Jmdw==
X-Google-Smtp-Source: APBJJlEq/O/XUyOsGRhtX+o0id/G6Yc1biCF/nZIu+TZrwnc8hLgLtP4H5JUzXTHsqgOrYZcBILIEg==
X-Received: by 2002:a17:906:7a46:b0:99b:cf57:11e3 with SMTP id i6-20020a1709067a4600b0099bcf5711e3mr1471594ejo.59.1690449241381;
        Thu, 27 Jul 2023 02:14:01 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709060e5a00b00992b50fbbe9sm523100eji.90.2023.07.27.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 02:14:00 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Date:   Thu, 27 Jul 2023 11:13:56 +0200
Message-ID: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add bits found in the ON_OFF_CONFIG register.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index b0832a4c690d..7a28bac7f171 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -243,6 +243,15 @@ enum pmbus_regs {
  */
 #define PB_OPERATION_CONTROL_ON		BIT(7)
 
+/*
+ * ON_OFF_CONFIG
+ */
+#define PB_ON_OFF_CONFIG_POWERUP_CONTROL	BIT(4)
+#define PB_ON_OFF_CONFIG_OPERATION_REQ		BIT(3)
+#define PB_ON_OFF_CONFIG_EN_PIN_REQ		BIT(2)
+#define PB_ON_OFF_CONFIG_POLARITY_HIGH		BIT(1)
+#define PB_ON_OFF_CONFIG_TURN_OFF_FAST		BIT(0)
+
 /*
  * WRITE_PROTECT
  */

base-commit: 60a6aa5742fa499a918b66d80c9baabef56c3adc
-- 
2.41.0

