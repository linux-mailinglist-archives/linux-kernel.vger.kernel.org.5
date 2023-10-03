Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BF7B7413
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjJCWXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjJCWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:23:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA30A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:23:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc6261ffso1784919276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696371788; x=1696976588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tCZ9sGW2dFIoiIJ1Nka8giJRyf+MG2OcgcHbbbzJ3zU=;
        b=k38tSP/FZHBZWkCLkPJENS3ab9nQCYS/y+TaeCLpFnRL+LEqTytPUiDL9M8cfchfYA
         QR29Wf0UkE8712jVDG7x2S85Vx2EjkUt5gqPY4V3C4qon25umM5NzVIm4kwlctAnBkM0
         b/cS7GCu+1wb0ziz2VNFBtFafOPdrNM9ljccKQAxiLy1ILd4CUmNsMh20c9it7MNz87s
         bmGSYEoqmcAms8NqjDw5gBZHBUNkRc9SusMF7GUHSzPtTFr46fIs1GHCnzrOyv7UPLg7
         rUtfWfVRoi1IN6s+arLhzOqNcDDzwJRW1kKlFOunqisvsHeblISfJpCW5z1JsNfyh7Wb
         0UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371788; x=1696976588;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCZ9sGW2dFIoiIJ1Nka8giJRyf+MG2OcgcHbbbzJ3zU=;
        b=cV4na6ipY6HrIjwh5Ip03gIyDK3L7E2bpU2DQ6nD5zp9Nwsh9cVhYUq01PE+jfLqKA
         6BKEI7PmhJ+MfP7rIIL5GTFCMEdLroSfjwllUdNNNl82j7aHhx0ZdzdhM01CxP6Nl6gI
         tenQQNB5MC8+YX59oM+mxKyRcvxdc1+N5qUdyHAXqMuhSsQtxvahtndOJHRyvft7ilkN
         vtndamd87fhQlRPUxbat1EmqmooTexZ8X8T3REGwEYvZ1aEOnkg5s+I52rIMtidHL4DL
         AkLOApD6WCRxNHydG+qvVl6OktMLG5nnZY28ojZfbDwYvR648J/7OQj/o/S79GnzrAiq
         q6dQ==
X-Gm-Message-State: AOJu0Yx1n1wRutrx4ZPqPNbGsvs4ENC90c9h3ukTgaHUqlipQSUwc1th
        QbrpIE2WjhKLJZZL5hNgTMtz/zQTaTEE3D2mlQ==
X-Google-Smtp-Source: AGHT+IF3MCdVcuEbUDPuR1AxHYCEQ+XcRpz3Ql56S2cBradS8j/Y6cCKomMEFbSycqYVYjSHC13duE6J74qwZ9HP8w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:1907:0:b0:d86:a97a:8a92 with SMTP
 id 7-20020a251907000000b00d86a97a8a92mr8582ybz.4.1696371787997; Tue, 03 Oct
 2023 15:23:07 -0700 (PDT)
Date:   Tue, 03 Oct 2023 22:23:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEqUHGUC/5WNQQqDMBBFryJZd4ozgsWueo8iJSZTHVqNZCRUx
 Ls39QaFv3l/8d5mlKOwmmuxmchJVMKUgU6FcYOdegbxmQ2VVJUNXUCXOLl5BR8lcVQYRR0skv+
 8x0tGcMBY15UlRFs6k01z5Kd8jsq9zTyILiGuRzTh7/3PnxAQqOk6z+zRkrv1IfRvPrswmnbf9 y8034xz1wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696371786; l=2527;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=cCDkWAced3tU7PCx4WFFpYw9ujSV23pQSM7iZfWw2HE=; b=GUfH119OCZQSjHT80MnLIY0cic8miLh0zHXnjG7ymGxUzmL52MGPI5Yxmw4y+zfSNS2rGTwIz
 eJ1yTaUNKnYBFbI5y4yZ2gNcpff6ptEj/CCQ63xs2JW+UBW+Ij03Ius
X-Mailer: b4 0.12.3
Message-ID: <20231003-strncpy-drivers-misc-ti-st-st_kim-c-v2-1-79630447b0a1@google.com>
Subject: [PATCH v2] drivers: misc: ti-st: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both `kim_data->dev_name` and `kim_gdata->dev_name` to be
NUL-terminated.

`kim_data->dev_name` seems to not require NUL-padding.

`kim_gdata` is already zero-allocated and as such does not require
NUL-padding:
|       kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy usage of:
strscpy(dest, src, sizeof(dest))

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use sizeof(dest) (thanks Kees)
- rebase onto mainline cbf3a2cb156a2c91
- Link to v1: https://lore.kernel.org/r/20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com
---
Note: build-tested only.
---
 drivers/misc/ti-st/st_kim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index fe682e0553b2..4b1be0bb6ac0 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -590,7 +590,7 @@ static ssize_t store_dev_name(struct device *dev,
 {
 	struct kim_data_s *kim_data = dev_get_drvdata(dev);
 	pr_debug("storing dev name >%s<", buf);
-	strncpy(kim_data->dev_name, buf, count);
+	strscpy(kim_data->dev_name, buf, sizeof(kim_data->dev_name));
 	pr_debug("stored dev name >%s<", kim_data->dev_name);
 	return count;
 }
@@ -751,7 +751,8 @@ static int kim_probe(struct platform_device *pdev)
 	}
 
 	/* copying platform data */
-	strncpy(kim_gdata->dev_name, pdata->dev_name, UART_DEV_NAME_LEN);
+	strscpy(kim_gdata->dev_name, pdata->dev_name,
+		sizeof(kim_gdata->dev_name));
 	kim_gdata->flow_cntrl = pdata->flow_cntrl;
 	kim_gdata->baud_rate = pdata->baud_rate;
 	pr_info("sysfs entries created\n");

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20230927-strncpy-drivers-misc-ti-st-st_kim-c-e1663a211a0c

Best regards,
--
Justin Stitt <justinstitt@google.com>

