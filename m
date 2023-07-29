Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FD767F71
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjG2NcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2NcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:32:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BCA3A96;
        Sat, 29 Jul 2023 06:32:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992e22c09edso416599466b.2;
        Sat, 29 Jul 2023 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690637519; x=1691242319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehQrsxvgL4zxhUTLst8f/NRMbcO61HuKHbTD88GGtUI=;
        b=G9nNiSDOiJ9LAKD0Qvu3u9inL5ltgCDzPfd2gHAKlGyNe7RaeU9VpxVvHxyT2c/UBy
         x5mqe7j0cZxpgtKFN3yXaFyMvhiZukVE1KM3BrhIj2ZhhxZ58H2pOxr16omZLWtztU15
         6uPKCrXwa5MLVeWPb+WFN13RQy7AgLK5TKdJ/guHeksJ/5exHJZF68cDMNM52MO5eLNa
         E5cnooLCTyLgTol+b0BgBEGoxaSfSgqkaLgsbOWVoBA94fIXt9g/vEuvJ0FCag7lluAD
         fmiFkTL1GyJs2kEvMeghZLZykf/osQPs1Y4op6Xu1f7LTbCrBNUXg2GQz/X0c6K/0n6Z
         Dwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690637519; x=1691242319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehQrsxvgL4zxhUTLst8f/NRMbcO61HuKHbTD88GGtUI=;
        b=A27miCaHWs2oH6XYAvniq3gdPhEZrqh4XdVcfQ8XGXXdJLvENnEOMZb+iZhTc1P5Xv
         GiQZezMBJzfi+zS4PkK9XtGBl+VVbaa3n0ipnGdZ+1zznfUvHPwHGBThCnQk6E6NmYFU
         lE29MFuNN6gHKkVjnvXl+DgxWRi/oHnsf/cJVtp7mEiMjRZeaSAKDaYMfVTNPsIjo0wu
         Sk8GbYvHhWK1m61Sq9xEKz0FmR8udW9tv4kyzxNxnBRhhGRWt9vZEse+KiMubZsXUv/k
         J8nz+ySyvPeOpAG54om96jAw/hhtItFOXKvo6ooPBTl8ga1FZYCaEf96EFjWKridtV+m
         x6OQ==
X-Gm-Message-State: ABy/qLa7i0g6INdVy8ofKmn2B3tTJzwcZ81imsY1cc7TmHKKdaCkaeeJ
        leTusQ3C+LdnpyaKlQZ3xFdV2xH1v52Rtg==
X-Google-Smtp-Source: APBJJlGU6ii/ivn+os7zQ58aKo3m/UbjN8Ga6xPx3Xr3nelhBJdmHartEUmc/SmOp/RFyCVHr99YVg==
X-Received: by 2002:a17:906:76ce:b0:99b:d594:8f8a with SMTP id q14-20020a17090676ce00b0099bd5948f8amr2316498ejn.0.1690637518993;
        Sat, 29 Jul 2023 06:31:58 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id br7-20020a170906d14700b0098ce63e36e9sm3336245ejb.16.2023.07.29.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:31:58 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
Date:   Sat, 29 Jul 2023 15:31:12 +0200
Message-ID: <20230729133112.462023-1-savicaleksa83@gmail.com>
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

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
Changes in v2:
- Added missing <linux/delay.h> include
---
 drivers/hwmon/aquacomputer_d5next.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index a997dbcb563f..6ec0ab58a289 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -13,6 +13,7 @@
 
 #include <linux/crc16.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
@@ -652,6 +653,31 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
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

