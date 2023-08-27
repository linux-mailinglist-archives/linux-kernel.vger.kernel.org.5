Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340578A117
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjH0SyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjH0Sx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:53:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECCDEB;
        Sun, 27 Aug 2023 11:53:55 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a9b41ffe11so1562384b6e.2;
        Sun, 27 Aug 2023 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693162435; x=1693767235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KaI3PfD8joR99TjMB7Mb3TjzWqZ8IotMwduAcjhk/lk=;
        b=UBOTVkj6afa8ANx8oC3soCEe93c7nuROSgHLTdnbhSsGHkrjseEaM/x7ttpL+nGNhX
         FNgPudGf0JGGEJg3vGkMZAWjWFXqfeypEwVBDcGbywBUtDxoTNURfV+wmQx0OYREVO0m
         N+53okvoOAqFrGIop8anyx/hvDx1BOxk8eGqirtZ+c1GCHJd4xxoHkOKK656F0tBi28K
         m3LvQxcDT24oFk+IwGn6NvCFGzIhdGnrdz9zjJZXnELi/ylK+r4ZvRE5q3zFefMFdKFX
         PpEAd+Ps1a+gztiEPgAksBvQcjCfh5RpTHMNL7y+otyLClzW7HHys5WhgKKMiNeYo/Zj
         8hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693162435; x=1693767235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaI3PfD8joR99TjMB7Mb3TjzWqZ8IotMwduAcjhk/lk=;
        b=dZL5Zg8MKa+q0FMaykyJzMHn+GkJOnOuqK5V0p1IqS3ri/PIUZpEwSv51mk2Nxspzz
         +ckc9rcO4EkmwfX7HEzg9Z5zfU9I8ak08/Rg+ULndIdtLOs8Hp+vNgFwPUUN4zLaE5tu
         RVQXw3xxU4Bgrs32Mq8KFjIER8OqDb2A3A8Cf1hZk5QEfz7uyRmDVaUi6MjRxoA43A0B
         XuS3rr8Dhqs3/VnDowcHlyMNSm4D1Djf+f1Mg8zKPRspyqpXgzeha14ojK9HZt6G2cX6
         Vue/e5KHYD5So1mXaor2bg+4fN+9YsFNvELxQYrzo4GmaZzAheSM3EpXICTHR1JiwzY3
         2rmw==
X-Gm-Message-State: AOJu0YyYpm/i0WleWUA25LYNVSAq4WmggtW6NPc/T4CsA19KjUzQdyC+
        8DHs8qGIwX0AJICVXeFTkjJQ40nqNhY=
X-Google-Smtp-Source: AGHT+IFXksIvo10D/RzlONjGABJrmWT89zl4Fs/Y/OpspCazjc4yZk2UhbkiHhh2cd8y7fYSSY5sAA==
X-Received: by 2002:a54:4482:0:b0:3a8:72e9:e173 with SMTP id v2-20020a544482000000b003a872e9e173mr8301399oiv.24.1693162434875;
        Sun, 27 Aug 2023 11:53:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100a:a3bb:1543:4287:715f:7d])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b0066684d8115bsm5310497pfn.178.2023.08.27.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 11:53:54 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v5] media: gspca: cpia1: shift-out-of-bounds in set_flicker
Date:   Mon, 28 Aug 2023 00:23:48 +0530
Message-Id: <20230827185348.34768-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Syzkaller reported the following issue:
UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'

When the value of the variable "sd->params.exposure.gain" exceeds the
number of bits in an integer, a shift-out-of-bounds error is reported. It
is triggered because the variable "currentexp" cannot be left-shifted by
more than the number of bits in an integer. In order to avoid invalid
range during left-shift, the conditional expression is added.


Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
Changed the patch. Instead of avoiding shift operation for invalid
input of 'exposure.gain', throw an error for invalid range.
v2->v3
Changed the commit message details
v3->v4
Removed the trailing spaces in commit message
v4->v5
Replaced the hardcoded value with inbuilt macro
---
 drivers/media/usb/gspca/cpia1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 46ed95483e22..5f5fa851ca64 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -18,6 +18,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1028,6 +1029,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.25.1

