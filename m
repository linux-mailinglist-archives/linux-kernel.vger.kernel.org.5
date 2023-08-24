Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB75C787BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbjHXWtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjHXWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC71BFA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88EC64F57
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3991CC433C8;
        Thu, 24 Aug 2023 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692917316;
        bh=PNESehI9Q7IF3No/lyuoFeziIEUo7dChHkjhbNo3naM=;
        h=From:Date:Subject:To:Cc:From;
        b=h8nqcQOySBiDPsWftbV5hnApgG9UztWyablBExiaEKXHaZJn5VxVGfGfJXlqdxCT7
         4YFSmjj85MQ9CVQAuzxqh9PujV4NPKStxw3qkQJvEgvIM3ewPg3udYrd2bQ8XViPXv
         wcoCh69VtbtMTOvL3T17N4Jhmq76DwJHr45lYHh+qxQ0gJbfSgbvF0iFvjFeTSUEFp
         8YX7SuNZo0cO83hCVMdPRMuD6mcQu+/nIOpIwymBEmvTk951kqC/drH+k0WUUjvGYg
         YlsWog4NQUeUvFsY0VVWCAd/ccQ4NZw16F4hHMpiGkRN2LXeutoy3g0njANIIABlGC
         wLOQf5D+E/z+A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 24 Aug 2023 23:48:22 +0100
Subject: [PATCH] regulator: userspace-consumer: Drop event support for this
 cycle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-regulator-remove-status-sysfs-v1-1-554956e8c1ca@kernel.org>
X-B4-Tracking: v=1; b=H4sIADXe52QC/x3MwQpAQBCA4VfRnE2xhLyKHDY7mMJqZonk3W1u/
 3f5H1ASJoU2eUDoZGW/ReRpAsNst4mQXTSYzBRZY0oUmo7FBi+xVn8SarDhUNRbR0UytSurvBl
 cZSE+dqGRr//f9e/7Aewq7LRvAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PNESehI9Q7IF3No/lyuoFeziIEUo7dChHkjhbNo3naM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk595AWuXR3tpVDXzYLIy75MKjrrdMcxwQmvCc7
 fP8W4BUw7eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOfeQAAKCRAk1otyXVSH
 0AlaB/44hzPIVgkcSH9nWnnAuBzcpAatVNGXeUDBKRPEtD6Ks2xinJlQRDps5LOcFPErj5hMMMu
 ymANeWC8C72U7luAuGROt/NJ4d+jN69LsK6L/VXS4PERsMenB8tPw5MQfvpRgsEhk2D1fyX/vMu
 CWKQPY/cJADgK+aBNNFrKrCYL/uGz7PQ3/3ka++s03zqjpZGPtmFAH22ZgyUkreyU3UtSVplt1k
 gtgFJyxJuAw1LVY3q4Mt9j/YiJL68cgKXllOIjHxOUjAV3gYHssoEPAv9G55R/tGjv4/3Nhq/GM
 t2XCfWiLzrUBhpJq3oplwJx/q66OrdaXcuUlyu3ybHEtKJgz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop commit 22475bcc2083 ("regulator: userspace-consumer: Add regulator
event support") since Zev Weiss points out that it leaks the constants
we use for notifications out as ABI which isn't ideal, we should have
something more abstracted there.  There's a definite need for this
feature but it needs some more work on the interface.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/userspace-consumer.c | 52 +---------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index a0b980022993..97f075ed68c9 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -29,10 +29,6 @@ struct userspace_consumer_data {
 
 	int num_supplies;
 	struct regulator_bulk_data *supplies;
-
-	struct kobject *kobj;
-	struct notifier_block nb;
-	unsigned long events;
 };
 
 static ssize_t name_show(struct device *dev,
@@ -93,30 +89,12 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEFINE_MUTEX(events_lock);
-
-static ssize_t events_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	struct userspace_consumer_data *data = dev_get_drvdata(dev);
-	unsigned long e;
-
-	mutex_lock(&events_lock);
-	e = data->events;
-	data->events = 0;
-	mutex_unlock(&events_lock);
-
-	return sprintf(buf, "0x%lx\n", e);
-}
-
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RW(state);
-static DEVICE_ATTR_RO(events);
 
 static struct attribute *attributes[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
-	&dev_attr_events.attr,
 	NULL,
 };
 
@@ -137,28 +115,12 @@ static const struct attribute_group attr_group = {
 	.is_visible =  attr_visible,
 };
 
-static int regulator_userspace_notify(struct notifier_block *nb,
-				      unsigned long event,
-				      void *ignored)
-{
-	struct userspace_consumer_data *data =
-		container_of(nb, struct userspace_consumer_data, nb);
-
-	mutex_lock(&events_lock);
-	data->events |= event;
-	mutex_unlock(&events_lock);
-
-	sysfs_notify(data->kobj, NULL, dev_attr_events.attr.name);
-
-	return NOTIFY_OK;
-}
-
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int i, ret;
+	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -191,7 +153,6 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	drvdata->num_supplies = pdata->num_supplies;
 	drvdata->supplies = pdata->supplies;
 	drvdata->no_autoswitch = pdata->no_autoswitch;
-	drvdata->kobj = &pdev->dev.kobj;
 
 	mutex_init(&drvdata->lock);
 
@@ -225,13 +186,6 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	}
 	drvdata->enabled = !!ret;
 
-	drvdata->nb.notifier_call = regulator_userspace_notify;
-	for (i = 0; i < drvdata->num_supplies; i++) {
-		ret = devm_regulator_register_notifier(drvdata->supplies[i].consumer, &drvdata->nb);
-		if (ret)
-			goto err_enable;
-	}
-
 	return 0;
 
 err_enable:
@@ -243,10 +197,6 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 {
 	struct userspace_consumer_data *data = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < data->num_supplies; i++)
-		devm_regulator_unregister_notifier(data->supplies[i].consumer, &data->nb);
 
 	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
 

---
base-commit: 21cc7f816c670423a9dae06ad7de5fbc40da97c7
change-id: 20230824-regulator-remove-status-sysfs-e27d4618cd6a

Best regards,
-- 
Mark Brown <broonie@kernel.org>

