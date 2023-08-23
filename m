Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764F785A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjHWORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjHWOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:16:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19149E57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:16:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fefe898f76so11021095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692800193; x=1693404993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvNWPXN1vWWitgfBYrpmklA9FyR+CbytrP5PUl8B75w=;
        b=ZE4ZB6/j8h6er5vaMpbTofn3aBl7+DrwhgeiY5EDoWFgAjxk7c2PJAjtCr1oQI+VME
         Gjn5ZEWbtrOLbcu/efdDUmeFpGBkXd0TWOG9FwdULtAgYYoYSpOpPR9m2v4FfUxiiZF2
         z1aSOyK+sJHIdz9fcCjQBanqtaRi/uz2f1czIRkQO70zWol+f952N2DBT1fPO37BvouK
         TiqL8O4VdZ58Sqn9ahePkAxQhD59iqwWb6H1aBZ9FP+ld0zf1YD9cyltWQ3Hv9oICJiM
         MP5cEif/VHuUqk9/UghrQvdkKh3njWHurl7Od5Ew09p5pyEGVaXbcqfZKSZ7JxP4ih2L
         bwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800193; x=1693404993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvNWPXN1vWWitgfBYrpmklA9FyR+CbytrP5PUl8B75w=;
        b=f+93eEF+x+d5XzEW5OK7OkaQPdlzOkKLGTYt7t6w3OZF06kavby7f/vSX0gIM3mIW8
         5tg1EzAbvpSFGVewm+Xvwslt1xowRe9GmLYAhcif/q0WqRv1acOgNG828KC5OFdFqiKw
         AeWD9y521IJhpBd4pe3rVR8//ZSQghYKOrGwB0G6LLqEkUH3TSE+E0loTsGJQlE352sp
         e3v8tBwuYH33XJ43zcVA9Bm3Q97NY7JGRN2ZbLb6sQBLUaJgEAiO+6Y/I1E3XTXRs0O7
         nieHH3i/yE8+5hFCxhc2Dqd8YwKLHSqu6xzxXc50pIkR1eSPbtYhtoO2Yo0sIk2woEkL
         hyFg==
X-Gm-Message-State: AOJu0Yyd2EBzsjsv0Jq2LEjHh/H/mnMAv5Inqea5Z3iyZfUNIvYgAlW5
        csiAmufOOGi7qc6bmz3PDyrZVWerlQOv5uX1DIlC5g==
X-Google-Smtp-Source: AGHT+IFiVKLoqxCoSUoLKsW95IcH8XTq1MRAEeK0UKnbG0ZSbC1ZuYZ95ap/qHhaE8o7qf+/oKRCow==
X-Received: by 2002:a1c:4c17:0:b0:3fa:95c7:e891 with SMTP id z23-20020a1c4c17000000b003fa95c7e891mr9700579wmf.35.1692800193553;
        Wed, 23 Aug 2023 07:16:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c379100b003fe26244858sm17749658wmr.46.2023.08.23.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:16:16 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: userspace-consumer: Use atomic operation
Date:   Wed, 23 Aug 2023 16:15:57 +0200
Message-ID: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace mutexes with atomic operations.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index a0b980022993..a86714bd32fd 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -32,7 +32,7 @@ struct userspace_consumer_data {
 
 	struct kobject *kobj;
 	struct notifier_block nb;
-	unsigned long events;
+	atomic_long_t events;
 };
 
 static ssize_t name_show(struct device *dev,
@@ -99,12 +99,7 @@ static ssize_t events_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	struct userspace_consumer_data *data = dev_get_drvdata(dev);
-	unsigned long e;
-
-	mutex_lock(&events_lock);
-	e = data->events;
-	data->events = 0;
-	mutex_unlock(&events_lock);
+	unsigned long e = atomic_long_xchg(&data->events, 0);
 
 	return sprintf(buf, "0x%lx\n", e);
 }
@@ -144,9 +139,7 @@ static int regulator_userspace_notify(struct notifier_block *nb,
 	struct userspace_consumer_data *data =
 		container_of(nb, struct userspace_consumer_data, nb);
 
-	mutex_lock(&events_lock);
-	data->events |= event;
-	mutex_unlock(&events_lock);
+	atomic_long_or(event, &data->events);
 
 	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
 

base-commit: 8950c4a350c188deb5f5b05df3244d4db82fe3d8
-- 
2.41.0

