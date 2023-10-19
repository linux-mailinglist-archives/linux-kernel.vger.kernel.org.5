Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F08E7CF082
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjJSGz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:55:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF55119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:55:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40839807e82so2328955e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697698523; x=1698303323; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sxkw9J6vbuDa33oyWmJKA2N6BRhlaSDTP/vmMSE0zJw=;
        b=YBdZTDFc8JZrs4MTwC7L+pWc6TYQb0PbC0s4K4WuPV3eSNVml7pQA3ZxK5Y+WEG0qp
         vEwQ1HvTDd2AATlXiNTkMkcgQSOe5REqiNA6CJhUABgBhbDvntvv/BkqKrWakrslDUfj
         ZsyxLl+fzXqeYbudrnN/TqmZbATsR0wLl3Gp9e7lZW0Dr8CVXmvEtq0hd7G+2YN6id3y
         IFG4MHWO3Mngdg6yKuQqzEWIaw7yKk9Uxg5AHxdBrHO3JPpbUKeMgVB18F2fzTmk1DVm
         2YAmGMXVrgL1OfdoUjykxm6jKlU1WcAwM42pTNB73drI66CFviFjPgjBJfaBUnzXwXrL
         yY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698523; x=1698303323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxkw9J6vbuDa33oyWmJKA2N6BRhlaSDTP/vmMSE0zJw=;
        b=Vmvf92JxB92lJfRdR0w6lmtFb4JUh6XfmpLgoxcGixEwaswlq5f3J8RWkjj8Q1lK5m
         TOEOL8yplolKitRD+DkVkyMbUEcrVt58I5lAO4dTMWfLdQTys9WG5C5/F7r3JfwrTmi2
         9zLZxUKU9O/CIwk9e6ttLZmid9yHW9otVVoB3KJo1z0EMogu7AFfnRHYY8C8Oev5oYVo
         1bBV/6/M1PPsLQN3X7JVEUk2V4mWOPAfwaLRT8rgPSrABWON968dZ5Rfl8O2d0msMM0I
         x9+q/767GUa9EvBVvnJq4xpK3/0qbrJfu6gGcOg/WMcsWrFuceNoKgAYxiH4FHsfEDWs
         +uAQ==
X-Gm-Message-State: AOJu0YyUs7MISHLUMozSB36E2zKwhYnV0JluJSjHJMRzp1zo8sgT2QBP
        H2a98uehMigR/bBs+5Qe+AvdLKKJcBipEg==
X-Google-Smtp-Source: AGHT+IGtUrfvTZXm57cB6L9weG+na/8FnIH2RYJGQDTaTpfTbY8L4FAKYCDw9+cTc2AXH/zOWgGATw==
X-Received: by 2002:a05:600c:1ca8:b0:405:784a:d53e with SMTP id k40-20020a05600c1ca800b00405784ad53emr740376wms.20.1697698523166;
        Wed, 18 Oct 2023 23:55:23 -0700 (PDT)
Received: from lab-ubuntu ([41.90.66.104])
        by smtp.gmail.com with ESMTPSA id x3-20020adff0c3000000b0032dc74c093dsm3713492wro.103.2023.10.18.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:55:22 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:55:20 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4] staging: vme_user: replace strcpy with strscpy
Message-ID: <ZTDS2H48JBUTiwZi@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch suggests using strscpy() instead of strcpy().

The advantages of strscpy() are that it always adds a NUL terminator
and prevents read/write overflows if the source string is not properly
terminated.

strcpy() lacks built-in bounds checking for the destination buffer,
making it susceptible to buffer overflows. These overflows can lead
to various unpredictable behaviors.

In this specific context, both strscpy and strcpy performs the same
operation without any functional difference.

The reason for this equivalence is that the driver_name string "vme_fake"
is shorter than the size of the fake_bridge->name array which is defined
as 16 characters (struct vme_bridge {char name[VMENAMSIZ];...}). Thus,
there is no risk of buffer overflow in either case. VMENAMSIZ variable
holds a constant value of 16 (#define VMENAMSIZ 16)

The null-terminated "vme_fake" string
(static const char driver_name[] = "vme_fake";) can be safely copied into
fake_bridge->name using either strscpy or strcpy.

While using strscpy() does not address any bugs, it is considered a better
practice and aligns with checkpatch recommendations.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Changes in v4:
 - Added a semicolon to mark the end of the strscpy() implementation.
 The semicolon got deleted accidentally while mailing the previous patch
 versions.
 - Added the patch reviewer.
---
Changes in v3:
 - Rewrote the commit message
---
Changes in v2:
 - Make the commit message more clearer.
 - Remove the incident extra line change.

---
 drivers/staging/vme_user/vme_fake.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 0e02c194298d..8ab5b43c70a6 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1091,7 +1091,7 @@ static int __init fake_init(void)
 	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
 		     (unsigned long)fake_bridge);
 
-	strcpy(fake_bridge->name, driver_name);
+	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name));
 
 	/* Add master windows to list */
 	INIT_LIST_HEAD(&fake_bridge->master_resources);
-- 
2.34.1

