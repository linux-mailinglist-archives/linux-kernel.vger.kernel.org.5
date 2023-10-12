Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4597C7A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443062AbjJLXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443042AbjJLXJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:09:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61951A9;
        Thu, 12 Oct 2023 16:09:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso205686b3a.3;
        Thu, 12 Oct 2023 16:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152192; x=1697756992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wklHuRjtu9eKbC21KJ0qhgZYz7A3pvh/X6lpMyLNrM=;
        b=v+ke/KCUyICRQEdWVlOAFOqgTa0Sgz0YhoFCwUC1Hv8vUEGUqhX49lhQeKx74RzqFd
         1+fkccDKj4UXLOvCv+l5gGyuaZZGNeCF1GIugAIknNG7uHZHOZFJ8F9DJIUvetVORxWq
         cpp2I2KogxzEWfq2HaYdxsLYoFrr1yVt+Ejiq3Bd7R5nldzkJiD5/WIZ76f1sB+Mt3IG
         Dlwz+dCM3c+UFwnzVxiaieMDeNtxowVpmkyFF02//g3zQrAXSmmvo0bMST1fK5GWV99S
         EZlenNEzhNXaP0afr5Ou2lGlpxdiQ/t41+91d3K/b7cNHbHxpYQabPAnRoJYvrXogJx2
         ExoQ==
X-Gm-Message-State: AOJu0YwrmWthZuHM+qcjseNFv8U83IqEvtFx3bj5cUUKbRV4BDysS0iY
        XLj2HxLfxyooowtpm32USwZQA6IikPTHhy3d
X-Google-Smtp-Source: AGHT+IHvsCDN04Ikusz/wjPmqe2Bfs6yIv+y6wzyHh6AF+oowBYFNSfMXE3TPdFvoJQ/Y9nmBEzuMA==
X-Received: by 2002:a05:6a00:1255:b0:68a:5449:7436 with SMTP id u21-20020a056a00125500b0068a54497436mr27851303pfi.32.1697152191710;
        Thu, 12 Oct 2023 16:09:51 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b0059d34fb9ccasm2244765pga.2.2023.10.12.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:09:51 -0700 (PDT)
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697152189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8wklHuRjtu9eKbC21KJ0qhgZYz7A3pvh/X6lpMyLNrM=;
        b=jkUICrkHhzZYt0gxJJyhhDOcCLpoM+WvLDhOzH9js7npKWtH1hyBo+LGns3xP1WqjyQUOH
        SvR3l1WcH+kWpfmcf0jzRfVRFeyheehJnlaoNFiMQv++O/xqSf+eoYaM0eIe96haeAPV7l
        /vxbaTBBYb8iQv/z5Gpj+0FEcwn8NHCg7vr2etuFp065BpSgpSBaZmfF+TdK8XT8CIrb5b
        w1lsV7t083yEea0tBFEiKzOKG8VrvcsLF4kqI23ntaVVlMUMZ+g9AVqfOhX5c+RoeBCB1+
        Xwjd5ekArbsun+VV/vwGvG/183QCvFsyuE3mA4ZyqCxUbPT1x0S84fg3YQFsBw==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To:     Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
Subject: [PATCH] media: pvrusb2: fix use after free on context disconnection
Date:   Thu, 12 Oct 2023 20:09:12 -0300
Message-ID: <20231012230911.48113-2-ricardo@marliere.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon module load, a kthread is created targeting the
pvr2_context_thread_func function, which may call pvr2_context_destroy
and thus call kfree() on the context object. However, that might happen
before the usb hub_event handler is able to notify the driver. This
patch adds a sanity check before the invalid read reported by syzbot,
within the context disconnection call stack.

Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a02a4205fff8eb92@google.com/
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 14170a5d72b3..1764674de98b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -268,7 +268,8 @@ void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
 	mp->disconnect_flag = !0;
-	pvr2_context_notify(mp);
+	if (!pvr2_context_shutok())
+		pvr2_context_notify(mp);
 }
 
 
-- 
2.42.0

