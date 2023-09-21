Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6947A913A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIUDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIUDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:21:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A0F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5780040cb81so315579a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1695266486; x=1695871286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWipJlFZbM4YKAg+kUj2K0xbQNVWSm/6S2rT+1aBy/Y=;
        b=dF4iPNZiV/QfKvkDPIytCmRCi1buxrqZiio7rrqScNXJyGQcnUIAD14AvMpvN4m5z/
         dokW7sGXXcblbWYdT2WKmx2OXbfkRTtQeotsD8MB+zdEUTKRxgd7c1GxJppfHT5zU4aB
         adXyPdiyV8hFv6efc7BmzL1/vXJUc+5ULAQNttupzh2OoHSl8d8Hv9IB7BIF5wJgMCJl
         uVXb5gQJppLHegvw5jgIe6hQ5VsDRU3RvQ3jfkuKgNw9v2yDzTccZUrERZ1X9bFjn0A8
         4RcD48xh2SWH1hcBSQShSTXZvumWDFB/gvq+V0NJdcIaBKpUFALGd26ZdY9ivXB9OcGp
         mC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266486; x=1695871286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWipJlFZbM4YKAg+kUj2K0xbQNVWSm/6S2rT+1aBy/Y=;
        b=KJIZun5V4Eg7pUOJfrrmXa6ZyCDtvBpZhAMAMcYx8ssC/8YSOFS6QkczMX5yDrv06Q
         UgbNOujiwLw2KW9KOsT6/lACys3RY9T4QE2eTgUK5mEHsTtH3Qn5xfi7a4g+L+ofDAHY
         8uUzNHr9yiDa+N5I1kFkgxScsrlNXqSuw/5evS4rhmcyDc391t9WDWeK5TRdBsO/uQrV
         kG0KOp2hlrX4pvlOPNX1G99xMnrdINzMQT5SiCIldeyyTnKY7fLYypJa1TyiPfcUWFvO
         exHSdRB1SXdPp9/SKptnh6GEynrdDataz8iNdmnrh48iV6QDO4U+hfBNhFKESZocfde5
         x3dA==
X-Gm-Message-State: AOJu0YyalI3G/Bwev0JpqW2Z8jj5jrG9q9E1AGu/SpgZ4v07fgQe0g28
        oQyZhgiUgxouOjBGFThvK5icMg==
X-Google-Smtp-Source: AGHT+IG6autl2H7Q76IFP7iq7R8Jl8qIPbMQGrmuceCL90rKqOePFrrOh/3ACu51r4dUWhqWU/4OCQ==
X-Received: by 2002:a05:6a20:6a1a:b0:158:17e6:7a6 with SMTP id p26-20020a056a206a1a00b0015817e607a6mr4466137pzk.42.1695266486355;
        Wed, 20 Sep 2023 20:21:26 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0068e49cb1692sm237324pff.1.2023.09.20.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:21:26 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/11] Staging: rtl8192e: Rename variable Time
Date:   Wed, 20 Sep 2023 20:25:05 -0700
Message-ID: <20230921032515.96152-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
References: <20230921032515.96152-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Time to time to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index a57673ecf791..fbac0e598cf9 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -10,11 +10,11 @@
 #include "rtllib.h"
 #include "rtl819x_BA.h"
 
-static void activate_ba_entry(struct ba_record *pBA, u16 Time)
+static void activate_ba_entry(struct ba_record *pBA, u16 time)
 {
 	pBA->b_valid = true;
-	if (Time != 0)
-		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(Time));
+	if (time != 0)
+		mod_timer(&pBA->timer, jiffies + msecs_to_jiffies(time));
 }
 
 static void deactivate_ba_entry(struct rtllib_device *ieee, struct ba_record *pBA)
-- 
2.39.2

