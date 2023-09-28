Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2D7B2841
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjI1WOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjI1WN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9269619E;
        Thu, 28 Sep 2023 15:13:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so220317671fa.3;
        Thu, 28 Sep 2023 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695939233; x=1696544033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq2t+OD4VTk72D2hdW1SrM0Er27y64WW6rpsPl+trdQ=;
        b=Q2da+FkephX0zw2mmksk2u/DYy5WCcR3JyMRGvLQ0UqnAYs4wO4ykFt2/1Wj+aML8l
         IR9FKq3ZGkOq93XePBU0Pgo/JNEAh+We5CsxD43nCbHz/PrKFMbTSTtRQDlzXpyuhV5s
         wpO6Y02oDlR93Q+QEXx0PGuqX5x3VsSohm2vODGk3J3+k3z1O/22kBYHXmruZqkBtn9A
         mGVC6ARNgeVxYgeRg9ruc2aYsi5kbqcAHBT1i/Jmj7nNgXGH7ZIe2s4mLaKqnvsJioeu
         VoqisEXwTo9T6a2vQyG/Xq/uImAibuOLaKf9fcSbpBnmq2EVvkWcziouYYtFMR6BY/S1
         ocWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695939233; x=1696544033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq2t+OD4VTk72D2hdW1SrM0Er27y64WW6rpsPl+trdQ=;
        b=StZdSotHxSkrGqT5FJ/E5UDaKx+4y2UhpH4N5Ky7ga4J5GW14Rmd0rjJ31Y6YmAW0Y
         oj852PVMK/oL8/zECvx+JnD0PB8JG1JsxigdIPv50DZLC9hZI9wZmas8Uft/9MuEt4Sx
         Ozk5L6XGOs10vtsQP84YkGSNhNkkTTxqAC0+4qBwuah6dKgP8BZcpGEg/kksQKSBKoOc
         qZfyKoegLBntUcSMZ4WbU1rRvzo6MuEfDCTYT8fZW12WMxxh8HAcc9JSfzvyp2KQJHF8
         +8ZYRrrQ8OXCVglpOxfDAgGDuflLWuYwmG87fPfvb3PDxm1b/ejD5P6/wifcY1k42gt5
         RIKw==
X-Gm-Message-State: AOJu0Yylw0AzeXYg5Q55G+b23hCJR5YEXyxAFwQmHQCLoqUtMX1dFKTV
        QJb6Nful+Rx4FS4Vrc40wso=
X-Google-Smtp-Source: AGHT+IGq/HJCv/TQyYhBN1FLL/mQM74PyAHZ3lzrTJ+VQSje+cdDzW4VgDwUTEte70l2elXc2zPVWQ==
X-Received: by 2002:a2e:8757:0:b0:2bc:bd41:ab7c with SMTP id q23-20020a2e8757000000b002bcbd41ab7cmr2213430ljj.53.1695939232575;
        Thu, 28 Sep 2023 15:13:52 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id g8-20020a2eb5c8000000b002c18acb1873sm656331ljn.7.2023.09.28.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:13:52 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     lenb@kernel.org, rui.zhang@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] drivers: acpi: Fix formatting issues where braces should be on newlines
Date:   Fri, 29 Sep 2023 00:13:44 +0200
Message-Id: <20230928221344.44289-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix the following formatting issues in thermal.c:
 * braces following function declarations should be on a new line
 * add single line between function declarations

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/acpi/thermal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 312730f8272e..dea5f8a51f87 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1046,7 +1046,8 @@ static struct acpi_driver acpi_thermal_driver = {
 	.drv.pm = &acpi_thermal_pm,
 };
 
-static int thermal_act(const struct dmi_system_id *d) {
+static int thermal_act(const struct dmi_system_id *d)
+{
 	if (act == 0) {
 		pr_notice("%s detected: disabling all active thermal trip points\n",
 			  d->ident);
@@ -1054,13 +1055,17 @@ static int thermal_act(const struct dmi_system_id *d) {
 	}
 	return 0;
 }
-static int thermal_nocrt(const struct dmi_system_id *d) {
+
+static int thermal_nocrt(const struct dmi_system_id *d)
+{
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
 	crt = -1;
 	return 0;
 }
-static int thermal_tzp(const struct dmi_system_id *d) {
+
+static int thermal_tzp(const struct dmi_system_id *d)
+{
 	if (tzp == 0) {
 		pr_notice("%s detected: enabling thermal zone polling\n",
 			  d->ident);
@@ -1068,7 +1073,9 @@ static int thermal_tzp(const struct dmi_system_id *d) {
 	}
 	return 0;
 }
-static int thermal_psv(const struct dmi_system_id *d) {
+
+static int thermal_psv(const struct dmi_system_id *d)
+{
 	if (psv == 0) {
 		pr_notice("%s detected: disabling all passive thermal trip points\n",
 			  d->ident);
-- 
2.34.1

