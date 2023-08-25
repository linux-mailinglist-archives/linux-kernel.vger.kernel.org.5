Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAA788688
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbjHYMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjHYMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:00:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19058198E;
        Fri, 25 Aug 2023 05:00:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so101570766b.2;
        Fri, 25 Aug 2023 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692964843; x=1693569643;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEKttxCzK+Mm67M/OBwLV0O7SaBvRkymMovm4HH+Y/A=;
        b=UT5aEFvLRj5zZAYtUtNheAbMhi5dWM9FGy5ss/gCVYufeVSCg5L3ktpb8BtDdRLdkw
         7Hz64ZFfEGBZ6FLl3sAR2YXGH/hbZJ+pXIDtLRlEd15liC8q0QC+0PqEgbC34XhNj57p
         un1antFnLT6vdhiegdhac8/Phwf7GSxRDTYEutyZOtVi28lubv1cy2hKDegTXxjnO7yF
         +mM/liT7wUkRKws2+8cuPemu3wqEErveRXWTtWLY3lzPDl6041+aSRs04xuBt+BrnoJA
         sa/o3rRhS7D3dUBDQeU/527Nct16LcaPJ6ZraBFO3WuVl7Z5t9eCP/IY5r2ZU6x2vJcD
         GO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692964843; x=1693569643;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEKttxCzK+Mm67M/OBwLV0O7SaBvRkymMovm4HH+Y/A=;
        b=XT7tbrM8lXJY8pXp5+xIKR5Swk8gYT2HJU/cac3OsE5NUFTCN5nCFGxXZi7T4ppP6z
         6m0c4A0z9LQ4Zp0ZvwKnzvg5HnXGF95I9XjxNW55OR2Pn3V8Kj2Bqy3KP563OX1YqUP/
         KFDVHJ7WbBlTc5AxLHM66I/VBhLhzgmqaxTi01MquYAt7xoAiIsOuXcU4aOeBiBIP6Gp
         HZ/yYwr+UKDLQNr2FNnwXlpfmxbmgZZY6hzO8dZ/B4z7ol4LfoZ9ybx9pxMMFbvDTedz
         3jRIvkvu7D2n/WrYwGXl6gWSl+Sttv2vT30q+jibrcaveSJp4wmSeXPId9MOVprLF0dH
         Uu9A==
X-Gm-Message-State: AOJu0YzH8jRIQlwuLxs6unDtte6h1R1fPXNlq1euUYMXll1DOdpUZCAp
        s7fbX3M2EbOy7EZzbcpjvHI=
X-Google-Smtp-Source: AGHT+IFGpXchAX+me0QmgZkYFyDzhksUmHvKKo/TWK1FTt4vhPSWOBe+n5kULj6C/IKWWW0iKKdNqA==
X-Received: by 2002:a17:907:60c7:b0:9a2:2635:daab with SMTP id hv7-20020a17090760c700b009a22635daabmr2984195ejc.47.1692964843242;
        Fri, 25 Aug 2023 05:00:43 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b0099bcf1c07c6sm892662ejk.138.2023.08.25.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:00:42 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] xfs: fix select in config XFS_ONLINE_SCRUB_STATS
Date:   Fri, 25 Aug 2023 14:00:40 +0200
Message-Id: <20230825120040.26314-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d7a74cad8f45 ("xfs: track usage statistics of online fsck")
introduces config XFS_ONLINE_SCRUB_STATS, which selects the non-existing
config FS_DEBUG. It is probably intended to select the existing config
XFS_DEBUG.

Fix the select in config XFS_ONLINE_SCRUB_STATS.

Fixes: d7a74cad8f45 ("xfs: track usage statistics of online fsck")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>i
---
Darrick, please pick this quick 'typo' fix.

 fs/xfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index c9d653168ad0..ed0bc8cbc703 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -147,7 +147,7 @@ config XFS_ONLINE_SCRUB_STATS
 	bool "XFS online metadata check usage data collection"
 	default y
 	depends on XFS_ONLINE_SCRUB
-	select FS_DEBUG
+	select XFS_DEBUG
 	help
 	  If you say Y here, the kernel will gather usage data about
 	  the online metadata check subsystem.  This includes the number
-- 
2.17.1

