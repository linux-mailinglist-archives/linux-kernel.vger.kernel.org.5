Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843627BE71E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbjJIQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376910AbjJIQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:57:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FD694
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:57:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32003aae100so3545717f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870670; x=1697475470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Czavm+hA74AE3KkSlm2hXBEMwAG3Dh3p+tVw2heAB7A=;
        b=MCdfFnbRJW1WAaKwEDUwiHSCpY562wWuKtkxn4NY+1haJGcoYfPPVi1Zy39PxNOJ7C
         ZIUFW+etlhHrfUNjVtyh6xIhdf0IJLjA6HPu0/wLTVMyQhcmgilBs0hn8GRb6TPt7QWM
         ilYe4fObxWLV3dXIT5XJOG35AgwwMTOPkNHvlZFPsBbHpNpbZsv9p7Q7Y+wv23qWcVJW
         OsYV1NNiJRjXsXSEfihdZoxL2aFa2KWVxZYGq0snyIAhlMZiUmIbnv5gi+FjofVCzE+O
         VK+uqe2ahdGNTnyftZSfTSS8JUAOOZDYPK9rzbGS+ThhViz/fbmI0WKqQ60mZlAGzG94
         VO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870670; x=1697475470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czavm+hA74AE3KkSlm2hXBEMwAG3Dh3p+tVw2heAB7A=;
        b=KqN5X2MdAGDaLRhws309Ik3XxbQXcEU4Z+ARh0j1HFhv5MxNT0DUAq2mJ/S9OGSQR3
         q4gbQ+TqO4BiZcwbXB/syjsEYtgVECsB1Ob7b8gM1o2Yq2pDc0DFW4vvcOsRA3Qn2+Ex
         GPz7OBvjE+B3BPY3ap1/HMZ3hLe4cgu33G5KCFVoGg3LIW2NB6kLG9x2wh6ZIHYr3MoK
         lH+KiUQe3normogigyk/ev0TKE0Ac+Fx0g21FNdBvMgzgr/x9qwgyFu/0e+O7/GSrRI7
         5AOyoFBDaQV5wQM0CcxpVztIGhgODOqn3WpwWbFXcEm/Dqoh21we0oc4ftW6tnYmC7e7
         fKBw==
X-Gm-Message-State: AOJu0Yy6aCEl7jEKhcl7QJBfqC3l+VUbkqxNzNMDYKB+Mxpc4vFSimiV
        WoZXWncBscFTGKzn5ozXngPybA==
X-Google-Smtp-Source: AGHT+IFMPqlr6PBRJnc3l9ctF3+CO5b90t85bTkLlY255sMAJWBYlApRgM4RXBucCwVJblJI0p/izg==
X-Received: by 2002:a5d:4dcb:0:b0:319:6997:9432 with SMTP id f11-20020a5d4dcb000000b0031969979432mr11098692wru.1.1696870670148;
        Mon, 09 Oct 2023 09:57:50 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:49 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drivers/rtc/sysfs: move code to count_attribute_groups()
Date:   Mon,  9 Oct 2023 18:57:34 +0200
Message-Id: <20231009165741.746184-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids overloading the "groups" variable for three different
purposes

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/rtc/sysfs.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index e3062c4d3f2c..617933d52324 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -313,21 +313,25 @@ const struct attribute_group **rtc_get_dev_attribute_groups(void)
 	return rtc_attr_groups;
 }
 
+static size_t count_attribute_groups(const struct attribute_group *const*groups)
+{
+	size_t count = 0;
+
+	for (; *groups; ++groups)
+		++count;
+	return count;
+}
+
 int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
 {
-	size_t old_cnt = 0, add_cnt = 0, new_cnt;
+	size_t old_cnt, add_cnt, new_cnt;
 	const struct attribute_group **groups, **old;
 
 	if (!grps)
 		return -EINVAL;
 
-	groups = rtc->dev.groups;
-	if (groups)
-		for (; *groups; groups++)
-			old_cnt++;
-
-	for (groups = grps; *groups; groups++)
-		add_cnt++;
+	old_cnt = rtc->dev.groups ? count_attribute_groups(rtc->dev.groups) : 0;
+	add_cnt = count_attribute_groups(grps);
 
 	new_cnt = old_cnt + add_cnt + 1;
 	groups = devm_kcalloc(&rtc->dev, new_cnt, sizeof(*groups), GFP_KERNEL);
-- 
2.39.2

