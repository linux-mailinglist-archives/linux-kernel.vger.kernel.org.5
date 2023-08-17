Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4277EEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347600AbjHQB4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbjHQB4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:56:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF00E48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:56:38 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9c9944da8so6148747a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692237398; x=1692842198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hfGgviSd6nI1b/pDHpUVOT9K8aiYOPruWp9HpRf7ho=;
        b=KfOfRyw3TWSN/rDPR+3GfdmmS7zMSFzG2rFHPqh52zVieyP6FFLBxTdQvfovBr6U+4
         PQVmj1EThxW/4ha7bozSDBG4YQqjj3SiHhN9SCTn5vZB5W0eu9eCOqOLGMwPmsxZHi9s
         CKI3tpS9PYQpNuRjrlko4P6fujeGqauGeKqDvY3ApRxH2E8f680LZjVmP6dgQ+gyw2P9
         bagBAqiGEnXKyYESMV8aoAX1IwPDr/pV3pSPsQaDAvtyOnJMTnq20qnggC9Atk7iVyWf
         tCfrRQ/2QzFn0OPBtcJS8s8W18MrYuRJeZMz4KWAdbmnh4TGk8LzxtrhFNe0QS88o4h0
         1sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692237398; x=1692842198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hfGgviSd6nI1b/pDHpUVOT9K8aiYOPruWp9HpRf7ho=;
        b=BKCbJ8evIDYlvi7kaB9ScDDN7OUiZ4nXvQ7BIAkqET0jCXoj6qwFFd1VhfvyQVFAiG
         hOjKrZcGIb3H0qS8yhkWNNd+o52/oLm41OJwo9PmkFGrmpsvbPnK0W2GIM2rWvzZ2+d8
         1Mh4yutLfzw2Nu6wFDbokq34NWOH+PI9BdN/cgVshcKCSktVx+Gr0c8ZvZzi6Kk7w0nh
         yM3QoQNmliCdNIbPWEMzNyH4+vq0I74Dwr+hAVRlXqaydMy0eKQDvh032kANB/EGaFby
         IfvLNnK5oOhMdVnWEzUS2csRCNaq3hbdM+oh9Sa6oBKc6puQcdw37bq+ThtOxQDYa26X
         1FNQ==
X-Gm-Message-State: AOJu0YzgKmNVAYfc5653kcg0vrvemql+i0s40enQDLdhvUWJVkEPw0bh
        orcJ9FYKSUf2y49oTvSkMtwUfPGNJtSRog==
X-Google-Smtp-Source: AGHT+IGe/Zm6llH9ORhHy0C40Q22+9RifZjmwUnSlRneXimEkaJeTLszj07EQi4Md8oJYMHC+kwDng==
X-Received: by 2002:a05:6830:12c9:b0:6bc:9dfb:43fc with SMTP id a9-20020a05683012c900b006bc9dfb43fcmr3279691otq.36.1692237397875;
        Wed, 16 Aug 2023 18:56:37 -0700 (PDT)
Received: from nocturne.svl.corp.google.com ([2a00:79e1:abc:100:10f9:91ea:43b9:8bba])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001b8c6662094sm13726338plz.188.2023.08.16.18.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 18:56:37 -0700 (PDT)
From:   Nicklaus Choo <nicklauscyc@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Nicklaus Choo <nicklauscyc@gmail.com>
Subject: [PATCH] Fix print formatting warning for some functions in drivers/staging/vme_user/vme.c
Date:   Wed, 16 Aug 2023 18:56:34 -0700
Message-ID: <20230817015634.18428-1-nicklauscyc@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Nicklaus Choo <nicklauscyc@gmail.com>
---
 drivers/staging/vme_user/vme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index b5555683a069..d583c4abbf50 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1742,12 +1742,12 @@ int vme_slot_num(struct vme_dev *vdev)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		pr_err("Can't find VME bus\n");
 		return -EINVAL;
 	}
 
 	if (!bridge->slot_get) {
-		printk(KERN_WARNING "vme_slot_num not supported\n");
+		pr_warn("%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.41.0

