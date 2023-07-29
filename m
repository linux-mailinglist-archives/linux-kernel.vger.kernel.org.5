Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B100767EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjG2L3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2L3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:29:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205A180;
        Sat, 29 Jul 2023 04:29:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf3f59905so190487666b.3;
        Sat, 29 Jul 2023 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690630155; x=1691234955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UsODLhPmgXVzJMgYwd6g25n/YmJLuT+zLYrhO4QA/Dk=;
        b=ctVlHDDZIRb0LmQKF+fmi2vn0h3fiDXr3nVc38arl4b6xcfsKdDaER0AX1kG/kjZ9k
         /QuGPJgQaLzwI7KrSAZyQ2jQY2zOxSqjKfWn+y1/S6YNsJoMzwyWnxpBAsxjVtLQ9xnf
         qQuNqY8XldkkIeEnFAeJBmnIlfJV0zyB8TcNkawsTOmdixmgvCbXsOLqB/5KfqNMrFo5
         0cajCJ2KYXyZfMLRofImzRtHqtjQQLYY69rUb+k6KAdoWBEOclH0QejZMAPytBTXky3C
         icIuksx75bThiFLLW6ymc/MsV+IX2NgGaWwkbOZ9FpOGF9KXWmftqn3ZeHIRaURRK5Uj
         rYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690630155; x=1691234955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsODLhPmgXVzJMgYwd6g25n/YmJLuT+zLYrhO4QA/Dk=;
        b=L90chpigk5OzYuh91Lm16hsUmaq7hfiF0bEwWDflFxZ5U4ojtPCZ3AgRs5Yveug4kU
         lPCen23/VeyXnUtaPegwDU8xjb4AKC+TLmlK4+iEW/6RZyO2yiIC1vmdRdheezJznM4m
         QZR9xX4eZl2MOv52Bh8S7kiOMgdl6KKu3UCtjfycE0KfvmoCtWKpUXar5Ec/hNrOrQAF
         yj/Lq0EjAhcwVZl/yhpLKhGABqDDK0fKdE6Anj8LzaoCkMXJbudqvb4kGQZEuiH2Z4uZ
         QzX9069Z3Fq8DKaWLzkSzw6x4bdX4qhKUche+FHUOLjYhZVmE/I32b4wHDVSMKVI83Xc
         aNSQ==
X-Gm-Message-State: ABy/qLauEFzOX3scJz3wblNson6iSaflzhmcN22PtJILwvwXeVMgKsYh
        e04H7CRnOwOrXar/AEGaLNo3DTrnCsFrjA==
X-Google-Smtp-Source: APBJJlGuFJn7fSxluY6R6mKpOrXYJNunCtN3citXHy5Jjt2oMiutRS2qEbMAzNePmEAC9WbV8yCHIQ==
X-Received: by 2002:a17:906:cc58:b0:993:f2c2:7512 with SMTP id mm24-20020a170906cc5800b00993f2c27512mr2334003ejb.33.1690630154992;
        Sat, 29 Jul 2023 04:29:14 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id y26-20020a170906071a00b009737b8d47b6sm3149645ejb.203.2023.07.29.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:29:14 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>, stable@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
Date:   Sat, 29 Jul 2023 13:27:32 +0200
Message-ID: <20230729112732.5516-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 200ms delay after sending a ctrl report to Quadro,
Octo, D5 Next and Aquaero to give them enough time to
process the request and save the data to memory. Otherwise,
under heavier userspace loads where multiple sysfs entries
are usually set in quick succession, a new ctrl report could
be requested from the device while it's still processing the
previous one and fail with -EPIPE.

Reported by a user on Github [1] and tested by both of us.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82

Cc: stable@vger.kernel.org
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a997dbcb563f..9cb55d51185a 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -652,6 +652,31 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
 				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Wait 200ms before returning to make sure that the device actually processed both reports
+	 * and saved ctrl data to memory. Otherwise, an aqc_get_ctrl_data() call made shortly after
+	 * may fail with -EPIPE because the device is still busy and can't provide data. This can
+	 * happen when userspace tools, such as fancontrol or liquidctl, write to sysfs entries in
+	 * quick succession.
+	 *
+	 * 200ms was found to be the sweet spot between fixing the issue and not significantly
+	 * prolonging the call. Quadro, Octo, D5 Next and Aquaero are currently known to be
+	 * affected.
+	 */
+	switch (priv->kind) {
+	case quadro:
+	case octo:
+	case d5next:
+	case aquaero:
+		msleep(200);
+		break;
+	default:
+		break;
+	}
+
 	return ret;
 }
 
-- 
2.41.0

