Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0547AEAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjIZKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:53:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E129B4;
        Tue, 26 Sep 2023 03:53:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578b4997decso6558894a12.0;
        Tue, 26 Sep 2023 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725615; x=1696330415; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIOtiw4Vu/5LT/q28eVE3Dtmyg66prHjYei1I5nWOjs=;
        b=QNPLkVwX/xUWmgWocrqta2A2+0Vn6B2n5h3LmTpw0Q52FO3dsrw7pfa11RTbVYPy3/
         mfG4iGAXmEhBRCXAr9U90LsxHy7nJHObA4YytKAABWK8rebnccT9ztJkuPKU+Q5u8LYx
         5riiHMj8eLAqMsoq/9DXoJSe9s6RsoL32XT+XsewsXzlZ+nvP3NFHT0OECHkitF/owSh
         eESWjLu+tqLLp9OXkve4wotiG+aEW4xbR/cns5V70RgBHld3C0FVWlXR0cugy6W+5E+r
         P2TqOqwL2pTHSTNgTkLBe5WREGDv5ntM91Lza+TkGBl9Kjft3N5VlMWBeqLBNxYewnR3
         2tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725615; x=1696330415;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIOtiw4Vu/5LT/q28eVE3Dtmyg66prHjYei1I5nWOjs=;
        b=F3g4jDpVrQk7+KXoPlB8XrVk0iO6ijIH42EO21O8nCdsTROZSse/z+L5OUIm5uqJnJ
         S4K3T+ZdGwK5MCvWXArEDeiI740FahBCzUzkZreM02V+F5acCIszvC9odrDmhBUQeGM3
         17E4cVjmstlH1BaBYOo5UAXLjv1nhvdbHZCQTlq/MNk50AtrWyzIhjCB4+iT1H1tAxE6
         /3kxN32RLvwvqZCCo2KgJQ8flTB+DkDl7JntgJkkY/7Ow5pIsH409Y6iOQ3Ay3QIUf5s
         yOQyEKFHQpvqJ5VkOrsk2bL8nHk4kTX9vE7IlYFu6iw/mA0KdO/MOaaWELqvNg8JziJJ
         5t4Q==
X-Gm-Message-State: AOJu0Yz36Ln761Vyp0nb+BIUQ8XqB1r4bnqgNgZfXZhtonOKFyVTjfev
        Z7akRwnt3D7QLtuQQFQlQ/o=
X-Google-Smtp-Source: AGHT+IGNucwzMarZ64hyme5OSMHfFeU8XflGBVJxo1PNxfECkFjBUPA9h6rwr6R1/vrmIvpw06cCnQ==
X-Received: by 2002:a05:6a20:3ba8:b0:15d:ccf3:939c with SMTP id b40-20020a056a203ba800b0015dccf3939cmr9074771pzh.35.1695725614578;
        Tue, 26 Sep 2023 03:53:34 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001bdc8a5e96csm10645022plt.169.2023.09.26.03.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:53:34 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] media: s5p-mfc: Fix potential deadlock on condlock
Date:   Tue, 26 Sep 2023 10:53:30 +0000
Message-Id: <20230926105330.10281-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &dev->condlock is acquired under irq context along the following
call chain from s5p_mfc_irq(), other acquisition of the same lock
inside process context or softirq context should disable irq avoid double
lock. enc_post_frame_start() seems to be one such function that execute
under process context or softirq context.

<deadlock #1>

enc_post_frame_start()
--> clear_work_bit()
--> spin_loc(&dev->condlock)
<interrupt>
   --> s5p_mfc_irq()
   --> s5p_mfc_handle_frame()
   --> clear_work_bit()
   --> spin_lock(&dev->condlock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch change clear_work_bit()
inside enc_post_frame_start() to clear_work_bit_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index f62703cebb77..4b4c129c09e7 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1297,7 +1297,7 @@ static int enc_post_frame_start(struct s5p_mfc_ctx *ctx)
 	if (ctx->state == MFCINST_FINISHING && ctx->ref_queue_cnt == 0)
 		src_ready = false;
 	if (!src_ready || ctx->dst_queue_cnt == 0)
-		clear_work_bit(ctx);
+		clear_work_bit_irqsave(ctx);
 
 	return 0;
 }
-- 
2.17.1

