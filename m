Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3355E7A329B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjIPV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjIPV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 17:28:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1578D1A5;
        Sat, 16 Sep 2023 14:28:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so53240641fa.0;
        Sat, 16 Sep 2023 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694899703; x=1695504503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4Wi30eAqxi74z6532D+2PHxNulQWSGewYfam9dn07c=;
        b=LmN+8m42GpPmPk1MEuEXqLPcSVL2W86zmpNXIn+vxPUi6WxX+tfavc0fkqzw4yEiUI
         ytyvWxsB6q5vepszHc95pMYpaIPDvEE7HSCOXRQQ6hU5cKAbn0bMOPUBCvDqNjK87PaW
         Fd8yrEg8NdHqoVp04bvebCl+BO8o3H36KgbwWL0J8sbjGn8QGx4WlTbnrLJBWy/rTKzC
         3V3JcHdAQQUHkl44ARQBXg2VnANGctQcFbNzbX4Ik0eQPn3c6bn0GoI2/alprBfJD5gq
         bO/Whg/kW38sD6F5VqTEqUSO05oqLGDFhAWbdJF5XJzRyoQjgSB01xddWCGReXQ6QJSe
         xqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694899703; x=1695504503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4Wi30eAqxi74z6532D+2PHxNulQWSGewYfam9dn07c=;
        b=xHYXjQ0T0Z9vUEMtXXzDEovqCPGtxhtB1WLScj863h6SFI2duz0qbPxEV4EqnNTXOG
         nWCKhx6yquVrxkLjErDkO7z5OBFEl6EDdeCqqt7UYsN3WJoKFCr9iAHHVE9fPfJLH/vA
         mGTKQGPDSwQ2B1ZBomNDXwufWhMY4rAcuyEtyRGLdrS2bk0p0uofgE/HHq4eLv+vfnxA
         CHV1CJKhVbmSj+DkmxPn0MkO1W/w7xwcZUfw5ihjLA00zI0IuA+ehRRJq/b0vESVDMwm
         lIhBeDCOZgBA8C2N/UTQ8CGeBX9sShfHHVGl49x1TBJZ+MhOguRzEpfpQdfQ7Wpv4et4
         yybQ==
X-Gm-Message-State: AOJu0Yx2eumUP0UflrQ7fKiXn/vD2FtaCXEsmMyYAx2ocBppkKRi9/UG
        jGvgyn270QWXFW+ydQMslSdfpIM6sKCXkA==
X-Google-Smtp-Source: AGHT+IF8YWvlyWg3HPaYeednUVd3rn7Jp+dJuxE7eDeB8N5w7NjJfbIH1YJvVgEnv3mPDXMMgUhveA==
X-Received: by 2002:a2e:950d:0:b0:2bc:dcd6:97b1 with SMTP id f13-20020a2e950d000000b002bcdcd697b1mr4495087ljh.47.1694899702511;
        Sat, 16 Sep 2023 14:28:22 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-c1aa-e5ad-22b7-62c7.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:c1aa:e5ad:22b7:62c7])
        by smtp.gmail.com with ESMTPSA id cw17-20020a170906c79100b009a1a5a7ebacsm4117567ejb.201.2023.09.16.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 14:28:22 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sat, 16 Sep 2023 23:28:18 +0200
Subject: [PATCH] Input: powermate - fix use-after-free in
 powermate_config_complete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPEdBmUC/x2NQQrDIBQFrxL+uoImkGCvUkowv89GSFW+pi2E3
 L3S5cxi5qACCSh07Q4SvEMJKTYwl454dfEJFR6Nqdf9oK0ZVU05sMrpA3m5inkvmJ2vkNkLoHj
 SA092tGwNtcjiCtQiLvLaMnHftiazwIfv/3q7n+cPRBKSgYUAAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694899701; l=1588;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=MOtjOjGctqmbOeILqG8GCyG823EYZNV4T1oZhE/JWNw=;
 b=/O5dX8BkYFUeoX9xnZzPE9IPokF/qf6mHmEcyfIpLse+q6YXom7Nt8G4F10CsHR9SJCfx/jhz
 kCz53G0RikvDh3d22UfoIONC6yYDhx/spwHmD1WKn9dYaHuIDuu3xZv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a use-after-free bug [1] in the powermate driver. This
happens when the device is disconnected, which leads to a memory free
from the powermate_device struct.
When an asynchronous control message completes after the kfree and its
callback is invoked, the lock does not exist anymore and hence the bug.

Return immediately if the URB status is -ESHUTDOWN (the actual status
that triggered this bug) or -ENOENT, avoiding any access to potentially
freed memory.

[1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
---
 drivers/input/misc/powermate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c1c733a9cb89..f61333fea35f 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -196,8 +196,11 @@ static void powermate_config_complete(struct urb *urb)
 	struct powermate_device *pm = urb->context;
 	unsigned long flags;
 
-	if (urb->status)
+	if (urb->status) {
 		printk(KERN_ERR "powermate: config urb returned %d\n", urb->status);
+		if (status == -ENOENT || status == -ESHUTDOWN)
+			return;
+	}
 
 	spin_lock_irqsave(&pm->lock, flags);
 	powermate_sync_state(pm);

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230916-topic-powermate_use_after_free-c703c7969c91

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

