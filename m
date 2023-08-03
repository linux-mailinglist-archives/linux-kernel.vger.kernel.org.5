Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A576E67A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjHCLMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHCLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:12:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5003AA9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:12:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso1060305a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691061154; x=1691665954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s50wqnYcuW7vCWAmLFI5zKlzJEcFsQM28qc0cEKNUSo=;
        b=NNnOrn2gpHzni6r0+I2E44v+NVp/J6WhE/ZyRjnjSW7UiRI21X/nEw241plybZTaFx
         MIj7txsnMcYyEMgjv9F2V8eRJJXf0z9bDfq/CAkBCa0EvowLEey2xKcSgK0Yk8Vh7HHj
         5ZEyJvn7kzkfohoQIYhUF0XltgvgniI5rRd1HJEhCZQ+XkrOxEeT3l6IRZy3+dVRfaVX
         WqDkFEXmE0ATnWx9+reCF6zjZ0eeMtiZ5ihnmieiaA7tvVgEOCcpLWFG/ez4prQ8OoP8
         Ed+TKcEBAF9dCb4fxh3s9sJk6jBxNHz9vzt4AEC6mMkOaKb/9Z3r5AEsjuiPpSYO6sYc
         +glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061154; x=1691665954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s50wqnYcuW7vCWAmLFI5zKlzJEcFsQM28qc0cEKNUSo=;
        b=CWCwvHoSlk4I7UC7w+BAAjraP94w5AshxcMJEPxcHZd2AcNiODDmzO2Jl/cLj/ER/o
         t8LN7JulTQjCy05dkddA1OXpBQuIalRio69a9Jh1D+jClQfb7LWExShF3ghcX4duros+
         BZXOK2abc2QjqkZ5YC91ghMF9uJyiTUop5t+aMGOte7yzhnR2U9zm7b0/WSfFFsLbrdc
         t6oz2ajSEIMzOkyN/0BaSWubleemKWKOmOriht6o3CY90vyP0LL09Y0btlnR9Watwxp3
         U45P7//ZhGGwhmP7vU5QlTKnsy3Nss4youDfU9Ldhes8QIReqng8MMPH7cpbfx86aleV
         jVgw==
X-Gm-Message-State: ABy/qLbiBvuV43NjrI1q2bfFrtPriY0JjzlciMKA6Db7EnbRAW3hShe5
        kwkWrQh+4dWH9ipX3NU8krqPhA==
X-Google-Smtp-Source: APBJJlGBuIrXuWxhXPWmcIKc1dZNltXd/w8q32ySlOuR746aIYSuh5xtb01fpaV6NKTb5BpNgTr4Dg==
X-Received: by 2002:a05:6402:1847:b0:521:d23b:f2c5 with SMTP id v7-20020a056402184700b00521d23bf2c5mr7105134edy.14.1691061154721;
        Thu, 03 Aug 2023 04:12:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n17-20020aa7c691000000b0051de018af1esm10027688edq.59.2023.08.03.04.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:12:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: userspace-consumer: Add regulator event support
Date:   Thu,  3 Aug 2023 13:12:25 +0200
Message-ID: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attribute to track regulator events received from regulator
notifier block handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 52 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..a0b980022993 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -29,6 +29,10 @@ struct userspace_consumer_data {
 
 	int num_supplies;
 	struct regulator_bulk_data *supplies;
+
+	struct kobject *kobj;
+	struct notifier_block nb;
+	unsigned long events;
 };
 
 static ssize_t name_show(struct device *dev,
@@ -89,12 +93,30 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static DEFINE_MUTEX(events_lock);
+
+static ssize_t events_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct userspace_consumer_data *data = dev_get_drvdata(dev);
+	unsigned long e;
+
+	mutex_lock(&events_lock);
+	e = data->events;
+	data->events = 0;
+	mutex_unlock(&events_lock);
+
+	return sprintf(buf, "0x%lx\n", e);
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RW(state);
+static DEVICE_ATTR_RO(events);
 
 static struct attribute *attributes[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_events.attr,
 	NULL,
 };
 
@@ -115,12 +137,28 @@ static const struct attribute_group attr_group = {
 	.is_visible =  attr_visible,
 };
 
+static int regulator_userspace_notify(struct notifier_block *nb,
+				      unsigned long event,
+				      void *ignored)
+{
+	struct userspace_consumer_data *data =
+		container_of(nb, struct userspace_consumer_data, nb);
+
+	mutex_lock(&events_lock);
+	data->events |= event;
+	mutex_unlock(&events_lock);
+
+	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
+
+	return NOTIFY_OK;
+}
+
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	int i, ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -153,6 +191,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	drvdata->num_supplies = pdata->num_supplies;
 	drvdata->supplies = pdata->supplies;
 	drvdata->no_autoswitch = pdata->no_autoswitch;
+	drvdata->kobj = &pdev->dev.kobj;
 
 	mutex_init(&drvdata->lock);
 
@@ -186,6 +225,13 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	}
 	drvdata->enabled = !!ret;
 
+	drvdata->nb.notifier_call = regulator_userspace_notify;
+	for (i = 0; i < drvdata->num_supplies; i++) {
+		ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
+		if (ret)
+			goto err_enable;
+	}
+
 	return 0;
 
 err_enable:
@@ -197,6 +243,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 {
 	struct userspace_consumer_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->num_supplies; i++)
+		devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
 
 	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
 

base-commit: 4fb53b2377c364e3753d6e293913b57dad68e98b
-- 
2.41.0

