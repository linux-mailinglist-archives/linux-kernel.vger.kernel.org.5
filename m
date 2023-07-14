Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45114753A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjGNMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjGNMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:08:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210E358D;
        Fri, 14 Jul 2023 05:08:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9922d6f003cso241551366b.0;
        Fri, 14 Jul 2023 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689336512; x=1691928512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIFl8xI2UuButzAPajsmIgl+1a2EybRrJWZfodELGUY=;
        b=aVNQhIPQ1nkqW5pkVpZdSjcL6JZy9VedWY2TZHdFs0Lu7/c2LpssorRCvcSTCioaBA
         iCNUmw5Efykan1bmbS11TBRHhNY3ryMQACoTDO11aEOvIA3kIgnLF6dBa9fZsYyxECFi
         n9XU5n+danqERRXMIbR/IXKpBwwnrrhHFYBDH1Oi1mRB4ImVyNclf9Zjwq1/8V2jcMR/
         n6p83BdU82ZU2WHwVFkNeZO3bAnDwdSeqEKNiA4spxHbzZQb+HBORs+Pks5oswT19hHG
         V8ItEOdMC/5XGUFGzrKsqw3xUop9xFU6nkbZBGRUXJKabP834zs2VNGCbMlIUPr50Qcu
         +y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336512; x=1691928512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIFl8xI2UuButzAPajsmIgl+1a2EybRrJWZfodELGUY=;
        b=Fvug0N5fFmFXO4OnXDFiUkS/rDF2h1IMcfoqYYPAnVI6hRkmcO+5uwXCRKrEwhn7gt
         1GZN+ZM4jXozC0UOY6hDvHFyxB2KFewCJxj8DPQ/zPmklCDYD5DQtIIuChmq2mNC0BOJ
         zyYQgU1MASk+fBzVlHpxhHS3idsmYJBrbyiMHe6X7LeYTWbnZXbnUuz2G1j1upPI+ZVk
         FWjHOWt5P84gN5oZNNYSg8Hn+BsrjuygIkGVUIAkoaiL2bGqNRZH6v63A/IbGO+BCTEk
         37Uu/F+RsyGEPI58ARYzBV3ky0alyxIZNf03QT1Dn/doo3jaxRQWewNsihIZvKGcOUNR
         h8zA==
X-Gm-Message-State: ABy/qLb270s/iCuGMAr17mIeIs1H6sriNBgmQdfYBsztfOYbx8+bS0th
        zP0tPgRg9npOIKeYxANZdNWmNrUrsLa7YA==
X-Google-Smtp-Source: APBJJlH1q7yzLA0bE26y5w8EyiRv4iKEZe0nRQzu/y4KSzbt2jvjkm0gwGSyym2gR35OsQskcy8z0g==
X-Received: by 2002:a17:906:ce3a:b0:988:9d0f:db52 with SMTP id sd26-20020a170906ce3a00b009889d0fdb52mr3941880ejb.35.1689336512361;
        Fri, 14 Jul 2023 05:08:32 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id hb24-20020a170906b89800b00977c7566ccbsm5238148ejb.164.2023.07.14.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:08:31 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>, stable@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout
Date:   Fri, 14 Jul 2023 14:07:11 +0200
Message-ID: <20230714120712.16721-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for
temperature sensor offsets") changed aqc_get_ctrl_val() to return
the value through a parameter instead of through the return value,
but didn't fix up a case that relied on the old behavior. Fix it
to use the proper received value and not the return code.

Fixes: 662d20b3a5af ("hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a981f7086114..a997dbcb563f 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1027,7 +1027,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			if (ret < 0)
 				return ret;
 
-			*val = aqc_percent_to_pwm(ret);
+			*val = aqc_percent_to_pwm(*val);
 			break;
 		}
 		break;
-- 
2.35.0

