Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0F7B7EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbjJDMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbjJDMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:10:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4684A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:10:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so3628322a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696421415; x=1697026215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WWYoB5MEV9gKIjnnbA4n0zDf7a0EYBT3iB0u8uEjVw=;
        b=BMnLhhGtnbGUSNtzACA5wHG2dPz36wqP/gzWGAs+CDZT5AK8ND2TeopmCPYzsns37z
         /nRb9JlcmQoLwtr/TrCFYYUsSbKCnWlxubfVKudwtUbeR1zjimQyV0WA52oV5sxG2uEJ
         monuyxWtC1wp69McxnX6V5pxbVxDn9x4Nl6hVPqCVOrdfZRChLWOq+clR7+QAR4pwdZk
         UvUnb55H7seMcOc8GXBxUzTqiwrLjuYI5iCyVr5wis3UJsgmeRQ5XzojqTe17Q4vfYxV
         pQzgvRiIW8cAvgBF5Pw2H0ZqoQ9E3iNBfMAn89WAm6on93wsHF4TvtxrMO+8pqnht3A3
         eTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421415; x=1697026215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WWYoB5MEV9gKIjnnbA4n0zDf7a0EYBT3iB0u8uEjVw=;
        b=tygfyUGqB/2fq+Qpk0/EE551Jyr8XGU3zIynOIyVWDJKMh6gTHKQ5PRl9u27KS0L4L
         779K9TDCMbKOps9FXje134hkJJ4qlrbcEFmz2yHiLhveZFWUlgd3XW9yWDpjxg9q0zkN
         VI+mwRBn9wjCr/rYkx6vdgqTKg2TuM0RZeL4OiUptDISAVFZJWjQs7Xf0S1jscOFj5h8
         Bw78qOAIoxNftbDVl+rkeZT8Tfnr+hUCTZbpffPAw/sgYLILGCIKnV7RVOGgqvc2zQRU
         kj79QEe/rtffSmISnUS5ToBK5weIgMPXqheYxFoDd0MUxFEHvXW4hEpbsP1dOyaN1UWR
         qXBg==
X-Gm-Message-State: AOJu0YwdkBpUdmkc7sRvjweHjLFAkMlxT0beyIpIrOZyHGQRE81cj4ML
        cxJWMmBvon+ykSRIq6AJHpl1Pg==
X-Google-Smtp-Source: AGHT+IHRWQLNJvh1ddx+tK8Q9ePxHL8w1tFm3gdF3z0HUdRVGWM/vsEkGq5jidZ7y/zr1gyhV/wYDg==
X-Received: by 2002:a05:6402:205:b0:534:8bdf:a258 with SMTP id t5-20020a056402020500b005348bdfa258mr1833057edv.31.1696421415286;
        Wed, 04 Oct 2023 05:10:15 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7ce0a000000b005288f0e547esm2354627edv.55.2023.10.04.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:10:14 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] regulator: userspace-consumer: Update name
Date:   Wed,  4 Oct 2023 14:10:09 +0200
Message-ID: <20231004121010.1192344-3-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004121010.1192344-1-naresh.solanki@9elements.com>
References: <20231004121010.1192344-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set name to dt node name.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 13c0a86ab32c..9030e1d9ce3c 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -159,6 +159,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		pdata = &tmpdata;
 		memset(pdata, 0, sizeof(*pdata));
 
+		pdata->name = devm_kstrdup(&pdev->dev, pdev->dev.of_node->name, GFP_KERNEL);
 		pdata->no_autoswitch = true;
 		pdata->num_supplies = get_num_supplies(pdev);
 
-- 
2.41.0

