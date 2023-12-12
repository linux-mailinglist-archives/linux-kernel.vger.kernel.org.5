Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E759A80E634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjLLIee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjLLIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:34:31 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8DF4;
        Tue, 12 Dec 2023 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702370077; bh=zLSyEthe/4DdR0aMOzSw83eC3jPiBmnxF3nl//8MZOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyqBLI/OkkMdG6cucpZJFmVXKgh5VPYfOk21KK0u9B6fUAKfQXegJsAUdTmf4gqlj
         yOQhi7iFqqaYdbrJtYDXgxTjaD8C8mLR9s77oorZPMGa+P5qE81veVyuxIyedTyKDB
         wuEFj3q/M0XjC+fHizVAIUYIE749XV7ce5SxOdPbINMj64QoC+JDtBLSBnVLuK4l0I
         ZXz55vYWH1CYLDGyK2CbGuSyDX5NRWPiiGMP8HWb0DVJ7hNxQn+Hs55py7jFZoMzow
         2r3qWklXrDK05o1RfMlBCTww2P0ObxTz1X3Rd2TvUKpSqupCsk4wy9/aaCds2hJr6o
         hyJ6hlfIV4u7w==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 14317100A0A; Tue, 12 Dec 2023 08:34:37 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702370062; bh=zLSyEthe/4DdR0aMOzSw83eC3jPiBmnxF3nl//8MZOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7HBSbPRNlgNEn/WY/PFOS1JEExoS8AETzZ7hNtdRp7LLT/w9/xlkdK4y7NLWJQ2k
         Zsv36ias08FSMct0CpsubAIfFg/n3XzW3vczfBAgiBjoMGp2KzL0uJXYo3tSQtHYaE
         +jbzf4Gd9LhXr9jgidPeciI90Q+q206fS5DgmZu9S2F7Lp1NvrDIWfXJj6yPmdF/Ji
         v61xT4EfXvLrRKYHJiT7BFxwyuOHlHrmp7uZRYznA28V7sv3AE64VO5JjogzBf7mVq
         riHgJKENAUunnS9GUvnM/avtFghNxAsVRNiOyMyKCjgtGyZafJobM7miIIo82BXB+S
         /ATUaiKvk8E6w==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 332A610006D;
        Tue, 12 Dec 2023 08:34:22 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] pwm: renesas: Remove unused include
Date:   Tue, 12 Dec 2023 08:34:02 +0000
Message-ID: <4c135f9cd23592b1646a4151e86ef4ea0321d4ef.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702369869.git.sean@mess.org>
References: <cover.1702369869.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No mutex is used in this driver.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-renesas-tpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ce92db1f85113..28265fdfc92a9 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0

