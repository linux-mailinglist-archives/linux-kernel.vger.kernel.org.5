Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA67BC9AC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbjJGUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:06:10 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93B7BD;
        Sat,  7 Oct 2023 13:06:08 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a2a3fb0713so128820739f.1;
        Sat, 07 Oct 2023 13:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696709168; x=1697313968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNlD1s/5Qv8LvOzp0cT+qMBzDmfWHxl8/xBRMHgFQGc=;
        b=QvfqL1f4PC+1Q+zm01Fk51afkAupO3PoLygj2Qnsv7ilHd2gUr+Ck07tl/4eA9X34i
         X/NGbV6kYMsA+pOnjuqtfq91902Hjt+h21YlQ/TAwBisRJcuHBh52Q+/eiv6jI9LXcND
         PQGTTrv1QzNtvb3MSPu3DRkHRXqqk8k5HmlBIyVHh0EkKpYTigXKYq19Ka+v4lSiz9F2
         1OfMw59LjN6BgyUWxYbbGrhUsJjK1y5em0JtWEhNpyuxde1kQhOlJHbRuW0jx2klRulU
         lGI/bO7VutOjFrMJHpBppkRPH6QdK1HbmPPkvGNYK619q0Xv02qTO2RuLVDlKXhTnQxR
         fkHA==
X-Gm-Message-State: AOJu0Yxjxzmpg0EEMuYQCgnIxFN6JeCchiTZPr96LE5ICz0+4IM1/kWI
        ZrkRVEdDfYOPkDXH12B6bAc=
X-Google-Smtp-Source: AGHT+IG2wf6mgobZ2IOixaCTrcl3zW9YZbaOfG0cI8m3grNo8XccXE19/FQlBmnU1OO4gAk3FQ/gRg==
X-Received: by 2002:a05:6602:54:b0:783:4bc6:636e with SMTP id z20-20020a056602005400b007834bc6636emr11401205ioz.21.1696709168170;
        Sat, 07 Oct 2023 13:06:08 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gj12-20020a0566386a0c00b0043193e32c78sm1106734jab.152.2023.10.07.13.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:06:07 -0700 (PDT)
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1696709166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zNlD1s/5Qv8LvOzp0cT+qMBzDmfWHxl8/xBRMHgFQGc=;
        b=nkSQrXCY5vVbqS6btuYu/JipccFgDJ7nsyFtTYPE0Ffxa7OF5HPKZO91zA3DcU6yWTiHPv
        Nr+KtmGt56HhXXRizuDQxOzfVNGguPFskpIeZzh6ZnpanJZ1twbWz2DQXa6Pl8KwqNtlGA
        AYsRDqMY7JOvTOm6SQOGF4bmtFGjZFBqtcnxUGZ7ybPcwI/4b2TtCrW8+gDQDlY8WdzNxW
        30w5/AdtEpNe1wFw9MYy9pGPNb3HM69K2BVXDqXKOvgHSOHkYTQ8PMxyAriBatLtfJxqtd
        idiCs7KvGnX6GNrMz8eSJ8C8vD9nJ7pJ/idgkOeTGdXWzdSjovyGTxd4XbgwLQ==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz Figa <tfiga@chromium.org>, Yong Zhi <yong.zhi@intel.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: [PATCH] staging: media: ipu3: remove ftrace-like logging
Date:   Sat,  7 Oct 2023 17:05:42 -0300
Message-Id: <20231007200541.126325-1-ricardo@marliere.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warnings in ipu3.c:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+       dev_dbg(dev, "enter %s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+       dev_dbg(dev, "leave %s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+       dev_dbg(dev, "enter %s\n", __func__);

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+       dev_dbg(dev, "leave %s\n", __func__);

Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci device driver")
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/staging/media/ipu3/ipu3.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index 0c453b37f8c4..18ca22c3018a 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -762,7 +762,6 @@ static int __maybe_unused imgu_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct imgu_device *imgu = pci_get_drvdata(pci_dev);
 
-	dev_dbg(dev, "enter %s\n", __func__);
 	imgu->suspend_in_stream = imgu_css_is_streaming(&imgu->css);
 	if (!imgu->suspend_in_stream)
 		goto out;
@@ -783,7 +782,6 @@ static int __maybe_unused imgu_suspend(struct device *dev)
 	imgu_powerdown(imgu);
 	pm_runtime_force_suspend(dev);
 out:
-	dev_dbg(dev, "leave %s\n", __func__);
 	return 0;
 }
 
@@ -793,8 +791,6 @@ static int __maybe_unused imgu_resume(struct device *dev)
 	int r = 0;
 	unsigned int pipe;
 
-	dev_dbg(dev, "enter %s\n", __func__);
-
 	if (!imgu->suspend_in_stream)
 		goto out;
 
@@ -821,8 +817,6 @@ static int __maybe_unused imgu_resume(struct device *dev)
 	}
 
 out:
-	dev_dbg(dev, "leave %s\n", __func__);
-
 	return r;
 }
 
-- 
2.40.1

