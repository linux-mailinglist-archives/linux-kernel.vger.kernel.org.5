Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8707C79A5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjIKIUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjIKIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:20:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3BE120
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:19:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500913779f5so7117663e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694420395; x=1695025195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgoHp4sSbdLPnwsP7QBEFkRKlD8fQKCxSLeR/YtKKwc=;
        b=ZyjBhxd/4CH0ce0+zqDz4fqROmajy8086/Sw88k2Glm3NBnek5E/bSp796qDR7Sn/1
         VHDimH1/nbwJfHprTCbG9eevCMibjpxI2uGyCYC3z2jyzz2vFCjzNdWXxtdslcAb01Kp
         CAxdbkd1kdeXX8gLnu+QZhITl36K+w05+ef/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420395; x=1695025195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgoHp4sSbdLPnwsP7QBEFkRKlD8fQKCxSLeR/YtKKwc=;
        b=E5lOpiv2HyefB9mR+UwyhQCHSl5p7doVUinkAzFZsl/nsoiNWwn+aaTU1iCPnIvgEU
         6jvPmNMaRfwFHugWFSeAAmaBoz53lTGCFs9L9t3Cz55kAMDCS9HtoRio9sVJNmsDye3v
         7oWQzdy9Ii2LEfXTl/Bv0uEdDorHGz7RLx5yc36EoASR4sLfIbe03W7wzHwY2lbKNOEa
         NhgXX6kj8QhRK1g8CITOAVp0exZ2IeYw/WLZJUaNrL4Z6m1iXK+Bw0L3Z2v2p3CpNPVA
         vZWiLCFBB5ylOKap3qhRia2GMTE5qblm9M8Dzc+Y5jLw+RCxlhVASMiqSVYXB8ZtGjIR
         oNVw==
X-Gm-Message-State: AOJu0YxNLFq5Qw286Q9poHwWyMx1pDvVkw6edJV+t7rOgSneVJcWYSLV
        CoAj6ZH91+m5s/vae5KafiBqAw==
X-Google-Smtp-Source: AGHT+IGKXkVlvpzb1jXGc7GPA/z62m6pR7a/3NtlCutcvnuu34bb7zCIn6QwlQhJ2uEpgzghSPTdTA==
X-Received: by 2002:a05:6512:3f8:b0:501:bd77:a4b with SMTP id n24-20020a05651203f800b00501bd770a4bmr6358700lfq.9.1694420395351;
        Mon, 11 Sep 2023 01:19:55 -0700 (PDT)
Received: from localhost ([2620:0:1043:12:a329:942b:177a:d4d])
        by smtp.gmail.com with UTF8SMTPSA id z28-20020ac25dfc000000b00500cede2786sm1268411lfq.65.2023.09.11.01.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:19:54 -0700 (PDT)
From:   Stefan Adolfsson <sadolfsson@chromium.org>
X-Google-Original-From: Stefan Adolfsson <sadolfsson@google.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Reka Norman <rekanorman@chromium.org>,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Stefan Adolfsson <sadolfsson@chromium.org>
Subject: [PATCH v2] media: cros-ec-cec: Add Constitution to the match table
Date:   Mon, 11 Sep 2023 10:19:21 +0200
Message-ID: <20230911081921.3515928-1-sadolfsson@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Adolfsson <sadolfsson@chromium.org>

Constitution has two HDMI ports which support CEC:
    Port B is EC port 0
    Port A is EC port 1

This patch depends on "media: cros-ec-cec: Add Dibbi to the match
table".

Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
---
Changes in v2:
 Use a NULL-terminated conns array for the match table entry

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 21361eff50ff..85431af65224 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -296,6 +296,7 @@ struct cec_dmi_match {
 
 static const char *const fizz_conns[] = { "Port B", NULL };
 static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
+static const char *const constitution_conns[] = { "Port B", "Port A", NULL };
 
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
@@ -316,6 +317,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Lisbon", "0000:00:02.0", fizz_conns },
 	/* Google Dibbi */
 	{ "Google", "Dibbi", "0000:00:02.0", dibbi_conns },
+	/* Google Constitution */
+	{ "Google", "Constitution", "0000:00:02.0", constitution_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.42.0.283.g2d96d420d3-goog

