Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E578E262
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbjH3WiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjH3WiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:38:08 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87FA9C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:37:47 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd346CkXzkh;
        Wed, 30 Aug 2023 23:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431536; bh=xYl17I+K4wwzgyiz7kt9ZmAtiqFq9MsVBbItAFx3V0A=;
        h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
        b=r6kVIleCqglHZlbLhc/FYoJBnRTlxyUjY9DAbOgPEpjk3j3YxcdYRANIWQ1MCsVe+
         BQ5Idgab6JjUMB1xazx+4K+efQZrWQN6oNqanAcdt7btdSY6IY53OVncN2656Qwt8t
         DRNBmib0ybN8AJT04SYyHmgI9lyHusKJd9UlRfuzFnaCkSs4Z6+LTNJPE615csmtw7
         j8+blDEZOhAPKaP9YbMHD88mRjy01OJfxfS4W+2p1K8gZbNwXQYgO0u2xLAJ/Eyxr8
         LVPyJQVTYq/otNwvVoVpdENcQtJRaZ+R6iEtU1MN+XVKHw3F0nwtnQifCy/I0CJv5m
         owLm8R2n+9uIg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:56 +0200
Message-Id: <5bcecac45e38eaec2c7df25996f518444279520c.1693431144.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 7/9] regulator/core: remove regulator_get_init_drvdata()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree users.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c         | 6 ------
 include/linux/regulator/driver.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c8d1b12ee43b..7c4ba090d88d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5881,12 +5881,6 @@ struct regmap *rdev_get_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(rdev_get_regmap);
 
-void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
-{
-	return reg_init_data->driver_data;
-}
-EXPORT_SYMBOL_GPL(regulator_get_init_drvdata);
-
 #ifdef CONFIG_DEBUG_FS
 static int supply_map_show(struct seq_file *sf, void *data)
 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4b7eceb3828b..827888b4b16c 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -758,7 +758,6 @@ int regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
 int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
-void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 int regulator_find_closest_bigger(unsigned int target, const unsigned int *table,
 				  unsigned int num_sel, unsigned int *sel);
 int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
-- 
2.39.2

