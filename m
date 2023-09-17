Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4165C7A3662
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjIQPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjIQPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:44:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D92FF7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 08:44:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so9257941fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694965470; x=1695570270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyE2cahixYUhSxqHETVMaNUic+89+Aiv8SH8B+785uI=;
        b=QUMpuvdfFfB8vggbGhcXQwTOtjK8mKZzYvkIOOGj2TpVWvEdDovO9T8YALO5QzZHl7
         GeM4SJQQ8c4B+9DSSTxn0Y8duB2AnHvE3+qs46q8seJ9Jq6g4C/i2LTUj2iz3/FsbCiF
         fhZGvAQk7ASJ3km5LGKkau4h9bt1oDYp+pt1/8U60eR+GcqKgg98NkOG3nT0P+xbZTRN
         VUTi6T/4xBhz6dWaqUwplT2+kiu2DOk80SXhRhJQw7YbaX8xzONW7SJhN2pYRRsgddjU
         CV+OsuUYZC5N9Avu3T+0hod+ovsezceX56ZcpBuYpPGTf9uqwgo3WqobTEP5sOvDW8zc
         xAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694965470; x=1695570270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyE2cahixYUhSxqHETVMaNUic+89+Aiv8SH8B+785uI=;
        b=E9Y1KNrlhcTA2deGLfVhQWd3agu/JG7O7SXArA4d5IjMT/dsk0zxbqr8iQAM/MTgQz
         +DPVPsJmlFnK/BfLQfxO+Q4midowc4i7CJVeF0cRAr4nYsuUfia36/veL61f/kZVJ+n0
         7IEb9LD8SBc5Xhw+0VB+mBQJl1+9O83o2Ch9gexeWvy0pAzaKtrWUHg1r5rZIqSARzzd
         4X3GnW4e35LFfhZLKsX12B1XLM/BWNzLRVziLWYl4Y3WZ8ybsAj8vnT1Ns12fUzJamj9
         ZNZuuKD684kV1Wlv92vK7aHzO/gSmVyrA1gXpZywyXp11AVf8c+7bBR/UxJe8RmHU6F8
         M0Fw==
X-Gm-Message-State: AOJu0YxZF+IKzYZPpOwiVCn1hLsj1Kd41VLHeyaZx9yFboYRjVJpjaFk
        U7YKQsc8tvziJdZNyMxMkUK1rPs0ZfKNxpwN
X-Google-Smtp-Source: AGHT+IEX25Wx2tJPOYCZ/eMzwF4zM4wpul2EIIBw1pw2JVFiB+wZEFEffTxiQFokZgxXv7dCE4tYIg==
X-Received: by 2002:a2e:a7c9:0:b0:2bf:ff17:811e with SMTP id x9-20020a2ea7c9000000b002bfff17811emr2215422ljp.14.1694965469323;
        Sun, 17 Sep 2023 08:44:29 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id h19-20020a2e9ed3000000b002b836d8c839sm1668550ljk.40.2023.09.17.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:44:28 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] staging: vme_user: Replace strcpy with strscpy
Date:   Sun, 17 Sep 2023 17:43:02 +0200
Message-Id: <20230917154302.913956-1-bergh.jonathan@gmail.com>
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

Replace strcpy with strscpy as preferred by checkpatch in vme_fake.c to
prevent warnings.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 9bcb89a84d53..0cf5700e151f 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1093,7 +1093,7 @@ static int __init fake_init(void)
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
 			(unsigned long) fake_bridge);
 
-	strcpy(fake_bridge->name, driver_name);
+	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name));
 
 	/* Add master windows to list */
 	INIT_LIST_HEAD(&fake_bridge->master_resources);
-- 
2.34.1

