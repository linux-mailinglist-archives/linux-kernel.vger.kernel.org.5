Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976BC785706
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjHWLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjHWLpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:45:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E5E67
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:45:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9a2033978so85316731fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692791140; x=1693395940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7tHqCtCBwrBi+V5VhXtnXcNtgviyB9B8EoBzfXwamQ=;
        b=E8GWGehguy7PP4MX5+Ef/QMUDP9jO042Djy0QuWaaJ8WBLX960EVJOJ5JAdzm6aXxS
         iFAsnk0PL4/fdEY9CHQ7JfdtzDW5RJ/ggoQpMcg9306EQ7lr5CZ+NR3RUnunLpQ3budb
         x+zdO03UVyovdggvHc4COXayuwUhMl67cK8Ne3sKgJhe7lGliC53GDaqz/Nus8BDuI7G
         gKqssHAGlbvdVCK/mjBJ2tNrRfpWcHTv8acmqxf7g6FXdVcZmUrNXIubaeT7V+70AMId
         AsNTSLsDHOoqmVD/huyhBJ6+MM/GBvTyBE6u14nvmL6bz2gc0T6OZCWPqvlvU6WS1xHT
         wzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692791140; x=1693395940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7tHqCtCBwrBi+V5VhXtnXcNtgviyB9B8EoBzfXwamQ=;
        b=OQU6G0TsetPUL2VBTi6Mc2NOCI+L4qazx7b+tVJ6HGFMI1WzIc5Sdco/UhjpASNDwC
         HoU4CrCoNLGd59SNDVgcdn7kgsrjWy7ZChBfcRzjSw4l/y0xqI3+9VZOTURWQTm1praJ
         DBFHRAK26Yblqbf5bCmn1+al1aQb9AwUxnqC3rKplCKIHqPMNqEvjqqShJVo+IpmMpS2
         ooqfaLmz9+7dj9hQmXAFGGPtSGKwsH9rRkBW301EI29Vbrt+OBhcZ1aLxxgNP2+dwIKc
         ulaf4YlhDp5uSi71bB7hQCTR30pd42ECVzNWv3z6gxHm6rCAlRm4KC736rT9cBfPffUg
         iqlg==
X-Gm-Message-State: AOJu0Ywg6FoX0AqKkrfcjcokYDIja89s7Oq99FSawYnh9qhw0YZ4b53Y
        Bwhoq4/09M6y9ivuUfAVTkVX2g==
X-Google-Smtp-Source: AGHT+IHdwziasj0D1MZ9uBcdhByqBC95ew9J9TcFICwlP0Jl9zRXSGXh3Dl8RPw6cWdVo/fTvnM4uQ==
X-Received: by 2002:a2e:88d1:0:b0:2b6:cff1:cd1c with SMTP id a17-20020a2e88d1000000b002b6cff1cd1cmr9657741ljk.34.1692791139858;
        Wed, 23 Aug 2023 04:45:39 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b003fbc0a49b57sm18503577wmc.6.2023.08.23.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:45:39 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v3 2/5] PM: domains: Add the domain HW-managed mode to the summary
Date:   Wed, 23 Aug 2023 14:45:25 +0300
Message-Id: <20230823114528.3677667-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823114528.3677667-1-abel.vesa@linaro.org>
References: <20230823114528.3677667-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that genpd supports dynamically switching the control for an
attached device between hardware- and software-mode,  let's add this
information to the genpd summary in debugfs.

Suggested-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v2:
 * Reworded the commit according to Ulf's suggestion
 * Dropped the _mode suffix from the status
 * Replaced "mode" with "managed by" in summary show function

 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index dfb4f1de540d..93350e67b0e8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3171,6 +3171,15 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
+static void mode_status_str(struct seq_file *s, struct device *dev)
+{
+	struct generic_pm_domain_data *gpd_data;
+
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+
+	seq_printf(s, "%20s", gpd_data->hw_mode ? "HW" : "SW");
+}
+
 static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -3229,6 +3238,7 @@ static int genpd_summary_one(struct seq_file *s,
 		seq_printf(s, "\n    %-50s  ", kobj_path);
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
+		mode_status_str(s, pm_data->dev);
 		kfree(kobj_path);
 	}
 
@@ -3245,8 +3255,9 @@ static int summary_show(struct seq_file *s, void *data)
 	int ret = 0;
 
 	seq_puts(s, "domain                          status          children                           performance\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------------------------------\n");
+	seq_puts(s, "    /device                                             runtime status                           managed by\n");
+	seq_puts(s, "------------------------------------------------------------------------------------------------------------\n");
+
 
 	ret = mutex_lock_interruptible(&gpd_list_lock);
 	if (ret)
-- 
2.34.1

