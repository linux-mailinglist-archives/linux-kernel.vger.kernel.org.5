Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE97CEF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjJSFrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjJSFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:47:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A64E196
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:47:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40839652b97so14909465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697694448; x=1698299248; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QH/jOnY0ZF8TPHR/Twc1JX2N6xDANfIG+JOlMvNVHM=;
        b=FwhZR+ceDVA88BHNKKOrXMEafNQY7OoXbfRGkzFQwqfq0sEAi2G7CjHga6dcQ7eNar
         Q0phvFDnhQcHlQrjJugAXMyTQa24kvmaWv3kiQ2NWmmFO3Ze3TFa1qD9jaCy3/aRyEtR
         xnbizL49TllwJGaIAonupyCPHNfneDxFwbbnWwQ558GzC+Rei3F/mp0I7+xfKF2Mgzbk
         7tLKvmjhYXpGZ5Vipxk7V4suHO+MDDm1nd/OY/AwkrJrPSvl1YGXTQ2P7A4FvIIm8+0U
         q3IfKpcJ/Wsbj68Nc3C3x3ToM8DAH8XR1ExEO9GjJlTnRzMUghfL+nicEZDW+xqgPdVQ
         Edfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694448; x=1698299248;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QH/jOnY0ZF8TPHR/Twc1JX2N6xDANfIG+JOlMvNVHM=;
        b=RpxY5AkoRiirZ+zbDYf28RNJ6xPtbxnYfmpROfNIxfj5vcKmMoIeraIze0dp3bV5qB
         G19eC/nGXs44MbxYA2aHhtCbpvQeGUi93seUEnmavEcJ3a6DvVhQ0iEt7cubfw4yeZUB
         +lPtDlRhF57uHSuqOuWg3MFFZla/AhHGSEqxUkmURmqkEqCTCiRxvq5YDwF+yVBZRB3/
         v2Wpb+RuBc7YgnYELk/gEx7Pm2meQQVyKiOUkbANePvJ6rTs07LESfYgYy5FuwGRJeiP
         j3z6NJITD9HZUuXtx/Dv7B3MyXha4PCVJqMEeUaEnOaBLuIMHs+8L92TRVS/o/wYiU38
         uk8w==
X-Gm-Message-State: AOJu0Ywm4n9dYac4FuRoZ3q6/xgCEaKobitFuv0dAuQFXQux3j+Bdu0q
        ifmo4nza9ALQ27xArMfmp7BVtmO0GSTF4w==
X-Google-Smtp-Source: AGHT+IFEDAqJ+kozlJJ+9eBNgjKdB19Uh/+XKcoV/W5aAz2ZrA8rKQm/+5rUJ/PKI07biAsRN+vuiw==
X-Received: by 2002:a05:600c:4f89:b0:408:3c8f:afd9 with SMTP id n9-20020a05600c4f8900b004083c8fafd9mr960177wmq.3.1697694447543;
        Wed, 18 Oct 2023 22:47:27 -0700 (PDT)
Received: from lab-ubuntu ([41.90.66.104])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b0040770ec2c19sm3438034wmi.10.2023.10.18.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:47:27 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:47:24 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Calvince Otieno <calvncce@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>
Subject: [PATCH v3] staging: vme_user: replace strcpy with strscpy
Message-ID: <ZTDC7N6GLXZqaevN@lab-ubuntu>
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

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Changes in v3:
 - Rewrote the commit message
---
Changes in v2:
 - Make the commit message more clearer.
 - Remove the incident extra line change.

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
+	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name))
 
 	/* Add master windows to list */
 	INIT_LIST_HEAD(&fake_bridge->master_resources);
-- 
2.34.1

