Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6193806A55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbjLFJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjLFJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:06:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92115D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:06:57 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c66b093b86so523753a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20230601.gappssmtp.com; s=20230601; t=1701853617; x=1702458417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkgnInx34MsdRC00k2I9y+o/ne93gzAEsHKwXhaX8A0=;
        b=QimAQ8iyaUOdup2m6AGC1hbBh5vYSjA0MUj+FwRsUAo7Qp4bNh1lLzCyd72ukcNTgm
         pQPCqe7zk9g/1fUO4fqJao6w+GZrS5EulUhZXiz8gH0DJyfzW/EUqsI4jCgBkvkEHO/n
         9s5bKGBplbohpkBfWUZXre7w0wQNUINV4+WDDVqIiedS6Q1vflO/gRj97Pk56dEOQ4zh
         71b4cUyUO11HZlmj691nXXWmCjDkwZ9hFhqWuJyGkWegcW6IHMm8zG4b6bPB0dqZvDAP
         Syx0D3KhmOxBlfYUI/EuZdgrcm19iLhqXXvK0Hpx0bY+rCc4SgFUiCGFVu7mgSiUWQmP
         JpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853617; x=1702458417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkgnInx34MsdRC00k2I9y+o/ne93gzAEsHKwXhaX8A0=;
        b=YvD9WqZpyjJcOFYOvSQemTNJPjipvvjZHWrvbqRVv6DMjVwsWVL/dfR9wEinGhiZmu
         U9W0R26eJSYLlvMYjbDertVdlYtPCeBprFQXMEHff0YMILipEux9a68KU6pNx9ORr5f0
         XHPs50rLQDECACBfHS/EQy4H9a5qPlzFk91uyoq/3mwn0BlyY6vz9gaavOPya8GoCMHX
         j8Ex9JUhZoNDgJP3UN30DJ5aVw5nZDiubNuo4eR4ok0xr3whaQleFJL6EPXfk0PdOYHt
         R+A1BDGAhDHzJdw8uqqA6Wj488N7A88OuqDRF/YZsli+rvXwCOTwG7vYRp/0nrNOrdcC
         EoWQ==
X-Gm-Message-State: AOJu0YzJkY8l5xr60e4C8SahqVxge4RXf3cOeVMleKHoqgKt1I7P5kfm
        A2fm6/AFWwM7ZiS+NpurcZ++iA==
X-Google-Smtp-Source: AGHT+IHrGxsDqoubS9LhJ6U+qoCk+pQ/zFRwTborkh3P26N1W35bYry7lNZkS91ue9idDeKXGjDzeQ==
X-Received: by 2002:a17:90b:1b46:b0:286:c155:10e0 with SMTP id nv6-20020a17090b1b4600b00286c15510e0mr827953pjb.31.1701853616973;
        Wed, 06 Dec 2023 01:06:56 -0800 (PST)
Received: from jensen.next (li999-236.members.linode.com. [45.33.49.236])
        by smtp.gmail.com with ESMTPSA id mi7-20020a17090b4b4700b00286a708cd07sm4967797pjb.57.2023.12.06.01.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:06:56 -0800 (PST)
From:   Jensen Huang <jensenhuang@friendlyarm.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Jensen Huang <jensenhuang@friendlyarm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: rk3x: fix potential spinlock recursion on poll
Date:   Wed,  6 Dec 2023 17:06:40 +0800
Message-ID: <20231206090641.18849-1-jensenhuang@friendlyarm.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possible deadlock scenario (on reboot):
rk3x_i2c_xfer_common(polling)
    -> rk3x_i2c_wait_xfer_poll()
        -> rk3x_i2c_irq(0, i2c);
            --> spin_lock(&i2c->lock);
            ...
        <rk3x i2c interrupt>
        -> rk3x_i2c_irq(0, i2c);
            --> spin_lock(&i2c->lock); (deadlock here)

Store the IRQ number and disable/enable it around the polling transfer.
This patch has been tested on NanoPC-T4.

Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index a044ca0c35a1..94514637c3bd 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -200,6 +200,7 @@ struct rk3x_i2c {
 	struct clk *clk;
 	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
+	int irq;
 
 	/* Settings */
 	struct i2c_timings t;
@@ -1087,13 +1088,18 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
-		rk3x_i2c_start(i2c);
-
 		if (!polling) {
+			rk3x_i2c_start(i2c);
+
 			timeout = wait_event_timeout(i2c->wait, !i2c->busy,
 						     msecs_to_jiffies(WAIT_TIMEOUT));
 		} else {
+			disable_irq(i2c->irq);
+			rk3x_i2c_start(i2c);
+
 			timeout = rk3x_i2c_wait_xfer_poll(i2c);
+
+			enable_irq(i2c->irq);
 		}
 
 		spin_lock_irqsave(&i2c->lock, flags);
@@ -1310,6 +1316,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c->irq = irq;
+
 	platform_set_drvdata(pdev, i2c);
 
 	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
-- 
2.42.0

