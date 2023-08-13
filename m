Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1577A61A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHMLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:08:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6ABF;
        Sun, 13 Aug 2023 04:08:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc8045e09dso21122485ad.0;
        Sun, 13 Aug 2023 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691924927; x=1692529727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsTxCPc1FRbAQu+e710DcZ5hw9KbeEFuU6FiiWJ0vJM=;
        b=o7bz97etTRFrHOOxA8YPH4LZZ6DNi3D8HA+1Yj7/KT0Qh09pjAaj1f9+0tiDYhKW39
         M2l2qf0Cd3Lvf7p5AGeq/0llMEof6BVNI/a6sSxPSkavQgZAPEKfBS54xQvxP4OQ4rZD
         6zHbRs1EbkiAypuEX+a4JHPIQj7x+k34hUMNVQoJKmdg4vytzv/OzI7mUXps4Y/wa402
         mKckoIC/UYpkpErG68BFKs7XBc/Ls5qYW6dV6fxK6761GIodkPP/6WTU9aHybRVzr4NH
         o4AX8pTqIJCsL8ffNy5oGeKhhF2DmztcveWwPa025lQPTzFmPoLxTrQWWX6frk7nCmg2
         vXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924927; x=1692529727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsTxCPc1FRbAQu+e710DcZ5hw9KbeEFuU6FiiWJ0vJM=;
        b=Nr5Fa9cRkOZm6Bj5opBpwSpOG+tOxbbXcJwU2dTgi9winGin2n2JCcWcelzVOwmCXd
         lROzQ3dqqO8nR1nfHf9F8oV4GBqGUAiSCYxPORb0EuuzYGeiEVmSJARLe3fbbFRQeEAv
         Ft/2RE1RwjZe0YjcSCJ+7X1FZ3w98e03Z2qGrTHXLk1y7e8IhRus41DubLsW38w/MIG/
         aI/B8D1OoYryXeRzR7z79D+6Mvw7oS3tuwmcNNixjHz4blY6YQx6Pw8F5nUWiafPlzNz
         YiQAU7NweshlRFLWzy+LVzzHduhy307B2ocdMxeXgr9C0v7fOX4zfgA5X7zrcGtpQkSg
         z8eA==
X-Gm-Message-State: AOJu0YxHA73Sw53MRGI2JK2YIP+gmIbw+0n+Lv5UbFn8/Vrod5BmpwVr
        1UVUAfFzLqDJ1m3v88Ku7rgwtAKFPCM=
X-Google-Smtp-Source: AGHT+IFkEYzu/K2uHtVx4RUNoiA3sjvyV1RZ7XxaOOlzLZahj9blAepnvECtMVlFp0IwnrbfvCkxtQ==
X-Received: by 2002:a17:902:da8f:b0:1b6:9551:e297 with SMTP id j15-20020a170902da8f00b001b69551e297mr5071022plx.44.1691924926670;
        Sun, 13 Aug 2023 04:08:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100c:8e93:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001bdc2fdcf7esm3910509plg.129.2023.08.13.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 04:08:46 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] platform: sps: Fix an unsigned comparison that can never be negative
Date:   Sun, 13 Aug 2023 16:38:41 +0530
Message-Id: <20230813110841.130206-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The variable 'mode' is declared as unsigned int in local function.
The return value of function amd_pmf_get_pprof_modes(dev) is int and
it is stored in the 'mode' variable. Also the value of 'mode' variable
is compared with 0 which is signed int by default. Thus redeclaring the
variable to signed int.

This fixes warning such as:
drivers/platform/x86/amd/pmf/sps.c:128:5-9:
WARNING: Unsigned expression compared with zero: mode < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the commit subject
---
 drivers/platform/x86/amd/pmf/sps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index ab69d517a36a..703723a66830 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -176,7 +176,7 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 {
-	u8 mode, flag = 0;
+	int mode, flag = 0;
 	int src;
 
 	mode = amd_pmf_get_pprof_modes(dev);
-- 
2.25.1

