Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283A78536F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjHWJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjHWI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:58:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5419A6;
        Wed, 23 Aug 2023 01:54:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso43281741fa.1;
        Wed, 23 Aug 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780889; x=1693385689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=Sy/NCDXkCZin/+NycWRiYEWKtdkDBzopVQ7kv139T3K7UCae5dMGr/U7va70x4eTcj
         P9Xsm7TSMqdCWUZGc7HwsSW0awPLIFowu0ycYjeipsl1edYONGtcUrhYI+XEjuma9VPt
         qYmFymGUKPrk0aDq8mMHH+QqY36SsQ0njUASXSogMg4ml0uLsWUoooS0x2hNPAftAuMk
         QkuzVgJ1erhBAy6GKwoO5W4wNxTlCG1R9sXiO722rj50x+2OReu/SurONQSqkt/E5Tiu
         QXK49viO/7VQLHGLMQFRTC+xe7jUI/NiA6lbiuKCH6IR+4Na+9WhTwfYh3OSMmpOgGCE
         VUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780889; x=1693385689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=dSQ6SKfkeiLD9TkxvkcDhwLHD+M7uUKTTL4SWG7PzQkoiQXIlY7B2rdAzyQVteWPqw
         IcCIHPjrvpFAq2+dOlGy9axXy0yqPSP+mHLZGigjqKJPm7VDzCOxw/A1YjaaOvjGZh9d
         WPBinhwIPGqNVJQ36GvmcVLQJzyKJE60MQeIx4r+K3IJdXxgJ0QqGTAhxRLvhuBhacW+
         ITWwXdm4+2QKc/ptsfrAIU7rAlbhE4t9TW6mMzpLKytm8dFQaHQmvo5JfpJFCNVKyXL9
         m7f8BhuiDQOKS5fkr4ndjvKiLFFRo2JRkPlUd/U2vXh80zulmcRASYpyT90P12DbQK1p
         POHw==
X-Gm-Message-State: AOJu0YyW+iSOv5KCh92LhbgIbu+hxyE/zesGzsK0e09Oh2pvT7sPEQnp
        4A/xsorbtePcJV6qD3vIvxDsjCwBZsebgw==
X-Google-Smtp-Source: AGHT+IHgk3D9e1v+N1TnoJ2cmm9pMqdjPPYyCQTyICyrvuzndJXyHdOsLy1+JBqbqy+9qU6WJyiT/Q==
X-Received: by 2002:a2e:3c0e:0:b0:2b6:3651:f12f with SMTP id j14-20020a2e3c0e000000b002b63651f12fmr9533149lja.3.1692780889123;
        Wed, 23 Aug 2023 01:54:49 -0700 (PDT)
Received: from gba-Precision-5530.kat.ac.za ([196.24.39.242])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fed78b03b4sm16265420wmc.20.2023.08.23.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:54:48 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq conflict
Date:   Wed, 23 Aug 2023 10:54:30 +0200
Message-Id: <20230823085430.6610-3-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823085430.6610-1-nemith592@gmail.com>
References: <20230823085430.6610-1-nemith592@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9119b1d51370..cbb45de5a76f 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -851,7 +851,7 @@ static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
 					  NULL, dsps_vbus_threaded_irq,
-					  IRQF_ONESHOT,
+					  IRQF_SHARED,
 					  "vbus", glue);
 	if (error) {
 		glue->vbus_irq = 0;
-- 
2.34.1

