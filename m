Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD75E7B9F82
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjJEOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjJEOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:22:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289327B01
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:31:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so172374766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696512666; x=1697117466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiSMw0DH0YnEshhxsB4lPXfkEW4kd1IPdZ6vz5cekDQ=;
        b=NYiTR2Xlv2MbjTyZuRmw3riOMm8mWQg96PO9TFNpseIVFUW6eTnlOof/EXtXARzEIz
         B1cy7EM7M1gLX56GvnEVfGHLLgxV6kcJnaWjuDnwqBpiB/F/E0uCeq9XUESNl/dpQ1rV
         LB+02q5tG2AD3BsnbhbILTokeIJtjZpSraQ4C/IcchSoyNHt4KRUJx/aXEG0CIm7mEya
         kyCDcV/cYiFANpIlwhafAFRKGNoqvNU1BElVoc5ThcaVUXRh4tmahARJrKlo/c1ksZeR
         ohnPmoo/OEIZR0bVPR/ViZWy5EMSS2oll1G0AaHczULSGYaIKHwHV6mImFg0got9mUZF
         pjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696512666; x=1697117466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiSMw0DH0YnEshhxsB4lPXfkEW4kd1IPdZ6vz5cekDQ=;
        b=ayYMdAUZ2SQ0WTZ360K+Uv6SxIooAKlBWGPbr04QUqb/XLB3ohDQHqyDE3egXE5RwQ
         rP9koSA+xB8ecaXAnznZUi1k3ObZQRoEVS8s6D4vXdzWPwa+BUHggcO4ToypGQ2PRkl8
         zM0O4a/pL4WQ67LJi1ZapYisDaRnpdnSGiuEU7zyzFo15Mt+hXFpDJ0m52g1NHU4ZoGF
         aYPOlC65A99ySlEfOjEMd4uMy/Du7AJnSMmGVY+9nu/HcJLPItERJ6lRq6oBWVksXPZ4
         fyWjr9Exdu3foWLsLdw5Y7XX2DGVAxUI7ZH7+SES2ZiGxIvaF5r1/L1EL4I/S1b2v1pE
         Zxrw==
X-Gm-Message-State: AOJu0YxsWeFfljo3ixoRNESMrdFlEjpmCHdBZPieErXvNTR9059CB72A
        IadN+Ky2lalkx+DFcc+r3aumuA==
X-Google-Smtp-Source: AGHT+IFF+IHtQBijr/E+6rOJo7Nutw2oamkEBNk5ppm10rTS/w8e6IY7YfRd2veiQ/BkPBrXBOevOg==
X-Received: by 2002:a17:906:18a1:b0:9b6:aac1:6fa5 with SMTP id c1-20020a17090618a100b009b6aac16fa5mr4541714ejf.55.1696512665832;
        Thu, 05 Oct 2023 06:31:05 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id b13-20020a170906d10d00b009930c80b87csm1229561ejz.142.2023.10.05.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:31:05 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/regulator: Notify sysfs about status changes
Date:   Thu,  5 Oct 2023 15:30:58 +0200
Message-ID: <20231005133059.917577-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Notify sysfs for state, status & microvolts.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3137e40fcd3e..ef5fa70ae2f1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -98,6 +98,10 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 static void destroy_regulator(struct regulator *regulator);
 static void _regulator_put(struct regulator *regulator);
 
+static struct device_attribute dev_attr_status;
+static struct device_attribute dev_attr_microvolts;
+static struct device_attribute dev_attr_state;
+
 const char *rdev_get_name(struct regulator_dev *rdev)
 {
 	if (rdev->constraints && rdev->constraints->name)
@@ -2798,6 +2802,8 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		_regulator_delay_helper(delay);
 	}
 
+	sysfs_notify(&rdev->dev.kobj, NULL, dev_attr_state.attr.name);
+
 	trace_regulator_enable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -2980,6 +2986,8 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	if (rdev->desc->off_on_delay)
 		rdev->last_off = ktime_get_boottime();
 
+	sysfs_notify(&rdev->dev.kobj, NULL, dev_attr_state.attr.name);
+
 	trace_regulator_disable_complete(rdev_get_name(rdev));
 
 	return 0;
@@ -4848,8 +4856,21 @@ EXPORT_SYMBOL_GPL(regulator_unregister_notifier);
 static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
+	const char *name;
+	int ret;
+
 	/* call rdev chain first */
-	return blocking_notifier_call_chain(&rdev->notifier, event, data);
+	ret =  blocking_notifier_call_chain(&rdev->notifier, event, data);
+
+	if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
+		name = dev_attr_microvolts.attr.name;
+		sysfs_notify(&rdev->dev.kobj, NULL, name);
+	} else {
+		name = dev_attr_status.attr.name;
+		sysfs_notify(&rdev->dev.kobj, NULL, name);
+	}
+
+	return ret;
 }
 
 int _regulator_bulk_get(struct device *dev, int num_consumers,

base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
-- 
2.41.0

